import 'dart:io' show Directory, File;

import 'package:dev_challenge_2_dart/constants.dart' show dbFileName;
import 'package:drift/drift.dart' show LazyDatabase;
import 'package:drift/native.dart' show NativeDatabase;
import 'package:path/path.dart' as p;

LazyDatabase openConnection() => LazyDatabase(
      () async {
        final dbFolder = '${Directory.current.path}/lib/db/';
        final file = File(p.join(dbFolder, dbFileName));

        return NativeDatabase.createInBackground(file);
      },
    );
