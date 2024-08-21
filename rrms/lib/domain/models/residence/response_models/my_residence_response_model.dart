import 'package:rrms/_all.dart';

class MyResidenceResponseModel {
  final int? id;
  final String? name;
  final String? address;
  final int? rooms;
  final double? size;
  final double? rentPrice;
  final ResidenceType? type;
  final String? thumbnailUrl;
  final String? city;

  MyResidenceResponseModel({
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

  factory MyResidenceResponseModel.fromJson(Map<String, dynamic> json) {
    return MyResidenceResponseModel(
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
