import 'package:rrms/_all.dart';

class PermissionHandlerCubit extends Cubit<PermissionHandlerState> {
  PermissionHandlerCubit({
    required Permission permission,
  }) : super(PermissionHandlerState.initial(permission: permission)) {
    init();
  }

  Future<void> init() async {
    final permissionStatus = await state.permission.status;

    emit(state.copyWith(permissionStatus: permissionStatus));

    await _updateStatus(permissionStatus);
  }

  Future<void> request() async {
    final permissionStatus = await state.permission.request();

    emit(state.copyWith(permissionStatus: permissionStatus));

    await _updateStatus(permissionStatus);
  }

  Future<void> openSettings() async {
    await openAppSettings();
  }

  Future<void> _updateStatus(PermissionStatus permissionStatus) async {
    switch (permissionStatus) {
      case PermissionStatus.denied:
        emit(state.copyWith(status: PermissionHandlerStateStatus.denied));
        break;
      case PermissionStatus.granted:
        emit(state.copyWith(status: PermissionHandlerStateStatus.allowed));
        break;
      case PermissionStatus.restricted:
        emit(state.copyWith(status: PermissionHandlerStateStatus.allowed));
        break;
      case PermissionStatus.limited:
        emit(state.copyWith(status: PermissionHandlerStateStatus.allowed));
        break;
      case PermissionStatus.permanentlyDenied:
        emit(state.copyWith(status: PermissionHandlerStateStatus.deniedForever));
        break;
      case PermissionStatus.provisional:
        emit(state.copyWith(status: PermissionHandlerStateStatus.allowed));
        break;
    }
  }
}
