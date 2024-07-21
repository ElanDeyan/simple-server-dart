import 'package:cryptography/cryptography.dart';

final pbkdf2 =
    Pbkdf2(macAlgorithm: Hmac.sha512(), iterations: 10000, bits: 256);
