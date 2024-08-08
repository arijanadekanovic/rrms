import 'package:rrms/_all.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit({int index = 0}) : super(NavigationState(index: index));

  void update(int index, {dynamic data}) => emit(NavigationState(index: index, data: data));
  void increment() => emit(NavigationState(index: state.index + 1, data: state.data));
  void decrement() => emit(NavigationState(index: state.index - 1, data: state.data));
}
