import 'package:charity_cashier/common/constants/route_constant.dart';
import 'package:charity_cashier/presentation/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/di_module/app_module.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (prev, next) {
          return prev.status != next.status;
        },
        listener: (context, state) {
          if (state.status == LoginStatus.loading) {
            EasyLoading.show(status: "Loading...");
          } else if (state.status == LoginStatus.failure) {
            EasyLoading.showError("Email / password anda salah");
          } else if (state.status == LoginStatus.success) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Berhasil');
            Navigator.pushNamedAndRemoveUntil(
                context, RouteConstants.dashboard, (route) => false);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(11.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: 1.sw,
                      child: ElevatedButton(
                        onPressed: state.isInputValid
                            ? () {
                                context
                                    .read<LoginBloc>()
                                    .add(LoginButtonPressed());
                              }
                            : null,
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteConstants.register,
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
          body: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Container(
                width: 1.sw,
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "CHARITY CASHIER",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff19AFF9),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Powered by Progrity.id",
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Efficiency at Every Sale",
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 21.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Log in to",
                          style: TextStyle(
                            fontSize: 32.sp,
                          ),
                        ),
                        Text(
                          "your account",
                          style: TextStyle(
                              fontSize: 32.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 21.h),
                    Column(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            context.read<LoginBloc>().add(
                                LoginInputChanged(type: "email", value: value));
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    const BorderSide(color: Color(0xffA4A4A4))),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        InputPassword(onChanged: (value) {
                          context.read<LoginBloc>().add(LoginInputChanged(
                              type: "password", value: value));
                        }),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: const Text("Forgot your password ?")),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class InputPassword extends StatefulWidget {
  const InputPassword({super.key, this.onChanged});

  final Function(String)? onChanged;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      obscureText: isSecure,
      decoration: InputDecoration(
        hintText: "Enter Password",
        suffixIcon: IconButton(
          icon: isSecure
              ? const Icon(Icons.remove_red_eye_sharp)
              : const Icon(Icons.remove_red_eye_outlined),
          onPressed: () {
            setState(() {
              isSecure = !isSecure;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xffA4A4A4)),
        ),
      ),
    );
  }
}
