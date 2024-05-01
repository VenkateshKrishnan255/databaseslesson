
class StudentModel {
  //Declaretion variable
  int? id;
  late String studentName;
  late String studentEmailId;
  late String studentMobileNo;

  //Constructor accept the data and initialize the above variables
  StudentModel(
      this.id,
      this.studentName,
      this.studentMobileNo,
      this.studentEmailId
      );
}
