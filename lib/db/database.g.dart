// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Word extends DataClass implements Insertable<Word> {
  final String strQuestion;
  final String strAnswer;
  final String imagePath1;
  final String imagePath2;
  const Word(
      {required this.strQuestion,
      required this.strAnswer,
      required this.imagePath1,
      required this.imagePath2});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['str_question'] = Variable<String>(strQuestion);
    map['str_answer'] = Variable<String>(strAnswer);
    map['image_path1'] = Variable<String>(imagePath1);
    map['image_path2'] = Variable<String>(imagePath2);
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      strQuestion: Value(strQuestion),
      strAnswer: Value(strAnswer),
      imagePath1: Value(imagePath1),
      imagePath2: Value(imagePath2),
    );
  }

  factory Word.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Word(
      strQuestion: serializer.fromJson<String>(json['strQuestion']),
      strAnswer: serializer.fromJson<String>(json['strAnswer']),
      imagePath1: serializer.fromJson<String>(json['imagePath1']),
      imagePath2: serializer.fromJson<String>(json['imagePath2']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'strQuestion': serializer.toJson<String>(strQuestion),
      'strAnswer': serializer.toJson<String>(strAnswer),
      'imagePath1': serializer.toJson<String>(imagePath1),
      'imagePath2': serializer.toJson<String>(imagePath2),
    };
  }

  Word copyWith(
          {String? strQuestion,
          String? strAnswer,
          String? imagePath1,
          String? imagePath2}) =>
      Word(
        strQuestion: strQuestion ?? this.strQuestion,
        strAnswer: strAnswer ?? this.strAnswer,
        imagePath1: imagePath1 ?? this.imagePath1,
        imagePath2: imagePath2 ?? this.imagePath2,
      );
  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('strQuestion: $strQuestion, ')
          ..write('strAnswer: $strAnswer, ')
          ..write('imagePath1: $imagePath1, ')
          ..write('imagePath2: $imagePath2')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(strQuestion, strAnswer, imagePath1, imagePath2);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Word &&
          other.strQuestion == this.strQuestion &&
          other.strAnswer == this.strAnswer &&
          other.imagePath1 == this.imagePath1 &&
          other.imagePath2 == this.imagePath2);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<String> strQuestion;
  final Value<String> strAnswer;
  final Value<String> imagePath1;
  final Value<String> imagePath2;
  const WordsCompanion({
    this.strQuestion = const Value.absent(),
    this.strAnswer = const Value.absent(),
    this.imagePath1 = const Value.absent(),
    this.imagePath2 = const Value.absent(),
  });
  WordsCompanion.insert({
    required String strQuestion,
    required String strAnswer,
    required String imagePath1,
    required String imagePath2,
  })  : strQuestion = Value(strQuestion),
        strAnswer = Value(strAnswer),
        imagePath1 = Value(imagePath1),
        imagePath2 = Value(imagePath2);
  static Insertable<Word> custom({
    Expression<String>? strQuestion,
    Expression<String>? strAnswer,
    Expression<String>? imagePath1,
    Expression<String>? imagePath2,
  }) {
    return RawValuesInsertable({
      if (strQuestion != null) 'str_question': strQuestion,
      if (strAnswer != null) 'str_answer': strAnswer,
      if (imagePath1 != null) 'image_path1': imagePath1,
      if (imagePath2 != null) 'image_path2': imagePath2,
    });
  }

  WordsCompanion copyWith(
      {Value<String>? strQuestion,
      Value<String>? strAnswer,
      Value<String>? imagePath1,
      Value<String>? imagePath2}) {
    return WordsCompanion(
      strQuestion: strQuestion ?? this.strQuestion,
      strAnswer: strAnswer ?? this.strAnswer,
      imagePath1: imagePath1 ?? this.imagePath1,
      imagePath2: imagePath2 ?? this.imagePath2,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (strQuestion.present) {
      map['str_question'] = Variable<String>(strQuestion.value);
    }
    if (strAnswer.present) {
      map['str_answer'] = Variable<String>(strAnswer.value);
    }
    if (imagePath1.present) {
      map['image_path1'] = Variable<String>(imagePath1.value);
    }
    if (imagePath2.present) {
      map['image_path2'] = Variable<String>(imagePath2.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('strQuestion: $strQuestion, ')
          ..write('strAnswer: $strAnswer, ')
          ..write('imagePath1: $imagePath1, ')
          ..write('imagePath2: $imagePath2')
          ..write(')'))
        .toString();
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, Word> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _strQuestionMeta =
      const VerificationMeta('strQuestion');
  @override
  late final GeneratedColumn<String> strQuestion = GeneratedColumn<String>(
      'str_question', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _strAnswerMeta =
      const VerificationMeta('strAnswer');
  @override
  late final GeneratedColumn<String> strAnswer = GeneratedColumn<String>(
      'str_answer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagePath1Meta =
      const VerificationMeta('imagePath1');
  @override
  late final GeneratedColumn<String> imagePath1 = GeneratedColumn<String>(
      'image_path1', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagePath2Meta =
      const VerificationMeta('imagePath2');
  @override
  late final GeneratedColumn<String> imagePath2 = GeneratedColumn<String>(
      'image_path2', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [strQuestion, strAnswer, imagePath1, imagePath2];
  @override
  String get aliasedName => _alias ?? 'words';
  @override
  String get actualTableName => 'words';
  @override
  VerificationContext validateIntegrity(Insertable<Word> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('str_question')) {
      context.handle(
          _strQuestionMeta,
          strQuestion.isAcceptableOrUnknown(
              data['str_question']!, _strQuestionMeta));
    } else if (isInserting) {
      context.missing(_strQuestionMeta);
    }
    if (data.containsKey('str_answer')) {
      context.handle(_strAnswerMeta,
          strAnswer.isAcceptableOrUnknown(data['str_answer']!, _strAnswerMeta));
    } else if (isInserting) {
      context.missing(_strAnswerMeta);
    }
    if (data.containsKey('image_path1')) {
      context.handle(
          _imagePath1Meta,
          imagePath1.isAcceptableOrUnknown(
              data['image_path1']!, _imagePath1Meta));
    } else if (isInserting) {
      context.missing(_imagePath1Meta);
    }
    if (data.containsKey('image_path2')) {
      context.handle(
          _imagePath2Meta,
          imagePath2.isAcceptableOrUnknown(
              data['image_path2']!, _imagePath2Meta));
    } else if (isInserting) {
      context.missing(_imagePath2Meta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {strQuestion};
  @override
  Word map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Word(
      strQuestion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}str_question'])!,
      strAnswer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}str_answer'])!,
      imagePath1: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path1'])!,
      imagePath2: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path2'])!,
    );
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $WordsTable words = $WordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [words];
}
