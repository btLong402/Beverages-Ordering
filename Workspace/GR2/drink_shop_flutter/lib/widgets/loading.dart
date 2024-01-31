import 'package:drink_shop_flutter/controllers/auth/auth_controller.dart';
import 'package:drink_shop_flutter/controllers/cart/cart_controller.dart';
import 'package:drink_shop_flutter/controllers/item/item_controller.dart';
import 'package:drink_shop_flutter/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final AuthController authController = Get.find();
  final ItemController itemController = Get.put(ItemController());
  final CartController cartController = Get.put(CartController());
  @override
  void initState() {
    super.initState();
    authController
        .getMyInfo()
        .whenComplete(() => Get.offAll(() => const BaseView()));
  }

  @override
  // ignore: prefer_const_constructors
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      backgroundColor: Colors.amberAccent,
    ));
  }
}
