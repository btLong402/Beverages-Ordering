import 'package:drink_shop_shipper/controllers/order/order_controller.dart';
import 'package:drink_shop_shipper/models/order/order_model.dart';
import 'package:drink_shop_shipper/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  final OrderController orderController = Get.find();
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
      body: Obx(() {
        OrderModel order = orderController.orderReceived.value;

        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: orderController.locationData.value,
            zoom: 15,
          ),
          markers: {
            Marker(
              markerId: const MarkerId('shipper'),
              position: orderController.locationData.value,
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
              position: LatLng(
                  resAddress.point!.latitude, resAddress.point!.longitude),
              icon: resIcon,
            ),
          },
        );
      }),
    );
  }
}
