import 'dart:convert';
import 'dart:io' show ContentType;

import 'package:collection/collection.dart';
import 'package:dev_challenge_2_dart/constants/headers.dart';
import 'package:dev_challenge_2_dart/constants/pbkdf2.dart';
import 'package:dev_challenge_2_dart/db/server_database.dart';
import 'package:dev_challenge_2_dart/repository/users_repository.dart';
import 'package:dev_challenge_2_dart/types/json.dart';
import 'package:email_validator/email_validator.dart';
import 'package:quiver/strings.dart';
import 'package:shelf/shelf.dart';

Future<Response> login(Request request) async {
  final body = await request.readAsString();
  late final JsonMap json;

  try {
    json = jsonDecode(utf8.decode(body.codeUnits)) as JsonMap;
  } catch (e) {
    return Response.badRequest(
      body: utf8.encode(jsonEncode({'message': e.toString()})),
      headers: {contentType: ContentType.json.toString()},
    );
  }

  final hasFieldsValidation = _hasFieldsValidationData(json);
  if (hasFieldsValidation.isNotEmpty) {
    return Response.badRequest(
      body: utf8.encode(jsonEncode(hasFieldsValidation)),
      headers: {contentType: ContentType.json.toString()},
    );
  }

  final hasFieldsValueValidation = await _fieldsValueValidationData(json);
  if (hasFieldsValueValidation.isNotEmpty) {
    return Response.badRequest(
      body: utf8.encode(jsonEncode(hasFieldsValueValidation)),
      headers: {contentType: ContentType.json.toString()},
    );
  }

  final passwordMatches =
      await _validateUserPassword(json['id'], json['password']);

  if (!passwordMatches) {
    return Response.badRequest(
      body: utf8.encode(jsonEncode({'error': 'Wrong password'})),
      headers: {contentType: ContentType.json.toString()},
    );
  }

  return Response.ok(
    utf8.encode(jsonEncode({'msg': 'Hello login!'})),
    headers: {'content-type': ContentType.json.toString()},
  );
}

Future<Map<String, dynamic>> _fieldsValueValidationData(JsonMap json) async {
  return <String, dynamic>{
    if (!EmailValidator.validate(json['id']!))
      'id': 'Invalid email format'
    else if (!await _checkIfEmailExists(json['id']))
      'id': 'Email not found',
    if (isBlank(json['password'])) 'password': 'Cannot be empty',
  };
}

Future<bool> _checkIfEmailExists(String email) async {
  final UsersRepository usersRepository = ServerDatabase();

  final emailExists =
      (await usersRepository.allUsers).map((user) => user.id).contains(email);

  await (usersRepository as ServerDatabase).close();

  return emailExists;
}

Map<String, String> _hasFieldsValidationData(JsonMap json) => <String, String>{
      if (!json.containsKey('id')) 'id': 'Missing id field',
      if (!json.containsKey('password')) 'password': 'Missing password',
    };

Future<bool> _validateUserPassword(String email, String password) async {
  final UsersRepository usersRepository = ServerDatabase();

  final user = await usersRepository.userById(email);

  await (usersRepository as ServerDatabase).close();

  if (user == null) return false;

  final secretKey = await pbkdf2.deriveKeyFromPassword(
    password: password,
    nonce: user.userSalt,
  );

  return user.password.equals(await secretKey.extractBytes());
}
