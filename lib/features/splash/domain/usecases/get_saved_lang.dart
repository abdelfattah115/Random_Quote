import 'package:dartz/dartz.dart';

import '../../../../core/usecases/base_use_case.dart';
import '../repositories/locale_repository.dart';
import '../../../../core/error/failures.dart';

class GetSavedLangUseCase extends BaseUseCases<String?, NoParams>{
  final LocaleRepository langRepository;

  GetSavedLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, String?>> call(NoParams params) async{
    return await langRepository.getSavedLang();
  }



}