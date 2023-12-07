// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Word extends DataClass implements Insertable<Word> {
  final String strQuestion;
  final String strAnswer;
  final String imageFileName1;
  final String imageFileName2;
  const Word(
      {required this.strQuestion,
      required this.strAnswer,
      required this.imageFileName1,
      required this.imageFileName2});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['str_question'] = Variable<String>(strQuestion);
    map['str_answer'] = Variable<String>(strAnswer);
    map['image_file_name1'] = Variable<String>(imageFileName1);
    map['image_file_name2'] = Variable<String>(imageFileName2);
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      strQuestion: Value(strQuestion),
      strAnswer: Value(strAnswer),
      imageFileName1: Value(imageFileName1),
      imageFileName2: Value(imageFileName2),
    );
  }

  factory Word.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Word(
      strQuestion: serializer.fromJson<String>(json['strQuestion']),
      strAnswer: serializer.fromJson<String>(json['strAnswer']),
      imageFileName1: serializer.fromJson<String>(json['imageFileName1']),
      imageFileName2: serializer.fromJson<String>(json['imageFileName2']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'strQuestion': serializer.toJson<String>(strQuestion),
      'strAnswer': serializer.toJson<String>(strAnswer),
      'imageFileName1': serializer.toJson<String>(imageFileName1),
      'imageFileName2': serializer.toJson<String>(imageFileName2),
    };
  }

  Word copyWith(
          {String? strQuestion,
          String? strAnswer,
          String? imageFileName1,
          String? imageFileName2}) =>
      Word(
        strQuestion: strQuestion ?? this.strQuestion,
        strAnswer: strAnswer ?? this.strAnswer,
        imageFileName1: imageFileName1 ?? this.imageFileName1,
        imageFileName2: imageFileName2 ?? this.imageFileName2,
      );
  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('strQuestion: $strQuestion, ')
          ..write('strAnswer: $strAnswer, ')
          ..write('imageFileName1: $imageFileName1, ')
          ..write('imageFileName2: $imageFileName2')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(strQuestion, strAnswer, imageFileName1, imageFileName2);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Word &&
          other.strQuestion == this.strQuestion &&
          other.strAnswer == this.strAnswer &&
          other.imageFileName1 == this.imageFileName1 &&
          other.imageFileName2 == this.imageFileName2);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<String> strQuestion;
  final Value<String> strAnswer;
  final Value<String> imageFileName1;
  final Value<String> imageFileName2;
  const WordsCompanion({
    this.strQuestion = const Value.absent(),
    this.strAnswer = const Value.absent(),
    this.imageFileName1 = const Value.absent(),
    this.imageFileName2 = const Value.absent(),
  });
  WordsCompanion.insert({
    required String strQuestion,
    required String strAnswer,
    required String imageFileName1,
    required String imageFileName2,
  })  : strQuestion = Value(strQuestion),
        strAnswer = Value(strAnswer),
        imageFileName1 = Value(imageFileName1),
        imageFileName2 = Value(imageFileName2);
  static Insertable<Word> custom({
    Expression<String>? strQuestion,
    Expression<String>? strAnswer,
    Expression<String>? imageFileName1,
    Expression<String>? imageFileName2,
  }) {
    return RawValuesInsertable({
      if (strQuestion != null) 'str_question': strQuestion,
      if (strAnswer != null) 'str_answer': strAnswer,
      if (imageFileName1 != null) 'image_file_name1': imageFileName1,
      if (imageFileName2 != null) 'image_file_name2': imageFileName2,
    });
  }

  WordsCompanion copyWith(
      {Value<String>? strQuestion,
      Value<String>? strAnswer,
      Value<String>? imageFileName1,
      Value<String>? imageFileName2}) {
    return WordsCompanion(
      strQuestion: strQuestion ?? this.strQuestion,
      strAnswer: strAnswer ?? this.strAnswer,
      imageFileName1: imageFileName1 ?? this.imageFileName1,
      imageFileName2: imageFileName2 ?? this.imageFileName2,
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
    if (imageFileName1.present) {
      map['image_file_name1'] = Variable<String>(imageFileName1.value);
    }
    if (imageFileName2.present) {
      map['image_file_name2'] = Variable<String>(imageFileName2.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('strQuestion: $strQuestion, ')
          ..write('strAnswer: $strAnswer, ')
          ..write('imageFileName1: $imageFileName1, ')
          ..write('imageFileName2: $imageFileName2')
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
  static const VerificationMeta _imageFileName1Meta =
      const VerificationMeta('imageFileName1');
  @override
  late final GeneratedColumn<String> imageFileName1 = GeneratedColumn<String>(
      'image_file_name1', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageFileName2Meta =
      const VerificationMeta('imageFileName2');
  @override
  late final GeneratedColumn<String> imageFileName2 = GeneratedColumn<String>(
      'image_file_name2', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [strQuestion, strAnswer, imageFileName1, imageFileName2];
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
    if (data.containsKey('image_file_name1')) {
      context.handle(
          _imageFileName1Meta,
          imageFileName1.isAcceptableOrUnknown(
              data['image_file_name1']!, _imageFileName1Meta));
    } else if (isInserting) {
      context.missing(_imageFileName1Meta);
    }
    if (data.containsKey('image_file_name2')) {
      context.handle(
          _imageFileName2Meta,
          imageFileName2.isAcceptableOrUnknown(
              data['image_file_name2']!, _imageFileName2Meta));
    } else if (isInserting) {
      context.missing(_imageFileName2Meta);
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
      imageFileName1: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}image_file_name1'])!,
      imageFileName2: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}image_file_name2'])!,
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
