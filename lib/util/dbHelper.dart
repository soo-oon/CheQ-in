import 'package:checkin/frontend/notificationCenter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'checkIn.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE notifications '
        '(notiID INTEGER PRIMARY KEY, title TEXT, body TEXT)');
  }

  Future<Notifications> add(Notifications notifications) async {
    print("I have added");
    var dbClient = await db;
    notifications.notiID =  await dbClient.insert('notifications', notifications.toMap());
    return notifications;
  }

  Future<List<Notifications>> getNotifications() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('notifications',
        columns: ['notiID', 'title', 'body']);
    List<Notifications> notification = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        notification.add(Notifications.fromMap(maps[i]));
      }
    }
    return notification;
  }
  /*Future<Student> add(Map student) async {
    var dbClient = await db;
    student.id = await dbClient.insert('notifications', student.toMap());
    return student;
  }

  Future<List<Student>> getStudents() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('student', columns: ['id', 'name']);
    List<Student> students = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        students.add(Student.fromMap(maps[i]));
      }
    }
    return students;
  }
*/
  /*Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'student',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Student student) async {
    var dbClient = await db;
    return await dbClient.update(
      'student',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }
*/
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}

