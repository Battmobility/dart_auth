import 'package:batt_auth/authentication/domain/domain.dart';

abstract interface class AuthNetworkService {
  Future<Accesstoken> getAuthToken(String userName, String password);
  Future<Accesstoken> refreshAuthToken(String refreshToken);
  Future<bool> registerUser(String email, String password);
  Future<bool> resendVerificationEmail(String email);
  Future<bool> resetPassword(String email);
}
