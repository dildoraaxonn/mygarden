import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Keeps tree photos in the app's documents folder.
class PhotoStorage {
  PhotoStorage.at(this._dir);

  final Directory _dir;

  static Future<PhotoStorage> open() async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, 'photos'));
    await dir.create(recursive: true);
    return PhotoStorage.at(dir);
  }

  File fileFor(String fileName) => File(p.join(_dir.path, fileName));

  /// Copies a picked image into app storage and returns its new file name.
  Future<String> save(String sourcePath) async {
    final name =
        '${DateTime.now().microsecondsSinceEpoch}${p.extension(sourcePath)}';
    await File(sourcePath).copy(fileFor(name).path);
    return name;
  }

  Future<void> delete(String fileName) async {
    final file = fileFor(fileName);
    if (await file.exists()) await file.delete();
  }
}
