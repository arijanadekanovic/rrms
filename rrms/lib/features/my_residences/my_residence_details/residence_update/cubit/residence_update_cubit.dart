import 'package:rrms/_all.dart';

class ResidenceUpdateCubit extends EventProviderCubit<ResidenceUpdateState> {
  final ResidencesRepository residencesRepository;

  ResidenceUpdateCubit({
    required this.residencesRepository,
    required ResidenceUpdateRequestModelValidator modelValidator,
  }) : super(ResidenceUpdateState.initial(modelValidator));

  Future<void> init(int id) async {
    emit(state.copyWith(status: ResidenceUpdateStateStatus.initializing));

    final result = await residencesRepository.prepareForUpdate(id);

    if (result.isSuccess) {
      emit(state.copyWith(status: ResidenceUpdateStateStatus.initialized, model: result.data));
    }
  }

  void update(ResidenceUpdateRequestModel model) {
    emit(state.copyWith(model: model));
  }

  Future<void> submit() async {
    final isModelValid = state.modelValidator.validate(state.model);

    if (isModelValid) {
      emit(state.copyWith(status: ResidenceUpdateStateStatus.submitting));

      final result = await residencesRepository.update(state.model);

      if (result.isSuccess) {
        emit(state.copyWith(status: ResidenceUpdateStateStatus.submittingSuccess));
      } else {
        emit(state.copyWith(status: ResidenceUpdateStateStatus.submittingError));
      }
    } else {
      emit(state.copyWith(status: ResidenceUpdateStateStatus.validationError));
      emit(state.copyWith(status: ResidenceUpdateStateStatus.initialSubmitted));
    }
  }
}
