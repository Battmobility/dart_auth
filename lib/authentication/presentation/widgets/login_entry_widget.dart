import 'package:batt_ds/batt_ds.dart';
import 'package:batt_auth/authentication/domain/domain.dart';
import 'package:batt_auth/l10n/auth_localizations.dart';
import 'package:batt_ds/molecules/buttons/batt_text_button.dart';
import 'package:batt_ds/molecules/buttons/text/batt_simple_text_button.dart';
import 'package:flutter/material.dart';

class LoginEntryWidget extends StatefulWidget {
  final AuthRepository authRepo;
  final Function(Accesstoken) onLogin;
  final Function(Object) onException;
  final String? email;
  final String? password;
  final bool showResendVerificationEmail;

  const LoginEntryWidget({
    super.key,
    required this.authRepo,
    required this.onLogin,
    required this.onException,
    this.email,
    this.password,
    this.showResendVerificationEmail = false,
  });

  @override
  State<LoginEntryWidget> createState() => _LoginEntryWidgetState();
}

class _LoginEntryWidgetState extends State<LoginEntryWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    if (widget.email != null && widget.password != null) {
      setState(() {
        userName = widget.email!;
        password = widget.password!;
      });
    }
  }

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
            padding: AppPaddings.xlarge.all.subtract(AppPaddings.xlarge.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: AuthLocalizations.of(context).emailFieldTitle,
                  ),
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
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.text,
                  onEditingComplete: () async {
                    if (_formKey.currentState!.validate()) {
                      _login(userName, password);
                    }
                  },
                ),
                DefaultSolidTextButton(
                    label: AuthLocalizations.of(context).loginButtonTitle,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _login(userName, password);
                      }
                    }),
                if (widget.showResendVerificationEmail)
                  DefaultSimpleTextButton(
                      label: AuthLocalizations.of(context)
                          .resendVerificationEmailTitle,
                      onPressed: () {
                        _resendVerificationEmail(context, userName);
                      }),
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

  void _login(String email, String password) async {
    try {
      final token =
          await widget.authRepo.loginUser(userName: email, password: password);
      widget.onLogin(token);
    } catch (e, _) {
      widget.onException(e);
    }
  }

  Future<void> _resendVerificationEmail(
      BuildContext context, String email) async {
    final success = await widget.authRepo.resendVerificationEmail(email: email);
    if (context.mounted) {
      final l10n = AuthLocalizations.of(context);
      showDialog(
        context: context,
        builder: (ctx) {
          return BattDialog(
              title: success
                  ? l10n.resendVerificationEmailConfirmationDialogTitle(email)
                  : l10n.resendVerificationEmailFailureDialogTitle,
              actions: [
                DefaultSimpleTextButton(
                    label: "Ok",
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    })
              ]).build(ctx);
        },
      );
    }
  }
}
