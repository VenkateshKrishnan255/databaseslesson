import 'package:flutter/material.dart';
import 'package:venkat_databases/Database/OptimizedStudentForm/optimizedstudentform.dart';
import 'package:venkat_databases/Database/UpdateStudentForm/updatestudentform.dart';
import '../../main.dart';
import '../DatabaseHelper/databasehelper.dart';
import '../StudentForm/studentformscreen.dart';
import '../StudentModel/studentmodel.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  //List Bag(Class type) to Store StudentTable
  List<StudentModel> _studentDetailList = <StudentModel>[];

  //After Main Method IniState Method Will Be Called
  @override
  void initState() {
    print('--------------->initState');
    super.initState();
    getAllStudentDetails(); //Manual Method call
  }

  getAllStudentDetails() async {
    print('--------------->getAllStudentDetails');
    //Getting Table Data and Store Local Variable
    var studentDetailRecords = await dbhelper.getStudentRecords();

    //ForLooping
    studentDetailRecords.forEach((row) {
      setState(() {
        print(row[DatabaseHelper.colId]);
        print(row[DatabaseHelper.colName]);
        print(row[DatabaseHelper.colMobileNo]);
        print(row[DatabaseHelper.colEmailId]);

        //Passing Data From StudendModel
        var studentModel = StudentModel(
            row[DatabaseHelper.colId],
            row[DatabaseHelper.colName],
            row[DatabaseHelper.colMobileNo],
            row[DatabaseHelper.colEmailId]);

        //Adding List Bag StudentModel
        _studentDetailList.add(studentModel);
        //---------------------------------
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          centerTitle: true,
          elevation: 10,
          title: const Text(
            'Student Details',
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Container(
          child: ListView.builder(
              itemCount: _studentDetailList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  //Print On Log
                  onTap: () {
                    print('--------------->List Item Clicked');
                    // print(_studentDetailList[index].id);
                    // print(_studentDetailList[index].studentName);
                    // print(_studentDetailList[index].studentMobileNo);
                    // print(_studentDetailList[index].studentEmailId);

                    // Update Class and Passing Data
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OptimizedStudentForm(),
                        settings: RouteSettings(
                            arguments: _studentDetailList[index])));
                  },

                  /*1. Show Data on StudentListScreen
                  * 2. We Can Mension List VariableName and Table ColumnName
                  * */
                  child: ListTile(
                    title: Text(
                      _studentDetailList[index].studentName,
                       //"\n" +
                       //_studentDetailList[index].studentMobileNo +
                       //"\n" +
                       //_studentDetailList[index].studentEmailId,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'Urbanist'),
                    ),
                  ),
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          //When Clicked floating actions move to next screen
          onPressed: () {
            //Identify log
            print('--------------->Floating Action Button Clicked');
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const OptimizedStudentForm()));
          },
          child: const Icon(Icons.add),
        ));
  }
}
