class CityModel {
  int id = 0;
  String name = "";
  int stateId = 0;

  CityModel();

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    stateId = json['state_id'] ?? 0;
  }
}