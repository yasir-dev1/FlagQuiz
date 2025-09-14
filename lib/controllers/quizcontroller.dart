import 'package:country_list/country_list.dart';
import 'package:flagquiz/models/quizmodel.dart';
import 'package:get/get.dart';

class Quizcontroller extends GetxController {
  RxList<Quizmodel> quizzes = <Quizmodel>[].obs;
  RxInt health = 3.obs;
  RxInt coins = 100.obs;

  void generateGame(int length) {
    quizzes.value = List.generate(
      length,
      (index) => Quizmodel.generatequiz(Countries.tr),
    );
    health.value = 3;
  }
}
