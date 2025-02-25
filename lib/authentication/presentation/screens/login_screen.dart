import 'package:batt_ds/batt_ds.dart';
import 'package:dart_auth/authentication/domain/domain.dart';
import 'package:dart_auth/dart_auth.dart';
import 'package:dart_auth/l10n/auth_localizations.dart';
import 'package:flutter/material.dart';

import '../widgets/create_login_widget.dart';
import '../widgets/login_entry_widget.dart';
import '../widgets/password_reset_widget.dart';

class LoginPage extends StatefulWidget {
  final Function(Accesstoken) onLogin;
  final Function(Object) onException;
  final String? reason;
  final AuthScreens? initialScreen;

  const LoginPage({
    required this.onLogin,
    required this.onException,
    super.key,
    this.reason,
    this.initialScreen = AuthScreens.login,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthScreens activeScreen;

  @override
  void initState() {
    super.initState();
    activeScreen = widget.initialScreen ?? AuthScreens.login;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) {
            return;
          } else {}
        },
        child: Center(
          heightFactor: 1.5,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              child: Padding(
                padding: AppPaddings.large.all,
                child: Stack(
                  children: [
                    // Log in
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: AppPaddings.medium.vertical,
                              child: Text(
                                  AuthLocalizations.of(context).loginTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                            ),
                            DefaultSimpleTextButton(
                              label: AuthLocalizations.of(context)
                                  .createAccountTitle,
                              buttonSize: BattButtonSize.large,
                              onPressed: () {
                                setState(() {
                                  activeScreen = AuthScreens.register;
                                });
                              },
                            )
                          ],
                        ),
                        if (widget.reason != null)
                          Padding(
                            padding: AppPaddings.medium.bottom,
                            child: Text(widget.reason!,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        LoginEntryWidget(
                          authRepo: authenticationRepository,
                          onLogin: widget.onLogin,
                          onException: widget.onException,
                        ),
                        DefaultSimpleTextButton(
                          label:
                              AuthLocalizations.of(context).createAccountTitle,
                          buttonSize: BattButtonSize.small,
                          onPressed: () {
                            setState(() {
                              activeScreen = AuthScreens.forgotPassword;
                            });
                          },
                        )
                      ],
                    ),
                    // Create account
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                  AuthLocalizations.of(context)
                                      .createAccountTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                            ),
                            DefaultSimpleTextButton(
                              label: AuthLocalizations.of(context).loginTitle,
                              buttonSize: BattButtonSize.large,
                              onPressed: () {
                                setState(() {
                                  activeScreen = AuthScreens.login;
                                });
                              },
                            )
                          ],
                        ),
                        CreateLoginWidget(
                          authRepo: authenticationRepository,
                          onCreated: (success, email) {
                            if (success) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: Text(AuthLocalizations.of(context)
                                          .createAccountSuccessMessage(email)),
                                      actions: [
                                        OrangeSolidTextButton(
                                            label: AuthLocalizations.of(context)
                                                .loginTitle,
                                            onPressed: () {
                                              Navigator.pop(context);
                                              setState(() {
                                                activeScreen =
                                                    AuthScreens.login;
                                              });
                                            })
                                      ]);
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: Text(AuthLocalizations.of(context)
                                          .createAccountFailureMessage),
                                      actions: [
                                        OrangeSolidTextButton(
                                            label: AuthLocalizations.of(context)
                                                .loginTitle,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            })
                                      ]);
                                },
                              );
                            }
                          },
                          onException: (e) => {
                            ScaffoldMessenger.of(context).showSnackBar(
                              BattSnackbar.error(
                                title: AuthLocalizations.of(context)
                                    .createAccountFailureMessage,
                                message: e.toString(),
                              ).build(context),
                            )
                          },
                        ),
                      ],
                    ),
                    // Reset password
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: AppPaddings.medium.vertical,
                              child: Text(
                                  AuthLocalizations.of(context)
                                      .resetPasswordTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                            ),
                            DefaultSimpleTextButton(
                              label: AuthLocalizations.of(context).loginTitle,
                              buttonSize: BattButtonSize.large,
                              onPressed: () {
                                setState(() {
                                  activeScreen = AuthScreens.login;
                                });
                              },
                            )
                          ],
                        ),
                        PasswordResetWidget(
                          authRepo: authenticationRepository,
                          onReset: (success, email) => {
                            if (success)
                              {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title: Text(
                                            AuthLocalizations.of(context)
                                                .resetPasswordSuccessMessage(
                                                    email)),
                                        actions: [
                                          OrangeSolidTextButton(
                                              label:
                                                  AuthLocalizations.of(context)
                                                      .loginTitle,
                                              onPressed: () {
                                                Navigator.pop(context);
                                                setState(() {
                                                  activeScreen =
                                                      AuthScreens.login;
                                                });
                                              })
                                        ]);
                                  },
                                )
                              }
                            else
                              {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title: Text(
                                            AuthLocalizations.of(context)
                                                .resetPasswordFailureMessage),
                                        actions: [
                                          OrangeSolidTextButton(
                                              label:
                                                  AuthLocalizations.of(context)
                                                      .loginTitle,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              })
                                        ]);
                                  },
                                )
                              }
                          },
                          onException: (e) => {
                            ScaffoldMessenger.of(context).showSnackBar(
                              BattSnackbar.error(
                                title: AuthLocalizations.of(context)
                                    .createAccountFailureMessage,
                                message: e.toString(),
                              ).build(context),
                            )
                          }, // TODO: show dialog,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
