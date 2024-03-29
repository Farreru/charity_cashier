import 'package:charity_cashier/data/models/register_response_model.dart';
import 'package:charity_cashier/domain/entities/register_params.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/login_params.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> postLogin(LoginParams params);
  Future<RegisterResponseModel> postRegister(RegisterParams params);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<LoginResponseModel> postLogin(LoginParams params) async {
    final result = await _dio.post("api/login", data: params.toMap());

    return LoginResponseModel.fromJson(result.data);
  }

  @override
  Future<RegisterResponseModel> postRegister(RegisterParams params) async {
    final result = await _dio.post("api/register", data: params.toMap());

    return RegisterResponseModel.fromJson(result.data);
  }
}
