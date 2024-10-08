import 'package:grock/grock.dart';
import 'package:todo_app3/add_model_sheet.dart';
import 'package:todo_app3/core/extansions/ui/ui_extansion.dart';
import 'package:todo_app3/login_view.dart';
import 'package:todo_app3/model/todo_model_view.dart';
import 'package:todo_app3/provider/firebase_auth_provider.dart';
import 'package:todo_app3/provider/firebase_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key, GoogleSignInAccount? googleSignInAccount});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Todo App",
              style: TextStyle(
                color: Colors.black,
                fontSize: context.val8x,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                ref.read(signOutProvider).then((value) {
                  // ignore: unused_result
                  ref.refresh(currentUserProvider);
                  Grock.toRemove(
                    const LoginView(),
                  );
                });
              },
              icon: Icon(
                Icons.logout_outlined,
                size: context.val8x,
              ),
            ),
          ],
        ),
      ),
      body: ref.watch(getTodoProvider).when(
            data: (value) {
              // final data =
              //     value.map((e) => TodoModel.fromMap(e.data())).toList();
              final data = value.map((e){
                final todoData = e.data();
                return todoData != null ? TodoModel.fromMap(todoData) : null;
              }).where((todo) => todo != null).cast<TodoModel>().toList();
              return RefreshIndicator.adaptive(
                onRefresh: () {
                  return Future.value(
                    ref.refresh(getTodoProvider),
                  );
                },
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: context.val4x),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = data.elementAt(index);
                    
                    return Opacity(
                      opacity: item.done == true ? 0.5 : 1,
                      child: Container(
                        padding: context.padding1x,
                        height: 90,
                        
                        width: double.infinity,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.orange),
                          ),
                          elevation: 8,
                          color: index % 2 == 0 ? Colors.orange.shade50 : Colors.white,
                          child: ListTile(
                            
                            
                            title: Text(
                              item.todo ?? "",
                              style: TextStyle(
                                fontSize: context.val5x,
                                decoration: item.done == true ? TextDecoration.lineThrough : TextDecoration.none,
                              ),
                            ),
                            leading: Checkbox(
                              value: item.done ?? false,
                              onChanged: (newValue) => ref
                                  .read(
                                    doneToggleProvider(
                                      DoneToggleModel(
                                          id: value.elementAt(index).id,
                                          done: newValue ?? false),
                                    ),
                                  )
                                  .then(
                                    (value) => ref.refresh(getTodoProvider),
                                  ),
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                //await value.elementAt(index).reference.delete();
                                showDialog(context: context, 
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title:Text('Silme İşlemi'),
                                    content: Text('Bu öğe silinecek emin misin'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                        Navigator.of(context).pop(); // Popup'ı kapat
                                      },
                                        child: const Text("Hayır"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                        await value.elementAt(index).reference.delete();
                                        Navigator.of(context).pop(); // Popup'ı kapat
                                      },
                                        child: const Text("Evet"),
                                      ),
                                    ],
                                  );
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) {
              return Center(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning,
          color: Colors.red,
          size: context.val15x,
        ),
        SizedBox(height: 10),
        Text(
          'Bir hata oluştu:',
          style: TextStyle(color: Colors.red, fontSize: context.val5x),
        ),
        SizedBox(height: 10),
        Text(
          error.toString(), // Hata mesajını gösterir
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(height: 10),
        Text(
          stackTrace.toString(), // Yığın izini (stackTrace) gösterir
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54),
        ),
      ],
    ),
              );
            },
          ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade300,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const AddModelSheet(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: context.val8x,
        ),
      ),
      backgroundColor: Colors.yellow,
    );
  }
}
