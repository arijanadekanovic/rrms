import 'package:rrms/_all.dart';

class ResidencesCubit extends EventReaderCubit<ResidencesState> {
  final ResidencesRepository residencesRepository;

  ResidencesCubit({
    required this.residencesRepository,
  }) : super(ResidencesState.initial());

  Future<void> load([ResidencesSearchRequestModel? searchModel]) async {
    emit(state.copyWith(status: ResidencesStateStatus.loading));

    final result = await residencesRepository.get(searchModel ?? state.searchModel);

    emit(
      state.copyWith(
        status: ResidencesStateStatus.loaded,
        searchModel: searchModel,
        residences: result.data,
      ),
    );
  }

  void updateSearchModel(ResidencesSearchRequestModel searchModel) {
    emit(state.copyWith(searchModel: searchModel));
  }

  @override
  void onEvent(Object event) {
    if (event is ResidenceDeleteState && event.status == ResidenceDeleteStateStatus.submittingSuccess) load();
  }
}
