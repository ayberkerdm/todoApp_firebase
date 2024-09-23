import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final currentUserProvider =
    Provider((ref) => FirebaseAuth.instance.currentUser);

final signOutProvider = Provider(
  (ref) async => await FirebaseAuth.instance.signOut(),
);

final loginUserProvider = Provider.family.autoDispose(
  (ref, List<String> list) async {
    final credential = EmailAuthProvider.credential(
      email: list.first,
      password: list.last,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    return FirebaseAuth.instance.currentUser;
  },
);

final registerUserProvider = Provider.family.autoDispose(
  (ref, List<String> list) async {
    final credential = EmailAuthProvider.credential(
      email: list.first,
      password: list.last,
    );
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: list.first,
      password: list.last,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    return FirebaseAuth.instance.currentUser;
  },
);

Future<User?> signInWithGoogle() async {
  // oturum açma sürecini başlat

  final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

  // süreç içinden bilgileri al

  final GoogleSignInAuthentication gAuth = await gUser!.authentication;

  // kullanıcı nesnesini oluştur

  final credential = GoogleAuthProvider.credential(
    accessToken: gAuth.accessToken,
    idToken: gAuth.idToken,
  );

  // kullanıcı girişini sağla

  final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

  return userCredential?.user;
}