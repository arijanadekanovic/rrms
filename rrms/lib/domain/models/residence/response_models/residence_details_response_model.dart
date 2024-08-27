import 'package:rrms/_all.dart';

class ResidenceDetailsResponseModel {
  final int? id;
  final String? name;
  final String? description;
  final String? address;
  final int? rooms;
  final double? size;
  final double? rentPrice;
  final ResidenceType? type;
  final String? thumbnailUrl;
  final ResidenceDetailsCityResponseModel? city;

  ResidenceDetailsResponseModel({
    this.id,
    this.name,
    this.description,
    this.address,
    this.rooms,
    this.size,
    this.rentPrice,
    this.type,
    this.thumbnailUrl,
    this.city,
  });

  factory ResidenceDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return ResidenceDetailsResponseModel(
      id: json.parseValue('id'),
      name: json.parseValue('name'),
      description: json.parseValue('description'),
      address: json.parseValue('address'),
      rooms: json.parseValue('rooms'),
      size: json.parseDouble('size'),
      rentPrice: json.parseDouble('rentPrice'),
      type: json.parseEnum('type', ResidenceType.parse),
      thumbnailUrl: json.parseValue('thumbnailUrl'),
      city: json.parse('city', ResidenceDetailsCityResponseModel.fromJson),
    );
  }
}
