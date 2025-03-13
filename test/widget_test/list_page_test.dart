import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:technical_flutter/providers/post_provider.dart';
import 'package:technical_flutter/views/screens/list_page.dart';
import 'package:technical_flutter/views/screens/live_post_page.dart';
import 'package:technical_flutter/views/screens/saved_post_page.dart';


class MockPostProvider extends Mock implements PostProvider {}

void main() {
  late MockPostProvider mockPostProvider;
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    mockPostProvider = MockPostProvider();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider<PostProvider>.value(
        value: mockPostProvider,
        child: const ListPage(),
      ),
    );
  }

  testWidgets('ListPage renders correctly', (WidgetTester tester) async {
    mockPostProvider = MockPostProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider<PostProvider>(
        create: (_) => PostProvider(),
        child: MaterialApp(
          home: ListPage(), // Replace with the widget you're testing
        ),
      ),
    );
    expect(find.text('listOfPosts'), findsOneWidget);
    final postProvider = tester.element(find.byType(bool)).read<PostProvider>();

    // Verify initial value
    expect(postProvider.isLoadingCall, 'Live Posts');

    await tester.pump();

    expect(find.text('listOfPosts'), findsOneWidget); // text located in app bar
    await tester.pump();

    expect(find.text('Live Posts'), findsOneWidget); // verify the tab bar 1
    expect(find.text('Saved Posts'), findsOneWidget); // verify the tab bar 2


    verify(mockPostProvider.fetchPosts()).called(1);
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
