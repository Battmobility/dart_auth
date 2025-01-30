import 'package:dart_auth/authentication/domain/domain.dart';
import 'package:flutter/material.dart';

import 'authentication/presentation/screens/login_screen.dart';

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
      await _getNewToken(
          context: context, onLogin: onLogin, onException: onException);
    }
  } else {
    await _getNewToken(
        context: context, onLogin: onLogin, onException: onException);
  }
}

Future<void> _getNewToken(
    {required BuildContext context,
    required Function(Accesstoken) onLogin,
    required Function(Object) onException}) async {
  showDialog(
      context: context,
      builder: (_) {
        return LoginPage(
          authRepo: authenticationRepository,
          onLogin: onLogin,
          onException: onException,
        );
      });
}

Future<Accesstoken> refreshToken({required Accesstoken accessToken}) async {
  return await authenticationRepository.refreshToken(token: accessToken);
}
