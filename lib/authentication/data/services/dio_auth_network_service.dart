import 'package:dart_auth/authentication/domain/domain.dart';
import 'package:dio/dio.dart';

import 'auth_network_service.dart';

final class DioAuthNetworkService implements AuthNetworkService {
  static const clientId = 'mobile';
  static const grantTypePassword = 'password';
  static const grantTypeRefresh = 'refresh_token';

  final Dio keycloakService;
  final Dio battService;

  DioAuthNetworkService({
    required this.keycloakService,
    required this.battService,
  });

  @override
  Future<Accesstoken> getAuthToken(String userName, String password) async {
    final response = await keycloakService.post(
      "/protocol/openid-connect/token",
      data: {
        'client_id': clientId,
        'username': userName,
        'password': password,
        'grant_type': grantTypePassword
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    return response.toAccessToken();
  }

  @override
  Future<Accesstoken> refreshAuthToken(String refreshToken) async {
    final response = await keycloakService.post(
      "/protocol/openid-connect/token",
      data: {
        'client_id': clientId,
        'refresh_token': refreshToken,
        'grant_type': grantTypeRefresh
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    return response.toAccessToken();
  }

  @override
  Future<bool> registerUser(String email, String password) async {
    final response = await battService.post("/user/v1/users", data: {
      "email": email,
      "password": password,
    });
    return response.statusCode == 204;
  }

  @override
  Future<bool> resetPassword(String email) async {
    final response = await battService.post("/user/v1/password-resets", data: {
      "email": email,
    });
    return response.statusCode == 204;
  }
}
