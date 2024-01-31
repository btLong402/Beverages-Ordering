import 'package:drink_shop_shipper/controllers/auth/auth_controller.dart';
import 'package:drink_shop_shipper/controllers/item/item_controller.dart';
import 'package:drink_shop_shipper/controllers/order/order_controller.dart';
import 'package:drink_shop_shipper/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final AuthController authController = Get.find();
  final ItemController itemController = Get.put(ItemController());
  final OrderController orderController = Get.put(OrderController());

  final Location location = Location();
  Future<void> getPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPermission();
    authController.getMyInfo().whenComplete(() {
      Get.offAll(() => const BaseView());
    });
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
