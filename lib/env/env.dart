import 'package:envied/envied.dart';

part 'env.g.dart';

@envied
abstract class Env {
  @EnviedField(varName: 'jwtSecretKey')
  static const String jwtSecretKey = _Env.jwtSecretKey;
}
