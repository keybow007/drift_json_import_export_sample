import 'package:flutter/material.dart';
import 'package:my_own_frashcard/parts/button_with_icon.dart';
import 'package:my_own_frashcard/screens/test_screen.dart';
import 'package:my_own_frashcard/screens/word_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isIncludedMemorizedWords = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: Image.asset("assets/images/image_title.png")),
            _titleText(),
            Divider(
              height: 30.0,
              color: Colors.white,
              indent: 8.0,
              endIndent: 8.0,
              thickness: 1.0,
            ),
            //かくにんテストをするボタン,
            ButtonWithIcon(
              onPressed: () => _startTestScreen(context), //
              icon: Icon(Icons.play_arrow),
              label: "かくにんテストをする",
              color: Colors.brown,
            ),
            SizedBox(
              height: 10.0,
            ),
            //ラジオボタン,
            _radioButtons(),
            //切り替えトグル（Switch）
            //_switch(),
            SizedBox(
              height: 30.0,
            ),
            //単語一覧を見るボタン,
            ButtonWithIcon(
              onPressed: () => _startWordListScreen(context), //
              icon: Icon(Icons.list),
              label: "単語一覧を見る",
              color: Colors.grey,
            ),
            SizedBox(
              height: 60.0,
            ),
            Text(
              "powered by Telulu LLC 2019",
              style: TextStyle(fontFamily: "Mont"),
            ),
            SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleText() {
    return Column(
      children: <Widget>[
        Text(
          "私だけの単語帳",
          style: TextStyle(fontSize: 40.0),
        ),
        Text(
          "My Own Frashcard",
          style: TextStyle(fontSize: 24.0, fontFamily: "Mont"),
        ),
      ],
    );
  }

  Widget _radioButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0),
      child: Column(
        children: <Widget>[
          RadioListTile(
            value: false,
            groupValue: isIncludedMemorizedWords,
            onChanged: (bool? value) => _onRadioSelected(value!),
            title: Text(
              "暗記済みの単語を除外する",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          RadioListTile(
            value: true,
            groupValue: isIncludedMemorizedWords,
            onChanged: (bool? value) => _onRadioSelected(value!),
            title: Text(
              "暗記済みの単語を含む",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  _onRadioSelected(bool value) {
    setState(() {
      isIncludedMemorizedWords = value;
      print("$valueが選ばれたで〜！");
    });
  }

  Widget _switch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SwitchListTile(
        title: Text("暗記済みの単語を含む"),
        value: isIncludedMemorizedWords,
        onChanged: (value){
          setState(() {
            isIncludedMemorizedWords = value;
          });
        },
        secondary: Icon(Icons.sort),
      ),
    );

  }

  _startWordListScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WordListScreen()));
  }

  _startTestScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TestScreen(
              isIncludedMemorizedWords: isIncludedMemorizedWords,
            )));
  }




}
