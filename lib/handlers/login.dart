import 'dart:convert';
import 'dart:io' show ContentType;

import 'package:collection/collection.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dev_challenge_2_dart/constants/headers.dart';
import 'package:dev_challenge_2_dart/constants/jwt_issuer.dart';
import 'package:dev_challenge_2_dart/constants/pbkdf2.dart';
import 'package:dev_challenge_2_dart/db/server_database.dart';
import 'package:dev_challenge_2_dart/env/env.dart';
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
    return Response.unauthorized(
      utf8.encode(jsonEncode(hasFieldsValueValidation)),
      headers: {contentType: ContentType.json.toString()},
    );
  }

  final passwordMatches = await _validateUserPassword(
    json['id'].toString(),
    json['password'].toString(),
  );

  if (!passwordMatches) {
    return Response.unauthorized(
      utf8.encode(jsonEncode({'error': 'Wrong password'})),
      headers: {contentType: ContentType.json.toString()},
    );
  }

  final jwt = _generateJwt(json['id'].toString());

  final token = jwt.sign(SecretKey(Env.jwtSecretKey));

  return Response.ok(
    utf8.encode(
      jsonEncode({'access_token': token, 'token_type': 'jwt'}),
    ),
    headers: {'content-type': ContentType.json.toString()},
  );
}

Future<Map<String, dynamic>> _fieldsValueValidationData(JsonMap json) async {
  return <String, dynamic>{
    if (!EmailValidator.validate(json['id']!.toString()))
      'id': 'Invalid email format'
    else if (!await _checkIfEmailExists(json['id'].toString()))
      'id': 'Email not found',
    if (isBlank(json['password'].toString())) 'password': 'Cannot be empty',
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

JWT _generateJwt(String email) {
  final now = DateTime.now();
  return JWT(
    {
      'key': 'value',
      'sub': email,
      'iat': now.millisecondsSinceEpoch,
      'exp': now.add(const Duration(minutes: 30)).millisecondsSinceEpoch,
    },
    issuer: jwtIssuer,
    subject: email,
  );
}
