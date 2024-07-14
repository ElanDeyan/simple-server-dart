import 'dart:io' show Directory, File;

import 'package:drift/drift.dart' show LazyDatabase;
import 'package:drift/native.dart' show NativeDatabase;
import 'package:path/path.dart' as p;

import '../constants.dart' show dbFileName;

LazyDatabase openConnection() => LazyDatabase(
      () async {
        final dbFolder = '${Directory.current.path}/lib/db/';
        final file = File(p.join(dbFolder, dbFileName));

        return NativeDatabase.createInBackground(file);
      },
    );
