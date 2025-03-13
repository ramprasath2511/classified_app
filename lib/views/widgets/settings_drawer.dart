import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_flutter/utils/custom_extension.dart';
import '../../providers/theme_provider.dart';
import '../../providers/locale_provider.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Center(
              child: Text(
                context.translate("settings"),
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.brightness_6),
            title:  Text(context.translate("theme")),
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
            title:  Text(context.translate("language")),
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
