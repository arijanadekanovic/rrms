import 'package:rrms/_all.dart';

class ResidencesHistoryResponseModel {
  final String? name;
  final String? address;
  final int? rooms;
  final double? size;
  final double? rentPrice;
  final String? thumbnailUrl;
  final int? cityId;
  final String? city;

  ResidencesHistoryResponseModel({
    this.name,
    this.address,
    this.rooms,
    this.size,
    this.rentPrice,
    this.thumbnailUrl,
    this.cityId,
    this.city,
  });

  factory ResidencesHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    return ResidencesHistoryResponseModel(
      name: json.parseValue('name'),
      address: json.parseValue('address'),
      rooms: json.parseValue('rooms'),
      size: json.parseDouble('size'),
      rentPrice: json.parseDouble('rentPrice'),
      thumbnailUrl: json.parseValue('thumbnailUrl'),
      cityId: json.parseValue('cityId'),
      city: json.parseValue('city'),
    );
  }
}
