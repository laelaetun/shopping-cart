import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart'; // must match exactly

// 1. Table
class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get age => integer().withDefault(const Constant(0))();
}

// 2. Database
@DriftDatabase(tables: [Students])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // CRUD
  Stream<List<Student>> watchStudents() => select(students).watch();
  Future<int> addStudent(StudentsCompanion student) =>
      into(students).insert(student);
  Future updateStudent(Student student) => update(students).replace(student);
  Future deleteStudent(Student student) => delete(students).delete(student);
}

// 3. Open connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
