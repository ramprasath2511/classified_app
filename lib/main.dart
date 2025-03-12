// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_flutter/providers/locale_provider.dart';
import 'package:technical_flutter/themes/app_theme.dart';
import 'routes/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'providers/post_provider.dart';
import 'utils/custom_extension.dart';
import 'providers/theme_provider.dart';
import 'package:template_package/locale/translations_delegate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()..loadTheme()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()..loadLocale()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: context.translate("appTitle"),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: '/',
            routes: AppRoutes.routes,
            supportedLocales: [const Locale('en'), const Locale('es')],
            localizationsDelegates: [
              const TranslationsDelegate(
                  supportedLocales: [Locale('en'), Locale('es')]),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
