class Countrymodel {
  final String code;
  final Map names;

  Countrymodel({required this.code, required this.names});

  Countrymodel fromJson(Map data) {
    return Countrymodel(code: data["code"], names: data["names"]);
  }
}
