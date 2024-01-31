import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future login({required String email, required String password}) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future register(
      {required String email,
      required String password,
      required String phoneNumber,
      required String fullName,
      String? address}) async {
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        await savingUserData(
            user.uid, email, fullName, password, phoneNumber, address);
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future savingUserData(String uid, String email, String fullName,
      String password, String phoneNumber, String? address) async {
    return await userCollection.doc(uid).set({
      "userName": fullName,
      "userEmail": email,
      "userPhone": phoneNumber,
      "userId": uid,
      "userAddress": address,
    });
  }

  Future getUserData({required String uid}) async {
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    return snapshot;
  }
}
