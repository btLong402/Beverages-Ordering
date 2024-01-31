import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_shop_shipper/db/auth/auth_service.dart';
import 'package:drink_shop_shipper/models/shipper/shipper_model.dart';
import 'package:drink_shop_shipper/views/auth/login_view.dart';
import 'package:drink_shop_shipper/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Rx<ShipperModel> user = ShipperModel().obs;
  @override
  void onReady() {
    super.onReady();
    Rx<User?> user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    ever(user, _initialScreen);
  }

  Future register({
    required String email,
    required String password,
    required String phoneNumber,
    required String fullName,
  }) async {
    return await AuthService().register(
        email: email.trim(),
        password: password.trim(),
        phoneNumber: phoneNumber,
        fullName: fullName);
  }

  Future login({required String email, required String password}) async {
    return await AuthService()
        .login(email: email.trim(), password: password.trim());
  }

  Future getMyInfo() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot snapshot =
            await AuthService().getUserData(uid: currentUser.uid);
        if (snapshot.exists) {
          user.value =
              ShipperModel.fromMap(snapshot.data() as Map<String, dynamic>);
        }
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginView());
    } else {
      Get.offAll(() => const Loading());
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
