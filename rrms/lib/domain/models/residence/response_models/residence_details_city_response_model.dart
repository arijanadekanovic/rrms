import 'package:rrms/_all.dart';

class ResidenceDetailsCityResponseModel {
  final int? id;
  final String? name;

  ResidenceDetailsCityResponseModel({
    this.id,
    this.name,
  });

  factory ResidenceDetailsCityResponseModel.fromJson(Map<String, dynamic> json) {
    return ResidenceDetailsCityResponseModel(
      id: json.parseValue('id'),
      name: json.parseValue('name'),
    );
  }
}
