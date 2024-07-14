// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<Uint8List> password = GeneratedColumn<Uint8List>(
      'password', aliasedName, false,
      type: DriftSqlType.blob, requiredDuringInsert: true);
  static const VerificationMeta _userSaltMeta =
      const VerificationMeta('userSalt');
  @override
  late final GeneratedColumn<Uint8List> userSalt = GeneratedColumn<Uint8List>(
      'user_salt', aliasedName, false,
      type: DriftSqlType.blob,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _fullnameMeta =
      const VerificationMeta('fullname');
  @override
  late final GeneratedColumn<String> fullname = GeneratedColumn<String>(
      'fullname', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _birthdateMeta =
      const VerificationMeta('birthdate');
  @override
  late final GeneratedColumn<DateTime> birthdate = GeneratedColumn<DateTime>(
      'birthdate', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, password, userSalt, fullname, birthdate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('user_salt')) {
      context.handle(_userSaltMeta,
          userSalt.isAcceptableOrUnknown(data['user_salt']!, _userSaltMeta));
    } else if (isInserting) {
      context.missing(_userSaltMeta);
    }
    if (data.containsKey('fullname')) {
      context.handle(_fullnameMeta,
          fullname.isAcceptableOrUnknown(data['fullname']!, _fullnameMeta));
    } else if (isInserting) {
      context.missing(_fullnameMeta);
    }
    if (data.containsKey('birthdate')) {
      context.handle(_birthdateMeta,
          birthdate.isAcceptableOrUnknown(data['birthdate']!, _birthdateMeta));
    } else if (isInserting) {
      context.missing(_birthdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}password'])!,
      userSalt: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}user_salt'])!,
      fullname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fullname'])!,
      birthdate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}birthdate'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final Uint8List password;
  final Uint8List userSalt;
  final String fullname;
  final DateTime birthdate;
  const User(
      {required this.id,
      required this.password,
      required this.userSalt,
      required this.fullname,
      required this.birthdate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['password'] = Variable<Uint8List>(password);
    map['user_salt'] = Variable<Uint8List>(userSalt);
    map['fullname'] = Variable<String>(fullname);
    map['birthdate'] = Variable<DateTime>(birthdate);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      password: Value(password),
      userSalt: Value(userSalt),
      fullname: Value(fullname),
      birthdate: Value(birthdate),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      password: serializer.fromJson<Uint8List>(json['password']),
      userSalt: serializer.fromJson<Uint8List>(json['userSalt']),
      fullname: serializer.fromJson<String>(json['fullname']),
      birthdate: serializer.fromJson<DateTime>(json['birthdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'password': serializer.toJson<Uint8List>(password),
      'userSalt': serializer.toJson<Uint8List>(userSalt),
      'fullname': serializer.toJson<String>(fullname),
      'birthdate': serializer.toJson<DateTime>(birthdate),
    };
  }

  User copyWith(
          {String? id,
          Uint8List? password,
          Uint8List? userSalt,
          String? fullname,
          DateTime? birthdate}) =>
      User(
        id: id ?? this.id,
        password: password ?? this.password,
        userSalt: userSalt ?? this.userSalt,
        fullname: fullname ?? this.fullname,
        birthdate: birthdate ?? this.birthdate,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      password: data.password.present ? data.password.value : this.password,
      userSalt: data.userSalt.present ? data.userSalt.value : this.userSalt,
      fullname: data.fullname.present ? data.fullname.value : this.fullname,
      birthdate: data.birthdate.present ? data.birthdate.value : this.birthdate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('password: $password, ')
          ..write('userSalt: $userSalt, ')
          ..write('fullname: $fullname, ')
          ..write('birthdate: $birthdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, $driftBlobEquality.hash(password),
      $driftBlobEquality.hash(userSalt), fullname, birthdate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          $driftBlobEquality.equals(other.password, this.password) &&
          $driftBlobEquality.equals(other.userSalt, this.userSalt) &&
          other.fullname == this.fullname &&
          other.birthdate == this.birthdate);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<Uint8List> password;
  final Value<Uint8List> userSalt;
  final Value<String> fullname;
  final Value<DateTime> birthdate;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.password = const Value.absent(),
    this.userSalt = const Value.absent(),
    this.fullname = const Value.absent(),
    this.birthdate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required Uint8List password,
    required Uint8List userSalt,
    required String fullname,
    required DateTime birthdate,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        password = Value(password),
        userSalt = Value(userSalt),
        fullname = Value(fullname),
        birthdate = Value(birthdate);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<Uint8List>? password,
    Expression<Uint8List>? userSalt,
    Expression<String>? fullname,
    Expression<DateTime>? birthdate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (password != null) 'password': password,
      if (userSalt != null) 'user_salt': userSalt,
      if (fullname != null) 'fullname': fullname,
      if (birthdate != null) 'birthdate': birthdate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<Uint8List>? password,
      Value<Uint8List>? userSalt,
      Value<String>? fullname,
      Value<DateTime>? birthdate,
      Value<int>? rowid}) {
    return UsersCompanion(
      id: id ?? this.id,
      password: password ?? this.password,
      userSalt: userSalt ?? this.userSalt,
      fullname: fullname ?? this.fullname,
      birthdate: birthdate ?? this.birthdate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (password.present) {
      map['password'] = Variable<Uint8List>(password.value);
    }
    if (userSalt.present) {
      map['user_salt'] = Variable<Uint8List>(userSalt.value);
    }
    if (fullname.present) {
      map['fullname'] = Variable<String>(fullname.value);
    }
    if (birthdate.present) {
      map['birthdate'] = Variable<DateTime>(birthdate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('password: $password, ')
          ..write('userSalt: $userSalt, ')
          ..write('fullname: $fullname, ')
          ..write('birthdate: $birthdate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ServerDatabase extends GeneratedDatabase {
  _$ServerDatabase(QueryExecutor e) : super(e);
  $ServerDatabaseManager get managers => $ServerDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final UsersDao usersDao = UsersDao(this as ServerDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  required Uint8List password,
  required Uint8List userSalt,
  required String fullname,
  required DateTime birthdate,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<Uint8List> password,
  Value<Uint8List> userSalt,
  Value<String> fullname,
  Value<DateTime> birthdate,
  Value<int> rowid,
});

class $$UsersTableTableManager extends RootTableManager<
    _$ServerDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder> {
  $$UsersTableTableManager(_$ServerDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UsersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UsersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<Uint8List> password = const Value.absent(),
            Value<Uint8List> userSalt = const Value.absent(),
            Value<String> fullname = const Value.absent(),
            Value<DateTime> birthdate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            password: password,
            userSalt: userSalt,
            fullname: fullname,
            birthdate: birthdate,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required Uint8List password,
            required Uint8List userSalt,
            required String fullname,
            required DateTime birthdate,
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            password: password,
            userSalt: userSalt,
            fullname: fullname,
            birthdate: birthdate,
            rowid: rowid,
          ),
        ));
}

class $$UsersTableFilterComposer
    extends FilterComposer<_$ServerDatabase, $UsersTable> {
  $$UsersTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<Uint8List> get password => $state.composableBuilder(
      column: $state.table.password,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<Uint8List> get userSalt => $state.composableBuilder(
      column: $state.table.userSalt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fullname => $state.composableBuilder(
      column: $state.table.fullname,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get birthdate => $state.composableBuilder(
      column: $state.table.birthdate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UsersTableOrderingComposer
    extends OrderingComposer<_$ServerDatabase, $UsersTable> {
  $$UsersTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<Uint8List> get password => $state.composableBuilder(
      column: $state.table.password,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<Uint8List> get userSalt => $state.composableBuilder(
      column: $state.table.userSalt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fullname => $state.composableBuilder(
      column: $state.table.fullname,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get birthdate => $state.composableBuilder(
      column: $state.table.birthdate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $ServerDatabaseManager {
  final _$ServerDatabase _db;
  $ServerDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
}
