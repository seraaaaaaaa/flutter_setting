import 'package:country_flags/country_flags.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_setting/enum/font_size.dart';
import 'package:flutter_setting/enum/language.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/setting_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    _packageInfo = null;
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final settingProvider = Provider.of<SettingProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListTile(
                horizontalTitleGap: 10,
                leading: Icon(
                  Icons.settings_outlined,
                  size: 40,
                  color: settingProvider.primaryColor,
                ),
                title: Text(
                  appLocalizations.settings,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            //dark mode
            ListTile(
              leading: const Icon(
                Icons.dark_mode_outlined,
                size: 28,
              ),
              title: Text(appLocalizations.darkMode,
                  style: Theme.of(context).textTheme.titleMedium),
              trailing: CupertinoSwitch(
                activeColor: settingProvider.primaryColor,
                value: settingProvider.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  if (value) {
                    settingProvider.toggleTheme(ThemeMode.dark);
                  } else {
                    settingProvider.toggleTheme(ThemeMode.light);
                  }
                },
              ),
            ),
            //lanaguage
            ListTile(
              leading: const Icon(
                Icons.translate,
                size: 28,
              ),
              title: Text(
                appLocalizations.language,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                appLocalizations.selectLanguage,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Column(
                              children: Language.values.map((language) {
                                return ListTile(
                                  onTap: () {
                                    settingProvider.setLanguage(language);
                                    Navigator.pop(context);
                                  },
                                  horizontalTitleGap: 20,
                                  leading: CountryFlag.fromCountryCode(
                                    language.flag,
                                    shape: const Circle(),
                                    height: 25,
                                    width: 35,
                                  ),
                                  title: Text(
                                    language.localizedName(context),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  trailing: settingProvider.language == language
                                      ? Icon(
                                          Icons.check_circle,
                                          color: settingProvider.primaryColor,
                                          size: 28,
                                        )
                                      : null,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    });
              },
              trailing: CountryFlag.fromCountryCode(
                Language.values
                    .where((lang) => lang == settingProvider.language)
                    .first
                    .flag,
                shape: const Circle(),
                height: 25,
                width: 35,
              ),
            ),
            //theme color
            ListTile(
              leading: const Icon(
                Icons.palette_outlined,
                size: 28,
              ),
              title: Text(
                appLocalizations.themeColor,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: settingProvider.primaryColor,
                ),
                width: 33,
                height: 33,
              ),
              onTap: () {
                ColorPicker(
                  color: settingProvider.primaryColor,
                  onColorChanged: (Color color) {
                    settingProvider.setPrimaryColor(color);
                  },
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.both: false,
                    ColorPickerType.primary: true,
                    ColorPickerType.accent: false,
                    ColorPickerType.bw: false,
                    ColorPickerType.custom: false,
                  },
                  heading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Select a Color',
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),
                  subheading: const Divider(),
                  selectedColorIcon: Icons.check_circle_outline,
                  actionButtons: const ColorPickerActionButtons(
                      dialogActionButtons: false),
                ).showPickerDialog(
                  context,
                );
              },
            ),
            //font size
            ListTile(
              leading: const Icon(
                Icons.format_size_outlined,
                size: 28,
              ),
              title: Text(
                appLocalizations.fontSize,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Slider(
              activeColor: settingProvider.primaryColor,
              value: optionToIndex(settingProvider.fontSize).toDouble(),
              min: 0,
              max: FontSize.values.length - 1,
              divisions: FontSize.values.length - 1,
              label: settingProvider.fontSize.label,
              onChanged: (value) {
                settingProvider.setFontSize(indexToOption(value));
              },
            ),
            //about app
            ListTile(
              onTap: () async {
                final Uri url =
                    Uri.parse("https://github.com/seraaaaaaaa/flutter_setting");
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              leading: const Icon(
                Icons.mobile_friendly_outlined,
                size: 28,
              ),
              title: Text(
                appLocalizations.aboutApp,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            //version info
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.info_outlined,
                size: 28,
              ),
              title: Text(
                appLocalizations.versionInfo,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: Text(
                _packageInfo == null ? '' : _packageInfo!.version,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
