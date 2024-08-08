import 'package:rrms/_all.dart';

enum PermissionHandlerStateStatus {
  initial,
  allowed,
  denied,
  deniedForever,
}

class PermissionHandlerState {
  final PermissionHandlerStateStatus status;
  final PermissionStatus? permissionStatus;
  final Permission permission;

  PermissionHandlerState({
    required this.status,
    this.permissionStatus,
    required this.permission,
  });

  factory PermissionHandlerState.initial({required Permission permission}) => PermissionHandlerState(
        status: PermissionHandlerStateStatus.initial,
        permission: permission,
      );

  PermissionHandlerState copyWith({
    PermissionHandlerStateStatus? status,
    PermissionStatus? permissionStatus,
    Permission? permission,
  }) =>
      PermissionHandlerState(
        status: status ?? this.status,
        permissionStatus: permissionStatus ?? this.permissionStatus,
        permission: permission ?? this.permission,
      );
}
