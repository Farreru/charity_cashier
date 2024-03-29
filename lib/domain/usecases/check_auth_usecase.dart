import 'package:charity_cashier/common/constants/app_error.dart';
import 'package:charity_cashier/common/usecases/no_params_usecase.dart';
import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class CheckAuthUseCase extends NoParamsUseCase<bool> {
  final AuthRepository _repository;

  CheckAuthUseCase(this._repository);

  @override
  Future<Either<AppError, bool>> call() {
    return _repository.checkAuthentication();
  }
}
