import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/app_strings.dart';

abstract class LangLocalDataSource {
  Future<String?> getSavedLang();

  Future<bool> changeLang(String langCode);
}

class LangLocalDataSourceImpl extends LangLocalDataSource {
  final SharedPreferences sharedPreferences;

  LangLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> changeLang(String langCode) async {
    return await sharedPreferences.setString(AppStrings.local, langCode);
  }

  @override
  Future<String?> getSavedLang() async {
    return sharedPreferences.containsKey(AppStrings.local)
        ? sharedPreferences.getString(AppStrings.local)
        : AppStrings.englishCode;
  }
}
