class Student {
  const Student({this.id, this.name});

  final int id;
  final String name;
}

class ErrorStudent {}

class ErrorStudentAccess extends ErrorStudent {}

class ErrorStudentGeneral extends ErrorStudent {}
