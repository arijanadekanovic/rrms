import 'package:rrms/_all.dart';

class MyResidencesCubit extends Cubit<MyResidencesState> {
  final ResidencesRepository residencesRepository;

  MyResidencesCubit({
    required this.residencesRepository,
  }) : super(MyResidencesState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: MyResidencesStateStatus.loading));

    final result = await residencesRepository.getMyResidences();

    emit(
      state.copyWith(
        status: MyResidencesStateStatus.loaded,
        myResidences: result.data,
      ),
    );
  }
}
