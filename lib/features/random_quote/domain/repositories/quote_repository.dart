import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/quote.dart';

abstract class BaseQuoteRepository{
  Future<Either<Failure, Quote>> getRandomQuote();
}