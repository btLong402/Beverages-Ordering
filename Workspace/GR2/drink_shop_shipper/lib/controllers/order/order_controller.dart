import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_shop_shipper/db/order/order_service.dart';
import 'package:drink_shop_shipper/models/order/order_line_model.dart';
import 'package:drink_shop_shipper/models/order/order_model.dart';
import 'package:drink_shop_shipper/models/user/user_model.dart';
import 'package:drink_shop_shipper/utils/constant.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderController extends GetxController {
  final OrderService orderService = OrderService();
  StreamSubscription<QuerySnapshot>? orderPendingSubscription;
  StreamSubscription<DocumentSnapshot>? orderReceivedSubscription;
  StreamSubscription<LocationData>? locationSubscription;
  Rx<UserModel> customer = UserModel().obs;
  RxList listOrderPending = <OrderModel>[].obs;
  Rx<String> orderReceivedId = ''.obs;
  Rx<OrderModel> orderReceived = OrderModel(
          orderId: '',
          customerId: '',
          shipperId: '',
          description: '',
          createAt: DateTime.now(),
          status: Status.pending,
          isPaid: false,
          total: 0,
          address: null)
      .obs;
  Rx<LatLng> locationData = const LatLng(0, 0).obs;
  @override
  void onReady() {
    super.onReady();
    queryOrderPending();
  }

  Future<void> getCustomerInfo({required String customerId}) async {
    DocumentSnapshot snapshot =
        await orderService.getCustomerInfo(customerId: customerId);
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    customer.value = UserModel.fromMap(data);
  }

  Future<void> updateStatus(
      {required String orderId, required Status status}) async {
    await orderService.updateStatus(orderId, status);
  }

  Future<void> receiveOrder({required orderId}) async {
    setOrderReceivedId(orderId);
    await orderService.receiveOrder(orderId);
  }

  Future<void> returnOrder() async {
    await orderService
        .returnOrder(orderReceivedId.value)
        .whenComplete(() => setOrderReceivedId(''));
  }

  Future<void> updateLocation({required LocationData location}) async {
    await orderService.updateLocation(location);
  }

  Future<void> startDelivering() async {
    await orderService.startDelivering(orderReceivedId.value);
  }

  Future<void> stopUpdateLocation() async {
    await orderService.stopUpdate();
  }

  Future<void> delivered() async {
    await orderService.delivered(orderReceivedId.value);
  }

  Future<List<OrderLineModel>> getOrderLines({required String orderId}) async {
    QuerySnapshot snapshot = await orderService.getOrderLines(orderId: orderId);
    return snapshot.docs.map((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return OrderLineModel.fromMap(data);
    }).toList();
  }

  void queryOrderPending() {
    orderPendingSubscription =
        orderService.queryOrderPending().listen((QuerySnapshot snapshot) {
      listOrderPending.value = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return OrderModel.fromMap(data);
      }).toList();
    });
  }

  void queryOrderReceived() {
    orderReceivedSubscription =
        orderService.queryOrderReceived(orderReceivedId.value).listen((event) {
      Map<String, dynamic> data = event.data() as Map<String, dynamic>;
      orderReceived.value = OrderModel.fromMap(data);
    });
  }

  void setOrderReceivedId(String orderId) {
    orderReceivedId.value = orderId;
  }

  Future checkOrderReceived() async {
    DocumentSnapshot snapshot = await orderService.checkOrderReceived();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      orderReceivedId.value = data['orderId'];
    }
  }

  void listenToLocation() {
    Location location = Location();
    locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) {
      locationData.value =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      pushLocationToFirebase(currentLocation);
    });
  }

  Future pushLocationToFirebase(LocationData currentLocation) async {
    await orderService.updateLocation(currentLocation);
  }

  void stopListeningToLocation() {
    locationSubscription?.cancel();
    locationSubscription = null;
    locationData.value = const LatLng(0, 0);
  }
}
