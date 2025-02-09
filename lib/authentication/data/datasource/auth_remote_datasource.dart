import 'package:dart_auth/authentication/domain/domain.dart';

import '../services/auth_network_service.dart';

abstract interface class AuthenticationDataSource {
  Future<Accesstoken> loginUser(
      {required String userName, required String password});
  Future<Accesstoken> refreshToken({required String refreshToken});
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
}
