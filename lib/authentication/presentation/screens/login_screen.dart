import 'package:dart_auth/authentication/domain/domain.dart';
import 'package:dart_auth/l10n/auth_localizations.dart';
import 'package:flutter/material.dart';

import '../widgets/login_entry_widget.dart';

class LoginPage extends StatefulWidget {
  final Function(Accesstoken) onLogin;
  final Function(Object) onException;
  final String? reason;

  const LoginPage(
      {super.key,
      this.reason,
      required this.onLogin,
      required this.onException});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) {
            return;
          } else {}
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(AppLocalizations.of(context).loginTitle,
                        style: Theme.of(context).textTheme.headlineMedium),
                  ),
                  if (widget.reason != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(widget.reason!,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  LoginEntryWidget(
                    authRepo: authenticationRepository,
                    onLogin: widget.onLogin,
                    onException: widget.onException,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
