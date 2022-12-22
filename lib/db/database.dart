import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Words extends Table {
  TextColumn get strQuestion => text()();

  TextColumn get strAnswer => text()();

  BoolColumn get isMemorized => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {strQuestion};
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'words.db'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Words])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  //統合処理
  //https://drift.simonbinder.eu/docs/advanced-features/migrations/
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(words, words.isMemorized);
        }
      },
    );
  }

  //Create
  Future addWord(Word word) => into(words).insert(word);

  //Read
  Future<List<Word>> get allWords => select(words).get();

  //For文を使いたいがためだけのコーディング
  Future<List<Word>> getAllWordsWithStar() async {
    var selectedWords = await allWords;
    var results = <Word>[];

    //3: forEach関数
    selectedWords.forEach((word) {
      if (!word.isMemorized) {
        word = word.copyWith(strQuestion: " ★ " + word.strQuestion);
      }
      results.add(word);
    });

    //2: for-in
    // for (var word in selectedWords) {
    //   if (!word.isMemorized) {
    //     word = word.copyWith(
    //         strQuestion: " ★ " + word.strQuestion
    //     );
    //   }
    //   results.add(word);
    // }

    //1: 普通のfor
    // for (var i = 0; i < selectedWords.length; i++) {
    //   var word = selectedWords[i];
    //   if (!word.isMemorized) {
    //     word = word.copyWith(
    //       strQuestion: " ★ " + word.strQuestion
    //     );
    //   }
    //   results.add(word);
    // }

    return results;
  }

  //Read (暗記済み単語除外）
  Future<List<Word>> get allWordsExcludedMemorized =>
      (select(words)..where((table) => table.isMemorized.equals(false))).get();

  //Read(暗記済みが下になるようにソート)
  Future<List<Word>> get allWordsSorted => (select(words)
        ..orderBy([(table) => OrderingTerm(expression: table.isMemorized)]))
      .get();

  //Update
  Future updateWord(Word word) => update(words).replace(word);

  //Delete
  Future deleteWord(Word word) => (delete(words)
        ..where((table) => table.strQuestion.equals(word.strQuestion)))
      .go();

  //DeleteAll
  Future clearDB() => delete(words).go();

//  Future deleteWordB(Word word) {
//    var deleteStatement = delete(words);
//    deleteStatement
//        .where((table) => table.strQuestion.equals(word.strQuestion));
//    return deleteStatement.go();
//  }
}
