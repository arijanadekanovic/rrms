import 'package:rrms/_all.dart';

class ResidentsCubit extends EventReaderCubit<ResidentsState> {
  final ResidentsRepository residentsRepository;

  ResidentsCubit({
    required this.residentsRepository,
  }) : super(ResidentsState.initial());

  Future<void> load([ResidentsSearchRequestModel? searchModel]) async {
    emit(state.copyWith(status: ResidentsStateStatus.loading));

    final result = await residentsRepository.get(searchModel ?? state.searchModel);

    emit(
      state.copyWith(
        status: ResidentsStateStatus.loaded,
        searchModel: searchModel,
        residents: result.data,
      ),
    );
  }

  @override
  void onEvent(Object event) {
    if (event is ResidentStatusUpdateState && event.status == ResidentStatusUpdateStateStatus.submittingSuccess) load();
  }
}
