import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'auth_localizations_en.dart';
import 'auth_localizations_fr.dart';
import 'auth_localizations_nl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AuthLocalizations
/// returned by `AuthLocalizations.of(context)`.
///
/// Applications need to include `AuthLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/auth_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AuthLocalizations.localizationsDelegates,
///   supportedLocales: AuthLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AuthLocalizations.supportedLocales
/// property.
abstract class AuthLocalizations {
  AuthLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AuthLocalizations of(BuildContext context) {
    return Localizations.of<AuthLocalizations>(context, AuthLocalizations)!;
  }

  static const LocalizationsDelegate<AuthLocalizations> delegate =
      _AuthLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('nl')
  ];

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginTitle;

  /// No description provided for @genericCancelLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get genericCancelLabel;

  /// No description provided for @loginButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginButtonTitle;

  /// No description provided for @loginfailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginfailedMessage;

  /// No description provided for @emailFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailFieldTitle;

  /// No description provided for @passwordFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordFieldTitle;

  /// No description provided for @loginErrorShortUsername.
  ///
  /// In en, this message translates to:
  /// **'Username must be at least 6 characters long'**
  String get loginErrorShortUsername;

  /// No description provided for @loginErrorShortPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get loginErrorShortPassword;

  /// No description provided for @forgotPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordLabel;

  /// No description provided for @loginErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while trying to log in. Please ensure you are connected to the internet and try again.'**
  String get loginErrorMessage;

  /// No description provided for @createAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'No account yet?'**
  String get createAccountLabel;

  /// No description provided for @useAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'Already a member?'**
  String get useAccountLabel;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccountTitle;

  /// No description provided for @createAccountButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createAccountButtonTitle;

  /// No description provided for @choosePasswordFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose password'**
  String get choosePasswordFieldTitle;

  /// No description provided for @createAccountSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'A link to verify your email address was sent to {email}. Please check your spam folder as well.'**
  String createAccountSuccessMessage(Object email);

  /// No description provided for @createAccountTandCLabelPt1.
  ///
  /// In en, this message translates to:
  /// **'I agree with the '**
  String get createAccountTandCLabelPt1;

  /// No description provided for @createAccountTandCLabelToC.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get createAccountTandCLabelToC;

  /// No description provided for @createAccountTandCLabelPt2.
  ///
  /// In en, this message translates to:
  /// **' and the '**
  String get createAccountTandCLabelPt2;

  /// No description provided for @createAccountTandCLabelPP.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy.'**
  String get createAccountTandCLabelPP;

  /// No description provided for @createAccountMustAcceptTermsMessage.
  ///
  /// In en, this message translates to:
  /// **'You must accept our terms to become a member.'**
  String get createAccountMustAcceptTermsMessage;

  /// No description provided for @createAccountFailureMessage.
  ///
  /// In en, this message translates to:
  /// **'Sorry, there was an error creating your account. If the problem persists, please contact support.'**
  String get createAccountFailureMessage;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordTitle;

  /// No description provided for @resendVerificationEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Resend verification email'**
  String get resendVerificationEmailTitle;

  /// No description provided for @resendVerificationEmailConfirmationDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification email re-sent to {email}.'**
  String resendVerificationEmailConfirmationDialogTitle(Object email);

  /// No description provided for @resendVerificationEmailFailureDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Failed to re-send verification email'**
  String get resendVerificationEmailFailureDialogTitle;

  /// No description provided for @resetPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter the email address associated with your account to reset the password.'**
  String get resetPasswordLabel;

  /// No description provided for @resetPasswordButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetPasswordButtonTitle;

  /// No description provided for @resetPasswordSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'A link to reset the password was sent to {email}.'**
  String resetPasswordSuccessMessage(Object email);

  /// No description provided for @resetPasswordFailureMessage.
  ///
  /// In en, this message translates to:
  /// **'Sorry, there was an error resetting your password. If the problem persists, please contact support.'**
  String get resetPasswordFailureMessage;

  /// No description provided for @passwordSafetyConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'I have saved my password in a safe place so I can use it to login to the mobile application later.'**
  String get passwordSafetyConfirmationMessage;

  /// No description provided for @passwordSafetyMustConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'You must confirm that you have saved your password.'**
  String get passwordSafetyMustConfirmMessage;
}

class _AuthLocalizationsDelegate
    extends LocalizationsDelegate<AuthLocalizations> {
  const _AuthLocalizationsDelegate();

  @override
  Future<AuthLocalizations> load(Locale locale) {
    return SynchronousFuture<AuthLocalizations>(
        lookupAuthLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AuthLocalizationsDelegate old) => false;
}

AuthLocalizations lookupAuthLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AuthLocalizationsEn();
    case 'fr':
      return AuthLocalizationsFr();
    case 'nl':
      return AuthLocalizationsNl();
  }

  throw FlutterError(
      'AuthLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
