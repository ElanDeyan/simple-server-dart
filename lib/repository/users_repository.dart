import '../db/server_database.dart' show User;

abstract interface class UsersRepository {
  Future<int> createUser(User user);

  Future<List<User>> get allUsers;

  Future<User?> userById(String email);
}
