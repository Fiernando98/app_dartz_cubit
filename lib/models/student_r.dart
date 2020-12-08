import 'package:dartz/dartz.dart';

import 'student.dart';

abstract class StudentR {
  Future<Either<ErrorStudent, List<Student>>> getAllStudents();

  Future<bool> deleteStudent(Student student);

  Future<bool> editStudent(Student student);

  Future<bool> addStudent(Student student);
}
