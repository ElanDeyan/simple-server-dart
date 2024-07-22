import 'dart:convert';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dev_challenge_2_dart/constants/headers.dart';
import 'package:shelf/shelf.dart';

Middleware jwtAuthMiddleware({required SecretKey secretKey}) {
  return (innerHandler) {
    return (request) async {
      if (request.url != Uri.parse('login')) {
        return innerHandler(request);
      }
      final authHeader = request.headers['authorization'];
      final jwtToken = authHeader?.split(' ').last;

      if (jwtToken != null) {
        try {
          final jwt = JWT.verify(jwtToken, secretKey);

          return Response.ok(
            utf8.encode(jsonEncode({'msg': 'Hello, ${jwt.subject}'})),
            headers: {contentType: ContentType.json.toString()},
          );
        } on JWTExpiredException {
          return Response.unauthorized(
            utf8.encode(jsonEncode({'error': 'Expired token'})),
            headers: {contentType: ContentType.json.toString()},
          );
        } on JWTInvalidException {
          return Response.unauthorized(
            utf8.encode(jsonEncode({'error': 'Invalid token'})),
            headers: {contentType: ContentType.json.toString()},
          );
        }
      } else {
        return innerHandler(request);
      }
    };
  };
}
