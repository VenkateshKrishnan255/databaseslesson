import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const databaseName = 'StudentDetailsDb.db'; //Database Name
  static const databaseVersion = 3; //Database Version
  static const studentDetailsTable = 'StudentTable'; //Database Table Name
  static const colId = 'StudentId'; //Table ColName_1
  static const colName = 'StudentName'; //Table ColName_2
  static const colMobileNo = 'StudentMobileNo'; //Table ColName_3
  static const colEmailId = 'StudentEmailId'; //Table ColName_4

  late final Database _db; //Declaration process and can't initialize

  //Initiazation Method
  Future<void> initialization() async {
    final documentsDirectory = await getApplicationDocumentsDirectory(); //Create Folder
    final path = join(documentsDirectory.path, databaseName); //Join Path

    //Creating database and Initialize
    _db = await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  //OnCreate Method and passing databaseName and database version
  Future _onCreate(Database database, int version) async {
    /* Create Query
    *  Create Table StudentTable (_studentId primary key,integer, _studentName Text,Notnull, _studentEmailId Text,Notnull)
    * */
    print('--------------->OnCreate');
    await database.execute('''
       CREATE TABLE $studentDetailsTable(
       $colId INTEGER PRIMARY KEY,
       $colName TEXT,
       $colMobileNo TEXT,
       $colEmailId TEXT)
    ''');
  }

  //onUpgrade Method and Passing databaseName , oldVersionName and newVersionName
  Future _onUpgrade(Database database, int oldVersion, int newVersion) async {
    /* Upgrade Query
    *  Drop table StudentTable and oncreate(Comparing Sql in this process is different)
    * */
    print('--------------->OnUpgrade');
    await database.execute('drop table $studentDetailsTable');
    _onCreate(database, newVersion);//call again
  }

//------------------------------------------------------

  //Insert Data Into Table
  Future<int> insertStudentDetails(Map<String, dynamic> row) async {
    print('--------------->insertStudentDetails');
    return await _db.insert(studentDetailsTable, row);
  }

  //Get Table
  Future<List<Map<String, dynamic>>> getStudentRecords() async {
    /* Display Query
    * Select * From StudentTable
    * */
    print('--------------->getStudentRecors');
    return await _db.query(studentDetailsTable);
  }

  //Update Method
  Future<int> updateStudentDetails(Map<String, dynamic> row) async {
    /* Display Query
    * Select colName Form studentDetailsTable where colId = id ,condition
    * */
    print('--------------->updateStudentDetails');
    int id = row[colId];
    return await _db.update(
      studentDetailsTable,
      row,
      where: '$colId = ?',
      whereArgs: [id],
    );
  }

  //Delete Method
  Future<int> deleteStudentDetails(int id)async{
     return await _db.delete(
       studentDetailsTable,
       where:'$colId= ?',
       whereArgs: [id]
     );
  }
}