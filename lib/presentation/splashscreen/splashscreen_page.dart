import 'package:charity_cashier/common/constants/app_colors.dart';
import 'package:charity_cashier/common/constants/route_constant.dart';
import 'package:charity_cashier/presentation/splashscreen/bloc/splashscreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/di_module/app_module.dart';

class SplashscreenPage extends StatelessWidget {
  const SplashscreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SplashscreenBloc>()..add(SplashscreenStarted()),
      child: BlocListener<SplashscreenBloc, SplashscreenState>(
        listenWhen: (prev, next) {
          return prev.status != next.status;
        },
        listener: (context, state) {
          Future.delayed(const Duration(seconds: 2), () {
            if (state.status == SplashscreenStatus.success) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteConstants.dashboard,
                (route) => false,
              );
            } else if (state.status == SplashscreenStatus.failure) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteConstants.login,
                (route) => false,
              );
            }
          });
        },
        child: Scaffold(
          backgroundColor: AppColors.primary,
          body: SizedBox(
            width: 1.sw,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "CHARITY CASHIER",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "Powered by Progrity.id",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
