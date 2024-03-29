import 'package:charity_cashier/common/constants/app_error.dart';
import 'package:charity_cashier/common/usecases/usecase.dart';
import 'package:charity_cashier/domain/entities/login_params.dart';
import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class PostLoginUseCase extends UseCase<bool, LoginParams> {
  final AuthRepository _repository;

  PostLoginUseCase(this._repository);

  @override
  Future<Either<AppError, bool>> call(LoginParams params) {
    return _repository.postLogin(params);
  }
}
