import 'package:dev_challenge_2_dart/db/database_setup.dart'
    show openConnection;
import 'package:dev_challenge_2_dart/db/users_dao.dart' show UsersDao;
import 'package:dev_challenge_2_dart/db/users_table.dart' show Users;
import 'package:dev_challenge_2_dart/repository/users_repository.dart'
    show UsersRepository;
import 'package:drift/drift.dart';

part 'server_database.g.dart';

@DriftDatabase(tables: [Users], daos: [UsersDao])
class ServerDatabase extends _$ServerDatabase implements UsersRepository {
  ServerDatabase() : super(openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
      );

  @override
  Future<int> createUser(User user) {
    return into(users).insertOnConflictUpdate(user.toCompanion(true));
  }

  @override
  Future<List<User>> get allUsers => usersDao.allUsers;

  @override
  Future<User?> userById(String email) => usersDao.userById(email);
}
