import 'package:rrms/_all.dart';

class ResidenceRecommendationResponseModel {
  final int? id;
  final String? name;
  final String? address;
  final int? rooms;
  final double? size;
  final double? rentPrice;
  final ResidenceType? type;
  final String? thumbnailUrl;
  final String? city;

  ResidenceRecommendationResponseModel({
    this.id,
    this.name,
    this.address,
    this.rooms,
    this.size,
    this.rentPrice,
    this.type,
    this.thumbnailUrl,
    this.city,
  });

  factory ResidenceRecommendationResponseModel.fromJson(Map<String, dynamic> json) {
    return ResidenceRecommendationResponseModel(
      id: json.parseValue('id'),
      name: json.parseValue('name'),
      address: json.parseValue('address'),
      rooms: json.parseValue('rooms'),
      size: json.parseDouble('size'),
      rentPrice: json.parseDouble('rentPrice'),
      type: json.parseEnum('type', ResidenceType.parse),
      thumbnailUrl: json.parseValue('thumbnailUrl'),
      city: json.parseValue('city'),
    );
  }
}
