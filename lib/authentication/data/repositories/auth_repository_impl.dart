import 'package:batt_auth/authentication/domain/domain.dart';
import 'package:batt_auth/authentication/domain/exceptions/exceptions.dart';
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
  Future<Accesstoken> refreshAccessToken(
      {required Accesstoken token, bool ifNeeded = false}) {
    if (token.isValid && ifNeeded) {
      return Future.value(token);
    }
    if (token.isRefreshValid) {
      return refreshToken(refreshToken: token.refreshToken!);
    } else if (token.refreshToken == null) {
      throw MissingRefreshTokenException();
    } else {
      throw ExpiredRefreshTokenException();
    }
  }

  @override
  Future<Accesstoken> refreshToken({required String refreshToken}) {
    return authenticationDataSource.refreshToken(refreshToken: refreshToken);
  }

  @override
  Future<bool> registerUser({required String email, required String password}) {
    return authenticationDataSource.registerUser(email, password);
  }

  @override
  Future<bool> resetPassword({required String email}) {
    return authenticationDataSource.resetPassword(email);
  }
}
