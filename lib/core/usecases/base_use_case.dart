import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class BaseUseCases<Type, Params> {
  Future<Either<Failure,Type>> call(NoParams params);
}

class NoParams extends Equatable{
  @override
  List<Object?> get props => [];

}