import 'dart:convert' show jsonDecode, jsonEncode, utf8;

import 'package:email_validator/email_validator.dart' show EmailValidator;
import 'package:quiver/strings.dart' show isBlank;
import 'package:shelf/shelf.dart' show Request, Response;
import 'package:shelf_router/shelf_router.dart' show Router;

final router = Router()..post('/users/new', createUser);

Future<Response> createUser(Request request) async {
  final body = await request.readAsString();

  late final dynamic bodyAsJson;

  try {
    bodyAsJson = jsonDecode(utf8.decode(body.codeUnits));
  } on FormatException catch (e) {
    return Response.badRequest(body: 'Invalid JSON format: ${e.message}');
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

    return Response.ok(jsonEncode({'msg': 'User created successfully'}));
  }

  return Response.badRequest(body: 'invalid data');
}

bool _validateEmail(String string) => EmailValidator.validate(string);
Map<String, String> _validateFields(
    String id, String password, String fullname, String birthDate) {
  return <String, String>{
    if (!_validateEmail(id)) 'id': 'Invalid email',
    if (isBlank(password)) 'password': 'Cannot be empty or blank',
    if (isBlank(fullname)) 'fullname': 'Cannot be empty or blank',
    if (DateTime.tryParse(birthDate) == null) 'birthdate': 'Invalid date'
  };
}
