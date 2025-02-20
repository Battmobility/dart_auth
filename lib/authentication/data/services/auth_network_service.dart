import 'package:dart_auth/authentication/domain/domain.dart';

abstract interface class AuthNetworkService {
  Future<Accesstoken> getAuthToken(String userName, String password);
  Future<Accesstoken> refreshAuthToken(String refreshToken);
  Future<bool> registerUser(String email, String password);
}
