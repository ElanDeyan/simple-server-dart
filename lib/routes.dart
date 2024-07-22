import 'package:dev_challenge_2_dart/handlers/create_user.dart';
import 'package:dev_challenge_2_dart/handlers/login.dart';
import 'package:dev_challenge_2_dart/handlers/read_users.dart';
import 'package:shelf_router/shelf_router.dart' show Router;

final router = Router()
  ..get('/users', readAllUsers)
  ..post('/users/new', createUser)
  ..post('/login', login);
