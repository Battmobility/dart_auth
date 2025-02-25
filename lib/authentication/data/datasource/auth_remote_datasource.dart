import 'package:dart_auth/authentication/domain/domain.dart';

import '../services/auth_network_service.dart';

abstract interface class AuthenticationDataSource {
  Future<Accesstoken> loginUser(
      {required String userName, required String password});
  Future<Accesstoken> refreshToken({required String refreshToken});
  Future<bool> registerUser(String email, String password);
  Future<bool> resetPassword(String email);
}

class RemoteAuthenticationDataSource implements AuthenticationDataSource {
  final AuthNetworkService networkService;

  RemoteAuthenticationDataSource({required this.networkService});

  @override
  Future<Accesstoken> loginUser(
      {required String userName, required String password}) async {
    return await networkService.getAuthToken(userName, password);
  }

  @override
  Future<Accesstoken> refreshToken({required String refreshToken}) async {
    return networkService.refreshAuthToken(refreshToken);
  }

  @override
  Future<bool> registerUser(String email, String password) async {
    return await networkService.registerUser(email, password);
  }

  @override
  Future<bool> resetPassword(String email) async {
    return await networkService.resetPassword(email);
  }
}
