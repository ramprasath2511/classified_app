// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_flutter/providers/locale_provider.dart';
import 'package:technical_flutter/routes/app_routes_constants.dart';
import 'package:technical_flutter/themes/app_theme.dart';
import 'routes/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'providers/post_provider.dart';
import 'utils/custom_extension.dart';
import 'providers/theme_provider.dart';
import 'package:template_package/locale/translations_delegate.dart';

void main() {
  runApp(const Test());
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
class Test extends StatefulWidget {
  const Test({super.key});
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()..loadSavedPosts()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()..loadTheme()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()..loadLocale()),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, child) {
          return MaterialApp(
            title: context.translate("appTitle"),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: home,
            navigatorKey: navigatorKey,
            onGenerateRoute: AppRoutes.generateRoute,
            locale: localeProvider.locale,
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
