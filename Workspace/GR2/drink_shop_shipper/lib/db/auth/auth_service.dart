import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final CollectionReference shipperCollection =
      FirebaseFirestore.instance.collection("shipper");

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
      }) async {
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        await savingUserData(
            user.uid, email, fullName, phoneNumber);
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future savingUserData(String uid, String email, String fullName,String phoneNumber) async {
    return await shipperCollection.doc(uid).set({
      'shipperName': fullName,
      'shipperUd': uid,
      'shipperEmail': email,
      'shipperPhone': phoneNumber,
      'shipperRate' : '0.0'
    });
  } 

  Future getUserData({required String uid}) async {
    DocumentSnapshot snapshot = await shipperCollection.doc(uid).get();
    if(snapshot.exists) {
      return snapshot;
    }
    return null;
  }

}
