import 'auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AuthLocalizationsNl extends AuthLocalizations {
  AuthLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get loginTitle => 'Meld je aan';

  @override
  String get loginButtonTitle => 'Log in';

  @override
  String get emailFieldTitle => 'E-mail';

  @override
  String get passwordFieldTitle => 'Wachtwoord';

  @override
  String get loginErrorShortUsername => 'Gebruikersnaam moet minstens zes karakters lang zijn';

  @override
  String get loginErrorShortPassword => 'Wachtwoord moet minstens zes karakters lang zijn';

  @override
  String get loginErrorMessage => 'Er ging iets verkeerd bij het afmelden. Gelieve te controleren of je verbinding hebt met internet en probeer daarna opnieuw.';

  @override
  String get createAccountTitle => 'Word Batt';

  @override
  String get createAccountButtonTitle => 'Maak account';

  @override
  String createAccountSuccessMessage(Object email) {
    return 'Er werd een link om het emailadres te bevestigen verstuurd naar $email.';
  }

  @override
  String get createAccountFailureMessage => 'Sorry, er was een probleem bij het aanmaken van een account. Probeer later nogmaals of neem contact op met onze klantendienst.';

  @override
  String get resetPasswordTitle => 'Stel wachtwoord opnieuw in';

  @override
  String get resetPasswordLabel => 'Voer het emailadres van je account in om je wachtwoord opnieuw in te stellen.';

  @override
  String get resetPasswordButtonTitle => 'Stel opnieuw in';

  @override
  String resetPasswordSuccessMessage(Object email) {
    return 'Er werd een link om het wachtwoord opnieuw in te stellen verstuurd naar $email.';
  }

  @override
  String get resetPasswordFailureMessage => 'Sorry, er was een probleem bij het opnieuw instellen. Probeer later nogmaals of neem contact op met onze klantendienst.';
}
