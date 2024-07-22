import 'dart:convert' show jsonDecode, jsonEncode, utf8;
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:dev_challenge_2_dart/constants.dart';
import 'package:dev_challenge_2_dart/constants/pbkdf2.dart';
import 'package:dev_challenge_2_dart/db/server_database.dart';
import 'package:dev_challenge_2_dart/repository/users_repository.dart';
import 'package:drift/remote.dart';
import 'package:email_validator/email_validator.dart';
import 'package:quiver/strings.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:shelf/shelf.dart' show Request, Response;

Future<Response> createUser(Request request) async {
  final body = await request.readAsString();

  late final dynamic bodyAsJson;

  try {
    bodyAsJson = jsonDecode(utf8.decode(body.codeUnits));
  } on FormatException catch (e) {
    return Response.badRequest(
      body: 'Invalid JSON format: ${e.message}',
      headers: {'content-type': 'application/json'},
    );
  }

  if (bodyAsJson
      case {
        "id": final String id,
        "password": final String password,
        "fullname": final String fullname,
        "birthdate": final String birthDate,
      }) {
    final validationResult = _validateFields(id, password, fullname, birthDate);
    if (validationResult.isNotEmpty) {
      return Response.badRequest(
        body: jsonEncode({'errors': validationResult}),
        headers: {'content-type': 'application/json'},
      );
    }

    final UsersRepository repository = ServerDatabase();
    final userAsJson = bodyAsJson as Map<String, dynamic>;
    final (:hashedPassword, :salt) = await _generatePasswordHash(
      pbkdf2,
      userAsJson[userJsonDataKeys.password]!.toString(),
    );

    userAsJson.update(
      userJsonDataKeys.password,
      (_) => hashedPassword,
      ifAbsent: () => hashedPassword,
    );

    userAsJson.putIfAbsent(
      'userSalt',
      () => salt,
    );

    try {
      await repository.createUser(User.fromJson(bodyAsJson));
    } on DriftRemoteException catch (e) {
      await (repository as ServerDatabase).close();

      return Response.internalServerError(
        body: jsonEncode({'error': e.toString()}),
        headers: {'content-type': 'application/json'},
      );
    } finally {
      await (repository as ServerDatabase).close();
    }

    return Response.ok(
      jsonEncode({'msg': 'User created successfully'}),
      headers: {'content-type': 'application/json'},
    );
  }

  return Response.badRequest(body: 'Invalid data');
}

bool _validateEmail(String string) => EmailValidator.validate(string);

Map<String, String> _validateFields(
  String id,
  String password,
  String fullname,
  String birthDate,
) {
  return <String, String>{
    if (!_validateEmail(id)) 'id': 'Invalid email',
    if (isBlank(password)) 'password': 'Cannot be empty or blank',
    if (isBlank(fullname)) 'fullname': 'Cannot be empty or blank',
    if (DateTime.tryParse(birthDate) == null) 'birthdate': 'Invalid date',
  };
}

Future<({Uint8List hashedPassword, Uint8List salt})> _generatePasswordHash(
  Pbkdf2 pbkdf2,
  String rawPassword,
) async {
  final salt =
      RandomStringGenerator(fixedLength: 10, hasSymbols: false).generate();

  final secretKey = await pbkdf2.deriveKeyFromPassword(
    password: rawPassword,
    nonce: salt.codeUnits,
  );

  return (
    hashedPassword: Uint8List.fromList(await secretKey.extractBytes()),
    salt: Uint8List.fromList(salt.codeUnits),
  );
}
