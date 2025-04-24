import 'package:dart_auth/authentication/domain/domain.dart';
import 'package:flutter/material.dart';

import 'authentication/presentation/screens/login_screen.dart';

void init(String? keycloakUrl, String? battMobilityUrl) {
  keycloakUrl = keycloakUrl;
  battMobilityUrl = battMobilityUrl;
}

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
      if (context.mounted) {
        await _showLoginDialog(
            context: context, onLogin: onLogin, onException: onException);
      }
    }
  } else {
    await _showLoginDialog(
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

Future<void> _showLoginDialog(
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
    },
  );
}

Future<void> showRegistrationDialog(
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
    },
  );
}

Future<Accesstoken> refreshAccessToken(
    {required Accesstoken accessToken}) async {
  return await authenticationRepository.refreshAccessToken(token: accessToken);
}

Future<Accesstoken?> refreshToken(String refreshToken) async {
  return authenticationRepository.refreshToken(refreshToken: refreshToken);
}

Future<bool> registerUser(
    {required String email, required String password}) async {
  return await authenticationRepository.registerUser(
    email: email,
    password: password,
  );
}

Future<bool> resetPassword(String email) async {
  return authenticationRepository.resetPassword(email: email);
}

enum AuthScreens { login, register, forgotPassword }
