import 'package:rrms/_all.dart';

class AppPdfViewerCubit extends Cubit<AppPdfViewerState> {
  AppPdfViewerCubit({required String url}) : super(AppPdfViewerState.initial(url)) {
    init();
  }

  Future<void> init() async {
    emit(state.copyWith(status: AppPdfViewerStateStatus.initialized));
  }

  Future<void> update(AppPdfViewerStateModel model) async {
    emit(state.copyWith(model: model));
  }
}
