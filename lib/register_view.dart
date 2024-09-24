import 'package:grock/grock.dart';
import 'package:todo_app3/core/extansions/ui/ui_extansion.dart';
import 'package:todo_app3/home_view.dart';
import 'package:todo_app3/login_view.dart';
import 'package:todo_app3/provider/firebase_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/extansions/textFields/special_text_field.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void register() {
    if (!emailController.text.trim().isEmail) return;
    if (passwordController.text.trim().length < 4) return;
    // if (emailController.text.trim().isEmail &&
    //     passwordController.text.trim().length > 4) {
    //   return;
    // }
    final List<String> list = [
      emailController.text.trim(),
      passwordController.text.trim(),
    ];
    ref
        .read(
          registerUserProvider(list),
        )
        .then(
          (value) => Grock.toRemove(
            const LoginView(),
          ),
        )
        .catchError(
      (err) {
        Grock.toast(
          text: err.toString(),
        );
        print(err);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register',
        style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 250,),
          SpecialTextField(
            label: 'Mail',
            icon: Icons.mail_outline_outlined,
            controller: emailController,
          ),
          context.emptySizedHeightBox2x,
          SpecialTextField(
            label: 'Password',
            icon: Icons.lock_outline_rounded,
            controller: passwordController,
          ),
          context.emptySizedHeightBox3x,
          SizedBox(
            height: context.val13x,
            child: Padding(
              padding: context.paddingHorizontal9x,
              child: ElevatedButton(
                onPressed: () {
                  register();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeView(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400),
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: context.val5x,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
