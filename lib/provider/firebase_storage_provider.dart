// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:todo_app3/model/todo_model_view.dart';
// import 'package:todo_app3/provider/firebase_auth_provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // final getTodoProvider = FutureProvider((ref) async {
// //   final userId = ref.read(currentUserProvider)?.uid;
// //   final getData = await FirebaseFirestore.instance
// //       .collection("todos")
// //       .where("id", isEqualTo: userId)
// //       .get();
// //   return getData.docs;
// // });

// final getTodoProvider = FutureProvider<List<TodoModel>?>((ref) async {
//   final userId = ref.read(currentUserProvider)?.uid;
  
//   // Kullanıcı kimliği kontrolü
//   if (userId == null) {
//     return null; // Kullanıcı oturum açmamışsa null döndür
//   }

//   final getData = await FirebaseFirestore.instance
//       .collection("todos")
//       .where("id", isEqualTo: userId)
//       .get();

//   // Veriler varsa, TodoModel listesi döndür
//   return getData.docs.map((e) => TodoModel.fromMap(e.data())).toList();
// });



// final addTodoProvider =
//     Provider.autoDispose.family((ref, TodoModel model) async {
//   return await FirebaseFirestore.instance
//       .collection("todos")
//       .add(model.toMap());
// });

// final doneToggleProvider = Provider.autoDispose.family(
//   (ref, DoneToggleModel doneToggleModel) async {
//     final firestore = FirebaseFirestore.instance;
//     return await firestore.collection("todos").doc(doneToggleModel.id).update(
//       {"done": doneToggleModel.done},
//     );
//   },
// );

// final deleteTodoProvider = Provider.autoDispose.family(
//   (ref, DoneToggleModel doneToggleModel) async {
//     final firestore = FirebaseFirestore.instance;
//     return await firestore.collection("todos").doc(doneToggleModel.id).delete();
//   },
// );

// class DoneToggleModel {
//   final String id;
//   final bool done;
//   DoneToggleModel({
//     required this.id,
//     required this.done,
//   });
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app3/model/todo_model_view.dart';
import 'package:todo_app3/provider/firebase_auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app3/provider/firebase_auth_provider.dart';

final getTodoProvider = FutureProvider((ref) async {
  final userId = ref.read(currentUserProvider)!.uid;
  final getData = await FirebaseFirestore.instance
      .collection("todos")
      .where("id", isEqualTo: userId)
      .get();
  return getData.docs;
});

final addTodoProvider =
    Provider.autoDispose.family((ref, TodoModel model) async {
  return await FirebaseFirestore.instance
      .collection("todos")
      .add(model.toMap());
});

final doneToggleProvider = Provider.autoDispose.family(
  (ref, DoneToggleModel doneToggleModel) async {
    final firestore = FirebaseFirestore.instance;
    return await firestore.collection("todos").doc(doneToggleModel.id).update(
      {"done": doneToggleModel.done},
    );
  },
);

final deleteTodoProvider = Provider.autoDispose.family(
  (ref, DoneToggleModel doneToggleModel) async {
    final firestore = FirebaseFirestore.instance;
    return await firestore.collection("todos").doc(doneToggleModel.id).delete();
  },
);

class DoneToggleModel {
  final String id;
  final bool done;
  DoneToggleModel({
    required this.id,
    required this.done,
  });
}