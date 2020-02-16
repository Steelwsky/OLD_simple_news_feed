// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewed.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ViewedItem extends DataClass implements Insertable<ViewedItem> {
  final String id;
  final String title;
  final String content;
  final String link;

  ViewedItem(
      {@required this.id,
      @required this.title,
      @required this.content,
      @required this.link});

  factory ViewedItem.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ViewedItem(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      content:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}content']),
      link: stringType.mapFromDatabaseResponse(data['${effectivePrefix}link']),
    );
  }

  factory ViewedItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ViewedItem(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      link: serializer.fromJson<String>(json['link']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'link': serializer.toJson<String>(link),
    };
  }

  @override
  ViewedItemsCompanion createCompanion(bool nullToAbsent) {
    return ViewedItemsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
    );
  }

  ViewedItem copyWith({String id, String title, String content, String link}) =>
      ViewedItem(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        link: link ?? this.link,
      );

  @override
  String toString() {
    return (StringBuffer('ViewedItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(title.hashCode, $mrjc(content.hashCode, link.hashCode))));

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ViewedItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.link == this.link);
}

class ViewedItemsCompanion extends UpdateCompanion<ViewedItem> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> content;
  final Value<String> link;

  const ViewedItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.link = const Value.absent(),
  });

  ViewedItemsCompanion.insert({
    @required String id,
    @required String title,
    @required String content,
    @required String link,
  })  : id = Value(id),
        title = Value(title),
        content = Value(content),
        link = Value(link);

  ViewedItemsCompanion copyWith(
      {Value<String> id,
      Value<String> title,
      Value<String> content,
      Value<String> link}) {
    return ViewedItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      link: link ?? this.link,
    );
  }
}

class $ViewedItemsTable extends ViewedItems
    with TableInfo<$ViewedItemsTable, ViewedItem> {
  final GeneratedDatabase _db;
  final String _alias;

  $ViewedItemsTable(this._db, [this._alias]);

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;

  @override
  GeneratedTextColumn get id => _id ??= _constructId();

  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;

  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();

  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _contentMeta = const VerificationMeta('content');
  GeneratedTextColumn _content;

  @override
  GeneratedTextColumn get content => _content ??= _constructContent();

  GeneratedTextColumn _constructContent() {
    return GeneratedTextColumn(
      'content',
      $tableName,
      false,
    );
  }

  final VerificationMeta _linkMeta = const VerificationMeta('link');
  GeneratedTextColumn _link;

  @override
  GeneratedTextColumn get link => _link ??= _constructLink();

  GeneratedTextColumn _constructLink() {
    return GeneratedTextColumn(
      'link',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, title, content, link];

  @override
  $ViewedItemsTable get asDslTable => this;

  @override
  String get $tableName => _alias ?? 'viewed_items';
  @override
  final String actualTableName = 'viewed_items';

  @override
  VerificationContext validateIntegrity(ViewedItemsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (d.content.present) {
      context.handle(_contentMeta,
          content.isAcceptableValue(d.content.value, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (d.link.present) {
      context.handle(
          _linkMeta, link.isAcceptableValue(d.link.value, _linkMeta));
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};

  @override
  ViewedItem map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ViewedItem.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ViewedItemsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.content.present) {
      map['content'] = Variable<String, StringType>(d.content.value);
    }
    if (d.link.present) {
      map['link'] = Variable<String, StringType>(d.link.value);
    }
    return map;
  }

  @override
  $ViewedItemsTable createAlias(String alias) {
    return $ViewedItemsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ViewedItemsTable _viewedItems;

  $ViewedItemsTable get viewedItems => _viewedItems ??= $ViewedItemsTable(this);

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [viewedItems];
}
