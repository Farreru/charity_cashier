import 'package:charity_cashier/common/constants/app_colors.dart';
import 'package:charity_cashier/common/constants/route_constant.dart';
import 'package:charity_cashier/presentation/login/bloc/login_bloc.dart';
import 'package:charity_cashier/presentation/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/di_module/app_module.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterBloc>(),
      child: BlocListener<RegisterBloc, RegisterState>(
        listenWhen: (prev, next) {
          return prev.status != next.status;
        },
        listener: (context, state) {
          if (state.status == RegisterStatus.loading) {
            EasyLoading.show(status: "Loading...");
          } else if (state.status == RegisterStatus.failure) {
            EasyLoading.showError("Registrasi Gagal! Silahkan ulangi");
          } else if (state.status == RegisterStatus.success) {
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
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: 1.sw,
                      child: ElevatedButton(
                        onPressed: state.isInputValid
                            ? () {
                                context
                                    .read<RegisterBloc>()
                                    .add(RegisterButtonPressed());
                              }
                            : null,
                        child: Text(
                          "Sign Up",
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
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteConstants.login,
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
          body: BlocBuilder<RegisterBloc, RegisterState>(
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
                          "Create",
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
                            context.read<RegisterBloc>().add(
                                RegisterInputChanged(
                                    type: "name", value: value));
                          },
                          decoration: InputDecoration(
                            hintText: "Enter full name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    const BorderSide(color: Color(0xffA4A4A4))),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        TextFormField(
                          onChanged: (value) {
                            context.read<RegisterBloc>().add(
                                RegisterInputChanged(
                                    type: "email", value: value));
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
                          context.read<RegisterBloc>().add(RegisterInputChanged(
                              type: "password", value: value));
                        }),
                        SizedBox(height: 16.h),
                        InputPasswordConfirmation(onChanged: (value) {
                          context.read<RegisterBloc>().add(RegisterInputChanged(
                              type: "password_confirmation", value: value));
                        }),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CheckBoxTerms(onChanged: (isChecked) {
                                  context.read<RegisterBloc>().add(
                                      RegisterCheckBoxTermsChanged(
                                          type: "checkbox", value: isChecked));
                                }),
                                SizedBox(
                                    width:
                                        8), // Adding some space between the checkbox and text
                                Text(
                                  "I agree to the",
                                ),
                                Text(
                                  " terms and conditions",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary),
                                )
                              ],
                            ),
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

class InputPasswordConfirmation extends StatefulWidget {
  const InputPasswordConfirmation({super.key, this.onChanged});

  final Function(String)? onChanged;

  @override
  State<InputPasswordConfirmation> createState() =>
      _InputPasswordConfirmationState();
}

class _InputPasswordConfirmationState extends State<InputPasswordConfirmation> {
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      obscureText: isSecure,
      decoration: InputDecoration(
        hintText: "Confirm password",
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
        hintText: "Enter password",
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

class CheckBoxTerms extends StatefulWidget {
  const CheckBoxTerms({Key? key, required this.onChanged}) : super(key: key);

  final void Function(bool) onChanged; // Ensure the correct signature

  @override
  State<CheckBoxTerms> createState() => _CheckBoxTermsState();
}

class _CheckBoxTermsState extends State<CheckBoxTerms> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (newValue) {
        setState(() {
          isChecked = newValue ?? false;
        });
        // Call the onChanged callback provided by the parent widget
        widget.onChanged(isChecked);
      },
    );
  }
}
