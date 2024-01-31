import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_shop_shipper/controllers/auth/auth_controller.dart';
import 'package:drink_shop_shipper/controllers/order/order_controller.dart';
import 'package:drink_shop_shipper/models/order/order_model.dart';
import 'package:drink_shop_shipper/utils/constant.dart';
import 'package:drink_shop_shipper/views/home/widgets/order_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class FinishedView extends StatelessWidget {
  FinishedView({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;
  final AuthController authController = Get.find();
  final OrderController orderController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Good day, \n${authController.user.value.shipperName}',
          style: const TextStyle(
            color: Color(0xFF230C02),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.black,
              )),
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 24,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: secondaryColor10LightTheme,
            height: 2,
            thickness: 2,
          ),
        ),
      ),
      body: StreamBuilder(stream: orderController.orderService.queryOrderFinished(), // Replace with your actual Stream
  builder: (BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator()); // Show a loading spinner while waiting for data
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}'); // Show error message if there's an error
    } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return noOrder(context);
          } else {
      List<OrderModel> orders = snapshot.data.docs.map<OrderModel>((DocumentSnapshot doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return OrderModel.fromMap(data);
            }).toList();
      return AnimationLimiter(
        child: ListView.builder(
          scrollDirection: MediaQuery.of(context).orientation == Orientation.portrait
              ? Axis.vertical
              : Axis.horizontal,
          itemCount: orders.length,
          itemBuilder: (BuildContext context, int index) {
            OrderModel order = orders[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: Duration(milliseconds: 500 + index * 20),
              child: SlideAnimation(
                horizontalOffset: 400.0,
                child: FadeInAnimation(child: OrderTitle(order: order)),
              ),
            );
          },
        ),
      );
    }
  },
),
    );
  }
}
