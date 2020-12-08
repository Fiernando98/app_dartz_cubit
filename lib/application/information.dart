import 'package:flutter/foundation.dart';
import 'package:flutter_dartz/models/student.dart';

class Information {
  final List<Student> students;
  final int selected;
  final String text;
  final String message;

  const Information(this.students, this.selected, this.text, this.message);

  factory Information.inicial() {
    return const Information([], 0, "", "");
  }

  Information copyWith(
      {List<Student> students, int selected, String text, String message}) {
    return Information(students ?? this.students, selected ?? this.selected,
        text ?? this.text, message ?? this.message);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Information &&
        listEquals(o.students, students) &&
        o.selected == selected &&
        o.text == text &&
        o.message == message;
  }

  @override
  int get hashCode =>
      students.hashCode ^ selected.hashCode ^ text.hashCode ^ message.hashCode;

  @override
  String toString() =>
      'Information{students: $students, selected: $selected, text: $text, message: $message}';
}
