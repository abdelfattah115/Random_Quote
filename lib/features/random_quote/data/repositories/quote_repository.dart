import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/exceptions.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';

class QuoteRepository implements BaseQuoteRepository {
  final BaseRemoteDataSource remoteDataSource;
  final BaseLocalDataSource localDataSource;
  final BaseNetworkInfo netWorkInfo;

  QuoteRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.netWorkInfo,
  });

  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    // if (await netWorkInfo.isConnected) {
      try {
        final remoteRandomQuote = await remoteDataSource.getRandomQuote();
        localDataSource.cacheRandomQuote(remoteRandomQuote);
        return Right(remoteRandomQuote);
      } on ServerException catch (e) {
        return Left(ServerFailure());
      }
    // } else {
    //   try {
    //     final cacheRandomQuote = await localDataSource.getLastRandomQuote();
    //     return Right(cacheRandomQuote);
    //   } on CacheException catch (e) {
    //     return Left(CacheFailure());
    //   }
    // }
  }
}
