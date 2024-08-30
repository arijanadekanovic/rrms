import 'package:rrms/_all.dart';

class ResidentStatusUpdateRequestModel {
  final int? residentId;
  final ResidentStatus? status;

  ResidentStatusUpdateRequestModel({
    this.residentId,
    this.status,
  });

  ResidentStatusUpdateRequestModel copyWith({
    int? residentId,
    ResidentStatus? status,
  }) {
    return ResidentStatusUpdateRequestModel(
      residentId: residentId ?? this.residentId,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (residentId != null) 'residentId': residentId,
      if (status != null) 'status': status?.value,
    };
  }
}
