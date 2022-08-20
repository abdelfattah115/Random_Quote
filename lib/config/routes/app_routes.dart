import 'package:flutter/material.dart';

import '../../core/utils/app_strings.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/random_quote/presentation/screens/quotes_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String randomQuoteRoute = '/randomQuote';
}

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.randomQuoteRoute:
        return MaterialPageRoute(
            builder: (_) => const QuoteScreen());
      default:
        return unDefinedRoute();
    }


  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text(AppStrings.noFoundRoute)),
      ),
    );
  }
}
