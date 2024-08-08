import 'package:rrms/_all.dart';

extension PermissionExtension on Permission {
  Future<bool> check() async {
    if (await isGranted) {
      return true;
    }

    if (await isRestricted || await isDenied) {
      return (await request()).isGranted;
    }

    if (await isPermanentlyDenied) {
      return await showRequestRationale(this);
    }

    return false;
  }
}
