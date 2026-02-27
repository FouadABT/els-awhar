import 'package:awhar_client/awhar_client.dart';
import 'package:get/get.dart';
import '../services/proposal_service.dart';
import 'auth_controller.dart';

/// Controller for managing driver proposals
class ProposalController extends GetxController {
  final ProposalService _proposalService = Get.find<ProposalService>();
  final AuthController _authController = Get.find<AuthController>();

  final RxList<DriverProposal> proposals = <DriverProposal>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<DriverProposal?> activeProposal = Rx<DriverProposal?>(null);

  /// Load proposals for a request (client viewing proposals)
  Future<void> loadProposalsForRequest(int requestId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final loadedProposals = await _proposalService.getProposalsForRequest(requestId);
      proposals.value = loadedProposals;
      
      if (loadedProposals.isEmpty) {
        errorMessage.value = 'No proposals yet. Drivers will submit offers soon.';
      }
    } catch (e) {
      errorMessage.value = 'Failed to load proposals: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Submit a proposal (driver side)
  Future<bool> submitProposal({
    required int requestId,
    required int estimatedArrival,
    double? proposedPrice,
    String? message,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final driverId = _authController.currentUser.value?.id;
      if (driverId == null) {
        throw Exception('User not logged in');
      }

      final proposal = await _proposalService.submitProposal(
        requestId: requestId,
        driverId: driverId,
        estimatedArrival: estimatedArrival,
        proposedPrice: proposedPrice,
        message: message,
      );

      if (proposal != null) {
        activeProposal.value = proposal;
        Get.snackbar(
          '✅ Proposal Sent',
          'Your proposal has been sent to the client',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        return true;
      }
      return false;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        '❌ Error',
        'Failed to submit proposal: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Accept a proposal (client side)
  Future<ServiceRequest?> acceptProposal(DriverProposal proposal) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final clientId = _authController.currentUser.value?.id;
      if (clientId == null) {
        throw Exception('User not logged in');
      }

      final request = await _proposalService.acceptProposal(
        proposalId: proposal.id!,
        clientId: clientId,
      );

      if (request != null) {
        // Remove the proposal from the list
        proposals.removeWhere((p) => p.id == proposal.id);
        
        Get.snackbar(
          '✅ Driver Assigned',
          '${proposal.driverName} is now your driver',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }

      return request;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        '❌ Error',
        'Failed to accept proposal: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Reject a proposal (client side)
  Future<void> rejectProposal(DriverProposal proposal) async {
    try {
      final clientId = _authController.currentUser.value?.id;
      if (clientId == null) return;

      final success = await _proposalService.rejectProposal(
        proposalId: proposal.id!,
        clientId: clientId,
      );

      if (success) {
        proposals.removeWhere((p) => p.id == proposal.id);
      }
    } catch (e) {
      Get.snackbar(
        '❌ Error',
        'Failed to reject proposal',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Clear proposals
  void clearProposals() {
    proposals.clear();
    activeProposal.value = null;
    errorMessage.value = '';
  }
}
