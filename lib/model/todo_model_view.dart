import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? id;
  String? todo;
  bool? done;
  DocumentReference? reference;

  TodoModel({
    this.id,
    this.todo,
    this.done,
    this.reference,
  });

  TodoModel copyWith({
    String? id,
    String? todo,
    bool? done,
  }) {
    return TodoModel(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'todo': todo,
      'done': done,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map, {DocumentReference? reference}) {
    return TodoModel(
      id: map['id'] != null ? map['id'] as String : null,
      todo: map['todo'] != null ? map['todo'] as String : null,
      done: map['done'] != null ? map['done'] as bool : null,
      reference: reference, // Burada reference'ı parametre olarak alıyoruz
    );
  }

  String toJson() => json.encode(toMap());
  factory TodoModel.fromJson(String source) => TodoModel.fromMap(json.decode(source));

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;

    return 
      other.id == id &&
      other.todo == todo &&
      other.done == done;
  }

  @override
  int get hashCode => id.hashCode ^ todo.hashCode ^ done.hashCode;
}
