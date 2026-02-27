import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Report management endpoint
/// Handles user reports and admin resolution
class ReportEndpoint extends Endpoint {
  /// Create a report using user IDs (automatically looks up client/driver profile IDs)
  /// This is the preferred method for Flutter apps
  Future<Report?> createReportByUserId(
    Session session, {
    required int reportedByUserId,
    required ReporterType reporterType,
    int? reportedUserIdAsDriver,  // User ID of the driver being reported
    int? reportedUserIdAsClient,  // User ID of the client being reported
    int? reportedStoreId,         // Store ID (stores table, not user ID)
    int? reportedOrderId,
    ReporterType? reportedType,
    required ReportReason reportReason,
    required String description,
    List<String>? evidenceUrls,
  }) async {
    try {
      // Validate that at least one target is specified
      if (reportedUserIdAsDriver == null &&
          reportedUserIdAsClient == null &&
          reportedStoreId == null &&
          reportedOrderId == null) {
        session.log('No report target specified', level: LogLevel.warning);
        return null;
      }

      // Look up the driver profile ID from user ID
      int? reportedDriverId;
      if (reportedUserIdAsDriver != null) {
        final driver = await DriverProfile.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(reportedUserIdAsDriver),
        );
        reportedDriverId = driver?.id;
        if (reportedDriverId == null) {
          session.log('Driver profile not found for userId: $reportedUserIdAsDriver', level: LogLevel.warning);
        }
      }

      // Look up the client profile ID from user ID
      int? reportedClientId;
      if (reportedUserIdAsClient != null) {
        final client = await UserClient.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(reportedUserIdAsClient),
        );
        reportedClientId = client?.id;
        if (reportedClientId == null) {
          session.log('Client profile not found for userId: $reportedUserIdAsClient', level: LogLevel.warning);
        }
      }

      // Call the original method with the resolved IDs
      return await createReport(
        session,
        reportedByUserId: reportedByUserId,
        reporterType: reporterType,
        reportedDriverId: reportedDriverId,
        reportedClientId: reportedClientId,
        reportedStoreId: reportedStoreId,
        reportedOrderId: reportedOrderId,
        reportedType: reportedType,
        reportReason: reportReason,
        description: description,
        evidenceUrls: evidenceUrls,
      );
    } catch (e) {
      session.log('Error creating report by userId: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Create a report (requires actual profile IDs, not user IDs)
  Future<Report?> createReport(
    Session session, {
    required int reportedByUserId,
    required ReporterType reporterType,
    int? reportedDriverId,
    int? reportedClientId,
    int? reportedStoreId,
    int? reportedOrderId,
    ReporterType? reportedType,
    required ReportReason reportReason,
    required String description,
    List<String>? evidenceUrls,
  }) async {
    try {
      // Validate that at least one target is specified
      if (reportedDriverId == null &&
          reportedClientId == null &&
          reportedStoreId == null &&
          reportedOrderId == null) {
        session.log('No report target specified', level: LogLevel.warning);
        return null;
      }

      final report = Report(
        reportedByUserId: reportedByUserId,
        reporterType: reporterType,
        reportedDriverId: reportedDriverId,
        reportedClientId: reportedClientId,
        reportedStoreId: reportedStoreId,
        reportedOrderId: reportedOrderId,
        reportedType: reportedType,
        reportReason: reportReason,
        description: description,
        evidenceUrls: evidenceUrls,
        status: ReportStatus.pending,
        resolution: ReportResolution.pending,
        createdAt: DateTime.now(),
      );

      final savedReport = await Report.db.insertRow(session, report);

      // Update report counters
      final reporter = await User.db.findById(session, reportedByUserId);
      if (reporter != null) {
        reporter.totalReportsMade++;
        await User.db.updateRow(session, reporter);
      }

      // Update reported user's counter
      int? reportedUserId;
      if (reportedDriverId != null) {
        final driver = await DriverProfile.db.findById(session, reportedDriverId);
        reportedUserId = driver?.userId;
      } else if (reportedClientId != null) {
        final client = await UserClient.db.findById(session, reportedClientId);
        reportedUserId = client?.userId;
      } else if (reportedStoreId != null) {
        final store = await Store.db.findById(session, reportedStoreId);
        reportedUserId = store?.userId;
      }

      if (reportedUserId != null) {
        final reportedUser = await User.db.findById(session, reportedUserId);
        if (reportedUser != null) {
          reportedUser.totalReportsReceived++;
          await User.db.updateRow(session, reportedUser);
        }
      }

      return savedReport;
    } catch (e) {
      session.log('Error creating report: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get all pending reports (for admin)
  Future<List<Report>> getPendingReports(Session session) async {
    try {
      return await Report.db.find(
        session,
        where: (t) => t.status.equals(ReportStatus.pending),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );
    } catch (e) {
      session.log('Error getting pending reports: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get reports for a specific user
  Future<List<Report>> getReportsForUser(
    Session session, {
    int? driverId,
    int? clientId,
  }) async {
    try {
      if (driverId != null) {
        return await Report.db.find(
          session,
          where: (t) => t.reportedDriverId.equals(driverId),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
        );
      } else if (clientId != null) {
        return await Report.db.find(
          session,
          where: (t) => t.reportedClientId.equals(clientId),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
        );
      }
      return [];
    } catch (e) {
      session.log('Error getting reports for user: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Resolve a report (admin action)
  Future<Report?> resolveReport(
    Session session, {
    required int reportId,
    required int adminId,
    required ReportResolution resolution,
    String? adminNotes,
    String? reviewNotes,
  }) async {
    try {
      final report = await Report.db.findById(session, reportId);

      if (report == null) {
        return null;
      }

      report.status = ReportStatus.resolved;
      report.resolution = resolution;
      report.reviewedByAdminId = adminId;
      report.adminNotes = adminNotes;
      report.reviewNotes = reviewNotes;
      report.reviewedAt = DateTime.now();
      report.resolvedAt = DateTime.now();
      report.resolvedBy = adminId;

      final updatedReport = await Report.db.updateRow(session, report);

      // Apply resolution to user
      int? reportedUserId;
      if (report.reportedDriverId != null) {
        final driver =
            await DriverProfile.db.findById(session, report.reportedDriverId!);
        reportedUserId = driver?.userId;
      } else if (report.reportedClientId != null) {
        final client =
            await UserClient.db.findById(session, report.reportedClientId!);
        reportedUserId = client?.userId;
      }

      if (reportedUserId != null) {
        await _applyResolution(
          session,
          reportedUserId,
          resolution,
          adminNotes,
        );
      }

      return updatedReport;
    } catch (e) {
      session.log('Error resolving report: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Apply resolution to user (suspend, ban, warning)
  Future<void> _applyResolution(
    Session session,
    int userId,
    ReportResolution resolution,
    String? reason,
  ) async {
    try {
      final user = await User.db.findById(session, userId);

      if (user == null) return;

      switch (resolution) {
        case ReportResolution.warning:
          // Just log warning, no action on account
          session.log('Warning issued to user $userId: $reason');
          break;

        case ReportResolution.suspension:
          // Suspend for 7 days
          user.isSuspended = true;
          user.suspendedUntil = DateTime.now().add(const Duration(days: 7));
          user.suspensionReason = reason ?? 'Violation of platform rules';
          await User.db.updateRow(session, user);
          break;

        case ReportResolution.ban:
          // Permanent ban
          user.isSuspended = true;
          user.suspendedUntil = null; // null means permanent
          user.suspensionReason = reason ?? 'Banned for serious violations';
          user.status = UserStatus.banned;
          await User.db.updateRow(session, user);
          break;

        case ReportResolution.dismissed:
        case ReportResolution.pending:
          // No action
          break;
      }
    } catch (e) {
      session.log('Error applying resolution: $e', level: LogLevel.error);
    }
  }

  /// Dismiss a report (admin decides it's not valid)
  Future<Report?> dismissReport(
    Session session, {
    required int reportId,
    required int adminId,
    String? reviewNotes,
  }) async {
    try {
      final report = await Report.db.findById(session, reportId);

      if (report == null) {
        return null;
      }

      report.status = ReportStatus.dismissed;
      report.resolution = ReportResolution.dismissed;
      report.reviewedByAdminId = adminId;
      report.reviewNotes = reviewNotes;
      report.reviewedAt = DateTime.now();

      return await Report.db.updateRow(session, report);
    } catch (e) {
      session.log('Error dismissing report: $e', level: LogLevel.error);
      return null;
    }
  }
}
