import '../models/accesstoken.dart';

abstract interface class AuthRepository {
  Future<Accesstoken> loginUser(
      {required String userName, required String password});
  Future<Accesstoken> refreshToken(
      {required Accesstoken token, bool ifNeeded = false});
}
