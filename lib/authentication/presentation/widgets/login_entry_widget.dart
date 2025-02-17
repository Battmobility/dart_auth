import 'package:batt_ds/molecules/buttons/buttons.dart';
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
  bool _obscurePassword = true;

  String userName = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 1000),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  //controller: emailController,
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  onChanged: (value) => userName = value,
                  initialValue: userName,
                  validator: (value) {
                    if (value == null) {
                      return AuthLocalizations.of(context)
                          .loginErrorShortUsername;
                    }
                    if (value.length < 4) {
                      return AuthLocalizations.of(context)
                          .loginErrorShortUsername;
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  onChanged: (value) => password = value,
                  initialValue: password,
                  validator: (value) {
                    if (value == null) {
                      return AuthLocalizations.of(context)
                          .loginErrorShortPassword;
                    }
                    if (value.length < 6) {
                      return AuthLocalizations.of(context)
                          .loginErrorShortPassword;
                    } else {
                      return null;
                    }
                  },
                  //controller: passwordController,
                  obscureText: _obscurePassword,
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.text,
                  onEditingComplete: () async {
                    if (_formKey.currentState!.validate()) {
                      _login(userName, password);
                    }
                  },
                ),
                OrangeSolidTextButton(
                    label: AuthLocalizations.of(context).loginButtonTitle,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _login(userName, password);
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
