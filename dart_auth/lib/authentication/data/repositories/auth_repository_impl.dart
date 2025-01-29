import 'package:dart_auth/authentication/domain/domain.dart';
import '../datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthenticationDataSource authenticationDataSource;

  AuthRepositoryImpl({required this.authenticationDataSource});

  @override
  Future<Accesstoken> loginUser(
      {required String userName, required String password}) {
    return authenticationDataSource.loginUser(
        userName: userName, password: password);
  }

  @override
  Future<Accesstoken> refreshToken(
      {required Accesstoken token, bool ifNeeded = false}) {
    if (token.isValid && ifNeeded) {
      return Future.value(token);
    }
    return authenticationDataSource.refreshToken(token: token);
  }
}
