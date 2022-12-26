import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

//画像をWebからランダムに取得して、アプリ内のローカルパスに保存

class ImageLoadManager {

  Future<String> getImage({required String key, required int fileIndex}) async {
    String filePath = "";

    //ランダムに画像が取得できるサイト（画像のByteDataが返ってくる）
    //https://picsum.photos/
    final requestUrl = Uri.parse("https://picsum.photos/200/300");
    final response = await http.get(requestUrl);
    if (response.statusCode == 200) {
      final responseBodyBytes = response.bodyBytes;

      //ローカルパスの取得
      final appDirectory = await getApplicationDocumentsDirectory();
      //拡張子必要（.jpg）:階層をつけたらダメみたい
      filePath = '${appDirectory.path}/$key$fileIndex.jpg';
      final localFile = File(filePath);
      await localFile.writeAsBytes(responseBodyBytes);

    } else {
      Fluttertoast.showToast(msg: "画像の取得に失敗しました: ${response.statusCode}");
    }
    return filePath;
  }


}