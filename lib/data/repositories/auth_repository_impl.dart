import 'package:charity_cashier/common/constants/app_error.dart';
import 'package:charity_cashier/data/datasources/auth_remote_data_source.dart';
import 'package:charity_cashier/domain/entities/login_params.dart';
import 'package:charity_cashier/domain/entities/register_params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final SharedPreferences _sharedPreferences;
  final Dio _dio;

  AuthRepositoryImpl(
      this._remoteDataSource, this._sharedPreferences, this._dio);

  @override
  Future<Either<AppError, bool>> postLogin(LoginParams params) async {
    try {
      final result = await _remoteDataSource.postLogin(params);

      _sharedPreferences.setBool('isLogin', true);
      _sharedPreferences.setString('token', result.data!.token!);

      _dio.interceptors.clear();
      _dio.interceptors.add(_authInterceptor(result.data!.token!));

      return right(true);
    } catch (e) {
      return left(const AppError("Error"));
    }
  }

  @override
  Future<Either<AppError, bool>> postRegister(RegisterParams params) async {
    try {
      final result = await _remoteDataSource.postRegister(params);

      _sharedPreferences.setBool('isLogin', true);
      _sharedPreferences.setString('token', result.data!.token!);

      _dio.interceptors.clear();
      _dio.interceptors.add(_authInterceptor(result.data!.token!));

      return right(true);
    } catch (e) {
      return left(const AppError("Error"));
    }
  }

  Interceptor _authInterceptor(String token) {
    return QueuedInterceptorsWrapper(onRequest: (reqOptions, handler) {
      reqOptions.headers['Authorization'] = "bearer $token";

      return handler.next(reqOptions);
    }, onError: (error, handler) async {
      return handler.next(error); //return non 401 error
    }, onResponse: (response, handler) async {
      return handler.resolve(response);
    });
  }

  @override
  Future<Either<AppError, bool>> checkAuthentication() async {
    try {
      final isLogin = _sharedPreferences.getBool('isLogin');
      if (isLogin == null) {
        throw Exception();
      }

      final token = _sharedPreferences.getString('token');
      _dio.interceptors.clear();
      _dio.interceptors.add(_authInterceptor(token!));

      return right(true);
    } catch (e) {
      return left(const AppError("error"));
    }
  }
}
