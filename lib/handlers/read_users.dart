import 'dart:convert';

import 'package:dev_challenge_2_dart/db/server_database.dart';
import 'package:dev_challenge_2_dart/extensions/user_extension.dart';
import 'package:dev_challenge_2_dart/repository/users_repository.dart';
import 'package:shelf/shelf.dart';

Future<Response> readAllUsers(Request request) async {
  final UsersRepository usersRepository = ServerDatabase();

  final users = await usersRepository.allUsers;

  await (usersRepository as ServerDatabase).close();

  return Response.ok(
    jsonEncode(users.map((user) => user.shareableView()).toList()),
    headers: {'content-type': 'application/json'},
  );
}
