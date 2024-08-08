import 'package:rrms/_all.dart';

class ResidencesCubit extends Cubit<ResidencesState> {
  final ResidencesRepository residencesRepository;

  ResidencesCubit({
    required this.residencesRepository,
  }) : super(ResidencesState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: ResidencesStateStatus.loading));

    final result = await residencesRepository.get();

    emit(
      state.copyWith(
        status: ResidencesStateStatus.loaded,
        residences: result.data,
      ),
    );
  }
}
