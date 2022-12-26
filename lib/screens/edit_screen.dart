import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_own_frashcard/db/database.dart';
import 'package:my_own_frashcard/main.dart';
import 'package:my_own_frashcard/models/image_load_manager.dart';
import 'package:my_own_frashcard/screens/word_list_screen.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _backToWordListScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("新しい単語の追加"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done),
              tooltip: "登録",
              onPressed: () => _insertWord(),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Text(
                  "問題とこたえを入力して「登録」ボタンを押してください",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              //問題入力部分
              _questionInputPart(),
              SizedBox(
                height: 50.0,
              ),
              // こたえ入力部分
              _answerInputPart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _questionInputPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          Text(
            "問題",
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: questionController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0),
          )
        ],
      ),
    );
  }

  Widget _answerInputPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          Text(
            "こたえ",
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: answerController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0),
          )
        ],
      ),
    );
  }

  Future<bool> _backToWordListScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WordListScreen(),
      ),
    );
    return Future.value(true);
  }

  _insertWord() async {
    final ImageLoadManager imageLoadManager = ImageLoadManager();
    //画像をランダムに取得しよう（画像２つ）
    final imagePath1 = await imageLoadManager.getImage(
      key: questionController.text,
      fileIndex: 1,
    );
    final imagePath2 = await imageLoadManager.getImage(
      key: questionController.text,
      fileIndex: 2,
    );

    if (questionController.text == "" || answerController.text == "") {
      Fluttertoast.showToast(
        msg: "問題と答えの両方を入力しないと登録できません",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("登録"),
        content: Text("登録していいですか？"),
        actions: <Widget>[
          TextButton(
            child: Text("はい"),
            onPressed: () async {
              var word = Word(
                  strQuestion: questionController.text,
                  strAnswer: answerController.text,
                  //TODO
                  imagePath1: imagePath1,
                  imagePath2: imagePath2);

              try {
                await database.addWord(word);
                print("OK");
                questionController.clear();
                answerController.clear();
                Fluttertoast.showToast(
                  backgroundColor: Colors.blueAccent,
                  msg: "登録が完了しました。",
                  toastLength: Toast.LENGTH_LONG,
                );
              } on SqliteException catch (e) {
                print(e.toString());
                Fluttertoast.showToast(
                  msg: "この問題は既に登録されていますので登録できません。",
                  toastLength: Toast.LENGTH_LONG,
                );
              } finally {
                Navigator.pop(context);
              }
            },
          ),
          TextButton(
            child: Text("いいえ"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
