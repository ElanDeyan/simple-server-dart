import 'package:dev_challenge_2_dart/db/server_database.dart'
    show $UsersTable, ServerDatabase, User;
import 'package:dev_challenge_2_dart/db/users_table.dart' show Users;
import 'package:drift/drift.dart' show DatabaseAccessor, DriftAccessor;

part 'users_dao.g.dart';

@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<ServerDatabase> with _$UsersDaoMixin {
  UsersDao(super.attachedDatabase);

  Future<List<User>> get allUsers => select(users).get();

  Future<User?> userById(String email) async {
    return (select(users)..where((row) => row.id.equals(email)))
        .getSingleOrNull();
  }
}
