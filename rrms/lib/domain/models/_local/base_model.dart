import 'package:equatable/equatable.dart';
import 'package:rrms/_all.dart';

abstract class BaseModel with EquatableMixin {
  bool get isEmpty {
    for (var i = 0; i < props.length; i++) {
      if (props[i].isString) {
        if ((props[i] as String?).isNotNullOrEmpty) {
          return false;
        }
      } else if (props[i] != null) {
        return false;
      }
    }

    return true;
  }
}

extension _TypeX on Object? {
  bool get isString => this is String? || this is String;
}
