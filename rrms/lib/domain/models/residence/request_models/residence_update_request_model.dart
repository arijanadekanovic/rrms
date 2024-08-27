import 'package:rrms/_all.dart';

class ResidenceUpdateRequestModel {
  final int? id;
  final String? name;
  final String? description;
  final String? address;
  final int? rooms;
  final double? size;
  final double? rentPrice;
  final ResidenceType? type;
  String? thumbnailUrl;
  final int? cityId;

  final FileInfo? thumbnail;

  ResidenceUpdateRequestModel({
    this.id,
    this.name,
    this.description,
    this.address,
    this.rooms,
    this.size,
    this.rentPrice,
    this.type,
    this.thumbnailUrl,
    this.cityId,
    this.thumbnail,
  });

  ResidenceUpdateRequestModel copyWith({
    int? id,
    String? name,
    String? description,
    String? address,
    int? rooms,
    double? size,
    double? rentPrice,
    ResidenceType? type,
    Optional<String>? thumbnailUrl,
    int? cityId,
    Optional<FileInfo>? thumbnail,
  }) {
    return ResidenceUpdateRequestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      rooms: rooms ?? this.rooms,
      size: size ?? this.size,
      rentPrice: rentPrice ?? this.rentPrice,
      type: type ?? this.type,
      thumbnailUrl: thumbnailUrl != null ? thumbnailUrl.value : this.thumbnailUrl,
      cityId: cityId ?? this.cityId,
      thumbnail: thumbnail != null ? thumbnail.value : this.thumbnail,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (address != null) 'address': address,
      if (rooms != null) 'rooms': rooms,
      if (size != null) 'size': size,
      if (rentPrice != null) 'rentPrice': rentPrice,
      if (type != null) 'type': type?.value,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      if (cityId != null) 'cityId': cityId,
    };
  }
}
