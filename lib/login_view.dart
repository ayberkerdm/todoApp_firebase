import 'package:grock/grock.dart';
import 'package:todo_app3/core/extansions/textFields/special_text_field.dart';
import 'package:todo_app3/core/extansions/ui/ui_extansion.dart';
import 'package:todo_app3/home_view.dart';
import 'package:todo_app3/provider/firebase_auth_provider.dart';
import 'package:todo_app3/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    // if (emailController.text.trim().isEmail) return;
    // if (passwordController.text.trim().length < 4) return;
    if (!emailController.text.trim().isEmail && 
    passwordController.text.trim().length <= 4) {
  return;
}

    final List<String> list = [
      emailController.text.trim(),
      passwordController.text.trim(),
    ];
    ref
        .read(
          loginUserProvider(list),
        )
        .then(
          (value) => Grock.toRemove(
            const HomeView(),
          ),
        )
        .catchError(
          (err) => Grock.toast(
            text: err.toString(),
            textStyle: TextStyle(color: Colors.black)
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Login',
        style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 250,
          ),
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
                  login();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeView(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: context.val5x,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: context.paddingHorizontal9x,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 1,
                  width: context.val20x,
                  color: Colors.blue,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterView(),
                      ),
                    );
                  },
                  child: const Text(
                    "Create a Account",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                Container(
                  height: 1,
                  width: context.val20x,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          Padding(
            padding: context.paddingHorizontal8x,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                signInWithGoogle().then(
                  (value) => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Text(
                    "Sign In with Google",
                    style: TextStyle(
                      fontSize: context.val4x * 1.2,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
