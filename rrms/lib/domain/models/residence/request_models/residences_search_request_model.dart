import 'package:rrms/_all.dart';

class ResidencesSearchRequestModel {
  final String? searchTerm;
  final int? cityId;
  final double? priceFrom;
  final double? priceTo;
  final double? sizeFrom;
  final double? sizeTo;
  final int? numberOfRooms;
  final ResidenceType? type;
  final bool? ownedByMe;

  ResidencesSearchRequestModel({
    this.searchTerm,
    this.cityId,
    this.priceFrom,
    this.priceTo,
    this.sizeFrom,
    this.sizeTo,
    this.numberOfRooms,
    this.type,
    this.ownedByMe,
  });

  ResidencesSearchRequestModel copyWith({
    String? searchTerm,
    int? cityId,
    double? priceFrom,
    double? priceTo,
    double? sizeFrom,
    double? sizeTo,
    int? numberOfRooms,
    ResidenceType? type,
    bool? ownedByMe,
  }) {
    return ResidencesSearchRequestModel(
      searchTerm: searchTerm ?? this.searchTerm,
      cityId: cityId ?? this.cityId,
      priceFrom: priceFrom ?? this.priceFrom,
      priceTo: priceTo ?? this.priceTo,
      sizeFrom: sizeFrom ?? this.sizeFrom,
      sizeTo: sizeTo ?? this.sizeTo,
      numberOfRooms: numberOfRooms ?? this.numberOfRooms,
      type: type ?? this.type,
      ownedByMe: ownedByMe ?? this.ownedByMe,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (searchTerm != null) 'searchTerm': searchTerm,
      if (cityId != null) 'cityId': cityId,
      if (priceFrom != null) 'priceFrom': priceFrom,
      if (priceTo != null) 'priceTo': priceTo,
      if (sizeFrom != null) 'sizeFrom': sizeFrom,
      if (sizeTo != null) 'sizeTo': sizeTo,
      if (numberOfRooms != null) 'numberOfRooms': numberOfRooms,
      if (type != null) 'type': type?.index,
      if (ownedByMe != null) 'ownedByMe': ownedByMe,
    };
  }
}
