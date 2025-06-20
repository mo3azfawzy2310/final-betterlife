import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String _selectedLanguageCode = 'en'; // default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Select Language',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          RadioListTile<String>(
            title: const Text('English'),
            value: 'en',
            groupValue: _selectedLanguageCode,
            onChanged: (val) {
              setState(() {
                _selectedLanguageCode = val!;
              });
            },
            secondary: const Icon(Icons.language, color: Colors.blue),
          ),
          RadioListTile<String>(
            title: const Text('Arabic'),
            value: 'ar',
            groupValue: _selectedLanguageCode,
            onChanged: (val) {
              setState(() {
                _selectedLanguageCode = val!;
              });
            },
            secondary: const Icon(Icons.language, color: Color(0xFF19998D)),
          ),
        ],
      ),
    );
  }
}
