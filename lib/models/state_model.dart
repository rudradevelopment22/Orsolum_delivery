import 'package:orsolum_delivery/models/city_model.dart';

class StateModel {
  int id = 0;
  String name = "";
  int countryId = 0;
  List<CityModel> cities = [];

  StateModel();

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    countryId = json['country_id'] ?? 0;

    cities =
        ((json["city"] ?? []) as List<dynamic>)
            .map((e) => CityModel.fromJson(e))
            .toList();
  }

  static List<StateModel> fromJsonList(List<dynamic> list) {
    return list.map((e) => StateModel.fromJson(e)).toList();
  }
}
