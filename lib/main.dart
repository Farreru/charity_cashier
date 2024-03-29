import 'package:charity_cashier/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/di_module/app_module.dart';
import 'common/loggers/bloc_event_logger.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();

  configureDependencies();

  Bloc.observer = BlocEventLogger();

  runApp(const App());
}
