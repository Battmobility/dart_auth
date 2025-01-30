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
}
