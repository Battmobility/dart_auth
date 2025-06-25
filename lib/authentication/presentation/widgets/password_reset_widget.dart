import 'package:batt_ds/batt_ds.dart';
import 'package:batt_auth/authentication/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:batt_auth/l10n/auth_localizations.dart';

final class PasswordResetWidget extends StatefulWidget {
  final Function(bool, String) onReset;
  final Function onCancel;
  final Function(Object) onException;

  final String? email;
  final AuthRepository authRepo;

  const PasswordResetWidget({
    super.key,
    this.email,
    required this.authRepo,
    required this.onReset,
    required this.onException,
    required this.onCancel,
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
            padding: AppPaddings.xlarge.all.subtract(AppPaddings.medium.top),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(AuthLocalizations.of(context).resetPasswordLabel,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.neutralColors[600])),
                TextFormField(
                  decoration: InputDecoration(),
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
                SolidCtaButton(
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
                    }),
                DefaultOutlinedTextButton(
                    label: AuthLocalizations.of(context).genericCancelLabel,
                    onPressed: () async {
                      widget.onCancel();
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
}
