// import 'dart:io';
//
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DBConnection {
//   //Singleton method
//   DBConnection._();
//
//   static final getInstance = DBConnection._();
//
//   static final String TABLE_NOTE = "notes";
//   static final String COLUMN_S_NO = "s_no";
//   static final String COLUMN_TITLE = "title";
//   static final String COLUMN_DESCRIPTION = "description";
//   Database? db;
//
//   Future<Database> getDB() async {
//     return db ??= await openDB();
//   }
//
//   //   if (db != null) {
//   //     return db!;
//   //   } else {
//   //     db = await openDB();
//   //     return db!;
//   //   }
//   // }
//
//   Future<Database> openDB() async {
//     Directory appDir = await getApplicationDocumentsDirectory();
//     String dbPath = join(appDir.path, "notesDB.db");
//     return await openDatabase(
//       dbPath,
//       onCreate: (db, version) {
//         db.execute(
//           //create your tables here...
//           "create table $TABLE_NOTE($COLUMN_S_NO integer primary key autoincrement,$COLUMN_TITLE,$COLUMN_DESCRIPTION)",
//         );
//       },
//       version: 1,
//     );
//   }
//
//   Future<bool> addNote({required title, required description}) async {
//     var db = await getDB();
//     int rowsAffected = await db.insert(TABLE_NOTE, {
//       COLUMN_TITLE: title,
//       COLUMN_DESCRIPTION: description,
//     });
//     return rowsAffected > 0;
//   }
//
//   Future<List<Map<String, dynamic>>> getNotes() async {
//     var db = await getDB();
//     List<Map<String, dynamic>> data = await db.query(TABLE_NOTE);
//     return data;
//   }
// }

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbConnection {
  static final String USER_EXP = "user_exp";
  static final String COLUMN_S_No = "s_no";
  static final String COLUMN_FIRST_TRAIT = "first_trait";
  static final String COLUMN_SECOND_TRAIT = "second_trait";
  static final String COLUMN_THIRD_TRAIT = "third_trait";
  static final String COLUMN_FOURTH_TRAIT = "fourth_trait";
  static final String COLUMN_FIFTH_TRAIT = "fifth_trait";
  static final String COLUMN_PAST_EXP = "past_exp";

  DbConnection._();

  static final getInstance = DbConnection._();

  Database? db;

  Future<Database> getDB() async {
    if (db != null) {
      return db!;
    } else {
      var db = await openDB();
      return db;
    }
  }

  Future<Database> openDB() async {
    Directory dirPath = await getApplicationDocumentsDirectory();
    String dbPath = join(dirPath.path, "UsersExpDB.db");
    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        db.execute(
          "create table $USER_EXP ($COLUMN_S_No integer primary key autoIncrement ,"
              " $COLUMN_FIRST_TRAIT text ,"
              " $COLUMN_SECOND_TRAIT text,"
              " $COLUMN_THIRD_TRAIT text,"
              " $COLUMN_FOURTH_TRAIT text,"
              " $COLUMN_FIFTH_TRAIT text,"
              " $COLUMN_PAST_EXP text)",
        );
      },
      version: 1,
    );
  }

  Future<bool> addNote({
    required String mTrait1,
    required String mTrait2,
    required String mTrait3,
    String? mTrait4,
    String? mTrait5,
    required String mPastExp
  }) async {
    var db = await getDB();
    int rowsAffected = await db.insert(USER_EXP, {
      COLUMN_FIRST_TRAIT: mTrait1,
      COLUMN_SECOND_TRAIT: mTrait2,
      COLUMN_THIRD_TRAIT: mTrait3,
      COLUMN_PAST_EXP: mPastExp
    });
    return rowsAffected > 0;
  }

  Future<List<Map<String, dynamic>>> getExp() async {
    var db = await getDB();
    List<Map<String, dynamic>> notes = await db.query(USER_EXP);
    return notes;
  }
}
