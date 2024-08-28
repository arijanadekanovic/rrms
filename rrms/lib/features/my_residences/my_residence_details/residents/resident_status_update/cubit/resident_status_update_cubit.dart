import 'package:rrms/_all.dart';

class ResidentStatusUpdateCubit extends EventProviderCubit<ResidentStatusUpdateState> {
  final ResidentsRepository residentsRepository;

  ResidentStatusUpdateCubit({
    required this.residentsRepository,
  }) : super(ResidentStatusUpdateState.initial());

  Future<void> submit(ResidentStatusUpdateRequestModel model) async {
    emit(state.copyWith(status: ResidentStatusUpdateStateStatus.submitting, model: model));

    final result = await residentsRepository.statusUpdate(model);

    if (result.isSuccess) {
      emit(state.copyWith(status: ResidentStatusUpdateStateStatus.submittingSuccess));
    } else {
      emit(state.copyWith(status: ResidentStatusUpdateStateStatus.submittingError));
    }

    emit(state.copyWith(status: ResidentStatusUpdateStateStatus.initial));
  }
}
