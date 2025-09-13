import 'package:flag/flag.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_list/country_list.dart';
import 'package:get/get.dart';

class Quizpage extends StatefulWidget {
  const Quizpage({super.key});

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  @override
  Widget build(BuildContext context) {
    RxInt health = 2.obs;
    RxInt coins = 100.obs;
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
                  color: index < health.value ? Colors.red : Colors.grey,
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
                      "${coins.value}",
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Column(
              children: [
                Text(
                  "2/21",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                LinearProgressIndicator(
                  value: 0.5,
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
                              "eg",
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
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    height: 500.h,
                    child: GridView.builder(
                      itemCount: 4, // number of options
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 buttons per row
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 12.w,
                        childAspectRatio: 1, // wider buttons
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(
                            child: Text(
                              Countries.list[index].name,
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.black,
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
    );
  }
}
