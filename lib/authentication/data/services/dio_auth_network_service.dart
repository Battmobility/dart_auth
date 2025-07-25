import 'package:batt_auth/authentication/domain/domain.dart';
import 'package:dio/dio.dart';

import 'auth_network_service.dart';

final class DioAuthNetworkService implements AuthNetworkService {
  final String keyCloakUrl;
  final String battMobilityUrl;
  static const clientId = 'mobile';
  static const grantTypePassword = 'password';
  static const grantTypeRefresh = 'refresh_token';

  String _parseErrorMessage(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final data = e.response!.data as Map<String, dynamic>;
      if (data.containsKey('debugMsg') && data['debugMsg'] is String) {
        return data['debugMsg'] as String;
      }
    }
    return e.message ?? 'An error occurred';
  }

  Dio get keycloakService => Dio(
        BaseOptions(baseUrl: keyCloakUrl),
      );
  Dio get battMobilityService => Dio(
        BaseOptions(baseUrl: battMobilityUrl),
      );

  DioAuthNetworkService({
    required this.keyCloakUrl,
    required this.battMobilityUrl,
  });

  @override
  Future<Accesstoken> getAuthToken(String userName, String password) async {
    try {
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
    } on DioException catch (e) {
      throw Exception(_parseErrorMessage(e));
    }
  }

  @override
  Future<Accesstoken> refreshAuthToken(String refreshToken) async {
    try {
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
    } on DioException catch (e) {
      throw Exception(_parseErrorMessage(e));
    }
  }

  @override
  Future<bool> registerUser(String email, String password) async {
    try {
      final response = await battMobilityService.post("/user/v1/users", data: {
        "email": email,
        "password": password,
      });
      return response.statusCode == 204;
    } on DioException catch (e) {
      throw Exception(_parseErrorMessage(e));
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    try {
      final response =
          await battMobilityService.post("/user/v1/password-resets", data: {
        "email": email,
      });
      return response.statusCode == 204;
    } on DioException catch (e) {
      throw Exception(_parseErrorMessage(e));
    }
  }

  @override
  Future<bool> resendVerificationEmail(String email) async {
    try {
      final response = await battMobilityService
          .post("/user/v1/verification-email-resends", data: {
        "email": email,
      });
      return response.statusCode == 204;
    } on DioException catch (e) {
      throw Exception(_parseErrorMessage(e));
    }
  }
}
