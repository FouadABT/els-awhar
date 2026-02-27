import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import 'package:http/http.dart' as http;

/// Proxy endpoint for MCP (Model Context Protocol) calls.
/// 
/// Forwards requests from admin dashboard to Kibana Agent Builder MCP endpoint,
/// bypassing CORS restrictions.
class McpProxyEndpoint extends Endpoint {
  static const String _kibanaUrl =
      'https://my-elasticsearch-project-d5a097.kb.europe-west1.gcp.elastic.cloud';
  static const String _mcpPath = '/api/agent_builder/mcp';
  static const String _apiKey =
      'aTkyUkpwd0JwZVo0dzVKdXpDSHY6YldZZ2tLVEMwSExjLVhqNjBJSW9odw==';

  /// Forward an MCP JSON-RPC request to Kibana
  Future<String> proxyMcpRequest(
    Session session,
    String requestJson,
  ) async {
    try {
      final uri = Uri.parse('$_kibanaUrl$_mcpPath');

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'ApiKey $_apiKey',
          'Content-Type': 'application/json',
          'Accept': 'application/json, text/event-stream',
        },
        body: requestJson,
      );

      if (response.statusCode != 200) {
        final request = jsonDecode(requestJson) as Map<String, dynamic>;
        return jsonEncode({
          'jsonrpc': '2.0',
          'error': {
            'code': -32603,
            'message':
                'MCP request failed: ${response.statusCode} ${response.reasonPhrase}',
            'data': response.body,
          },
          'id': request['id'],
        });
      }

      return response.body;
    } catch (e, stackTrace) {
      session.log('MCP proxy error: $e', level: LogLevel.error);
      session.log(stackTrace.toString(), level: LogLevel.debug);

      final request = jsonDecode(requestJson) as Map<String, dynamic>;
      return jsonEncode({
        'jsonrpc': '2.0',
        'error': {
          'code': -32603,
          'message': 'Internal error: $e',
        },
        'id': request['id'],
      });
    }
  }
}
