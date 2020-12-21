// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();

  static S current;

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();

      return S.current;
    });
  }

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Loading..`
  String get loadingMessage {
    return Intl.message(
      'Loading..',
      name: 'loadingMessage',
      desc: '',
      args: [],
    );
  }

  /// `assets/engBlank.png`
  String get titleName {
    return Intl.message(
      'assets/engBlank.png',
      name: 'titleName',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get startWord {
    return Intl.message(
      'Start',
      name: 'startWord',
      desc: '',
      args: [],
    );
  }

  /// `Select your Sex`
  String get selectMessage {
    return Intl.message(
      'Select your Sex',
      name: 'selectMessage',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get maleMessage {
    return Intl.message(
      'Male',
      name: 'maleMessage',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get femaleMessage {
    return Intl.message(
      'Female',
      name: 'femaleMessage',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get acceptMessage {
    return Intl.message(
      'Accept',
      name: 'acceptMessage',
      desc: '',
      args: [],
    );
  }

  /// `Indicate your sex!`
  String get selectSexMessage {
    return Intl.message(
      'Indicate your sex!',
      name: 'selectSexMessage',
      desc: '',
      args: [],
    );
  }

  /// `Indicate your sex!`
  String get selectSexAlert {
    return Intl.message(
      'Indicate your sex!',
      name: 'selectSexAlert',
      desc: '',
      args: [],
    );
  }

  /// `Hold the scanner to fill the bar!`
  String get holdMessage {
    return Intl.message(
      'Hold the scanner to fill the bar!',
      name: 'holdMessage',
      desc: '',
      args: [],
    );
  }

  /// `Hold me!`
  String get holdButtonMessage {
    return Intl.message(
      'Hold me!',
      name: 'holdButtonMessage',
      desc: '',
      args: [],
    );
  }

  /// `Dragon`
  String get dragonMessage {
    return Intl.message(
      'Dragon!',
      name: 'dragonMessage',
      desc: '',
      args: [],
    );
  }

  /// `Phoenix`
  String get phoenixMessage {
    return Intl.message(
      'Phoenix!',
      name: 'phoenixMessage',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get congratulationsMessage {
    return Intl.message(
      'Congratulations!',
      name: 'congratulationsMessage',
      desc: '',
      args: [],
    );
  }

  /// `You are a`
  String get youAreMessage {
    return Intl.message(
      'You are a',
      name: 'youAreMessage',
      desc: '',
      args: [],
    );
  }

  /// `Wholesomeness`
  String get wholesomenessMessage {
    return Intl.message(
      'Wholesomeness',
      name: 'wholesomenessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Fairy`
  String get fairyMessage {
    return Intl.message(
      'Fairy!',
      name: 'fairyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Unicorn`
  String get unicornMessage {
    return Intl.message(
      'Unicorn!',
      name: 'unicornMessage',
      desc: '',
      args: [],
    );
  }

  /// `Logic`
  String get logicMessage {
    return Intl.message(
      'Logic',
      name: 'logicMessage',
      desc: '',
      args: [],
    );
  }

  /// `Imagination`
  String get imaginationMessage {
    return Intl.message(
      'Imagination',
      name: 'imaginationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Conducive to or suggestive of good health and physical well-being.`
  String get helpMessage {
    return Intl.message(
      'Conducive to or suggestive of good health and physical well-being.',
      name: 'helpMessage',
      desc: '',
      args: [],
    );
  }

  /// `Share!`
  String get shareMessage {
    return Intl.message(
      'Share!',
      name: 'shareMessage',
      desc: '',
      args: [],
    );
  }

  /// `The test says i am `
  String get onShareText {
    return Intl.message(
      'The test says i am ',
      name: 'onShareText',
      desc: '',
      args: [],
    );
  }

  /// `Try for yourself! `
  String get onShareText2 {
    return Intl.message(
      'Try for yourself! ',
      name: 'onShareText2',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy `
  String get privacyMessage {
    return Intl.message(
      'View Privacy Policy',
      name: 'privacyMessage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
