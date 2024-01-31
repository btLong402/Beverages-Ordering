// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:drink_shop_flutter/controllers/item/item_controller.dart';
import 'package:drink_shop_flutter/controllers/order/order_controller.dart';
import 'package:drink_shop_flutter/models/order/order_line_model.dart';
import 'package:drink_shop_flutter/models/order/order_model.dart';
import 'package:drink_shop_flutter/utils/constant.dart';
import 'package:drink_shop_flutter/views/history%20order/widgets/order_history_detail.dart';

class OrderHistoryTitle extends StatefulWidget {
  final int index;
  final OrderModel order;
  const OrderHistoryTitle({
    Key? key,
    required this.index,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderHistoryTitle> createState() => _OrderHistoryTitleState();
}

class _OrderHistoryTitleState extends State<OrderHistoryTitle> {
  final OrderController orderController = Get.find();
  final ItemController itemController = Get.find();
  List<OrderLineModel> orderLines = [];
  @override
  void initState() {
    super.initState();
    initializeOrderLines();
  }

  void initializeOrderLines() async {
    // Use 'await' to wait for the completion of the asynchronous operation.
    orderLines =
        await orderController.getOrderLines(orderId: widget.order.orderId);

    // After receiving the result, trigger a rebuild of the widget tree.
    if (mounted) {
    setState(() {});
  }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    bool isSameDay = false;
    if (widget.order.createAt.day == now.day &&
        widget.order.createAt.month == now.month &&
        widget.order.createAt.year == now.year) isSameDay = true;

    return GestureDetector(
        onTap: () => Get.to(() =>
            OrderHistoryDetail(index: widget.index, orderLines: orderLines)),
        child: SizedBox(
          height: 140,
          child: Column(
            children: [
              ListTile(
                
                title: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/icon_history.svg",
                              width: 64,
                              height: 64,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resAddress.address!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    widget.order.status.icon,
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.order.status.title,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                itemController.getOrderLineString(orderLines),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                trailing: Column(children: [
                  Text(
                    isSameDay
                        ? DateFormat('HH:mm').format(widget.order.createAt)
                        : DateFormat('d MMM, HH:mm')
                            .format(widget.order.createAt),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
              const Divider(
                height: 2,
                thickness: 2,
                color: secondaryColor5LightTheme,
              ),
            ],
          ),
        ));
  }
}
