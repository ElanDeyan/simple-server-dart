import 'dart:convert' show jsonDecode, utf8;

import 'package:email_validator/email_validator.dart' show EmailValidator;
import 'package:shelf/shelf.dart' show Request, Response;
import 'package:shelf_router/shelf_router.dart' show Router;

final router = Router()..post('/users/new', createUser);

Future<Response> createUser(Request request) async {
  final body = await request.readAsString();

  final bodyAsJson = jsonDecode(utf8.decode(body.codeUnits));

  if (bodyAsJson
      case {
        "id": final String id,
        "password": final String password,
        "fullname": final String fullname,
        "birthdate": final String birthDate,
      }
      when EmailValidator.validate(id) &&
          DateTime.tryParse(birthDate) != null) {
    return Response.ok('Valid data');
  }

  return Response.badRequest(body: 'invalid data');
}
