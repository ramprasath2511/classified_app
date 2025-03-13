import 'package:flutter/material.dart';

import '../views/screens/details_page.dart';
import '../views/screens/list_page.dart';
import '../views/screens/saved_post_page.dart';
import 'app_routes_constants.dart';

class AppRoutes {

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;
    String? routeName = settings.name;
    switch (routeName) {
      case home:
        return MaterialPageRoute(builder: (_) => ListPage());

      case details:
          return MaterialPageRoute(builder: (_) => DetailsPage(post: args?['post']));

      case savedPost:
        return MaterialPageRoute(builder: (_) => SavedPostsPage());



      default:
        return MaterialPageRoute(builder: (_) => ListPage());
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Page Not Found")),
      ),
    );
  }
}
