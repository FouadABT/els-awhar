import 'dart:convert';
import 'package:flutter/foundation.dart';
import './api_service.dart';

/// MCP (Model Context Protocol) client for communicating with
/// Elastic Agent Builder's MCP endpoint via Serverpod proxy.
///
/// Exposes all 68+ Awhar tools to the admin dashboard for direct invocation.
class McpService {
  static McpService? _instance;
  static McpService get instance => _instance ??= McpService._();
  McpService._();

  int _requestId = 0;

  /// Send a JSON-RPC 2.0 request to the MCP endpoint via Serverpod proxy
  Future<Map<String, dynamic>> _sendRequest(
    String method, {
    Map<String, dynamic>? params,
  }) async {
    _requestId++;
    final body = {
      'jsonrpc': '2.0',
      'method': method,
      'params': params ?? {},
      'id': _requestId,
    };

    debugPrint('[MCP] >> $method (id=$_requestId)');

    try {
      final client = ApiService.instance.client;
      final requestJson = jsonEncode(body);
      final responseJson = await client.mcpProxy.proxyMcpRequest(requestJson);
      final response = jsonDecode(responseJson) as Map<String, dynamic>;

      if (response.containsKey('error')) {
        final error = response['error'] as Map<String, dynamic>;
        throw McpException(
          error['message'] as String? ?? 'Unknown MCP error',
          jsonEncode(error),
        );
      }

      debugPrint('[MCP] << $method OK');
      return response;
    } catch (e) {
      if (e is McpException) rethrow;
      throw McpException('MCP request failed: $e');
    }
  }

  /// Initialize the MCP connection
  Future<McpServerInfo> initialize() async {
    final response = await _sendRequest('initialize', params: {
      'protocolVersion': '2024-11-05',
      'capabilities': {},
      'clientInfo': {
        'name': 'awhar-admin-dashboard',
        'version': '1.0.0',
      },
    });

    final result = response['result'] as Map<String, dynamic>;
    final serverInfo = result['serverInfo'] as Map<String, dynamic>;

    return McpServerInfo(
      name: serverInfo['name'] as String? ?? 'unknown',
      version: serverInfo['version'] as String? ?? '0.0.0',
      protocolVersion: result['protocolVersion'] as String? ?? '',
    );
  }

  /// List all available tools
  Future<List<McpTool>> listTools() async {
    final response = await _sendRequest('tools/list');
    final result = response['result'] as Map<String, dynamic>;
    final tools = result['tools'] as List<dynamic>;

    return tools.map((t) {
      final tool = t as Map<String, dynamic>;
      final inputSchema = tool['inputSchema'] as Map<String, dynamic>?;

      return McpTool(
        name: tool['name'] as String,
        description: tool['description'] as String? ?? '',
        inputSchema: inputSchema ?? {},
      );
    }).toList();
  }

  /// Call a tool with the given arguments
  Future<McpToolResult> callTool(
    String toolName, {
    Map<String, dynamic>? arguments,
  }) async {
    final response = await _sendRequest('tools/call', params: {
      'name': toolName,
      'arguments': arguments ?? {},
    });

    final result = response['result'] as Map<String, dynamic>;
    final content = result['content'] as List<dynamic>?;
    final isError = result['isError'] as bool? ?? false;

    final parts = <McpContentPart>[];
    if (content != null) {
      for (final c in content) {
        final part = c as Map<String, dynamic>;
        parts.add(McpContentPart(
          type: part['type'] as String? ?? 'text',
          text: part['text'] as String? ?? '',
        ));
      }
    }

    return McpToolResult(
      content: parts,
      isError: isError,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DATA MODELS
// ═══════════════════════════════════════════════════════════════════════════

class McpServerInfo {
  final String name;
  final String version;
  final String protocolVersion;

  const McpServerInfo({
    required this.name,
    required this.version,
    required this.protocolVersion,
  });
}

class McpTool {
  final String name;
  final String description;
  final Map<String, dynamic> inputSchema;

  const McpTool({
    required this.name,
    required this.description,
    required this.inputSchema,
  });

  /// Agent category prefix (e.g., "awhar_concierge", "platform_core")
  String get category {
    final parts = name.split('_');
    if (parts.length >= 2) {
      // e.g., awhar_concierge_user_profile -> awhar_concierge
      if (parts[0] == 'awhar' && parts.length >= 3) {
        return '${parts[0]}_${parts[1]}';
      }
      if (parts[0] == 'platform' && parts.length >= 3) {
        return '${parts[0]}_${parts[1]}';
      }
    }
    return 'other';
  }

  /// Short name without category prefix
  String get shortName {
    final prefix = category;
    if (name.startsWith('${prefix}_')) {
      return name.substring(prefix.length + 1);
    }
    return name;
  }

  /// Get the list of required parameters
  List<McpToolParam> get parameters {
    final props =
        inputSchema['properties'] as Map<String, dynamic>? ?? {};
    final required =
        (inputSchema['required'] as List<dynamic>?)?.cast<String>() ?? [];

    return props.entries.map((e) {
      final schema = e.value as Map<String, dynamic>;
      return McpToolParam(
        name: e.key,
        type: schema['type'] as String? ?? 'string',
        description: schema['description'] as String? ?? '',
        isRequired: required.contains(e.key),
      );
    }).toList();
  }

  /// True if this tool requires no parameters
  bool get hasNoParams => parameters.isEmpty;
}

class McpToolParam {
  final String name;
  final String type;
  final String description;
  final bool isRequired;

  const McpToolParam({
    required this.name,
    required this.type,
    required this.description,
    required this.isRequired,
  });
}

class McpToolResult {
  final List<McpContentPart> content;
  final bool isError;

  const McpToolResult({
    required this.content,
    required this.isError,
  });

  String get text => content.map((c) => c.text).join('\n');
}

class McpContentPart {
  final String type;
  final String text;

  const McpContentPart({
    required this.type,
    required this.text,
  });
}

class McpException implements Exception {
  final String message;
  final String? details;

  const McpException(this.message, [this.details]);

  @override
  String toString() => 'McpException: $message${details != null ? '\n$details' : ''}';
}
