import '../models/accesstoken.dart';

abstract interface class AuthRepository {
  Future<Accesstoken> loginUser(
      {required String userName, required String password});
  Future<Accesstoken> refreshAccessToken(
      {required Accesstoken token, bool ifNeeded = false});
  Future<Accesstoken> refreshToken({required String refreshToken});
  Future<bool> registerUser({required String email, required String password});
  Future<bool> resendVerificationEmail({required String email});
  Future<bool> resetPassword({required String email});
}
