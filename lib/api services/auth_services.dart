import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social/api%20services/colection_paths.dart';
import 'package:social/models/user.dart' as models;

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  Future<void> createUser({models.User user}) async {
    try {
      var res = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      if (res?.user != null) {
        var newUser = user.copyWith(
          id: res.user.uid,
        );
        await store.collection(ColectionsPaths.users).doc(newUser.id).set(
              newUser.toJson(),
              SetOptions(
                merge: false,
              ),
            );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
