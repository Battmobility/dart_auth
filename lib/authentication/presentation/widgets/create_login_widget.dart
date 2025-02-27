import 'package:batt_ds/batt_ds.dart';
import 'package:dart_auth/authentication/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:dart_auth/l10n/auth_localizations.dart';

final class CreateLoginWidget extends StatefulWidget {
  final Function(bool, String, String) onCreated;
  final Function(Object) onException;
  final AuthRepository authRepo;

  const CreateLoginWidget({
    super.key,
    required this.authRepo,
    required this.onCreated,
    required this.onException,
  });

  @override
  CreateLoginWidgetState createState() => CreateLoginWidgetState();
}

class CreateLoginWidgetState extends State<CreateLoginWidget> {
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
            padding: AppPaddings.xlarge.all,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: AuthLocalizations.of(context).emailFieldTitle,
                  ),
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
                    labelText: AuthLocalizations.of(context).passwordFieldTitle,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
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
                    if (value.length < 8) {
                      return AuthLocalizations.of(context)
                          .loginErrorShortPassword;
                    } else {
                      return null;
                    }
                  },
                  obscureText: _obscurePassword,
                  autofillHints: const [AutofillHints.newPassword],
                  keyboardType: TextInputType.text,
                  onEditingComplete: () async {
                    if (_formKey.currentState!.validate()) {
                      _createLogin(userName, password);
                    }
                  },
                ),
                OrangeSolidTextButton(
                    label:
                        AuthLocalizations.of(context).createAccountButtonTitle,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _createLogin(userName, password);
                      }
                    })
              ]
                  .map((e) => Padding(
                        padding: AppPaddings.small.vertical,
                        child: e,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _createLogin(String email, String password) async {
    try {
      final success =
          await widget.authRepo.registerUser(email: email, password: password);
      widget.onCreated(success, email, password);
    } catch (e, _) {
      widget.onException(e);
    }
  }
}
