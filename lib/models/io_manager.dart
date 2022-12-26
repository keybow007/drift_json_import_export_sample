import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_own_frashcard/db/database.dart';
import 'package:my_own_frashcard/models/zip_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../main.dart';

class IOManager {
  final ZipManager zipManager = ZipManager();
  final dbDataFileName = "db_data.txt";

  Future<void> exportData() async {
    //データベースからデータを取得
    final dbData = await database.allWords;
    if (dbData.isEmpty) {
      //本当はToastはView側で書くべき
      Fluttertoast.showToast(msg: "データがありませんでした。");
      return;
    }

    try {
      //JsonString化
      final decodedJsonString = _convertToJson(dbData);
      /*
      * （ファイルの保存方法：これがちょいややこしい）
      * Androidの場合：Shareで端末に直接保存できないが、getExternalStorageDirectoriesが使えるのでそこに保存
      *   （ただし、外部ストレージではあるが、アプリをアンインストールすると消えてしまうので、シェアもしておいた方が無難）
      * iOSの場合：getExternalStorageDirectoriesが使えないが、Shareで端末に保存できるのでShareさせる
      * */

      //アプリ内のローカルパスにdecodedJsonStringを保存
      //https://docs.flutter.dev/cookbook/persistence/reading-writing-files
      final dbDataFilePath = (Platform.isIOS)
          ? appDirectory.path
          //: (await getExternalStorageDirectory())?.path;
          : (await getExternalStorageDirectories(type: StorageDirectory.downloads))?.first.path;
      final dbDataFile = File("$dbDataFilePath/$dbDataFileName");
      await dbDataFile.writeAsString(decodedJsonString);

      //---------------
      //画像のファイルパス
      final imageFiles = _getImageFiles(dbData);

      //DBデータと画像群を１つのzipファイルにまとめる
      final zipFile = await zipManager.encodeZipFile(dbDataFile, imageFiles);

      //ファイルをシェア（保存自体はユーザーにやってもらう）
      //Share.shareFilesは非推奨 => shareXFilesに
      //https://pub.dev/packages/share_plus
      if (zipFile != null) await Share.shareXFiles([XFile(zipFile.path)],
          //（注）Googleドライブの場合は「subject」がタイトル（ファイル名）になるので、
          // ここに拡張子（zip）をいれておかないとダウンロードした際に展開できないみたい
          text: "データをエクスポートします", subject: "output.zip");
    } on Exception catch (e) {
      //本当はToastはView側で書くべき
      Fluttertoast.showToast(msg: "データのエクスポートに失敗しました: $e");
    }
  }

  String _convertToJson(List<Word> dbData) {
    var jsonData = <Map<String, dynamic>>[];
    dbData.forEach((element) {
      //Driftの自動生成コードにtoJsonがある
      final jsonElement = element.toJson();
      jsonData.add(jsonElement);
    });
    //（注）ここでEncodeしておかないとインポート時にFormatExceptionが出る
    //https://stackoverflow.com/questions/68366182/json-decode-error-formatexception-unexpected-character-at-character-3/68367460#68367460
    return jsonEncode(jsonData);
  }

  Future<void> importData() async {
    //外部に保存したJSONファイルをFilePickerで取得
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles();
    if (filePickerResult == null) {
      //本当はToastはView側で書くべき
      Fluttertoast.showToast(msg: "ファイルの取得に失敗しました。");
      return;
    }
    try {
      final importFile = File(filePickerResult.files.single.path!);
      //インポートしたzipファイルのデータ読み込み
      //https://docs.flutter.dev/cookbook/persistence/reading-writing-files#4-read-data-from-the-file
      final bytes = await importFile.readAsBytes();
      final archives = ZipDecoder().decodeBytes(bytes);
      //ローカルに保存
      await Future.forEach(archives, (ArchiveFile archiveFile) async {
        final fileName = archiveFile.name;
        if (archiveFile.isFile) {
          final data = archiveFile.content as List<int>;
          final localFile = File("${appDirectory.path}/$fileName");
          await localFile.writeAsBytes(data);
        }
      });
      //DBデータの読み取り
      final dbFile = File("${appDirectory.path}/$dbDataFileName");
      final jsonString = await dbFile.readAsString();
      //jsonStringを解析（as List<dynamic>>にしないとループ処理ができないがList<Map<String, dynamic>>にすると型違いエラーになる）
      final decodedJson = jsonDecode(jsonString) as List<dynamic>;
      //DBに登録
      await insertImportDataToDB(decodedJson);
    } on Exception catch (e) {
      //本当はToastはView側で書くべき
      Fluttertoast.showToast(msg: "データのインポートに失敗しました: $e");
    }
  }

  Future<void> insertImportDataToDB(List<dynamic> decodedJson) async {
    try {
      //一旦DBをクリアにする（UNIQUE constraint failed回避のため）
      await database.clearDB();

      await Future.forEach(decodedJson, (element) async {
        final mappedElement = element as Map<String, dynamic>;
        //Driftの自動生成コードにfromJsonがある
        await database.addWord(Word.fromJson(mappedElement));
      });
    } on Exception catch (e) {
      //本当はToastはView側で書くべき
      Fluttertoast.showToast(msg: "データのインポートに失敗しました: $e");
    }
  }

  List<File> _getImageFiles(List<Word> dbData) {
    var imageFiles = <File>[];
    dbData.forEach((element) {
      if (element.imagePath1 != "") imageFiles.add(File(element.imagePath1));
      if (element.imagePath2 != "") imageFiles.add(File(element.imagePath2));
    });
    return imageFiles;
  }


}
