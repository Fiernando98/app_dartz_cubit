import 'dart:convert';

import 'package:flutter_dartz/models/student.dart';

List<Student> adapterSource(String data) {
  final List t = json.decode(data);
  final List<ElementAdapter> list =
      t.map((e) => ElementAdapter.fromJSON(e)).toList();
  final List<Student> listStudent =
      list.map((e) => Student(id: e.id, name: e.name)).toList();
  return listStudent;
}

class ElementAdapter {
  int id;
  String name;

  ElementAdapter(this.id, this.name);

  ElementAdapter.fromJSON(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
  }
}
