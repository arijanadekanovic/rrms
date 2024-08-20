import 'package:rrms/_all.dart';

enum CitiesStateStatus {
  loading,
  loaded,
}

class CitiesState {
  final CitiesStateStatus status;
  final List<CityResponseModel> cities;

  CitiesState({
    required this.status,
    required this.cities,
  });

  factory CitiesState.initial() => CitiesState(
        status: CitiesStateStatus.loaded,
        cities: [],
      );

  CitiesState copyWith({
    CitiesStateStatus? status,
    List<CityResponseModel>? cities,
  }) {
    return CitiesState(
      status: status ?? this.status,
      cities: cities ?? this.cities,
    );
  }
}
