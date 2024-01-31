import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_shop_flutter/db/auth/auth_service.dart';
import 'package:drink_shop_flutter/models/user/user_model.dart';
import 'package:drink_shop_flutter/views/auth/login_view.dart';
import 'package:drink_shop_flutter/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Rx<UserModel> user = UserModel().obs;
  @override
  void onReady() {
    super.onReady();
    Rx<User?> user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    ever(user, _initialScreen);
  }

  register(
      {required String email,
      required String password,
      required String phoneNumber,
      required String fullName,
      String? address}) async {
    return await AuthService().register(
        email: email.trim(),
        password: password.trim(),
        phoneNumber: phoneNumber,
        fullName: fullName,
        address: address);
  }

  login({required String email, required String password}) async {
    return await AuthService()
        .login(email: email.trim(), password: password.trim());
  }

  getMyInfo() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot snapshot =
            await AuthService().getUserData(uid: currentUser.uid);
        if (snapshot.exists) {
          UserModel fetchMyInfo =
              UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
          user.value = UserModel().copyWith(
            userAddress: fetchMyInfo.userAddress,
            userEmail: fetchMyInfo.userEmail,
            userId: fetchMyInfo.userId,
            userName: fetchMyInfo.userName,
            userPhone: fetchMyInfo.userPhone,
          );
        }
      }
    } catch (e) {
      // Handle any potential errors that may occur during the data fetching process.
      debugPrint('Error fetching user data: $e');
    }
  }

  void logout() async {
    await auth.signOut();
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginView());
    } else {
      Get.offAll(() => const Loading());
    }
  }
}
