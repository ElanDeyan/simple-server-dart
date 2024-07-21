import 'package:drift/drift.dart';

import '../repository/users_repository.dart' show UsersRepository;
import 'database_setup.dart' show openConnection;
import 'users_dao.dart' show UsersDao;
import 'users_table.dart' show Users;

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
