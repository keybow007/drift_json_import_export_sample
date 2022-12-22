import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_own_frashcard/db/database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../main.dart';

class JsonIOManager {
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
      final filePath = (Platform.isIOS)
          ? (await getApplicationDocumentsDirectory()).path
          : (await getExternalStorageDirectory())?.path;
      final file = File("$filePath/my_words.txt");
      await file.writeAsString(decodedJsonString);

      //ファイルをシェア（保存自体はユーザーにやってもらう）
      //Share.shareFilesは非推奨 => shareXFilesに
      //https://pub.dev/packages/share_plus
      await Share.shareXFiles([XFile(file.path)],
          text: "データをエクスポートします", subject: "データのエクスポート @${DateTime.now()} ");
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
      //インポートしたファイルのデータ読み込み
      //https://docs.flutter.dev/cookbook/persistence/reading-writing-files#4-read-data-from-the-file
      final jsonString = await importFile.readAsString();
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
}
