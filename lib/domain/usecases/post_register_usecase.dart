import 'package:charity_cashier/common/constants/app_error.dart';
import 'package:charity_cashier/common/usecases/usecase.dart';
import 'package:charity_cashier/domain/entities/register_params.dart';
import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class PostRegisterUseCase extends UseCase<bool, RegisterParams> {
  final AuthRepository _repository;

  PostRegisterUseCase(this._repository);

  @override
  Future<Either<AppError, bool>> call(RegisterParams params) {
    return _repository.postRegister(params);
  }
}
