import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_setting/enum/language.dart';
import 'package:flutter_setting/screen/setting_page.dart';
import 'package:flutter_setting/theme/global_theme.dart';
import 'package:flutter_setting/provider/setting_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Setting',
      themeMode: settingProvider.themeMode,
      theme: GlobalTheme.lightTheme,
      darkTheme: GlobalTheme.darkTheme,
      locale: settingProvider.locale,
      supportedLocales: Language.values.map((lang) => lang.toLocale).toList(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(settingProvider.fontSize.scale),
        ),
        child: const SettingPage(),
      ),
    );
  }
}
