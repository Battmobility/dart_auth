// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AuthLocalizationsFr extends AuthLocalizations {
  AuthLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get loginTitle => 'Log in';

  @override
  String get genericCancelLabel => 'Cancel';

  @override
  String get loginButtonTitle => 'Log in';

  @override
  String get loginfailedMessage => 'Login failed';

  @override
  String get emailFieldTitle => 'E-mail';

  @override
  String get passwordFieldTitle => 'Wachtwoord';

  @override
  String get loginErrorShortUsername =>
      'Username must be at least 6 characters long';

  @override
  String get loginErrorShortPassword =>
      'Password must be at least 8 characters long';

  @override
  String get forgotPasswordLabel => 'Forgot password?';

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
    return 'Un lien pour vérifier votre adresse e-mail a été envoyé à $email. Veuillez également vérifier votre dossier spam.';
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
      'J\'ai sauvegardé mon mot de passe dans un endroit sûr pour pouvoir l\'utiliser pour me connecter à l\'application mobile plus tard.';

  @override
  String get passwordSafetyMustConfirmMessage =>
      'Vous devez confirmer que vous avez sauvegardé votre mot de passe.';
}
