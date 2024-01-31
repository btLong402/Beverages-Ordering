// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_shop_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:drink_shop_flutter/controllers/order/order_controller.dart';
import 'package:drink_shop_flutter/models/order/order_model.dart';

class FollowMaps extends StatefulWidget {
  final int index;
  const FollowMaps({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<FollowMaps> createState() => _FollowMapsState();
}

class _FollowMapsState extends State<FollowMaps> {
  OrderController orderController = Get.find();
  BitmapDescriptor shipperIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor yourIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor resIcon = BitmapDescriptor.defaultMarker;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialIcon();
  }

  void initialIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(devicePixelRatio: 1.5),
            'assets/images/dinosaur_128px.png')
        .then((value) => shipperIcon = value);
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(devicePixelRatio: 1.5),
            'assets/images/anonymous_128px.png')
        .then((value) => yourIcon = value);
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(devicePixelRatio: 1.5),
            'assets/images/restaurant.png')
        .then((value) => resIcon = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Follow your order',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: orderController.orderService
            .followShipper(orderController.orderList[widget.index].shipperId!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Obx(() {
            OrderModel order = orderController.orderList[widget.index];

            if (order.shipperId == null ||
                order.status == Status.completed ||
                order.status == Status.canceled) {
              orderController.cancelFollowShipper();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.back();
              });
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                Map<String, dynamic> data =
                    snapshot.data.data() as Map<String, dynamic>;
                GeoPoint shipperLocation = data['location'] as GeoPoint;

                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        shipperLocation.latitude, shipperLocation.longitude),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('shipper'),
                      position: LatLng(
                          shipperLocation.latitude, shipperLocation.longitude),
                      icon: shipperIcon,
                    ),
                    Marker(
                      markerId: const MarkerId('customer'),
                      position: LatLng(order.address!.point!.latitude,
                          order.address!.point!.longitude),
                      icon: yourIcon,
                    ),
                    Marker(
                      markerId: const MarkerId('restaurant'),
                      position: LatLng(resAddress.point!.latitude,
                          resAddress.point!.longitude),
                      icon: resIcon,
                    ),
                  },
                );
              }
            }
          });
        },
      ),
    );
  }
}
