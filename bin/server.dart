import 'dart:io' show InternetAddress, Platform, stdout;

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dev_challenge_2_dart/env/env.dart';
import 'package:dev_challenge_2_dart/middlewares/jwt_middleware.dart';
import 'package:dev_challenge_2_dart/routes.dart' show router;
import 'package:shelf/shelf.dart' show Pipeline, logRequests;
import 'package:shelf/shelf_io.dart' show serve;

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(jwtAuthMiddleware(secretKey: SecretKey(Env.jwtSecretKey)))
      .addHandler(router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  
  stdout.writeln('Server listening at $ip on port ${server.port}');
}
