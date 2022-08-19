import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/app_interceptors.dart';
import 'package:quotes/core/api/dio_consumer.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    // UseCases
    sl.registerLazySingleton(
      () => GetRandomQuoteUseCase(quoteRepository: sl()),
    );

    // Repository
    sl.registerLazySingleton<BaseQuoteRepository>(
      () => QuoteRepository(
        remoteDataSource: sl(),
        localDataSource: sl(),
        netWorkInfo: sl(),
      ),
    );

    // Data Sources
    sl.registerLazySingleton<BaseLocalDataSource>(
      () => LocalDataSource(sharedPref: sl()),
    );
    sl.registerLazySingleton<BaseRemoteDataSource>(
      () => RemoteDataSource(apiConsumer: sl()),
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
