import 'package:rrms/_all.dart';

class CitiesCubit extends EventReaderCubit<CitiesState> {
  final CitiesRepository citiesRepository;

  CitiesCubit({
    required this.citiesRepository,
  }) : super(CitiesState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: CitiesStateStatus.loading));

    final result = await citiesRepository.get();

    emit(
      state.copyWith(
        status: CitiesStateStatus.loaded,
        cities: result.data,
      ),
    );
  }

  @override
  void onEvent(Object event) {
    if (event is AuthState && event.isAuthenticated) load();
  }
}
