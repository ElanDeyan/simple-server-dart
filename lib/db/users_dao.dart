import 'package:drift/drift.dart' show DatabaseAccessor, DriftAccessor;

import 'server_database.dart' show $UsersTable, ServerDatabase, User;
import 'users_table.dart' show Users;

part 'users_dao.g.dart';

@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<ServerDatabase> with _$UsersDaoMixin {
  UsersDao(super.attachedDatabase);

  Future<List<User>> get allUsers => select(users).get();
}
