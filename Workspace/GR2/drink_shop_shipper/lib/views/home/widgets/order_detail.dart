// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:drink_shop_shipper/views/receive/receive_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:drink_shop_shipper/controllers/item/item_controller.dart';
import 'package:drink_shop_shipper/controllers/order/order_controller.dart';
import 'package:drink_shop_shipper/models/item/product/product_model.dart';
import 'package:drink_shop_shipper/models/item/size/size_model.dart';
import 'package:drink_shop_shipper/models/item/topping/topping_model.dart';
import 'package:drink_shop_shipper/models/order/order_line_model.dart';
import 'package:drink_shop_shipper/models/order/order_model.dart';
import 'package:drink_shop_shipper/utils/constant.dart';

class OrderDetail extends StatefulWidget {
  final OrderModel order;
  const OrderDetail({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final ItemController itemController = Get.find();
  final OrderController orderController = Get.find();
  List<OrderLineModel> lines = [];
  bool isLoading = true;
  int totalPrice = 0; // Change to double
  int total = 0;
  @override
  void initState() {
    super.initState();
    orderController.getOrderLines(orderId: widget.order.orderId).then((value) {
      lines = value;
      calculateTotal(lines);
    });
    orderController
        .getCustomerInfo(customerId: widget.order.customerId)
        .whenComplete(() => setState(() {
              isLoading = false;
            }));
  }

  void calculateTotal(List<OrderLineModel> orderLines) {
    totalPrice = 0;
    total = 0;
    for (OrderLineModel line in orderLines) {
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
                    Text(
                      widget.order.status.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat('EEEE, dd MMM, HH:mm')
                          .format(widget.order.createAt),
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
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, top: 5.0),
              child: Row(children: [
                CircleAvatar(
                  radius: 36,
                  child: SvgPicture.asset(
                    "assets/icons/anonymous.svg",
                    width: 45,
                    height: 45,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Customer'),
                    const SizedBox(height: 5),
                    !isLoading
                        ? Text(
                            orderController.customer.value.userName!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          )
                        : const CircularProgressIndicator(),
                    const SizedBox(height: 5),
                    !isLoading
                        ? Text(
                            orderController.customer.value.userPhone!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          )
                        : Container(), // Empty container when loading
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
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, top: 5.0),
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
                        widget.order.address!.address!,
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
                    itemController.products[lines[index].productId];
                SizeModel size = itemController.sizes[lines[index].sizeId];
                List<String> toppings = [];
                for (var topping in lines[index].listTopping) {
                  ToppingModel toppingModel = itemController.toppings[topping];
                  toppings.add(toppingModel.toppingName);
                }
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
                              Text(lines[index].quantity.toString())
                            ]),
                      ),
                      if (toppings.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            Text(
                              'Toppings: ${toppings.join(', ')}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
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
              itemCount: lines.length,
            ))),
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
        const SizedBox(
          height: 130.0,
        )
      ]),
      floatingActionButton: widget.order.status == Status.pending
          ? Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    orderController
                        .receiveOrder(orderId: widget.order.orderId)
                        .whenComplete(
                            () => Get.offAll(() => ReceiveView(lines: lines)));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    'Receive order',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
