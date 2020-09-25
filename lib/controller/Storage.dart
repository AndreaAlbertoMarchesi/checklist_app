import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:checklist_app/model/Task.dart';
import 'package:path_provider/path_provider.dart';

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    File file = File('$path/counter.txt');
    return file;
  }

  Future<Task> readData() async {
    try {
      final file = await _localFile;
      if(file.existsSync()) {
        String content = await file.readAsString();
        return Task.fromJson(jsonDecode(content));
      }
    } catch (e) {
      print(e);
    }
    return Task.emptyRoot;
  }

  Future<File> writeData(Task root) async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(root.toJson()));
  }
}
