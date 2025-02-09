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
          await authenticationRepository.refreshAccessToken(token: accessToken);
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

Future<void> loginUser(
    {required Accesstoken token,
    required BuildContext context,
    required Function(Accesstoken) onLogin,
    required Function(Object) onException}) async {
  try {
    final refreshedToken =
        await authenticationRepository.refreshAccessToken(token: token);
    onLogin(refreshedToken);
  } catch (e) {
    onException(e);
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
          onLogin: onLogin,
          onException: onException,
        );
      });
}

Future<Accesstoken> refreshAccessToken(
    {required Accesstoken accessToken}) async {
  return await authenticationRepository.refreshAccessToken(token: accessToken);
}

Future<Accesstoken?> refreshToken(String refreshToken) async {
  return authenticationRepository.refreshToken(refreshToken: refreshToken);
}
