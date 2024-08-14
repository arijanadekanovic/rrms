import 'package:rrms/_all.dart';

class ResidencesRequestModel {
  final String? searchTerm;
  final int? cityId;
  final double? priceFrom;
  final double? priceTo;
  final double? sizeFrom;
  final double? sizeTo;
  final int? numberOfRooms;
  final ResidenceType? type;

  ResidencesRequestModel({
    this.searchTerm,
    this.cityId,
    this.priceFrom,
    this.priceTo,
    this.sizeFrom,
    this.sizeTo,
    this.numberOfRooms,
    this.type,
  });

  ResidencesRequestModel copyWith({
    String? searchTerm,
    int? cityId,
    double? priceFrom,
    double? priceTo,
    double? sizeFrom,
    double? sizeTo,
    int? numberOfRooms,
    ResidenceType? type,
  }) {
    return ResidencesRequestModel(
      searchTerm: searchTerm ?? this.searchTerm,
      cityId: cityId ?? this.cityId,
      priceFrom: priceFrom ?? this.priceFrom,
      priceTo: priceTo ?? this.priceTo,
      sizeFrom: sizeFrom ?? this.sizeFrom,
      sizeTo: sizeTo ?? this.sizeTo,
      numberOfRooms: numberOfRooms ?? this.numberOfRooms,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'searchTerm': searchTerm,
      'cityId': cityId,
      'priceFrom': priceFrom,
      'priceTo': priceTo,
      'sizeFrom': sizeFrom,
      'sizeTo': sizeTo,
      'numberOfRooms': numberOfRooms,
      'type': type,
    };
  }
}
