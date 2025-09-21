import 'package:flagquiz/controllers/quizcontroller.dart';
import 'package:flagquiz/pages/quizpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Gameoverpage extends StatefulWidget {
  final String score;
  const Gameoverpage({super.key, required this.score});

  @override
  State<Gameoverpage> createState() => _GameoverpageState();
}

class _GameoverpageState extends State<Gameoverpage> {
  @override
  Widget build(BuildContext context) {
    Quizcontroller controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: Icon(Icons.language_sharp, size: 28.sp),
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Obx(
                () => Icon(
                  Icons.favorite,
                  color: index < controller.health.value
                      ? Colors.red
                      : Colors.grey,
                  size: 28.sp,
                ),
              ),
            );
          }),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              child: Row(
                children: [
                  Icon(Icons.monetization_on, color: Colors.amber, size: 20.sp),
                  SizedBox(width: 4.w),
                  Obx(
                    () => Text(
                      "${controller.coins.value}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  GestureDetector(
                    onTap: () {
                      controller.coins.value +=
                          10; // Optional: Add controller.coins manually
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      padding: EdgeInsets.all(3.w),
                      child: Icon(Icons.add, color: Colors.white, size: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Game Over",
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Your Score: ${widget.score}",
              style: TextStyle(fontSize: 24.sp, color: Colors.black),
            ),
            SizedBox(height: 40.h),
            SizedBox(
              width: 300.w,
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: () {
                              if (controller.coins.value >= 100) {
                                controller.coins.value -= 100;
                                // controller.generateGame(21);
                                Get.offAll(Quizpage());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: controller.coins.value >= 100
                                  ? Colors.green
                                  : Colors.grey,
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                                vertical: 15.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Continue -300",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  Icons.monetization_on,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.generateGame(21);
                            Get.offAll(Quizpage());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.w,
                              vertical: 15.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "Retry",
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
