import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../main.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late String _selectedLanguageCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentLocale = Localizations.localeOf(context).languageCode;
    _selectedLanguageCode = currentLocale;
  }

  void _changeLanguage(String? languageCode) {
    if (languageCode == null) return;
    setState(() {
      _selectedLanguageCode = languageCode;
    });
    Locale newLocale = Locale(languageCode);
    MyApp.setLocale(context, newLocale);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.settings,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            localizations.selectLanguage,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          RadioListTile<String>(
            title: Text(localizations.english),
            value: 'en',
            groupValue: _selectedLanguageCode,
            onChanged: _changeLanguage,
            secondary: const Icon(Icons.language, color: Colors.blue),
          ),
          RadioListTile<String>(
            title: Text(localizations.arabic),
            value: 'ar',
            groupValue: _selectedLanguageCode,
            onChanged: _changeLanguage,
            secondary: const Icon(Icons.language, color: Color(0xFF19998D)),
          ),
        ],
      ),
    );
  }
}
