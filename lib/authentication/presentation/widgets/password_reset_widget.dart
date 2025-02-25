import 'package:batt_ds/batt_ds.dart';
import 'package:dart_auth/authentication/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:dart_auth/l10n/auth_localizations.dart';

final class PasswordResetWidget extends StatefulWidget {
  final Function(bool, String) onReset;
  final Function(Object) onException;

  final String? email;
  final AuthRepository authRepo;

  const PasswordResetWidget({
    super.key,
    this.email,
    required this.authRepo,
    required this.onReset,
    required this.onException,
  });

  @override
  PasswordResetWidgetState createState() => PasswordResetWidgetState();
}

class PasswordResetWidgetState extends State<PasswordResetWidget> {
  final _formKey = GlobalKey<FormState>();

  String userName = "";

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
                    labelText: AuthLocalizations.of(context).passwordFieldTitle,
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
                OrangeSolidTextButton(
                    label:
                        AuthLocalizations.of(context).resetPasswordButtonTitle,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final success = await widget.authRepo
                              .resetPassword(email: userName);
                          widget.onReset(success, userName);
                        } catch (e, _) {
                          widget.onException(e);
                        }
                      }
                    })
              ]
                  .map((e) => Padding(
                        padding: AppPaddings.xlarge.vertical,
                        child: e,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
