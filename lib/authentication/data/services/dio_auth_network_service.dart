import 'package:batt_auth/authentication/domain/domain.dart';
import 'package:dio/dio.dart';

import 'auth_network_service.dart';
import 'api_exception.dart';

final class DioAuthNetworkService implements AuthNetworkService {
  final String keyCloakUrl;
  final String battMobilityUrl;
  static const clientId = 'mobile';
  static const grantTypePassword = 'password';
  static const grantTypeRefresh = 'refresh_token';

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
    try {
      final response = await battMobilityService.post("/user/v1/users", data: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 204) {
        return true;
      } else {
        throw ApiException.fromJson(
          jsonString: response.data?.toString(),
          statusCode: response.statusCode ?? 0,
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw ApiException.fromJson(
          jsonString: e.response?.data?.toString(),
          statusCode: e.response?.statusCode ?? 0,
        );
      } else {
        throw ApiException.unknown();
      }
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    final response =
        await battMobilityService.post("/user/v1/password-resets", data: {
      "email": email,
    });
    if (response.statusCode == 204) {
      return true;
    } else {
      throw ApiException.fromJson(
        jsonString: response.data?.toString(),
        statusCode: response.statusCode ?? 0,
      );
    }
  }

  @override
  Future<bool> resendVerificationEmail(String email) async {
    final response = await battMobilityService
        .post("/user/v1/verification-email-resends", data: {
      "email": email,
    });
    if (response.statusCode == 204) {
      return true;
    } else {
      throw ApiException.fromJson(
        jsonString: response.data?.toString(),
        statusCode: response.statusCode ?? 0,
      );
    }
  }
}
