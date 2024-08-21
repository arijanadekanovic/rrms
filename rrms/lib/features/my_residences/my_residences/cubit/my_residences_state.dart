import 'package:rrms/_all.dart';

enum MyResidencesStateStatus {
  loading,
  loaded,
}

class MyResidencesState {
  final MyResidencesStateStatus status;
  final List<MyResidenceResponseModel> myResidences;

  MyResidencesState({
    required this.status,
    required this.myResidences,
  });

  factory MyResidencesState.initial() => MyResidencesState(
        status: MyResidencesStateStatus.loaded,
        myResidences: [],
      );

  MyResidencesState copyWith({
    MyResidencesStateStatus? status,
    List<MyResidenceResponseModel>? myResidences,
  }) {
    return MyResidencesState(
      status: status ?? this.status,
      myResidences: myResidences ?? this.myResidences,
    );
  }
}
