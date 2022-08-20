import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../datasources/lang_local_data_sourece.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/locale_repository.dart';

class LocaleRepositoryImpl extends LocaleRepository {
  final LangLocalDataSource langLocalDataSource;

  LocaleRepositoryImpl({required this.langLocalDataSource});

  @override
  Future<Either<Failure, bool>> changeLang(String langCode) async {
    try {
      return Right(await langLocalDataSource.changeLang(langCode));
    } on ServerException catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getSavedLang() async {
    try {
      return Right(await langLocalDataSource.getSavedLang());
    } on ServerException catch (e) {
      return Left(ServerFailure());
    }
  }
}
