import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:technical_flutter/model/post.dart';
import 'package:technical_flutter/providers/locale_provider.dart';
import 'package:technical_flutter/providers/post_provider.dart';
import 'package:technical_flutter/providers/theme_provider.dart';
import 'package:technical_flutter/routes/app_routes.dart';
import 'package:technical_flutter/services/post_service.dart';
import 'package:technical_flutter/themes/app_theme.dart';
import 'package:technical_flutter/views/screens/list_page.dart';
import 'package:technical_flutter/views/screens/live_post_page.dart';
import 'package:technical_flutter/views/screens/saved_post_page.dart';
import 'package:template_package/locale/translations_delegate.dart';


class MockPostProvider extends Mock implements PostProvider {}

void main() {
  late MockPostProvider mockPostProvider;
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    mockPostProvider = MockPostProvider();
  });

  Widget createWidgetUnderTest() {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PostProvider()..loadSavedPosts()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()..loadTheme()),
          ChangeNotifierProvider(create: (_) => LocaleProvider()..loadLocale()),
        ],
        child: Consumer2<ThemeProvider, LocaleProvider>(
          builder: (context, themeProvider, localeProvider, child) {
            return MaterialApp(
              title: 'Test App',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,
              initialRoute: '/',
              onGenerateRoute: AppRoutes.generateRoute,
              locale: localeProvider.locale,
              supportedLocales: [const Locale('en'), const Locale('es')],
              localizationsDelegates: [
                const TranslationsDelegate(supportedLocales: [Locale('en'), Locale('es')]),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: ListPage(),
            );
          },
        ),
    );
  }

  testWidgets('ListPage renders correctly', (WidgetTester tester) async {
    mockPostProvider = MockPostProvider();
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.pump();
    expect(find.text('Live Posts'), findsOneWidget);
    expect(find.text('Saved Posts'), findsOneWidget);

  });

  testWidgets('Switching between tabs works correctly', (WidgetTester tester) async {
    when(mockPostProvider.fetchPosts()).thenAnswer((_) async =>Future.value());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();


    expect(find.byType(LivePostsPage), findsOneWidget);
    expect(find.byType(SavedPostsPage), findsNothing);


    await tester.tap(find.text('Saved Posts'));
    await tester.pumpAndSettle();


    expect(find.byType(SavedPostsPage), findsOneWidget);
    expect(find.byType(LivePostsPage), findsNothing);


    await tester.tap(find.text('Live Posts'));
    await tester.pumpAndSettle();

    expect(find.byType(LivePostsPage), findsOneWidget);
    expect(find.byType(SavedPostsPage), findsNothing);
  });
}
