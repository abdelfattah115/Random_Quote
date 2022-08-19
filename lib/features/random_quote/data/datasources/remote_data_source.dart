import 'package:quotes/core/api/api_consumer.dart';

import '../../../../core/api/end_points.dart';
import '../model/quote_model.dart';

abstract class BaseRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class RemoteDataSource implements BaseRemoteDataSource {
  final ApiConsumer apiConsumer;

  RemoteDataSource({required this.apiConsumer});

  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await apiConsumer.get(EndPoints.randomQuoteUrl);
    return QuoteModel.fromJson(response);
  }
}
