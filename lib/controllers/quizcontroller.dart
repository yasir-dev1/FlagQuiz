import 'package:flagquiz/models/quizmodel.dart';
import 'package:flagquiz/models/countries.dart';
import 'package:get/get.dart';

class Quizcontroller extends GetxController {
  RxList<Quizmodel> quizzes = <Quizmodel>[].obs;
  RxInt health = 3.obs;
  RxInt coins = 100.obs;
  RxString selectedlang = "en".obs;
  RxList<String> languages = ["en", "zh", "hi", "es", "fr", "ar", "tr"].obs;

  void generateGame(int len) {
    health.value = 3;
    quizzes.clear(); // Clear previous quizzes
    int i = 0;
    while (i < len) {
      Quizmodel quizmodel = Quizmodel.generatequiz(list);

      // Check if any existing quiz has the same correct country code
      bool hasDuplicate = quizzes.any(
        (existingQuiz) => existingQuiz.correct.code == quizmodel.correct.code,
      );

      if (!hasDuplicate) {
        quizzes.add(quizmodel);
        i++;
      }
    }
  }
}
