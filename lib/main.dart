import 'package:flagquiz/controllers/quizcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flagquiz/pages/quizpage.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Quizcontroller());
    return ScreenUtilInit(
      designSize: Size(480.0, 1042.6666666666667),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            textTheme: Typography.englishLike2018.apply(
              fontSizeFactor: 1.sp, // scale fonts
            ),
          ),
          home: child,
        );
      },
      child: Quizpage(),
    );
  }
}
