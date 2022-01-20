import 'package:e2ea/localization/localizations_demo.dart';


import 'package:flutter/cupertino.dart';

class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;
  Language(this.id, this.name, this.flag, this.languageCode);

  static List<Language> langList(BuildContext context) {
    return <Language>[
      Language(
          1, '🇸🇾', DemoLocalizations.of(context).translate('Lang_1'), 'ar'),
      Language(
          2, '🇺🇸', DemoLocalizations.of(context).translate('Lang_2'), 'en')
    ];
  }
}
