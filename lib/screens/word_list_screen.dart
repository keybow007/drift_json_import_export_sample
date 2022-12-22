import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_own_frashcard/db/database.dart';
import 'package:my_own_frashcard/main.dart';
import 'package:my_own_frashcard/models/json_io_manager.dart';
import 'package:my_own_frashcard/screens/edit_screen.dart';

class WordListScreen extends StatefulWidget {
  @override
  _WordListScreenState createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  List<Word> _wordList = [];

  //TODO データのインポート・エクスポート機能追加
  JsonIOManager jsonIOManager = JsonIOManager();

  @override
  void initState() {
    super.initState();
    _getAllWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("単語一覧"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sort),
            tooltip: "暗記済みの単語を下になるようにソート",
            onPressed: () => _sortWords(),
          ),
          //TODO データのインポート・エクスポート機能追加
          IconButton(
            icon: Icon(Icons.upload),
            tooltip: "エクスポート",
            onPressed: () => _exportData(),
          ),
          IconButton(
            icon: Icon(Icons.download),
            tooltip: "インポート",
            onPressed: () => _importData(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewWord(),
        child: Icon(Icons.add),
        tooltip: "新しい単語の登録",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _wordListWidget(),
      ),
    );
  }

  _addNewWord() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => EditScreen(
                  status: EditStatus.ADD,
                )));
  }

  void _getAllWords() async {
    _wordList = await database.allWords;
    //for文を使いたいがためだけのコーディング
    //_wordList = await database.getAllWordsWithStar();

    setState(() {});
  }

  Widget _wordListWidget() {
    return ListView.builder(
        itemCount: _wordList.length,
        itemBuilder: (context, int position) => _wordItem(position));
  }

  Widget _wordItem(int position) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.grey.shade700,
      child: ListTile(
        title: Text("${_wordList[position].strQuestion}"),
        subtitle: Text(
          "${_wordList[position].strAnswer}",
          style: TextStyle(fontFamily: "Mont"),
        ),
        trailing:
            _wordList[position].isMemorized ? Icon(Icons.check_circle) : null,
        onTap: () => _editWord(_wordList[position]),
        onLongPress: () => _deleteWord(_wordList[position]),
      ),
    );
  }

  _deleteWord(Word selectedWord) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(selectedWord.strQuestion),
        content: Text("削除してもいいですか？"),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              //20220905：primary / onPrimaryはFlutter3.3以降非推奨に
              //https://github.com/flutter/flutter/pull/105291
              foregroundColor: Colors.white,
            ),
            child: Text("はい"),
            onPressed: () async {
              await database.deleteWord(selectedWord);
              Fluttertoast.showToast(
                msg: "削除が完了しました",
                toastLength: Toast.LENGTH_LONG,
              );
              _getAllWords();
              Navigator.pop(context);
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

  _editWord(Word selectedWord) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(
          status: EditStatus.EDIT,
          word: selectedWord,
        ),
      ),
    );
  }

  _sortWords() async {
    _wordList = await database.allWordsSorted;
    setState(() {});
  }

  //----TODO データのインポート・エクスポート機能追加---------

  _exportData() async {
    await jsonIOManager.exportData();
    Fluttertoast.showToast(msg: "データのエクスポートが完了しました");
  }

  _importData() async {
    await jsonIOManager.importData();
    //インポート後にデータ再取得
    _getAllWords();
    Fluttertoast.showToast(msg: "データのインポートが完了しました");
  }


}
