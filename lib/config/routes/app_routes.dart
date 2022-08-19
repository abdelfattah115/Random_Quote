import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/random_quote/presentation/screens/splash_screen.dart';
import '../../core/services/service_locator.dart';
import '../../features/random_quote/presentation/cubits/quotes_cubit.dart';
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
            builder: (_) => BlocProvider(
                create: (context) => sl<QuotesCubit>()..getRandomQuotes(),
                child: const QuoteScreen()));
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
