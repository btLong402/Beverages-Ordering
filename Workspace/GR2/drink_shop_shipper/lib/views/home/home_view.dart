// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:drink_shop_shipper/controllers/auth/auth_controller.dart';
import 'package:drink_shop_shipper/controllers/order/order_controller.dart';
import 'package:drink_shop_shipper/models/order/order_model.dart';
import 'package:drink_shop_shipper/utils/constant.dart';
import 'package:drink_shop_shipper/views/home/widgets/order_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);
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
        body: Obx(() {
          if (orderController.listOrderPending.isEmpty) {
            return noOrder(context);
          } else {
            return AnimationLimiter(
                child: ListView.builder(
                    scrollDirection: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? Axis.vertical
                        : Axis.horizontal,
                    itemCount: orderController.listOrderPending.length,
                    itemBuilder: (BuildContext context, int index) {
                      OrderModel order =
                          orderController.listOrderPending[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 500 + index * 20),
                        child: SlideAnimation(
                          horizontalOffset: 400.0,
                          child:
                              FadeInAnimation(child: OrderTitle(order: order)),
                        ),
                      );
                    }));
          }
        }));
  }
}
