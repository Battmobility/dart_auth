import 'auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AuthLocalizationsFr extends AuthLocalizations {
  AuthLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get loginTitle => 'Log in';

  @override
  String get loginButtonTitle => 'Log in';

  @override
  String get loginErrorShortUsername => 'Username must be at least 6 characters long';

  @override
  String get loginErrorShortPassword => 'Password must be at least 6 characters long';

  @override
  String get loginErrorMessage => 'Something went wrong while trying to log in. Please ensure you are connected to the internet and try again.';

  @override
  String get createAccountTitle => 'Create account';

  @override
  String get resetPasswordTitle => 'Reset password';

  @override
  String get resetPasswordLabel => 'Enter the email address associated with your account to reset the password.';
}
