import 'package:rrms/_all.dart';

class ResidenceAddCubit extends EventProviderCubit<ResidenceAddState> {
  final ResidencesRepository residencesRepository;

  ResidenceAddCubit({
    required this.residencesRepository,
    required ResidenceAddRequestModelValidator modelValidator,
  }) : super(ResidenceAddState.initial(modelValidator));

  void update(ResidenceAddRequestModel model) {
    emit(state.copyWith(model: model));
  }

  Future<void> submit() async {
    final isModelValid = state.modelValidator.validate(state.model);

    if (isModelValid) {
      emit(state.copyWith(status: ResidenceAddStateStatus.submitting));

      final result = await residencesRepository.add(state.model);

      if (result.isSuccess) {
        emit(state.copyWith(status: ResidenceAddStateStatus.submittingSuccess));
      } else {
        emit(state.copyWith(status: ResidenceAddStateStatus.submittingError));
      }
    } else {
      emit(state.copyWith(status: ResidenceAddStateStatus.validationError));
      emit(state.copyWith(status: ResidenceAddStateStatus.initialSubmitted));
    }
  }
}
