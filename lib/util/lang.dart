import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TLang {
  final Locale locale;
  Map<String, dynamic> _strings;

  TLang(this.locale);

  static TLang of(BuildContext context) {
    return Localizations.of<TLang>(context, TLang);
  }

  static const LocalizationsDelegate<TLang> delegate =
      AppLocalizationsDelegate();

  static String getKey(BuildContext aContext, String aKey) {
    return TLang.of(aContext).translate(aKey);
  }

  static Locale getCurrent(Locale aLocale, Iterable<Locale> aSupportedLocales) {
    for (var supportedLocale in aSupportedLocales) {
      if (supportedLocale.languageCode == aLocale.languageCode &&
          supportedLocale.countryCode == aLocale.countryCode) {
        return supportedLocale;
      }
    }
    return aSupportedLocales.first;
  }

  String get assetName => 'assets/lang/${locale.languageCode}.json';

  Future load() async {
    String jsonString = await rootBundle.loadString(assetName);
    _strings = jsonDecode(jsonString);
  }

  String translate(String aKey) {
    return (_strings[aKey] ?? aKey).toString();
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<TLang> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale aLocale) {
    return ['en', 'uk'].contains(aLocale.languageCode);
  }

  @override
  Future<TLang> load(Locale aLocale) async {
    TLang lang = new TLang(aLocale);
    await lang.load();
    return lang;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
