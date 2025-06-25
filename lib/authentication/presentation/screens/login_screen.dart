import 'package:batt_ds/batt_ds.dart';
import 'package:batt_auth/authentication/domain/domain.dart';
import 'package:batt_auth/batt_auth.dart';
import 'package:batt_auth/l10n/auth_localizations.dart';
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

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AuthScreens activeScreen;
  bool showResendVerificationEmail = false;
  String? email;
  String? password;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isForwardNavigation = true;

  @override
  void initState() {
    super.initState();
    activeScreen = widget.initialScreen ?? AuthScreens.login;

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Start with completed animation
    _animationController.value = 1.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _changeScreen(AuthScreens newScreen) {
    _isForwardNavigation = _getNavigationDirection(activeScreen, newScreen);

    _animationController.reverse().then((_) {
      setState(() {
        activeScreen = newScreen;
      });
      _animationController.forward();
    });
  }

  bool _getNavigationDirection(AuthScreens current, AuthScreens target) {
    // Define a simple screen hierarchy: login < register < forgotPassword
    final screenOrder = {
      AuthScreens.login: 0,
      AuthScreens.register: 1,
      AuthScreens.forgotPassword: 2
    };

    return screenOrder[target]! > screenOrder[current]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                child: Card(
                  child: Padding(
                    padding: AppPaddings.medium.vertical,
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        // Calculate slide offset based on animation state and direction
                        final slideOffset = _isForwardNavigation
                            ? Tween<Offset>(
                                begin: const Offset(0.0, 0.3),
                                end: Offset.zero,
                              ).evaluate(_fadeAnimation)
                            : Tween<Offset>(
                                begin: const Offset(0.0, -0.3),
                                end: Offset.zero,
                              ).evaluate(_fadeAnimation);

                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: Transform.translate(
                            offset: Offset(
                                0,
                                slideOffset.dy *
                                    100), // Scale for more visible effect
                            child: _activeWidget(),
                          ),
                        );
                      },
                    ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: AppPaddings.xlarge.horizontal,
                child: Text(AuthLocalizations.of(context).loginTitle,
                    maxLines: 3, style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            if (widget.reason != null)
              Padding(
                padding: AppPaddings.medium.bottom,
                child: Text(widget.reason!,
                    style: Theme.of(context).textTheme.titleSmall),
              ),
            LoginEntryWidget(
                authRepo: authenticationRepository,
                onLogin: widget.onLogin,
                onException: widget.onException,
                onCreateAccountPressed: () {
                  _changeScreen(AuthScreens.register);
                },
                onResetPasswordPressed: () {
                  _changeScreen(AuthScreens.forgotPassword);
                },
                email: email,
                password: password,
                showResendVerificationEmail: showResendVerificationEmail),
          ],
        );
      case AuthScreens.forgotPassword:
        return Column(
          key: UniqueKey(),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: AppPaddings.xlarge.horizontal,
                child: Text(AuthLocalizations.of(context).resetPasswordTitle,
                    maxLines: 3, style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            PasswordResetWidget(
              authRepo: authenticationRepository,
              onReset: (success, email) => {
                if (success)
                  {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BattDialog(
                            title: AuthLocalizations.of(context)
                                .resetPasswordSuccessMessage(email),
                            actions: [
                              DefaultSolidTextButton(
                                label: AuthLocalizations.of(context).loginTitle,
                                onPressed: () {
                                  Navigator.pop(context);
                                  _changeScreen(AuthScreens.login);
                                },
                              )
                            ]).build(context);
                      },
                    )
                  }
                else
                  {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BattDialog(
                            title: AuthLocalizations.of(context)
                                .resetPasswordFailureMessage,
                            actions: [
                              DefaultSolidTextButton(
                                label: AuthLocalizations.of(context).loginTitle,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ]).build(context);
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
              onCancel: () {
                _changeScreen(AuthScreens.login);
              },
            ),
          ],
        );
      case AuthScreens.register:
        return Column(
          key: UniqueKey(),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: AppPaddings.xlarge.horizontal,
                child: Text(AuthLocalizations.of(context).createAccountTitle,
                    maxLines: 3, style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            CreateLoginWidget(
              authRepo: authenticationRepository,
              onCreated: (success, email, password) {
                if (success) {
                  this.email = email;
                  this.password = password;
                  showResendVerificationEmail = true;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return BattDialog(
                          title: AuthLocalizations.of(context)
                              .createAccountSuccessMessage(email),
                          actions: [
                            DefaultSolidTextButton(
                              label: AuthLocalizations.of(context).loginTitle,
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  activeScreen = AuthScreens.login;
                                });
                              },
                            )
                          ]).build(context);
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return BattDialog(
                          title: AuthLocalizations.of(context)
                              .createAccountFailureMessage,
                          actions: [
                            DefaultSolidTextButton(
                              label: AuthLocalizations.of(context).loginTitle,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ]).build(context);
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
              onLoginPressed: () {
                _changeScreen(AuthScreens.login);
              },
            ),
          ],
        );
    }
  }
}
