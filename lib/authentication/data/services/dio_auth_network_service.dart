import 'package:dart_auth/authentication/domain/domain.dart';
import 'package:dio/dio.dart';

import 'auth_network_service.dart';

final class DioAuthNetworkService implements AuthNetworkService {
  static const clientId = 'mobile';
  static const grantTypePassword = 'password';
  static const grantTypeRefresh = 'refresh_token';

  final Dio service;

  DioAuthNetworkService({required this.service});

  @override
  Future<Accesstoken> getAuthToken(String userName, String password) async {
    final response = await service.post(
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
  Future<Accesstoken> refreshAuthToken(Accesstoken token) async {
    if (token.refreshToken == null) {
      throw Exception("Refresh token missing");
    }
    final response = await service.post(
      "/protocol/openid-connect/token",
      data: {
        'client_id': clientId,
        'refresh_token': token.refreshToken,
        'grant_type': grantTypeRefresh
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    return response.toAccessToken();
  }
}
