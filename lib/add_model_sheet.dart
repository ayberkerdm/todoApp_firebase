import 'package:grock/grock.dart';
import 'package:todo_app3/core/extansions/ui/ui_extansion.dart';
import 'package:todo_app3/model/todo_model_view.dart';
import 'package:todo_app3/provider/firebase_auth_provider.dart';
import 'package:todo_app3/provider/firebase_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddModelSheet extends ConsumerStatefulWidget {
  const AddModelSheet({super.key});

  @override
  ConsumerState<AddModelSheet> createState() => _AddModelSheetState();
}

class _AddModelSheetState extends ConsumerState<AddModelSheet> {
  final textController = TextEditingController();
  late final FocusNode node;

  void addTodo() async {
    if (textController.text.trim().isEmpty) return;
    final id = ref.read(currentUserProvider)!.uid;
    final model = TodoModel(
      id: id,
      todo: textController.text.trim(),
      done: false,
    );
    ref.read(addTodoProvider(model)).then(
          (value) {
            // ignore: unused_result
            ref.refresh(getTodoProvider);
            Grock.back();
          },
        );
  }

  @override
  void initState() {
    super.initState();
    node = FocusNode();
    node.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 16.padding,
      margin: 16.padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 12.borderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textController,
            focusNode: node,
            decoration: const InputDecoration(
              hintText: "Todo Giriniz",
            ),
          ),
          context.emptySizedHeightBox2x,
          ElevatedButton(
            onPressed: () {
              addTodo();
              Navigator.of(context).pop();
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }
}