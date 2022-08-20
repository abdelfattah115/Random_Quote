import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/usecases/change_lang.dart';
import '../../domain/usecases/get_saved_lang.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit({
    required this.getSavedLangUseCase,
    required this.changeLangUseCase,
  }) : super(const ChangeLangState(Locale(AppStrings.englishCode)));

  final GetSavedLangUseCase getSavedLangUseCase;
  final ChangeLangUseCase changeLangUseCase;

  var currentLangCode = AppStrings.englishCode;

  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParams());
    response.fold(
      (_) {
        debugPrint(AppStrings.cacheError);
      },
      (value) {
        currentLangCode = value!;
        emit(ChangeLangState(Locale(currentLangCode)));
      },
    );
  }

  Future<void> _changeLang(String langCode) async {
    final response = await changeLangUseCase.call(langCode);
    response.fold(
      (_) {
        debugPrint(AppStrings.cacheError);
      },
      (value) {
        currentLangCode = langCode;
        emit(ChangeLangState(Locale(currentLangCode)));
      },
    );
  }

  void toEnglish() => _changeLang(AppStrings.englishCode);

  void toArabic() => _changeLang(AppStrings.arabicCode);
}
