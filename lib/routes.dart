import 'package:dev_challenge_2_dart/handlers/login.dart';
import 'package:shelf_router/shelf_router.dart' show Router;

import 'handlers/create_user.dart';
import 'handlers/read_users.dart';

final router = Router()
  ..get('/users', readAllUsers)
  ..post('/users/new', createUser)
  ..post('/login', login);
