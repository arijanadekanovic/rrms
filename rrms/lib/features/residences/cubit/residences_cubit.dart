import 'package:rrms/_all.dart';

class ResidencesCubit extends EventProviderCubit<ResidencesState> {
  final ResidencesRepository residencesRepository;

  ResidencesCubit({
    required this.residencesRepository,
  }) : super(ResidencesState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: ResidencesStateStatus.loading));

    final result = await residencesRepository.get();

    // await Future.delayed(const Duration(seconds: 4));

    emit(
      state.copyWith(
        status: ResidencesStateStatus.loaded,
        residences: result.data,
      ),
    );
  }
}
