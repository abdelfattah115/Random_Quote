import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes/features/splash/data/datasources/lang_local_data_sourece.dart';
import 'package:quotes/features/splash/data/repositories/locale_repository_impl.dart';
import 'package:quotes/features/splash/domain/repositories/locale_repository.dart';
import 'package:quotes/features/splash/domain/usecases/change_lang.dart';
import 'package:quotes/features/splash/domain/usecases/get_saved_lang.dart';
import 'package:quotes/features/splash/presentation/cubit/lcoale_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_consumer.dart';
import '../api/app_interceptors.dart';
import '../api/dio_consumer.dart';
import '../network/network_info.dart';
import '../../features/random_quote/data/datasources/local_data_source.dart';
import '../../features/random_quote/data/datasources/remote_data_source.dart';
import '../../features/random_quote/data/repositories/quote_repository.dart';
import '../../features/random_quote/domain/repositories/quote_repository.dart';
import '../../features/random_quote/domain/usecases/get_random_quote.dart';
import '../../features/random_quote/presentation/cubits/quotes_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    // Features

    // Blocs
    sl.registerFactory(() => QuotesCubit(getRandomQuoteUseCase: sl()));
    sl.registerFactory(
      () => LocaleCubit(
        changeLangUseCase: sl(),
        getSavedLangUseCase: sl(),
      ),
    );

    // UseCases
    sl.registerLazySingleton<GetRandomQuoteUseCase>(
      () => GetRandomQuoteUseCase(quoteRepository: sl()),
    );
    sl.registerLazySingleton<GetSavedLangUseCase>(
      () => GetSavedLangUseCase(langRepository: sl()),
    );
    sl.registerLazySingleton<ChangeLangUseCase>(
      () => ChangeLangUseCase(langRepository: sl()),
    );

    // Repository
    sl.registerLazySingleton<BaseQuoteRepository>(
      () => QuoteRepository(
        remoteDataSource: sl(),
        localDataSource: sl(),
        netWorkInfo: sl(),
      ),
    );

    sl.registerLazySingleton<LocaleRepository>(
        () => LocaleRepositoryImpl(langLocalDataSource: sl()));


    // Data Sources
    sl.registerLazySingleton<BaseLocalDataSource>(
      () => LocalDataSource(sharedPref: sl()),
    );
    sl.registerLazySingleton<BaseRemoteDataSource>(
      () => RemoteDataSource(apiConsumer: sl()),
    );

    sl.registerLazySingleton<LangLocalDataSource>(
          () => LangLocalDataSourceImpl(sharedPreferences: sl()),
    );

    // Core
    sl.registerLazySingleton<BaseNetworkInfo>(
      () => NetWorkInfo(connectionChecker: sl()),
    );
    sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

    // External
    final sharedPref = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPref);
    sl.registerLazySingleton(() => AppInterceptor());
    sl.registerLazySingleton(() => LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ));
    // sl.registerLazySingleton(() => http.Client());
    sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => InternetConnectionChecker());
  }
}
