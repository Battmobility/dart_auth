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

  String? email;
  String? password;

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
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: SingleChildScrollView(
                child: Padding(
                  padding: AppPaddings.xlarge.all.add(AppPaddings.large.top),
                  child: Card(
                    child: Padding(
                        padding: AppPaddings.medium.vertical,
                        child: _activeWidget()),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _activeWidget() {
    switch (activeScreen) {
      case AuthScreens.login:
        return Column(
          key: UniqueKey(),
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: AppPaddings.xlarge.horizontal,
                    child: Text(AuthLocalizations.of(context).loginTitle,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.headlineMedium),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: DefaultSimpleTextButton(
                    label: AuthLocalizations.of(context).createAccountTitle,
                    buttonSize: BattButtonSize.large,
                    onPressed: () {
                      setState(() {
                        activeScreen = AuthScreens.register;
                      });
                    },
                  ),
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
              email: email,
              password: password,
            ),
            DefaultSimpleTextButton(
              label: AuthLocalizations.of(context).resetPasswordTitle,
              onPressed: () {
                setState(() {
                  activeScreen = AuthScreens.forgotPassword;
                });
              },
            )
          ],
        );
      case AuthScreens.forgotPassword:
        return Column(
          key: UniqueKey(),
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: AppPaddings.xlarge.horizontal,
                    child: Text(
                        AuthLocalizations.of(context).resetPasswordTitle,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.headlineMedium),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: DefaultSimpleTextButton(
                    label: AuthLocalizations.of(context).loginTitle,
                    buttonSize: BattButtonSize.large,
                    onPressed: () {
                      setState(() {
                        activeScreen = AuthScreens.login;
                      });
                    },
                  ),
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
                            title: Text(AuthLocalizations.of(context)
                                .resetPasswordSuccessMessage(email)),
                            actions: [
                              OrangeSolidTextButton(
                                  label:
                                      AuthLocalizations.of(context).loginTitle,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      activeScreen = AuthScreens.login;
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
                            title: Text(AuthLocalizations.of(context)
                                .resetPasswordFailureMessage),
                            actions: [
                              OrangeSolidTextButton(
                                  label:
                                      AuthLocalizations.of(context).loginTitle,
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
              },
            ),
          ],
        );
      case AuthScreens.register:
        return Column(
          key: UniqueKey(),
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: AppPaddings.xlarge.horizontal,
                    child: Text(
                        AuthLocalizations.of(context).createAccountTitle,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.headlineMedium),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: DefaultSimpleTextButton(
                    label: AuthLocalizations.of(context).loginTitle,
                    buttonSize: BattButtonSize.large,
                    onPressed: () {
                      setState(() {
                        activeScreen = AuthScreens.login;
                      });
                    },
                  ),
                )
              ],
            ),
            CreateLoginWidget(
              authRepo: authenticationRepository,
              onCreated: (success, email, password) {
                if (success) {
                  this.email = email;
                  this.password = password;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: Text(AuthLocalizations.of(context)
                              .createAccountSuccessMessage(email)),
                          actions: [
                            OrangeSolidTextButton(
                                label: AuthLocalizations.of(context).loginTitle,
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    activeScreen = AuthScreens.login;
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
                                label: AuthLocalizations.of(context).loginTitle,
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
        );
    }
  }
}
