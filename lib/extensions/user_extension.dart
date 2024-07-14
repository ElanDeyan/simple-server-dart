import 'package:dev_challenge_2_dart/db/server_database.dart';

extension UserExtension on User {
  Map<String, dynamic> shareableView() => <String, dynamic>{
        'id': id,
        'fullname': fullname,
        'birthdate': '${birthdate.year}-${birthdate.month}-${birthdate.day}',
      };
}
