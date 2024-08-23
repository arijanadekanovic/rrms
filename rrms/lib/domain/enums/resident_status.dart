import 'package:rrms/_all.dart';

enum ResidentStatus {
  pendingRequest(0),
  active(1),
  contractExpired(2),
  rejected(3);

  final int value;

  const ResidentStatus([this.value = 0]);

  static ResidentStatus? parse(int? index) => ResidentStatus.values.firstOrDefault((x) => x.value == index);

  String get title => switch (this) {
        ResidentStatus.pendingRequest => 'Pending request',
        ResidentStatus.active => 'Active',
        ResidentStatus.contractExpired => 'Contract expired',
        ResidentStatus.rejected => 'Rejected',
      };

  Color color(AppThemeData appTheme) => switch (this) {
        ResidentStatus.pendingRequest => appTheme.warning,
        ResidentStatus.active => appTheme.success,
        ResidentStatus.contractExpired => appTheme.blue,
        ResidentStatus.rejected => appTheme.danger,
      };
}
