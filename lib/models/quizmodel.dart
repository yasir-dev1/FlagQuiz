import 'dart:math';

import 'package:country_list/country_list.dart';

class Quizmodel {
  final Country correct;
  final List<Country> list;

  Quizmodel({required this.correct, required this.list});

  static Quizmodel generatequiz(List<Country> contries) {
    List<Country> list = <Country>[];
    Country country = contries[Random().nextInt(contries.length)];
    list.add(country);
    int i = 0;
    while (i < 3) {
      Country c = contries[Random().nextInt(contries.length)];
      if (!list.contains(c) && c.isoCode != "IL") {
        list.add(c);
        list.shuffle();
        i++; // only increment if a new country was added
      }
    }
    list.shuffle();

    return Quizmodel(correct: country, list: list);
  }
}
