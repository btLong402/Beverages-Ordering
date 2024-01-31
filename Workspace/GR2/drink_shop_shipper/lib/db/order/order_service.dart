import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_shop_shipper/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

class OrderService {
  final CollectionReference orderRef =
      FirebaseFirestore.instance.collection('Orders');
  final CollectionReference orderLineRef =
      FirebaseFirestore.instance.collection('OrderLines');
  final CollectionReference orderReceivedRef =
      FirebaseFirestore.instance.collection('OrderReceived');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference shipperLocationRef =
      FirebaseFirestore.instance.collection('shipperLocation');
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future getCustomerInfo({required String customerId}) async {
    DocumentSnapshot snapshot = await userCollection.doc(customerId).get();
    return snapshot;
  }

  Stream<QuerySnapshot> queryOrderPending() {
    return orderRef
        .where('status', isEqualTo: 0)
        .orderBy('createAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> queryOrderFinished() {
    return orderRef
        .where('shipperId', isEqualTo: uid)
        .where('status', isEqualTo: 3)
        .orderBy('createAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> queryOrderDelivered() {
    return orderRef
        .where('shipperId', isEqualTo: uid)
        .where('status', isEqualTo: 3)
        .orderBy('createAt', descending: true)
        .snapshots();
  }

  Future getOrderLines({required String orderId}) async {
    return await orderLineRef.where('orderId', isEqualTo: orderId).get();
  }

  Stream<DocumentSnapshot> queryOrderReceived(String orderId) {
    return orderRef.doc(orderId).snapshots();
  }

  Future queryOrder(String orderId) async {
    return await orderRef.doc(orderId).get();
  }

  Future checkOrderReceived() async {
    return await orderReceivedRef.doc(uid).get();
  }

  Future updateStatus(String orderId, Status status) async {
    return await orderRef.doc(orderId).update({'status': status.index});
  }

  Future updateLocation(LocationData location) async {
    return await shipperLocationRef.doc(uid).set({
      'location': GeoPoint(location.latitude ?? 0, location.longitude ?? 0),
    });
  }

  Future stopUpdate() async {
    return await shipperLocationRef.doc(uid).delete();
  }

  Future delivered(String orderId) async {
    return await orderRef
        .doc(orderId)
        .update({'isPaid': true, 'status': 3}).whenComplete(
            () async => await orderReceivedRef.doc(uid).delete());
  }

  Future receiveOrder(String orderId) async {
    return await orderRef
        .doc(orderId)
        .update({'shipperId': uid, 'status': 1}).whenComplete(() async =>
            await orderReceivedRef.doc(uid).set({'orderId': orderId}));
  }

  Future returnOrder(String orderId) async {
    return await orderRef
        .doc(orderId)
        .update({'shipperId': null, 'status': 0}).whenComplete(
            () async => await orderReceivedRef.doc(uid).delete());
  }

  Future startDelivering(String orderId) async {
    return await orderRef.doc(orderId).update({'status': 2});
  }
}
