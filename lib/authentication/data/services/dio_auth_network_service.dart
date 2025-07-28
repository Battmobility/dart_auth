import 'dart:convert';
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
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 400) {
        try {
          final responseData = e.response?.data;
          String? errorDescription;
          
          if (responseData is Map<String, dynamic> && responseData.containsKey('error_description')) {
            errorDescription = responseData['error_description'];
          } else if (responseData is String) {
            final jsonData = jsonDecode(responseData);
            if (jsonData is Map<String, dynamic> && jsonData.containsKey('error_description')) {
              errorDescription = jsonData['error_description'];
            }
          }
          
          if (errorDescription != null) {
            throw ApiException(
              message: errorDescription, 
              statusCode: 400, 
              identifier: "auth_error_400"
            );
          }
        } catch (apiException) {
          if (apiException is ApiException) {
            rethrow;
          }
        }
      }
      rethrow;
    }
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
