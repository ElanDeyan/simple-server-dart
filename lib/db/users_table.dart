import 'package:drift/drift.dart'
    show
        BlobColumn,
        BuildGeneralColumn,
        Column,
        DateTimeColumn,
        Table,
        TextColumn;

class Users extends Table {
  TextColumn get id => text()();
  BlobColumn get password => blob()();
  BlobColumn get userSalt => blob().unique()();
  TextColumn get fullname => text()();
  DateTimeColumn get birthdate => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
