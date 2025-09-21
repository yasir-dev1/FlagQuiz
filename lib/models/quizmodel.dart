import 'dart:math';

import 'package:flagquiz/models/countrymodel.dart';

class Quizmodel {
  final Countrymodel correct;
  final List<Countrymodel> list;

  Quizmodel({required this.correct, required this.list});

  static Quizmodel generatequiz(List<Countrymodel> contries) {
    List<Countrymodel> list = <Countrymodel>[];
    Countrymodel country = contries[Random().nextInt(contries.length)];
    list.add(country);
    int i = 0;
    while (i < 3) {
      Countrymodel c = contries[Random().nextInt(contries.length)];
      if (!list.contains(c) && c.code != "IL") {
        list.add(c);
        list.shuffle();
        i++;
      }
    }
    list.shuffle();

    return Quizmodel(correct: country, list: list);
  }
}
