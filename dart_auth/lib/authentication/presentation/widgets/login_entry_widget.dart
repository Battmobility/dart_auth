import 'package:dart_auth/authentication/domain/domain.dart';
import 'package:dart_auth/l10n/auth_localizations.dart';
import 'package:flutter/material.dart';

class LoginEntryWidget extends StatefulWidget {
  final AuthRepository authRepo;
  final Function(Accesstoken) onLogin;
  final Function(Object) onException;

  const LoginEntryWidget(
      {super.key,
      required this.authRepo,
      required this.onLogin,
      required this.onException});

  @override
  State<LoginEntryWidget> createState() => _LoginEntryWidgetState();
}

class _LoginEntryWidgetState extends State<LoginEntryWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: emailController,
                autofillHints: const [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                validator: (value) {
                  if (value == null) {
                    return AppLocalizations.of(context)!
                        .loginErrorShortUsername;
                  }
                  if (value.length < 4) {
                    return AppLocalizations.of(context)!
                        .loginErrorShortUsername;
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return AppLocalizations.of(context)!
                        .loginErrorShortPassword;
                  }
                  if (value.length < 6) {
                    return AppLocalizations.of(context)!
                        .loginErrorShortPassword;
                  } else {
                    return null;
                  }
                },
                controller: passwordController,
                obscureText: true,
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.text,
                onEditingComplete: () async {
                  if (_formKey.currentState!.validate()) {
                    _login(emailController.text, passwordController.text);
                  }
                },
              ),
              OutlinedButton(
                  child: Text(AppLocalizations.of(context).loginButtonTitle),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login(emailController.text, passwordController.text);
                    }
                  })
            ]
                .map((e) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: e,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  void _login(String email, String password) async {
    try {
      final token =
          await widget.authRepo.loginUser(userName: email, password: password);
      widget.onLogin(token);
    } catch (e, _) {
      widget.onException(e);
    }
  }
}
