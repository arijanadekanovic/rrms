import 'package:rrms/_all.dart';

class ResidencesCubit extends Cubit<ResidencesState> {
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
}
