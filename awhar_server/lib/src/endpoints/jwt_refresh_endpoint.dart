import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart' as core;

/// JWT token refresh endpoint that extends Serverpod's RefreshJwtTokensEndpoint
/// This enables automatic JWT token refresh on the Flutter client
class RefreshJwtTokensEndpoint extends core.RefreshJwtTokensEndpoint {}
