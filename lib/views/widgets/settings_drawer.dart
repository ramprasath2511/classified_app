import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/locale_provider.dart';

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Center(
              child: Text(
                "Settings",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text("Theme"),
            trailing: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
                return  Switch(
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (bool value) {
                    themeProvider.toggleTheme(value);
                  },
                );
              }
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            trailing: Consumer<LocaleProvider>(builder: (context, localeProvider, _) {
                return DropdownButton<Locale>(
                  value: localeProvider.locale,
                  onChanged: (Locale? newLocale) {
                    if (newLocale != null) {
                      localeProvider.setLocale(newLocale);
                    }
                  },
                  items: const [
                    DropdownMenuItem(value: Locale('en'), child: Text("English")),
                    DropdownMenuItem(value: Locale('es'), child: Text("Spanish")),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
