// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AuthLocalizationsEn extends AuthLocalizations {
  AuthLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginTitle => 'Log in';

  @override
  String get genericCancelLabel => 'Cancel';

  @override
  String get loginButtonTitle => 'Log in';

  @override
  String get loginfailedMessage => 'Login failed';

  @override
  String get emailFieldTitle => 'Email';

  @override
  String get passwordFieldTitle => 'Password';

  @override
  String get loginErrorShortUsername =>
      'Username must be at least 6 characters long';

  @override
  String get loginErrorInvalidEmail => 'Username must be a valid email address';

  @override
  String get loginErrorShortPassword =>
      'Password must be at least 8 characters long';

  @override
  String get forgotPasswordLabel => 'Forgot password?';

  @override
  String get loginErrorUnauthorized => 'Login failed, check your credentials';

  @override
  String get loginErrorMessage =>
      'Something went wrong while trying to log in. Please ensure you are connected to the internet and try again.';

  @override
  String get createAccountLabel => 'No account yet?';

  @override
  String get useAccountLabel => 'Already a member?';

  @override
  String get createAccountTitle => 'Create account';

  @override
  String get createAccountButtonTitle => 'Create';

  @override
  String get choosePasswordFieldTitle => 'Choose password';

  @override
  String createAccountSuccessMessage(Object email) {
    return 'A link to verify your email address was sent to $email. Please check your spam folder as well.';
  }

  @override
  String get createAccountTandCLabelPt1 => 'I agree with the ';

  @override
  String get createAccountTandCLabelToC => 'Terms of Use';

  @override
  String get createAccountTandCLabelPt2 => ' and the ';

  @override
  String get createAccountTandCLabelPP => 'Privacy policy.';

  @override
  String get createAccountMustAcceptTermsMessage =>
      'You must accept our terms to become a member.';

  @override
  String get createAccountFailureMessage =>
      'Sorry, there was an error creating your account. If the problem persists, please contact support.';

  @override
  String get resetPasswordTitle => 'Reset password';

  @override
  String get resendVerificationEmailTitle => 'Resend verification email';

  @override
  String resendVerificationEmailConfirmationDialogTitle(Object email) {
    return 'Verification email re-sent to $email.';
  }

  @override
  String get resendVerificationEmailFailureDialogTitle =>
      'Failed to re-send verification email';

  @override
  String get resetPasswordLabel =>
      'Enter the email address associated with your account to reset the password.';

  @override
  String get resetPasswordButtonTitle => 'Reset';

  @override
  String resetPasswordSuccessMessage(Object email) {
    return 'A link to reset the password was sent to $email.';
  }

  @override
  String get resetPasswordFailureMessage =>
      'Sorry, there was an error resetting your password. If the problem persists, please contact support.';

  @override
  String get passwordSafetyConfirmationMessage =>
      'I have saved my password in a safe place so I can use it to login to the mobile application later.';

  @override
  String get passwordSafetyMustConfirmMessage =>
      'You must confirm that you have saved your password.';
}
