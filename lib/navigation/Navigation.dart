import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Navigation {
  static final Map<String, Widget> _preloadedRoutes = {};

  /// Preload a route by building its widget once and caching it.
  static void preload(BuildContext context, String routeName, WidgetBuilder builder) {
    if (!_preloadedRoutes.containsKey(routeName)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _preloadedRoutes[routeName] = builder(context);
      });
    }
  }

  /// Push route using Navigator, using preloaded widget if available.
  static Future<dynamic> pushNamed(BuildContext context, String routeName) {
    if (_preloadedRoutes.containsKey(routeName)) {
      final screen = _preloadedRoutes.remove(routeName)!;
      return Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    }
    return Navigator.pushNamed(context, routeName);
  }
}
