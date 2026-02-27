import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/controllers/auth_controller.dart';
import '../../core/controllers/request_controller.dart';
import '../../core/services/location_service.dart';
import '../../core/services/proposal_service.dart';
import '../../core/services/request_service.dart';
import '../agents/concierge_agent.dart';
import '../widgets/radar_pulse_painter.dart';
import '../widgets/matching_tool_step.dart';
import '../widgets/matched_driver_card.dart';

/// ╔══════════════════════════════════════════════════════════════╗
/// ║  AI DRIVER MATCHING SCREEN                                  ║
/// ║  Beautiful real-time visualization of the AI agent           ║
/// ║  matching process. Uses SSE streaming from Kibana            ║
/// ║  Agent Builder to show each tool being called.               ║
/// ║                                                              ║
/// ║  Phases:                                                     ║
/// ║  1. 🔄 Initializing — "Preparing AI Agent..."                ║
/// ║  2. 🧠 Reasoning — Radar scan + agent thinking               ║
/// ║  3. 🔧 Tool Calls — Each ES|QL tool shown in real time      ║
/// ║  4. ✅ Results — Matched drivers slide in one by one         ║
/// ║  5. 🎯 Complete — Auto-navigate or show summary             ║
/// ╚══════════════════════════════════════════════════════════════╝
class AiMatchingScreen extends StatefulWidget {
  const AiMatchingScreen({super.key});

  /// Global flag to suppress notification overlay when on this screen
  static bool isActive = false;

  @override
  State<AiMatchingScreen> createState() => _AiMatchingScreenState();
}

class _AiMatchingScreenState extends State<AiMatchingScreen>
    with TickerProviderStateMixin {
  // ── Agent / Streaming ──
  final ConciergeAgent _agent = ConciergeAgent();
  String? _streamSessionId;
  Timer? _pollTimer;
  int _lastEventIndex = 0;

  // ── Phase tracking ──
  _MatchPhase _phase = _MatchPhase.initializing;
  String _statusText = '';
  String _reasoningText = '';
  String _finalMessage = '';

  // ── Tool steps ──
  final List<_ToolStepState> _toolSteps = [];
  int _activeToolIndex = -1;

  // ── Matched drivers ──
  final List<_MatchedDriver> _matchedDrivers = [];

  // ── Animations ──
  late AnimationController _radarController;
  late AnimationController _pulseController;
  late AnimationController _phaseTransitionController;

  // ── Request data (passed via arguments) ──
  int? _requestId;
  ServiceType? _serviceType;
  double? _latitude;
  double? _longitude;

  // ── Proposals ──
  final List<DriverProposal> _proposals = [];
  Timer? _proposalPollTimer;
  bool _isAccepting = false;
  late AnimationController _proposalSlideController;

  // ── Direct driver accept (driver_proposed status) ──
  ServiceRequest? _proposedRequest;
  User? _proposedDriverUser;
  Timer? _requestStatusPollTimer;
  late AnimationController _driverAcceptedController;

  // ── Timing ──
  final Stopwatch _stopwatch = Stopwatch();
  final RxInt _elapsedSeconds = 0.obs;
  Timer? _timerTick;

  @override
  void initState() {
    super.initState();

    // Setup animations
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _phaseTransitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _phaseTransitionController.forward();

    _proposalSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _driverAcceptedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Mark screen as active to suppress notification overlay
    AiMatchingScreen.isActive = true;

    // Parse arguments & start matching
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _parseArguments();
      _startMatching();
    });
  }

  void _parseArguments() {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    _requestId = args['requestId'] as int?;
    _serviceType = args['serviceType'] as ServiceType?;
    _latitude = args['latitude'] as double?;
    _longitude = args['longitude'] as double?;

    // Also try getting location from LocationService
    if (_latitude == null || _longitude == null) {
      try {
        final locationService = Get.find<LocationService>();
        final pos = locationService.currentPosition.value;
        if (pos != null) {
          _latitude ??= pos.latitude;
          _longitude ??= pos.longitude;
        }
      } catch (_) {}
    }
  }

  Future<void> _startMatching() async {
    _stopwatch.start();
    _timerTick = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsedSeconds.value = _stopwatch.elapsed.inSeconds;
    });

    setState(() {
      _phase = _MatchPhase.initializing;
      _statusText = 'matching.initializing'.tr;
    });

    await Future.delayed(const Duration(milliseconds: 800));

    // Build the matching prompt
    final serviceTypeName = _serviceType?.name ?? 'delivery';
    final message = _buildMatchingMessage(serviceTypeName);

    setState(() {
      _phase = _MatchPhase.searching;
      _statusText = 'matching.searching'.tr;
    });

    try {
      // Get user info
      final authController = Get.find<AuthController>();
      final userId = authController.currentUser.value?.id;

      // Start streaming conversation with awhar-match agent
      _streamSessionId = await _agent.startConverse(
        agentId: 'awhar-match',
        message: message,
        userId: userId,
        latitude: _latitude,
        longitude: _longitude,
      );

      // Start polling
      _lastEventIndex = 0;
      _pollTimer = Timer.periodic(
        const Duration(milliseconds: 500),
        (_) => _pollForEvents(),
      );
    } catch (e) {
      debugPrint('[AiMatching] Error starting stream: $e');
      setState(() {
        _phase = _MatchPhase.error;
        _statusText = 'matching.error'.tr;
        _reasoningText = e.toString();
      });
    }
  }

  String _buildMatchingMessage(String serviceType) {
    final parts = <String>[];

    parts.add('Find the best drivers for a $serviceType request.');

    if (_requestId != null) {
      parts.add('Request ID: $_requestId.');
    }

    if (_latitude != null && _longitude != null) {
      parts.add(
        'Client location: lat $_latitude, lng $_longitude (Taza, Morocco).',
      );
    }

    parts.add(
      'Return top 5 matched drivers ranked by score. Include distance, rating, and match explanation.',
    );

    return parts.join(' ');
  }

  Future<void> _pollForEvents() async {
    if (_streamSessionId == null) return;

    try {
      final status = await _agent.pollStream(
        streamSessionId: _streamSessionId!,
        lastEventIndex: _lastEventIndex,
      );

      // Process new events
      for (final event in status.events) {
        _processStreamEvent(event);
      }
      _lastEventIndex += status.events.length;

      // Check completion
      if (status.status == 'complete') {
        _pollTimer?.cancel();
        _onMatchingComplete(status);
      } else if (status.status == 'error') {
        _pollTimer?.cancel();
        setState(() {
          _phase = _MatchPhase.error;
          _statusText = status.errorMessage ?? 'matching.error'.tr;
        });
      }
    } catch (e) {
      debugPrint('[AiMatching] Poll error: $e');
    }
  }

  void _processStreamEvent(AgentStreamEvent event) {
    switch (event.type) {
      case 'reasoning':
      case 'thinking':
        if (_phase != _MatchPhase.reasoning) {
          setState(() {
            _phase = _MatchPhase.reasoning;
            _statusText = 'matching.ai_thinking'.tr;
          });
        }
        try {
          final data = json.decode(event.data) as Map<String, dynamic>;
          final text =
              data['text']?.toString() ??
              data['reasoning']?.toString() ??
              data['thinking']?.toString() ??
              '';
          if (text.isNotEmpty) {
            setState(() => _reasoningText = text);
          }
        } catch (_) {}
        break;

      case 'tool_call':
        _handleToolCall(event);
        break;

      case 'tool_result':
        _handleToolResult(event);
        break;

      case 'message_chunk':
        if (_phase != _MatchPhase.results) {
          setState(() {
            _phase = _MatchPhase.results;
            _statusText = 'matching.analyzing_results'.tr;
          });
        }
        try {
          final data = json.decode(event.data) as Map<String, dynamic>;
          final chunk =
              data['text_chunk']?.toString() ??
              data['chunk']?.toString() ??
              data['text']?.toString() ??
              '';
          if (chunk.isNotEmpty) {
            setState(() => _finalMessage += chunk);
            // Don't parse partial text — wait for message_complete
          }
        } catch (_) {}
        break;

      case 'message_complete':
        try {
          final data = json.decode(event.data) as Map<String, dynamic>;
          final msg =
              data['message_content']?.toString() ??
              data['message']?.toString() ??
              data['text']?.toString() ??
              '';
          if (msg.isNotEmpty) {
            debugPrint(
              '[AiMatching] message_complete (${msg.length} chars): ${msg.substring(0, min(200, msg.length))}...',
            );
            setState(() => _finalMessage = msg);
            _tryParseDriversFromText(msg);
          }
        } catch (_) {}
        break;

      default:
        break;
    }
  }

  void _handleToolCall(AgentStreamEvent event) {
    try {
      final data = json.decode(event.data) as Map<String, dynamic>;
      final toolName =
          data['tool_name']?.toString() ??
          data['tool_id']?.toString() ??
          data['name']?.toString() ??
          'unknown';

      // Mark previous tool as complete
      if (_activeToolIndex >= 0 && _activeToolIndex < _toolSteps.length) {
        _toolSteps[_activeToolIndex].isActive = false;
        _toolSteps[_activeToolIndex].isComplete = true;
      }

      // Add new tool
      setState(() {
        if (_phase != _MatchPhase.toolCalls) {
          _phase = _MatchPhase.toolCalls;
          _statusText = 'matching.running_tools'.tr;
        }

        _toolSteps.add(
          _ToolStepState(
            toolName: toolName,
            isActive: true,
            isComplete: false,
          ),
        );
        _activeToolIndex = _toolSteps.length - 1;
      });
    } catch (_) {}
  }

  void _handleToolResult(AgentStreamEvent event) {
    // Mark active tool as complete
    if (_activeToolIndex >= 0 && _activeToolIndex < _toolSteps.length) {
      setState(() {
        _toolSteps[_activeToolIndex].isActive = false;
        _toolSteps[_activeToolIndex].isComplete = true;

        // Try to extract result summary for the tool
        try {
          final data = json.decode(event.data) as Map<String, dynamic>;
          final results = data['results'] ?? data['data'];
          if (results is List && results.isNotEmpty) {
            _toolSteps[_activeToolIndex].statusText =
                '${results.length} results found';
          }
        } catch (_) {}
      });
    }

    // Try to extract driver data from tool results
    try {
      final data = json.decode(event.data) as Map<String, dynamic>;
      _tryParseDriversFromToolResult(data);
    } catch (_) {}
  }

  void _tryParseDriversFromText(String text) {
    // Split the AI message into per-driver blocks.
    // The AI typically outputs numbered entries or sections separated by
    // blank lines / markdown headers. We split on numbered list items
    // ("1.", "2.", etc.) or double-newlines, then extract fields from each block.

    // Normalize line endings
    final normalized = text.replaceAll('\r\n', '\n').replaceAll('\r', '\n');

    // Split on numbered items: "1." "2." etc. at start of line or after newline
    final blockPattern = RegExp(r'(?:^|\n)\s*(?:\d+[\.\)\-]\s*|[-•]\s*)');
    final blocks = normalized
        .split(blockPattern)
        .where((b) => b.trim().isNotEmpty)
        .toList();

    // If no numbered blocks found, try splitting on double newlines
    final effectiveBlocks = blocks.length > 1
        ? blocks
        : normalized
              .split(RegExp(r'\n\n+'))
              .where((b) => b.trim().isNotEmpty)
              .toList();

    final newDrivers = <_MatchedDriver>[];

    // Helpers to extract fields
    int? _extractId(String block) {
      final m = RegExp(r'(?:ID|id)[:\s#]*?(\d+)').firstMatch(block);
      return m != null ? int.tryParse(m.group(1)!) : null;
    }

    double? _extractRating(String block) {
      final m = RegExp(
        r'(?:Rating|⭐|rating)[:\s]*(\d+\.?\d*)',
      ).firstMatch(block);
      return m != null ? double.tryParse(m.group(1)!) : null;
    }

    double? _extractDistance(String block) {
      final m = RegExp(
        r'(?:Distance|📍|distance)[:\s]*(\d+\.?\d*)\s*km',
        caseSensitive: false,
      ).firstMatch(block);
      return m != null ? double.tryParse(m.group(1)!) : null;
    }

    int? _extractScore(String block) {
      final m = RegExp(
        r'(?:Score|Match|match)[:\s]*(\d+)\s*%',
        caseSensitive: false,
      ).firstMatch(block);
      return m != null ? int.tryParse(m.group(1)!) : null;
    }

    String? _extractVehicle(String block) {
      final m = RegExp(
        r'(?:Vehicle|🚗|vehicle)[:\s]*([A-Za-z]+(?:\s+[A-Za-z]+)*)',
        caseSensitive: false,
      ).firstMatch(block);
      return m?.group(1)?.trim();
    }

    String? _extractName(String block) {
      // Try markdown bold: **Name** or __Name__
      var m = RegExp(r'\*\*([^*]+)\*\*').firstMatch(block);
      m ??= RegExp(r'__([^_]+)__').firstMatch(block);
      if (m != null) {
        var name = m.group(1)!.trim();
        // Remove trailing (ID: X) from the bold name if present
        name = name.replaceAll(RegExp(r'\s*\(ID[:\s#]*\d+\)'), '').trim();
        if (name.length >= 3) return name;
      }

      // Try "Driver Name" or "Name:" pattern at start of block
      m = RegExp(
        r'^\s*(?:Driver\s+)?([A-Z][a-zà-ÿ]+(?:\s+[A-Z][a-zà-ÿ]+)+)',
        multiLine: true,
      ).firstMatch(block);
      if (m != null) {
        final name = m.group(1)!.trim();
        // Must have at least two words (first + last name) and contain an ID or rating nearby
        if (name.length >= 3 &&
            (block.contains(
              RegExp(
                r'ID|Rating|⭐|Distance|📍|Score|Match|Vehicle|🚗',
                caseSensitive: false,
              ),
            ))) {
          return name;
        }
      }
      return null;
    }

    for (final block in effectiveBlocks) {
      final name = _extractName(block);
      if (name == null) continue;

      // Skip if already have this driver
      if (_matchedDrivers.any((d) => d.name == name) ||
          newDrivers.any((d) => d.name == name))
        continue;

      final rng = Random();
      newDrivers.add(
        _MatchedDriver(
          name: name,
          id: _extractId(block),
          rating: _extractRating(block),
          distanceKm: _extractDistance(block),
          matchScore: _extractScore(block),
          vehicleType: _extractVehicle(block),
          radarX: (rng.nextDouble() - 0.5) * 1.2,
          radarY: (rng.nextDouble() - 0.5) * 1.2,
        ),
      );
    }

    if (newDrivers.isNotEmpty) {
      debugPrint(
        '[AiMatching] ✅ Parsed ${newDrivers.length} drivers from text: ${newDrivers.map((d) => '${d.name} (ID:${d.id}, ⭐${d.rating}, ${d.distanceKm}km, ${d.matchScore}%)').join(', ')}',
      );
      setState(() {
        _matchedDrivers.addAll(newDrivers);
        if (_phase != _MatchPhase.results) {
          _phase = _MatchPhase.results;
        }
      });
    } else {
      debugPrint(
        '[AiMatching] ⚠️ No drivers parsed from text (${effectiveBlocks.length} blocks checked)',
      );
    }
  }

  void _tryParseDriversFromToolResult(Map<String, dynamic> data) {
    // Try to parse driver data from tool results (tabular_data format)
    // Handles two formats:
    // 1. Nested SSE format: data['results'][].data.{columns, values}
    // 2. Flattened format: data.{columns, values} (from AgentBuilderStep.toolOutput)

    // Check if this IS the flat tabular data directly
    if (data.containsKey('columns') && data.containsKey('values')) {
      _parseTabularData(data);
      return;
    }

    // Check nested format: results[].data.{columns, values}
    final results = data['results'] ?? data['data'];
    if (results is List) {
      for (final r in results) {
        if (r is! Map) continue;
        final rData = r['data'];
        if (rData is Map<String, dynamic> &&
            rData.containsKey('columns') &&
            rData.containsKey('values')) {
          _parseTabularData(rData);
        }
      }
    }
  }

  /// Parse tabular data {columns: [...], values: [[...], ...]} into matched drivers
  void _parseTabularData(Map<String, dynamic> data) {
    final columns = data['columns'] as List?;
    final values = data['values'] as List?;
    if (columns == null || values == null) return;

    debugPrint(
      '[AiMatching] 📊 Parsing tabular data: ${columns.length} columns, ${values.length} rows',
    );

    final colNames = columns.map((c) {
      if (c is Map) return c['name']?.toString().toLowerCase() ?? '';
      return c.toString().toLowerCase();
    }).toList();

    // Find column indices with broader matching
    final nameIdx = colNames.indexWhere(
      (c) => c.contains('name') || c.contains('display'),
    );
    final ratingIdx = colNames.indexWhere((c) => c.contains('rating'));
    final distIdx = colNames.indexWhere((c) => c.contains('dist'));
    final idIdx = colNames.indexWhere(
      (c) => c.contains('user_id') || c.contains('userid') || c == 'id',
    );
    final scoreIdx = colNames.indexWhere(
      (c) => c.contains('score') || c.contains('match'),
    );
    final vehicleIdx = colNames.indexWhere(
      (c) => c.contains('vehicle') || c.contains('type'),
    );

    for (final row in values) {
      if (row is! List) continue;
      final name = nameIdx >= 0 && nameIdx < row.length
          ? row[nameIdx]?.toString()
          : null;
      if (name == null || name.isEmpty) continue;

      final existing = _matchedDrivers.any((d) => d.name == name);
      if (existing) continue;

      final rng = Random();
      setState(() {
        _matchedDrivers.add(
          _MatchedDriver(
            name: name,
            id: idIdx >= 0 && idIdx < row.length
                ? int.tryParse(row[idIdx]?.toString() ?? '')
                : null,
            rating: ratingIdx >= 0 && ratingIdx < row.length
                ? double.tryParse(row[ratingIdx]?.toString() ?? '')
                : null,
            distanceKm: distIdx >= 0 && distIdx < row.length
                ? double.tryParse(row[distIdx]?.toString() ?? '')
                : null,
            matchScore: scoreIdx >= 0 && scoreIdx < row.length
                ? int.tryParse(row[scoreIdx]?.toString() ?? '')
                : null,
            vehicleType: vehicleIdx >= 0 && vehicleIdx < row.length
                ? row[vehicleIdx]?.toString()
                : null,
            radarX: (rng.nextDouble() - 0.5) * 1.2,
            radarY: (rng.nextDouble() - 0.5) * 1.2,
          ),
        );
      });
    }
  }

  void _onMatchingComplete(AgentStreamStatus status) {
    _stopwatch.stop();

    // Mark all tools complete
    for (final step in _toolSteps) {
      step.isActive = false;
      step.isComplete = true;
    }

    // 1. Try to extract drivers from AgentBuilderStep tool outputs (most reliable)
    if (status.steps != null) {
      debugPrint(
        '[AiMatching] 📦 Processing ${status.steps!.length} steps from complete status',
      );
      for (final step in status.steps!) {
        debugPrint(
          '[AiMatching]   Step: type=${step.type}, tool=${step.toolName}, hasOutput=${step.toolOutput != null}',
        );
        if (step.toolOutput != null && step.toolOutput!.isNotEmpty) {
          debugPrint(
            '[AiMatching]   Output preview: ${step.toolOutput!.substring(0, min(200, step.toolOutput!.length))}...',
          );
          try {
            final parsed = json.decode(step.toolOutput!);
            if (parsed is Map<String, dynamic>) {
              _tryParseDriversFromToolResult(parsed);
            } else if (parsed is List) {
              // List of resource data or raw results
              for (final item in parsed) {
                if (item is Map<String, dynamic>) {
                  _tryParseDriversFromToolResult(item);
                }
              }
            }
          } catch (_) {
            // toolOutput might not be JSON — skip
          }
        }
      }
    }

    // 2. Use final message from status as fallback text parsing
    if (status.finalMessage != null && status.finalMessage!.isNotEmpty) {
      _finalMessage = status.finalMessage!;
      // Only parse text if we haven't found drivers from tool outputs
      if (_matchedDrivers.isEmpty) {
        _tryParseDriversFromText(_finalMessage);
      }
    }

    if (_matchedDrivers.isEmpty) {
      setState(() {
        _phase = _MatchPhase.noResults;
        _statusText = 'matching.no_drivers'.tr;
      });
      return;
    }

    // Transition to waiting for proposals
    setState(() {
      _phase = _MatchPhase.waitingForProposals;
      _statusText = 'matching.waiting_for_proposals'.tr;
    });

    // Start polling for proposals AND request status changes
    _startProposalPolling();
    _startRequestStatusPolling();
  }

  void _startProposalPolling() {
    if (_requestId == null) return;

    // Poll every 3 seconds for new proposals
    _proposalPollTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _pollForProposals(),
    );

    // Also poll immediately
    _pollForProposals();
  }

  /// Poll for direct driver accept (request status changes to driver_proposed)
  void _startRequestStatusPolling() {
    if (_requestId == null) return;

    _requestStatusPollTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _pollRequestStatus(),
    );
  }

  Future<void> _pollRequestStatus() async {
    if (_requestId == null || _phase == _MatchPhase.driverAccepted) return;

    try {
      final requestService = Get.find<RequestService>();
      final request = await requestService.getRequestById(_requestId!);

      if (!mounted || request == null) return;

      // Driver directly accepted the client's price
      if (request.status == RequestStatus.driver_proposed &&
          request.proposedDriverId != null) {
        debugPrint(
          '[AiMatching] Driver proposed! ID: ${request.proposedDriverId}',
        );

        // Fetch driver user info
        User? driverUser;
        try {
          final client = Get.find<Client>();
          final response = await client.user.getUserById(
            userId: request.proposedDriverId!,
          );
          driverUser = response.user;
        } catch (e) {
          debugPrint('[AiMatching] Could not fetch driver info: $e');
        }

        if (!mounted) return;

        setState(() {
          _proposedRequest = request;
          _proposedDriverUser = driverUser;
          _phase = _MatchPhase.driverAccepted;
          _statusText = 'matching.driver_accepted'.tr;
        });

        // Animate the driver card in
        _driverAcceptedController.reset();
        _driverAcceptedController.forward();

        // Stop polling — we found our driver
        _proposalPollTimer?.cancel();
        _requestStatusPollTimer?.cancel();
      }

      // Request was accepted (client already approved somewhere else)
      if (request.status == RequestStatus.accepted ||
          request.status == RequestStatus.driver_arriving ||
          request.status == RequestStatus.in_progress) {
        _proposalPollTimer?.cancel();
        _requestStatusPollTimer?.cancel();

        // Update request controller and navigate
        try {
          final requestController = Get.find<RequestController>();
          requestController.activeRequest.value = request;
        } catch (_) {}

        if (mounted) {
          Get.offNamed(
            '/client/active-request',
            arguments: {
              'requestId': request.id,
            },
          );
        }
      }
    } catch (e) {
      debugPrint('[AiMatching] Request status poll error: $e');
    }
  }

  /// Client approves the proposed driver from the radar screen
  Future<void> _approveProposedDriver() async {
    if (_isAccepting || _proposedRequest == null) return;
    setState(() => _isAccepting = true);

    try {
      final authController = Get.find<AuthController>();
      final clientId = authController.currentUser.value?.id;
      if (clientId == null) throw Exception('Not logged in');

      final requestService = Get.find<RequestService>();
      final updatedRequest = await requestService.approveDriver(
        requestId: _proposedRequest!.id!,
        clientId: clientId,
      );

      if (updatedRequest != null && mounted) {
        // Update request controller
        try {
          final requestController = Get.find<RequestController>();
          requestController.activeRequest.value = updatedRequest;
        } catch (_) {}

        // Navigate to active request tracking
        Get.offNamed(
          '/client/active-request',
          arguments: {
            'requestId': updatedRequest.id,
          },
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isAccepting = false);
        Get.snackbar(
          'Error',
          'Failed to approve driver: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  /// Client rejects the proposed driver
  Future<void> _rejectProposedDriver() async {
    if (_proposedRequest == null) return;

    try {
      final authController = Get.find<AuthController>();
      final clientId = authController.currentUser.value?.id;
      if (clientId == null) return;

      final requestService = Get.find<RequestService>();
      await requestService.rejectDriver(
        requestId: _proposedRequest!.id!,
        clientId: clientId,
      );

      if (mounted) {
        setState(() {
          _proposedRequest = null;
          _proposedDriverUser = null;
          _isAccepting = false;
          _phase = _MatchPhase.waitingForProposals;
          _statusText = 'matching.waiting_for_proposals'.tr;
        });

        // Resume polling
        _startRequestStatusPolling();
        _startProposalPolling();
      }
    } catch (e) {
      debugPrint('[AiMatching] Reject proposed driver error: $e');
    }
  }

  Future<void> _pollForProposals() async {
    if (_requestId == null) return;

    try {
      final proposalService = Get.find<ProposalService>();
      final proposals = await proposalService.getProposalsForRequest(
        _requestId!,
      );

      if (!mounted) return;

      // Check for new pending proposals
      final pendingProposals = proposals
          .where((p) => p.status == ProposalStatus.pending)
          .toList();

      if (pendingProposals.isNotEmpty &&
          pendingProposals.length > _proposals.length) {
        setState(() {
          _proposals
            ..clear()
            ..addAll(pendingProposals);
          _phase = _MatchPhase.proposalReceived;
          _statusText = 'matching.proposal_received'.tr;
        });

        // Animate proposal card in
        _proposalSlideController.reset();
        _proposalSlideController.forward();
      }
    } catch (e) {
      debugPrint('[AiMatching] Proposal poll error: $e');
    }
  }

  Future<void> _acceptProposal(DriverProposal proposal) async {
    if (_isAccepting) return;
    setState(() => _isAccepting = true);

    try {
      final authController = Get.find<AuthController>();
      final clientId = authController.currentUser.value?.id;
      if (clientId == null) throw Exception('Not logged in');

      final proposalService = Get.find<ProposalService>();
      final request = await proposalService.acceptProposal(
        proposalId: proposal.id!,
        clientId: clientId,
      );

      if (request != null && mounted) {
        _proposalPollTimer?.cancel();

        // Update request controller
        try {
          final requestController = Get.find<RequestController>();
          requestController.activeRequest.value = request;
        } catch (_) {}

        // Navigate to request tracking
        Get.back(
          result: {
            'success': true,
            'accepted': true,
            'requestId': request.id,
            'driverName': proposal.driverName,
          },
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isAccepting = false);
        Get.snackbar(
          '❌ Error',
          'Failed to accept proposal: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  Future<void> _rejectProposal(DriverProposal proposal) async {
    try {
      final authController = Get.find<AuthController>();
      final clientId = authController.currentUser.value?.id;
      if (clientId == null) return;

      final proposalService = Get.find<ProposalService>();
      await proposalService.rejectProposal(
        proposalId: proposal.id!,
        clientId: clientId,
      );

      if (mounted) {
        setState(() {
          _proposals.removeWhere((p) => p.id == proposal.id);
          if (_proposals.isEmpty) {
            _phase = _MatchPhase.waitingForProposals;
            _statusText = 'matching.waiting_for_proposals'.tr;
          }
        });
      }
    } catch (e) {
      debugPrint('[AiMatching] Reject error: $e');
    }
  }

  void _navigateToOrders() {
    Get.back(
      result: {
        'success': _matchedDrivers.isNotEmpty,
        'driverCount': _matchedDrivers.length,
        'processingTimeMs': _stopwatch.elapsedMilliseconds,
      },
    );
  }

  @override
  void dispose() {
    AiMatchingScreen.isActive = false;
    _pollTimer?.cancel();
    _proposalPollTimer?.cancel();
    _requestStatusPollTimer?.cancel();
    _timerTick?.cancel();
    _radarController.dispose();
    _pulseController.dispose();
    _phaseTransitionController.dispose();
    _proposalSlideController.dispose();
    _driverAcceptedController.dispose();
    super.dispose();
  }

  // ════════════════════════════════════════════════════════════
  // BUILD
  // ════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ──
            _buildTopBar(colors),

            // ── Main content ──
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 8.h),

                    // ── Radar visualization ──
                    _buildRadarSection(colors, isDark),

                    SizedBox(height: 16.h),

                    // ── Status text ──
                    _buildStatusSection(colors),

                    SizedBox(height: 16.h),

                    // ── AI Reasoning bubble ──
                    if (_reasoningText.isNotEmpty &&
                        _phase != _MatchPhase.complete)
                      _buildReasoningBubble(colors),

                    // ── Tool steps ──
                    if (_toolSteps.isNotEmpty) ...[
                      _buildToolStepsSection(colors),
                      SizedBox(height: 12.h),
                    ],

                    // ── Matched drivers (only during matching phases) ──
                    if (_matchedDrivers.isNotEmpty &&
                        _phase != _MatchPhase.waitingForProposals &&
                        _phase != _MatchPhase.proposalReceived) ...[
                      _buildMatchedDriversSection(colors),
                      SizedBox(height: 12.h),
                    ],

                    // ── Waiting for proposals ──
                    if (_phase == _MatchPhase.waitingForProposals)
                      _buildWaitingForProposalsSection(colors),

                    // ── Incoming proposals ──
                    if (_phase == _MatchPhase.proposalReceived &&
                        _proposals.isNotEmpty)
                      _buildIncomingProposalsSection(colors),

                    // ── Driver accepted (direct accept flow) ──
                    if (_phase == _MatchPhase.driverAccepted &&
                        _proposedRequest != null)
                      _buildDriverAcceptedSection(colors),

                    // ── Final message ──
                    if (_phase == _MatchPhase.complete ||
                        _phase == _MatchPhase.noResults)
                      _buildCompletionSection(colors),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

            // ── Bottom action bar ──
            if (_phase == _MatchPhase.complete ||
                _phase == _MatchPhase.noResults ||
                _phase == _MatchPhase.error ||
                _phase == _MatchPhase.waitingForProposals ||
                _phase == _MatchPhase.proposalReceived ||
                _phase == _MatchPhase.driverAccepted)
              _buildBottomBar(colors),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(AppColorScheme colors) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          // Close button
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.close_rounded, color: colors.textSecondary),
            style: IconButton.styleFrom(
              backgroundColor: colors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),

          const Spacer(),

          // ES Agent badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: const Color(0xFF00BFA5).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: const Color(0xFF00BFA5).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/appiconnobackgound.png',
                  width: 16.w,
                  height: 16.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Elasticsearch Agent',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00BFA5),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Timer
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                '${_elapsedSeconds.value}s',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  fontFeatures: const [FontFeature.tabularFigures()],
                  color: colors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarSection(AppColorScheme colors, bool isDark) {
    final radarSize = 220.w;
    final isScanning =
        _phase == _MatchPhase.searching ||
        _phase == _MatchPhase.reasoning ||
        _phase == _MatchPhase.toolCalls;
    final isWaiting =
        _phase == _MatchPhase.waitingForProposals ||
        _phase == _MatchPhase.proposalReceived;
    final isDriverAccepted = _phase == _MatchPhase.driverAccepted;

    return Container(
      width: radarSize,
      height: radarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark
            ? Colors.black.withValues(alpha: 0.3)
            : Colors.white.withValues(alpha: 0.5),
        border: Border.all(
          color: colors.border.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isScanning
                ? colors.primary.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: Listenable.merge([_radarController, _pulseController]),
        builder: (context, _) {
          // Build radar dots from matched drivers
          final dots = _matchedDrivers.asMap().entries.map((entry) {
            final idx = entry.key;
            final driver = entry.value;
            final rng = Random(driver.name.hashCode);

            // Scatter based on distance (closer = smaller radius)
            final dist = driver.distanceKm ?? (rng.nextDouble() * 3 + 0.5);
            final normalizedDist = (dist / 10.0).clamp(0.1, 0.85);
            final angle = driver.radarX != null
                ? atan2(driver.radarY!, driver.radarX!)
                : (rng.nextDouble() * 2 * pi);

            return RadarDot(
              normalizedX: normalizedDist * cos(angle),
              normalizedY: normalizedDist * sin(angle),
              color: idx == 0 ? colors.primary : colors.success,
              opacity: 1.0,
              scale: idx == 0 ? 1.3 : 1.0,
            );
          }).toList();

          return CustomPaint(
            size: Size(radarSize, radarSize),
            painter: RadarPulsePainter(
              pulseProgress: _pulseController.value,
              sweepAngle: _radarController.value * 2 * pi,
              primaryColor: colors.textMuted,
              accentColor: isScanning
                  ? colors.primary
                  : isDriverAccepted
                  ? colors.success
                  : isWaiting
                  ? colors.info
                  : _phase == _MatchPhase.complete
                  ? colors.success
                  : colors.info,
              driverDots: dots,
              glowIntensity: isScanning
                  ? 1.0
                  : isWaiting
                  ? 0.6
                  : 0.4,
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusSection(AppColorScheme colors) {
    IconData icon;
    Color iconColor;

    switch (_phase) {
      case _MatchPhase.initializing:
        icon = Icons.memory_rounded;
        iconColor = colors.info;
        break;
      case _MatchPhase.searching:
        icon = Icons.radar_rounded;
        iconColor = colors.primary;
        break;
      case _MatchPhase.reasoning:
        icon = Icons.psychology_rounded;
        iconColor = colors.warning;
        break;
      case _MatchPhase.toolCalls:
        icon = Icons.build_circle_rounded;
        iconColor = colors.primary;
        break;
      case _MatchPhase.results:
        icon = Icons.analytics_rounded;
        iconColor = colors.info;
        break;
      case _MatchPhase.complete:
        icon = Icons.check_circle_rounded;
        iconColor = colors.success;
        break;
      case _MatchPhase.waitingForProposals:
        icon = Icons.hourglass_top_rounded;
        iconColor = colors.primary;
        break;
      case _MatchPhase.proposalReceived:
        icon = Icons.local_offer_rounded;
        iconColor = colors.success;
        break;
      case _MatchPhase.driverAccepted:
        icon = Icons.person_pin_circle_rounded;
        iconColor = colors.success;
        break;
      case _MatchPhase.noResults:
        icon = Icons.search_off_rounded;
        iconColor = colors.warning;
        break;
      case _MatchPhase.error:
        icon = Icons.error_outline_rounded;
        iconColor = colors.error;
        break;
    }

    return Column(
      children: [
        // Animated icon
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: Icon(
            icon,
            key: ValueKey(_phase),
            size: 28.sp,
            color: iconColor,
          ),
        ),
        SizedBox(height: 8.h),

        // Phase title
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            _phaseTitle,
            key: ValueKey('title_$_phase'),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 4.h),

        // Subtitle
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            _statusText,
            key: ValueKey('status_$_statusText'),
            style: TextStyle(
              fontSize: 13.sp,
              color: colors.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // Driver count badge
        if (_matchedDrivers.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: colors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: colors.success.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              '${_matchedDrivers.length} ${'matching.drivers_matched'.tr}',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: colors.success,
              ),
            ),
          ),
        ],
      ],
    );
  }

  String get _phaseTitle {
    switch (_phase) {
      case _MatchPhase.initializing:
        return 'matching.title_initializing'.tr;
      case _MatchPhase.searching:
        return 'matching.title_searching'.tr;
      case _MatchPhase.reasoning:
        return 'matching.title_reasoning'.tr;
      case _MatchPhase.toolCalls:
        return 'matching.title_analyzing'.tr;
      case _MatchPhase.results:
        return 'matching.title_results'.tr;
      case _MatchPhase.complete:
        return 'matching.title_complete'.tr;
      case _MatchPhase.waitingForProposals:
        return 'matching.title_waiting'.tr;
      case _MatchPhase.proposalReceived:
        return 'matching.title_proposal'.tr;
      case _MatchPhase.driverAccepted:
        return 'matching.title_driver_accepted'.tr;
      case _MatchPhase.noResults:
        return 'matching.title_no_results'.tr;
      case _MatchPhase.error:
        return 'matching.title_error'.tr;
    }
  }

  Widget _buildReasoningBubble(AppColorScheme colors) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: colors.warning.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🧠', style: TextStyle(fontSize: 14.sp)),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              _reasoningText,
              style: TextStyle(
                fontSize: 11.sp,
                color: colors.textSecondary,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolStepsSection(AppColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '🔧',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(width: 6.w),
            Text(
              'matching.tools_executed'.tr,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
            const Spacer(),
            Text(
              '${_toolSteps.where((s) => s.isComplete).length}/${_toolSteps.length}',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: colors.textMuted,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        ...List.generate(
          _toolSteps.length,
          (i) => MatchingToolStep(
            key: ValueKey('tool_$i'),
            toolName: _toolSteps[i].toolName,
            statusText: _toolSteps[i].statusText,
            isActive: _toolSteps[i].isActive,
            isComplete: _toolSteps[i].isComplete,
            index: i,
          ),
        ),
      ],
    );
  }

  Widget _buildMatchedDriversSection(AppColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('🚗', style: TextStyle(fontSize: 14.sp)),
            SizedBox(width: 6.w),
            Text(
              'matching.matched_drivers'.tr,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ...List.generate(
          _matchedDrivers.length,
          (i) => MatchedDriverCard(
            key: ValueKey('driver_${_matchedDrivers[i].name}'),
            driverName: _matchedDrivers[i].name,
            rating: _matchedDrivers[i].rating,
            distanceKm: _matchedDrivers[i].distanceKm,
            matchScore: _matchedDrivers[i].matchScore,
            matchReason: _matchedDrivers[i].matchReason,
            vehicleType: _matchedDrivers[i].vehicleType,
            isTopPick: i == 0,
            animationIndex: i,
          ),
        ),
      ],
    );
  }

  Widget _buildCompletionSection(AppColorScheme colors) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _phase == _MatchPhase.complete
            ? colors.success.withValues(alpha: 0.06)
            : colors.warning.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: _phase == _MatchPhase.complete
              ? colors.success.withValues(alpha: 0.2)
              : colors.warning.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          // Success/warning icon
          Icon(
            _phase == _MatchPhase.complete
                ? Icons.celebration_rounded
                : Icons.info_outline_rounded,
            size: 32.sp,
            color: _phase == _MatchPhase.complete
                ? colors.success
                : colors.warning,
          ),
          SizedBox(height: 8.h),

          Text(
            _phase == _MatchPhase.complete
                ? 'matching.success_message'.tr
                : 'matching.no_results_message'.tr,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),

          Text(
            _phase == _MatchPhase.complete
                ? 'matching.success_subtitle'.tr
                : 'matching.no_results_subtitle'.tr,
            style: TextStyle(
              fontSize: 12.sp,
              color: colors.textMuted,
            ),
            textAlign: TextAlign.center,
          ),

          // Processing time
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer_outlined, size: 14.sp, color: colors.textMuted),
              SizedBox(width: 4.w),
              Text(
                '${(_stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(1)}s • ${_toolSteps.length} tools • Elasticsearch Agent',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(AppColorScheme colors) {
    final isWaitingPhase =
        _phase == _MatchPhase.waitingForProposals ||
        _phase == _MatchPhase.proposalReceived ||
        _phase == _MatchPhase.driverAccepted;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        border: Border(
          top: BorderSide(color: colors.border.withValues(alpha: 0.2)),
        ),
      ),
      child: Row(
        children: [
          if (_phase == _MatchPhase.noResults || _phase == _MatchPhase.error)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _toolSteps.clear();
                    _matchedDrivers.clear();
                    _proposals.clear();
                    _finalMessage = '';
                    _reasoningText = '';
                    _stopwatch.reset();
                    _elapsedSeconds.value = 0;
                  });
                  _startMatching();
                },
                icon: const Icon(Icons.refresh_rounded),
                label: Text('matching.retry'.tr),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  side: BorderSide(color: colors.primary),
                  foregroundColor: colors.primary,
                ),
              ),
            ),
          if (_phase == _MatchPhase.noResults || _phase == _MatchPhase.error)
            SizedBox(width: 12.w),

          // During waiting — show "View Orders" as secondary action
          if (isWaitingPhase) ...[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _navigateToOrders,
                icon: Icon(Icons.list_alt_rounded, color: colors.textSecondary),
                label: Text(
                  'matching.view_orders'.tr,
                  style: TextStyle(color: colors.textSecondary),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  side: BorderSide(color: colors.border),
                ),
              ),
            ),
          ],

          // For complete/error/noResults phases
          if (!isWaitingPhase)
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _navigateToOrders,
                icon: Icon(
                  _phase == _MatchPhase.complete
                      ? Icons.check_rounded
                      : Icons.arrow_forward_rounded,
                  color: Colors.white,
                ),
                label: Text(
                  _phase == _MatchPhase.complete
                      ? 'matching.view_orders'.tr
                      : 'matching.continue'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // WAITING & PROPOSAL UI
  // ════════════════════════════════════════════════════════════

  Widget _buildWaitingForProposalsSection(AppColorScheme colors) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: colors.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        children: [
          // Pulsing dots animation
          SizedBox(
            height: 40.h,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) {
                    final offset = (i * 0.3);
                    final value = ((_pulseController.value + offset) % 1.0);
                    final scale = 0.5 + (sin(value * pi) * 0.5);
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 10.w,
                          height: 10.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.primary.withValues(
                              alpha: 0.3 + (scale * 0.7),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            'matching.waiting_message'.tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 6.h),

          Text(
            'matching.waiting_subtitle'.tr,
            style: TextStyle(
              fontSize: 12.sp,
              color: colors.textMuted,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12.h),

          // Notified drivers count
          if (_matchedDrivers.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: colors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications_active_rounded,
                    size: 14.sp,
                    color: colors.success,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '${_matchedDrivers.length} ${'matching.drivers_notified'.tr}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: colors.success,
                    ),
                  ),
                ],
              ),
            ),

          SizedBox(height: 12.h),

          // Processing stats
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer_outlined, size: 14.sp, color: colors.textMuted),
              SizedBox(width: 4.w),
              Text(
                '${(_stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(1)}s \u2022 ${_toolSteps.length} tools \u2022 Elasticsearch Agent',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIncomingProposalsSection(AppColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Text('\uD83C\uDF89', style: TextStyle(fontSize: 16.sp)),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'matching.proposals_header'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: colors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '${_proposals.length}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: colors.success,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Proposal cards
        ...List.generate(_proposals.length, (i) {
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _proposalSlideController,
                    curve: Interval(
                      (i * 0.15).clamp(0.0, 0.7),
                      ((i * 0.15) + 0.3).clamp(0.3, 1.0),
                      curve: Curves.easeOutBack,
                    ),
                  ),
                ),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: _proposalSlideController,
                curve: Interval(
                  (i * 0.15).clamp(0.0, 0.7),
                  ((i * 0.15) + 0.3).clamp(0.3, 1.0),
                ),
              ),
              child: _buildProposalCard(_proposals[i], colors, isFirst: i == 0),
            ),
          );
        }),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════
  // DRIVER ACCEPTED (INLINE - replaces modal)
  // ════════════════════════════════════════════════════════════

  Widget _buildDriverAcceptedSection(AppColorScheme colors) {
    final request = _proposedRequest!;
    final driver = _proposedDriverUser;
    final driverName =
        driver?.fullName ?? request.proposedDriverName ?? 'Driver';
    final driverPhone = driver?.phoneNumber ?? request.proposedDriverPhone;
    final driverRating = driver?.rating;
    final offeredPrice = request.clientOfferedPrice ?? 0;

    return SlideTransition(
      position:
          Tween<Offset>(
            begin: const Offset(0, 0.4),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _driverAcceptedController,
              curve: Curves.easeOutBack,
            ),
          ),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _driverAcceptedController,
          curve: const Interval(0.0, 0.6),
        ),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: colors.success.withValues(alpha: 0.4),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.success.withValues(alpha: 0.15),
                blurRadius: 20,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Success header
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.success,
                      colors.success.withValues(alpha: 0.85),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.r),
                    topRight: Radius.circular(18.r),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'matching.driver_wants_to_help'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'matching.accepted_your_price'.tr,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Driver info
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 4.h),
                child: Row(
                  children: [
                    // Driver avatar
                    Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.primary.withValues(alpha: 0.1),
                        border: Border.all(
                          color: colors.success.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          driverName.isNotEmpty
                              ? driverName[0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: colors.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),

                    // Name & details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            driverName,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              if (driverRating != null) ...[
                                Icon(
                                  Icons.star_rounded,
                                  size: 16.sp,
                                  color: Colors.amber,
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  driverRating.toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: colors.textSecondary,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                              ],
                              if (driverPhone != null) ...[
                                Icon(
                                  Icons.phone_rounded,
                                  size: 14.sp,
                                  color: colors.textMuted,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  driverPhone,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: colors.textMuted,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Price badge
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: colors.success.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: colors.success.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.payments_outlined,
                        size: 18.sp,
                        color: colors.success,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${offeredPrice.toStringAsFixed(0)} MAD',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color: colors.success,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: colors.success.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          'matching.your_price'.tr,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: colors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Accept / Reject buttons
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                child: Row(
                  children: [
                    // Reject
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isAccepting ? null : _rejectProposedDriver,
                        icon: Icon(Icons.close_rounded, size: 18.sp),
                        label: Text(
                          'matching.decline'.tr,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colors.error,
                          side: BorderSide(
                            color: colors.error.withValues(alpha: 0.5),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    // Accept
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: _isAccepting ? null : _approveProposedDriver,
                        icon: _isAccepting
                            ? SizedBox(
                                width: 18.w,
                                height: 18.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                        label: Text(
                          _isAccepting
                              ? 'matching.accepting'.tr
                              : 'matching.accept_driver'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.success,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          elevation: _isAccepting ? 0 : 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProposalCard(
    DriverProposal proposal,
    AppColorScheme colors, {
    bool isFirst = false,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isFirst
              ? colors.success.withValues(alpha: 0.4)
              : colors.border,
          width: isFirst ? 1.5 : 1,
        ),
        boxShadow: [
          if (isFirst)
            BoxShadow(
              color: colors.success.withValues(alpha: 0.1),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top badge for first proposal
            if (isFirst)
              Container(
                margin: EdgeInsets.only(bottom: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.success, colors.primary],
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bolt_rounded, size: 14.sp, color: Colors.white),
                    SizedBox(width: 4.w),
                    Text(
                      'matching.first_response'.tr,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

            // Driver info row
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 26.r,
                  backgroundColor: colors.primary.withValues(alpha: 0.1),
                  child: Text(
                    proposal.driverName.isNotEmpty
                        ? proposal.driverName[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: colors.primary,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Name & rating
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        proposal.driverName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 14.sp,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            proposal.driverRating?.toStringAsFixed(1) ?? 'New',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: colors.textSecondary,
                            ),
                          ),
                          if (proposal.driverVehicleInfo != null) ...[
                            SizedBox(width: 10.w),
                            Icon(
                              Icons.directions_car_rounded,
                              size: 13.sp,
                              color: colors.textMuted,
                            ),
                            SizedBox(width: 3.w),
                            Flexible(
                              child: Text(
                                proposal.driverVehicleInfo!,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: colors.textMuted,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Details row
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  // ETA
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 16.sp,
                          color: colors.primary,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '${proposal.estimatedArrival} min',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: colors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Price
                  if (proposal.proposedPrice != null) ...[
                    Container(
                      width: 1,
                      height: 20.h,
                      color: colors.border,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.payments_outlined,
                            size: 16.sp,
                            color: colors.success,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            '${proposal.proposedPrice!.toStringAsFixed(0)} MAD',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: colors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Driver message
            if (proposal.message != null && proposal.message!.isNotEmpty) ...[
              SizedBox(height: 10.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: colors.info.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: colors.info.withValues(alpha: 0.15),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\uD83D\uDCAC', style: TextStyle(fontSize: 12.sp)),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        proposal.message!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: colors.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: 14.h),

            // Accept / Decline buttons
            Row(
              children: [
                // Decline
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _rejectProposal(proposal),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.error,
                      side: BorderSide(
                        color: colors.error.withValues(alpha: 0.5),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'matching.decline'.tr,
                      style: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                ),

                SizedBox(width: 10.w),

                // Accept
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: _isAccepting
                        ? null
                        : () => _acceptProposal(proposal),
                    icon: _isAccepting
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                    label: Text(
                      _isAccepting
                          ? 'matching.accepting'.tr
                          : 'matching.accept_driver'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.success,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: _isAccepting ? 0 : 2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// DATA MODELS
// ════════════════════════════════════════════════════════════

enum _MatchPhase {
  initializing,
  searching,
  reasoning,
  toolCalls,
  results,
  complete,
  waitingForProposals,
  proposalReceived,
  driverAccepted,
  noResults,
  error,
}

class _ToolStepState {
  final String toolName;
  bool isActive;
  bool isComplete;
  String? statusText;

  _ToolStepState({
    required this.toolName,
    this.isActive = false,
    this.isComplete = false,
    this.statusText,
  });
}

class _MatchedDriver {
  final String name;
  final int? id;
  final double? rating;
  final double? distanceKm;
  final int? matchScore;
  final String? matchReason;
  final String? vehicleType;
  final String? profilePhotoUrl;
  final double? radarX;
  final double? radarY;

  _MatchedDriver({
    required this.name,
    this.id,
    this.rating,
    this.distanceKm,
    this.matchScore,
    this.matchReason,
    this.vehicleType,
    this.profilePhotoUrl,
    this.radarX,
    this.radarY,
  });
}
