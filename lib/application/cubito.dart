import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dartz/application/information.dart';
import 'package:flutter_dartz/models/student.dart';
import 'package:flutter_dartz/models/student_r.dart';

class Cubito extends Cubit<Information> {
  final StudentR repo;

  Cubito(this.repo) : super(Information.inicial()) {
    getAllStudents();
  }

  void getAllStudents() async {
    final response = await repo.getAllStudents();
    response.fold((l) => emit(state.copyWith(message: "Hay P2")),
        (r) => emit(Information(r, null, state.text, "")));
  }

  void changeText(String text) {
    emit(state.copyWith(text: text));
  }

  void changeSelected(int newSelect) {
    emit(state.copyWith(selected: newSelect));
  }

  void deleteStudent(Student student) async {
    await repo.deleteStudent(student);
    getAllStudents();
  }

  void addStudent() async {
    print("Texto: ${state.text}");
    final result = await repo.addStudent(Student(id: 0, name: state.text));
    if (result == false) {
      emit(state.copyWith(message: "No Pude Agregar"));
    }
    getAllStudents();
  }

  void editStudent() async {
    Student student =
        Student(id: state.students[state.selected].id, name: state.text);
    final result = await repo.editStudent(student);
    if (result == false) {
      emit(state.copyWith(message: "No Pude Editar"));
    }
    getAllStudents();
  }
}
