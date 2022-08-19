import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/app_strings.dart';
import '../model/quote_model.dart';

abstract class BaseLocalDataSource {
  Future<QuoteModel> getLastRandomQuote();

  Future<void> cacheRandomQuote(QuoteModel quote);
}

class LocalDataSource implements BaseLocalDataSource {
  final SharedPreferences sharedPref;

  LocalDataSource({required this.sharedPref});

  @override
  Future<QuoteModel> getLastRandomQuote() {
    final jsonString = sharedPref.getString(AppStrings.randomQuoteKey);
    if (jsonString != null) {
      return Future.value(
        QuoteModel.fromJson(json.decode(jsonString)),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheRandomQuote(QuoteModel quote) {
    return sharedPref.setString(AppStrings.randomQuoteKey, json.encode(quote));
  }
}
