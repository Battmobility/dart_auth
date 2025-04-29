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
  String get emailFieldTitle => 'E-mail';

  @override
  String get passwordFieldTitle => 'Wachtwoord';

  @override
  String get loginErrorShortUsername => 'Username must be at least 6 characters long';

  @override
  String get loginErrorShortPassword => 'Password must be at least 8 characters long';

  @override
  String get loginErrorMessage => 'Something went wrong while trying to log in. Please ensure you are connected to the internet and try again.';

  @override
  String get createAccountTitle => 'Create account';

  @override
  String get createAccountButtonTitle => 'Create';

  @override
  String get choosePasswordFieldTitle => 'Choose password';

  @override
  String createAccountSuccessMessage(Object email) {
    return 'A link to verify your email address was sent to $email.';
  }

  @override
  String get createAccountFailureMessage => 'Sorry, there was an error creating your account. If the problem persists, please contact support.';

  @override
  String get resetPasswordTitle => 'Reset password';

  @override
  String get resendVerificationEmailTitle => 'Resend verification email';

  @override
  String resendVerificationEmailConfirmationDialogTitle(Object email) {
    return 'Verification email re-sent to $email.';
  }

  @override
  String get resendVerificationEmailFailureDialogTitle => 'Failed to re-send verification email';

  @override
  String get resetPasswordLabel => 'Enter the email address associated with your account to reset the password.';

  @override
  String get resetPasswordButtonTitle => 'Reset';

  @override
  String resetPasswordSuccessMessage(Object email) {
    return 'A link to reset the password was sent to $email.';
  }

  @override
  String get resetPasswordFailureMessage => 'Sorry, there was an error resetting your password. If the problem persists, please contact support.';
}
