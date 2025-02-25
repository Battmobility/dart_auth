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
  String get loginErrorShortUsername => 'Gebruikersnaam moet minstens zes karakters lang zijn';

  @override
  String get loginErrorShortPassword => 'Wachtwoord moet minstens zes karakters lang zijn';

  @override
  String get loginErrorMessage => 'Er ging iets verkeerd bij het afmelden. Gelieve te controleren of je verbinding hebt met internet en probeer daarna opnieuw.';

  @override
  String get createAccountTitle => 'Word Batt';

  @override
  String get resetPasswordTitle => 'Stel wachtwoord opnieuw in';

  @override
  String get resetPasswordLabel => 'Voer het emailadres van je account in om je wachtwoord opnieuw in te stellen.';
}
