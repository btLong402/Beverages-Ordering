// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:drink_shop_flutter/controllers/order/order_controller.dart';
import 'package:drink_shop_flutter/models/order/order_model.dart';
import 'package:drink_shop_flutter/views/maps/follow_maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:drink_shop_flutter/controllers/item/item_controller.dart';
import 'package:drink_shop_flutter/models/item/product/product_model.dart';
import 'package:drink_shop_flutter/models/item/size/size_model.dart';
import 'package:drink_shop_flutter/models/order/order_line_model.dart';
import 'package:drink_shop_flutter/utils/constant.dart';

class OrderHistoryDetail extends StatefulWidget {
  final int index;
  final List<OrderLineModel> orderLines;
  const OrderHistoryDetail({
    Key? key,
    required this.index,
    required this.orderLines,
  }) : super(key: key);

  @override
  State<OrderHistoryDetail> createState() => _OrderHistoryDetailState();
}

class _OrderHistoryDetailState extends State<OrderHistoryDetail> {
  final ItemController itemController = Get.find();
  final OrderController orderController = Get.find();
  int totalPrice = 0; // Change to double
  int total = 0;
  @override
  void initState() {
    super.initState();
    calculateTotal();
  }

  void calculateTotal() {
    totalPrice = 0;
    total = 0;
    for (OrderLineModel line in widget.orderLines) {
      totalPrice += line.quantity * line.subTotal;
    }
    total = (totalPrice + deliveryFee).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Summary',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      OrderModel order =
                          orderController.orderList[widget.index];
                      return Text(
                        order.status.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      );
                    }),
                    Text(
                      DateFormat('EEEE, dd MMM, HH:mm').format(
                          orderController.orderList[widget.index].createAt),
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 2,
                thickness: 2,
                color: secondaryColor10LightTheme,
              ),
            ],
          ), // Empty child
        ),
      ),
      body: ListView(children: [
        Obx(() {
          OrderModel order = orderController.orderList[widget.index];
          if (order.shipperId != null) {
            orderController.getShipperInfo(shipperId: order.shipperId!);
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 5.0),
                  child: Row(children: [
                    CircleAvatar(
                      radius: 36,
                      child: SvgPicture.asset(
                        "assets/icons/dinosaur.svg",
                        width: 36,
                        height: 36,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Shipper'),
                        const SizedBox(height: 5),
                        orderController.shipper.value.shipperName != null
                            ? Text(
                                orderController.shipper.value.shipperName!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              )
                            : const CircularProgressIndicator()
                      ],
                    )
                  ]),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  height: 2,
                  thickness: 2,
                  color: secondaryColor10LightTheme,
                ),
              ],
            );
          } else {
            return Container();
          }
        }),
        Container(
          margin: const EdgeInsets.only(left: 10, top: 5.0),
          // width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Delivery details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/restaurant.svg",
                  width: 26,
                  height: 26,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Restaurant location'),
                    const SizedBox(height: 5),
                    Text(
                      resAddress.address!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                )
              ],
            ),
            SvgPicture.asset(
              "assets/icons/line_dotted.svg",
              width: 24,
              height: 24,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/location_circle.svg",
                  width: 26,
                  height: 26,
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 330,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Delivery location'),
                      const SizedBox(height: 5),
                      Text(
                        orderController
                            .orderList[widget.index].address!.address!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: secondaryColor10LightTheme,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, top: 5.0),
          child: const Text(
            "Order details",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, top: 5.0),
          child: AnimationLimiter(
              child: ListView.builder(
            shrinkWrap: true, // Add this line
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              ProductModel product =
                  itemController.products[widget.orderLines[index].productId];
              SizeModel size =
                  itemController.sizes[widget.orderLines[index].sizeId];
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${product.productName} - Size ${size.size}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(widget.orderLines[index].quantity.toString())
                          ]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const DottedDashedLine(
                      height: 0,
                      width: 382,
                      axis: Axis.horizontal,
                      dashColor: secondaryColor20LightTheme,
                      dashWidth: 2.0,
                    )
                  ]));
            },
            itemCount: widget.orderLines.length,
          )),
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: secondaryColor10LightTheme,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, top: 5.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Payment details',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('Price'), Text('$totalPrice')],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery fee',
                  ),
                  Text(
                    '$deliveryFee',
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: DottedDashedLine(
                height: 0,
                width: 382,
                axis: Axis.horizontal,
                dashColor: secondaryColor20LightTheme,
                dashWidth: 2.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total payment',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('$total')
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: DottedDashedLine(
                height: 0,
                width: 382,
                axis: Axis.horizontal,
                dashColor: secondaryColor20LightTheme,
                dashWidth: 2.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment method',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Cash')
                ],
              ),
            ),
          ]),
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: secondaryColor10LightTheme,
        ),
      ]),
      floatingActionButton: Obx(() {
        OrderModel order = orderController.orderList[widget.index];
        if (order.shipperId != null && order.status == Status.delivering) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Get.to(() => FollowMaps(index: widget.index)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  'Follow Shipper',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
