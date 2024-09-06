import 'package:rrms/_all.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as p;

class FileInfo  {
  String path;
  File file;
  String name;
  String get nameWithExtension => '$name$extension';
  String extension;
  FileInfoType type;

  Future<int> get size async => await file.length();

  FileInfo({
    required this.path,
    required this.file,
    required this.name,
    required this.extension,
    required this.type,
  });

  factory FileInfo.fromPath(String path) {
    final extension = p.extension(path);

    return FileInfo(
      file: File(path),
      name: basename(path),
      extension: extension,
      path: path,
      type: FileInfoType.fromExtension(extension),
    );
  }
}
