import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class LocaleRepository {
  Future<Either<Failure, String?>> getSavedLang();

  Future<Either<Failure, bool>> changeLang(String langCode);
}
