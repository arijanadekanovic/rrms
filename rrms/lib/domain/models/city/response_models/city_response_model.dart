import 'package:rrms/_all.dart';

class CityResponseModel {
  final int? id;
  final String? name;

  CityResponseModel({
    this.id,
    this.name,
  });

  factory CityResponseModel.fromJson(Map<String, dynamic> json) {
    return CityResponseModel(
      id: json.parseValue('id'),
      name: json.parseValue('name'),
    );
  }
}
