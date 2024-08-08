import 'package:rrms/_all.dart';

class VisibilityCubit extends Cubit<VisibilityState> {
  VisibilityCubit({bool isVisible = false}) : super(VisibilityState(isVisible: isVisible));

  Future<void> update(bool isVisible, {dynamic data}) async {
    emit(VisibilityState(isVisible: isVisible, data: data));
  }
}
