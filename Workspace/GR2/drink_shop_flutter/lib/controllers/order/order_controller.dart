import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_shop_flutter/db/order/order_service.dart';
import 'package:drink_shop_flutter/models/order/order_line_model.dart';
import 'package:drink_shop_flutter/models/order/order_model.dart';
import 'package:drink_shop_flutter/models/shipper/shipper_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  StreamSubscription<QuerySnapshot>? historySubscription;
  StreamSubscription<DocumentSnapshot>? shipperLocationSubscription;
  RxList orderList = <OrderModel>[].obs;
  Rx<ShipperModel> shipper = ShipperModel().obs;
  final OrderService orderService = OrderService();
  Rx<GeoPoint> shipperLocation = const GeoPoint(0, 0).obs;
  @override
  void onReady() {
    queryHistory();
  }

  Future<void> createOrder({required OrderModel order}) async {
    await orderService.createOrder(order: order);
  }

  void queryHistory() {
    historySubscription =
        orderService.queryHistory().listen((QuerySnapshot snapshot) {
      List<OrderModel> orders = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return OrderModel.fromMap(data);
      }).toList();
      orderList.assignAll(orders);
    });
  }
  void cancelFollowShipper() {
    shipperLocationSubscription?.cancel();
    shipperLocation.value = const GeoPoint(0, 0);
  }

  Future<List<OrderLineModel>> getOrderLines({required String orderId}) async {
    QuerySnapshot snapshot = await orderService.getOrderLines(orderId: orderId);
    return snapshot.docs.map((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return OrderLineModel.fromMap(data);
    }).toList();
  }

  Future<void> getShipperInfo({required String shipperId}) async {
    DocumentSnapshot snapshot = await orderService.getShipperInfo(shipperId);
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    shipper.value = ShipperModel.fromMap(data);
  }
}
