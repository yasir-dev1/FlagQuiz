import 'package:flag/flag.dart';
import 'package:flag/flag_widget.dart';
import 'package:flagquiz/controllers/quizcontroller.dart';
import 'package:flagquiz/pages/gameoverpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Quizpage extends StatefulWidget {
  const Quizpage({super.key});

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  Quizcontroller controller = Get.find();

  @override
  void initState() {
    controller.generateGame(21);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RxInt level = 0.obs;

    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    padding: EdgeInsets.all(3.w),
                    child: Icon(Icons.add, color: Colors.white, size: 16.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              child: Column(
                children: [
                  Text(
                    "${level.value}/${controller.quizzes.length}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  LinearProgressIndicator(
                    value: level.value / controller.quizzes.length,
                    minHeight: 20.h,
                    backgroundColor: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        child: SizedBox(
                          width: 400.w, // responsive width
                          child: AspectRatio(
                            aspectRatio: 3 / 2, // common flag ratio
                            child: Container(
                              color: Colors.grey[100],
                              child: Flag.fromString(
                                controller.quizzes[level.value].correct.isoCode,
                                height: 10,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      height: 500.h,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 4, // number of options
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 buttons per row
                          mainAxisSpacing: 12.h,
                          crossAxisSpacing: 12.w,
                          childAspectRatio: 1, // wider buttons
                        ),
                        itemBuilder: (context, index) {
                          Rx<Color> color = Colors.white.obs;
                          RxBool clickable = true.obs;
                          return GestureDetector(
                            onTap: () {
                              if (clickable.value) {
                                clickable.value = false;
                                if (controller
                                        .quizzes[level.value]
                                        .list[index]
                                        .isoCode ==
                                    controller
                                        .quizzes[level.value]
                                        .correct
                                        .isoCode) {
                                  color.value = Colors.green;
                                  Future.delayed(
                                    const Duration(milliseconds: 200),
                                    () {
                                      level++;
                                    },
                                  );
                                } else {
                                  color.value = Colors.red;
                                  if (controller.health.value != 1) {
                                    controller.health.value--;
                                  } else {
                                    controller.health.value--;
                                    Future.delayed(
                                      Duration(milliseconds: 200),
                                      () {
                                        Get.offAll(
                                          Gameoverpage(score: "${level.value}"),
                                        );
                                      },
                                    );
                                  }
                                }
                              }
                            },
                            child: Obx(
                              () => Container(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                decoration: BoxDecoration(
                                  color: color.value,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Center(
                                  child: Text(
                                    controller
                                        .quizzes[level.value]
                                        .list[index]
                                        .name,
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      color: color.value != Colors.white
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
