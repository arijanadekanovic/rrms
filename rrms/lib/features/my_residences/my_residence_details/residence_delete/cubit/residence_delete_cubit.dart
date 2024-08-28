import 'package:rrms/_all.dart';

class ResidenceDeleteCubit extends EventProviderCubit<ResidenceDeleteState> {
  final ResidencesRepository residencesRepository;

  ResidenceDeleteCubit({
    required this.residencesRepository,
  }) : super(ResidenceDeleteState.initial());

  Future<void> submit(int id) async {
    emit(
      state.copyWith(
        status: ResidenceDeleteStateStatus.submitting,
        id: Optional(id),
      ),
    );

    final result = await residencesRepository.delete(id);

    if (result.isSuccess) {
      emit(state.copyWith(status: ResidenceDeleteStateStatus.submittingSuccess));
    } else {
      emit(
        state.copyWith(
          status: ResidenceDeleteStateStatus.submittingError,
          id: Optional.absent(),
        ),
      );
    }
  }
}
