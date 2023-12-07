import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../main.dart';

//画像をWebからランダムに取得して、アプリ内のローカルパスに保存

class ImageLoadManager {

  /*
  * （注）画像のパスをそのまま返すとOSを跨いだ際に画像が読み込めなくなるので
  *   （AndroidとiOSではgetApplicationDocumentsDirectoryの絶対パスが異なるので）
  *   DBには画像のファイル名だけを保存しておいて、パスは読み込みの際にOSに任せる形にする
  *   （getApplicationDocumentsDirectoryに任せる）
  *
  * */
  Future<String> getImage({required String key, required int fileIndex}) async {
    String filePath = "";

    //ランダムに画像が取得できるサイト（画像のByteDataが返ってくる）
    //https://picsum.photos/
    final requestUrl = Uri.parse("https://picsum.photos/200/300");
    final response = await http.get(requestUrl);
    if (response.statusCode == 200) {
      final responseBodyBytes = response.bodyBytes;

      //拡張子必要（.jpg）:階層をつけたらダメみたい
      filePath = '${appDirectory.path}/$key$fileIndex.jpg';
      final localFile = File(filePath);
      await localFile.writeAsBytes(responseBodyBytes);

    } else {
      Fluttertoast.showToast(msg: "画像の取得に失敗しました: ${response.statusCode}");
    }
    return path.basename(filePath);
  }


}