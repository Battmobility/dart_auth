import 'package:batt_ds/batt_ds.dart';
import 'package:batt_auth/authentication/data/services/api_exception.dart';
import 'package:batt_auth/authentication/domain/domain.dart';
import 'package:batt_auth/l10n/auth_localizations.dart';
import 'package:flutter/material.dart';

class LoginEntryWidget extends StatefulWidget {
  final AuthRepository authRepo;
  final Function(Accesstoken) onLogin;
  final Function onResetPasswordPressed;
  final Function onCreateAccountPressed;
  final Function(Object) onException;
  final String? email;
  final String? password;
  final bool showResendVerificationEmail;
  final bool showAccountCreation;

  const LoginEntryWidget({
    super.key,
    required this.authRepo,
    required this.onLogin,
    required this.onException,
    required this.onResetPasswordPressed,
    required this.onCreateAccountPressed,
    this.email,
    this.password,
    this.showResendVerificationEmail = false,
    this.showAccountCreation = true,
  });

  @override
  State<LoginEntryWidget> createState() => _LoginEntryWidgetState();
}

class _LoginEntryWidgetState extends State<LoginEntryWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email ?? '');
    _passwordController = TextEditingController(text: widget.password ?? '');
  }

  @override
  void didUpdateWidget(LoginEntryWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.email != oldWidget.email) {
      _emailController.text = widget.email ?? '';
    }
    if (widget.password != oldWidget.password) {
      _passwordController.text = widget.password ?? '';
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String get userName => _emailController.text;
  String get password => _passwordController.text;

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
                spacing: AppSpacings.sm,
                children: [
                  Text(AuthLocalizations.of(context).emailFieldTitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.neutralColors[600])),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(),
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
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
                  SizedBox(height: AppSpacings.sm),
                  Text(AuthLocalizations.of(context).passwordFieldTitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.neutralColors[600])),
                  TextFormField(
                    controller: _passwordController,
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
                  SizedBox(height: AppSpacings.md),
                  SolidCtaButton(
                      label: AuthLocalizations.of(context).loginButtonTitle,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login(userName, password);
                        }
                      }),
                  DefaultOutlinedTextButton(
                    label: AuthLocalizations.of(context).resetPasswordTitle,
                    onPressed: () {
                      widget.onResetPasswordPressed();
                    },
                  ),
                  if (widget.showAccountCreation) ...[
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
                              Text(
                                  AuthLocalizations.of(context)
                                      .createAccountLabel,
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
                      label: AuthLocalizations.of(context).createAccountTitle,
                      onPressed: () {
                        widget.onCreateAccountPressed();
                      },
                    ),
                  ],
                  if (widget.showResendVerificationEmail)
                    OutlinedCtaButton(
                        label: AuthLocalizations.of(context)
                            .resendVerificationEmailTitle,
                        onPressed: () {
                          _resendVerificationEmail(context, _emailController.text);
                        }),
                ]),
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
      if (e is ApiException && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          BattSnackbar.error(
            title: AuthLocalizations.of(context).createAccountFailureMessage,
            message: e.message,
          ).build(context),
        );
      }
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
