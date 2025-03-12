import 'package:flutter/material.dart';

import '../views/screens/details_page.dart';
import '../views/screens/list_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String details = '/details';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => ListPage(),
    details: (context) => DetailsPage(),
  };
}
