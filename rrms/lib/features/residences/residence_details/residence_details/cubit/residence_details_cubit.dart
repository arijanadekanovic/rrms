import 'package:rrms/_all.dart';

class ResidenceDetailsCubit extends EventReaderCubit<ResidenceDetailsState> {
  final ResidencesRepository residencesRepository;

  ResidenceDetailsCubit({
    required this.residencesRepository,
  }) : super(ResidenceDetailsState.initial());

  Future<void> load(int id) async {
    emit(state.copyWith(status: ResidenceDetailsStateStatus.loading));

    final result = await residencesRepository.getById(id);

    if (result.isSuccess) {
      emit(
        state.copyWith(
          status: ResidenceDetailsStateStatus.loaded,
          details: result.data,
        ),
      );
    }
  }

  @override
  void onEvent(Object event) {
    if (event is ResidenceUpdateState && event.status == ResidenceUpdateStateStatus.submittingSuccess && event.model.id == state.details?.id) load(state.details?.id ?? 0);
  }
}
