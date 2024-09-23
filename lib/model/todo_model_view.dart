import 'dart:convert';

class TodoModel {
  String? id;
  String? todo;
  bool? done;

  TodoModel({
    this.id,
    this.todo,
    this.done
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

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id': id,
      'todo': todo,
      'done': done,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] != null ? map['id'] as String : null,
      todo: map['todo'] != null ? map['todo'] as String : null,
      done: map['done'] != null ? map['done'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());
  factory TodoModel.fromJson(String source) => TodoModel.fromMap(json.decode(source));

  @override
  bool operator == (covariant TodoModel other) {
    if (identical(this, other)) return true;

    return 
      other.id == id &&
      other.todo == todo &&
      other.done == done;
  }

  @override
  int get hasCode => id.hashCode ^todo.hashCode ^ done.hashCode;
}
