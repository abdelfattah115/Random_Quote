import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/quote.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_random_quote.dart';

part 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  final GetRandomQuoteUseCase getRandomQuoteUseCase;

  QuotesCubit({required this.getRandomQuoteUseCase}) : super(QuotesInitialState());

  Future<void> getRandomQuotes() async {
    emit(QuotesLoadingState());
    final response = await getRandomQuoteUseCase(NoParams());
    emit(
      response.fold(
        (failure) => QuotesErrorState(message: _mapFailureToMessage(failure)),
        (quote) => QuotesSuccessState(quote: quote),
      ),
    );
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return AppStrings.serverError;
    case CacheFailure:
      return AppStrings.cacheError;
    default:
      return AppStrings.unexpectedError;
  }
}
