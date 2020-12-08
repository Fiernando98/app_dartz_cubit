import 'package:dartz/dartz.dart';
import 'package:flutter_dartz/models/student.dart';
import 'package:flutter_dartz/models/student_r.dart';
import 'package:flutter_dartz/repo/adapters.dart';
import 'package:flutter_dartz/uris.dart';
import 'package:http/http.dart' as http;

class Repository implements StudentR {
  @override
  Future<Either<ErrorStudent, List<Student>>> getAllStudents() async {
    try {
      final response = await http.get(API_STUDENTS, headers: {
        'Content-Type': 'application/json'
      }).timeout(Duration(seconds: 15), onTimeout: () {
        return null;
      });

      if (response == null || response.statusCode != 200) {
        return Left(ErrorStudentAccess());
      }

      List<Student> students = adapterSource(response.body);
      return Right(students);
    } on Exception {
      return Left(ErrorStudentGeneral());
    }
  }

  @override
  Future<bool> deleteStudent(Student student) async {
    try {
      final response = await http.delete("$API_STUDENTS/${student.id}",
          headers: {
            'Content-Type': 'application/json'
          }).timeout(Duration(seconds: 15), onTimeout: () {
        return null;
      });
      if (response == null || response.statusCode != 200) {
        return false;
      }
      return true;
    } on Exception {
      return false;
    }
  }

  @override
  Future<bool> editStudent(Student student) async {
    try {
      final studentJSON = {"name": student.name};
      final response = await http
          .put("$API_STUDENTS/${student.id}",
              headers: {'Content-Type': 'application/json'}, body: studentJSON)
          .timeout(Duration(seconds: 15), onTimeout: () {
        return null;
      });

      if (response == null || response.statusCode != 200) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> addStudent(Student student) async {
    try {
      final studentJSON = {"name": student.name};
      final response = await http
          .post(API_STUDENTS,
              headers: {'Content-Type': 'application/json'}, body: studentJSON)
          .timeout(Duration(seconds: 15), onTimeout: () {
        return null;
      });

      if (response == null || response.statusCode != 201) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
