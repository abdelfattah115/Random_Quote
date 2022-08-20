import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'config/locale/app_localizations_setup.dart';
import 'features/splash/presentation/cubit/lcoale_cubit.dart';
import 'core/services/service_locator.dart';
import 'config/routes/app_routes.dart';
import 'core/utils/app_strings.dart';
import 'config/themes/app_theme.dart';
import 'features/random_quote/presentation/cubits/quotes_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().init();
  BlocOverrides.runZoned(
        () {
      runApp(const QuoteApp());
    },
    blocObserver: AppBlocObserver(),
  );
}

class QuoteApp extends StatelessWidget {
  const QuoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<LocaleCubit>()..getSavedLang()),
          BlocProvider(create: (context) => sl<QuotesCubit>()..getRandomQuotes()),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppStrings.appName,
              theme: appTheme(),
              locale: state.locale,
              onGenerateRoute: AppRoutes.onGenerateRoute,
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localeResolutionCallback:
              AppLocalizationsSetup.localeResolutionCallback,
              localizationsDelegates:
              AppLocalizationsSetup.localizationsDelegates,
            );
          },
        ));
  }
}
