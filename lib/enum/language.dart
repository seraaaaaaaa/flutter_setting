import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Language {
  english('en', 'gb'),
  chinese('zh', 'cn'),
  japanese('ja', 'jp'),
  korean('ko', 'kr');

  const Language(this.code, this.flag);

  final String code;
  final String flag;

  Locale get toLocale => Locale(code);
}

extension LanguageExtension on Language {
  String localizedName(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    switch (this) {
      case Language.english:
        return appLocalizations.english;
      case Language.chinese:
        return appLocalizations.chinese;
      case Language.japanese:
        return appLocalizations.japanese;
      case Language.korean:
        return appLocalizations.korean;
    }
  }
}
