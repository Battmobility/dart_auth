import 'package:batt_auth/authentication/presentation/widgets/checkbox_form_field.dart';
import 'package:batt_ds/batt_ds.dart';
import 'package:batt_auth/authentication/domain/domain.dart';
import 'package:batt_auth/l10n/auth_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final class CreateLoginWidget extends StatefulWidget {
  final Function(bool, String, String) onCreated;
  final Function onLoginPressed;
  final Function(Object) onException;
  final AuthRepository authRepo;

  const CreateLoginWidget({
    super.key,
    required this.authRepo,
    required this.onCreated,
    required this.onException,
    required this.onLoginPressed,
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
    final l10n = AuthLocalizations.of(context);
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
                Text(l10n.emailFieldTitle,
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
                      return l10n.loginErrorShortUsername;
                    }
                    if (value.length < 4) {
                      return l10n.loginErrorShortUsername;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: AppSpacings.md),
                Text(l10n.choosePasswordFieldTitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.neutralColors[600])),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.neutralColors[600],
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
                      return l10n.loginErrorShortPassword;
                    }
                    if (value.length < 8) {
                      return l10n.loginErrorShortPassword;
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
                SizedBox(height: AppSpacings.md),
                CheckboxFormField(
                  validator: (value) => value == true
                      ? null
                      : l10n.createAccountMustAcceptTermsMessage,
                  title: RichText(
                      text: TextSpan(
                          text: l10n.createAccountTandCLabelPt1,
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                        TextSpan(
                            text: l10n.createAccountTandCLabelToC,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(Uri.parse(
                                    "https://www.battmobility.be/algemenevoorwaarden/"));
                              },
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    decoration: TextDecoration.underline)),
                        TextSpan(
                            text: l10n.createAccountTandCLabelPt2,
                            style: Theme.of(context).textTheme.bodyLarge),
                        TextSpan(
                            text: l10n.createAccountTandCLabelPP,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(Uri.parse(
                                    "https://www.battmobility.be/privacy-voorwaarden/"));
                              },
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    decoration: TextDecoration.underline)),
                      ])),
                ),
                SizedBox(height: AppSpacings.xs),
                SolidCtaButton(
                    label: l10n.createAccountButtonTitle,
                    onPressed: () {
                      _createLogin(userName, password);
                    }),
                Padding(
                  padding: AppPaddings.medium.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: AppPaddings.medium.trailing,
                              child: Divider(),
                            ),
                          ),
                          Text(AuthLocalizations.of(context).useAccountLabel,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColors.neutralColors[600])),
                          Expanded(
                            child: Padding(
                              padding: AppPaddings.medium.leading,
                              child: Divider(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                DefaultOutlinedTextButton(
                  label: AuthLocalizations.of(context).loginButtonTitle,
                  onPressed: () {
                    widget.onLoginPressed();
                  },
                ),
              ]
                  .map((e) => Padding(
                        padding: AppPaddings.xsmall.vertical,
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
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      try {
        final success = await widget.authRepo
            .registerUser(email: email, password: password);
        widget.onCreated(success, email, password);
      } catch (e, _) {
        widget.onException(e);
      }
    }
  }
}
