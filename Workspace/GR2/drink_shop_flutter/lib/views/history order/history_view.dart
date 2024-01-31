import 'package:drink_shop_flutter/controllers/order/order_controller.dart';
import 'package:drink_shop_flutter/models/order/order_model.dart';
import 'package:drink_shop_flutter/utils/constant.dart';
import 'package:drink_shop_flutter/views/history%20order/widgets/order_history_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order History'),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Divider(
              height: 2,
              thickness: 2,
              color: secondaryColor5LightTheme,
            ),
          ),
        ),
        body: Obx(() {
          if (orderController.orderList.isEmpty) {
            return _noOrder();
          } else {
            return AnimationLimiter(
                child: ListView.builder(
                    scrollDirection: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? Axis.vertical
                        : Axis.horizontal,
                    itemCount: orderController.orderList.length,
                    itemBuilder: (BuildContext context, int index) {
                      OrderModel order = orderController.orderList[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 500 + index * 20),
                        child: SlideAnimation(
                          horizontalOffset: 400.0,
                          child: FadeInAnimation(
                              child: OrderHistoryTitle(
                            index: index,
                            order: order,
                          )),
                        ),
                      );
                    }));
          }
        }));
  }

  Widget _noOrder() {
    return Center(
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MediaQuery.of(context).orientation == Orientation.portrait
              ? const SizedBox(
                  height: 0,
                )
              : const SizedBox(
                  height: 50,
                ),
          SvgPicture.asset(
            'assets/images/choices_order.svg',
            height: 200,
            width: 200,
            semanticsLabel: 'No Order',
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "There Is No Order",
            style: TextStyle(fontSize: 20),
          ),
        ],
      )),
    );
  }
}
