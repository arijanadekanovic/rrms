import 'package:rrms/_all.dart';

class ResidentAddCubit extends EventProviderCubit<ResidentAddState> {
  final ResidentsRepository residentsRepository;

  ResidentAddCubit({
    required this.residentsRepository,
    required ResidentAddRequestModelValidator modelValidator,
  }) : super(ResidentAddState.initial(modelValidator));

  void init(int residenceId) {
    emit(state.copyWith(model: state.model.copyWith(residenceId: residenceId)));
  }

  void update(ResidentAddRequestModel model) {
    emit(state.copyWith(model: model));
  }

  Future<void> submit() async {
    final isModelValid = state.modelValidator.validate(state.model);

    if (isModelValid) {
      emit(state.copyWith(status: ResidentAddStateStatus.submitting));

      final result = await residentsRepository.add(state.model);

      if (result.isSuccess) {
        emit(state.copyWith(status: ResidentAddStateStatus.submittingSuccess));
      } else {
        emit(state.copyWith(status: ResidentAddStateStatus.submittingError));
      }
    } else {
      emit(state.copyWith(status: ResidentAddStateStatus.validationError));
      emit(state.copyWith(status: ResidentAddStateStatus.initialSubmitted));
    }
  }
}
