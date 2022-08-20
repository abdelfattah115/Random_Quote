import 'package:dartz/dartz.dart';

import '../repositories/locale_repository.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/error/failures.dart';

class ChangeLangUseCase extends BaseUseCases<bool, String> {
  final LocaleRepository langRepository;

  ChangeLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, bool>> call(String langCode) async {
    return await langRepository.changeLang(langCode);
  }
}
