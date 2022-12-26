/*
* DBデータを格納したJsonファイルと画像のファイル群を１つのzipファイルにしよう
* https://pub.dev/packages/archive
* */

import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';


class ZipManager {
  Future<File?> encodeZipFile(File dbDataFile, List<File> imageFiles) async {
    File? zipFile;

    final files = [...imageFiles];
    files.add(dbDataFile);

    //ローカルパスの取得
    final appDirectory = await getApplicationDocumentsDirectory();

    try {
      final encoder = ZipFileEncoder();
      encoder.create("${appDirectory.path}/output.zip");
      await Future.forEach(files, (File file) => encoder.addFile(file));
      zipFile = File(encoder.zipPath);
      //zipに書き込むためのメソッド（これを忘れると展開できないzipファイルができてしまう）
      encoder.close();
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: "zipファイル化に失敗しました: ${e.toString()}");
    }
    return zipFile;
  }

}


