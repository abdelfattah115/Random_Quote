import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/quote_repository.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../entities/quote.dart';

class GetRandomQuoteUseCase implements BaseUseCases<Quote, NoParams>{
  final BaseQuoteRepository quoteRepository;

  GetRandomQuoteUseCase({required this.quoteRepository});

  @override
  Future<Either<Failure, Quote>> call(NoParams params) async{
    return await quoteRepository.getRandomQuote();
  }

}