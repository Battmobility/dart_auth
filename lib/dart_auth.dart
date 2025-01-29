import 'package:dart_auth/authentication/domain/domain.dart';
import 'package:flutter/material.dart';

Future<void> login(
    {required Accesstoken? accessToken,
    required BuildContext context,
    required Function(Accesstoken) onLogin,
    required Function(Object) onException}) async {
  if (accessToken != null) {
    try {
      final refreshedToken =
          await authenticationRepository.refreshToken(token: accessToken);
      onLogin(refreshedToken);
    } catch (e) {
      onException(e);
    }
  } else {
    onException(Exception('No token provided.'));
  }
}
