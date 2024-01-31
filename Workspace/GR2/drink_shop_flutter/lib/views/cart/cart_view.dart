import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:drink_shop_flutter/controllers/cart/cart_controller.dart';
import 'package:drink_shop_flutter/controllers/item/item_controller.dart';
import 'package:drink_shop_flutter/controllers/order/order_controller.dart';
import 'package:drink_shop_flutter/models/address/address.dart';
import 'package:drink_shop_flutter/models/item/product/product_model.dart';
import 'package:drink_shop_flutter/models/item/size/size_model.dart';
import 'package:drink_shop_flutter/models/item/topping/topping_model.dart';
import 'package:drink_shop_flutter/models/order/order_line_model.dart';
import 'package:drink_shop_flutter/models/order/order_model.dart';
import 'package:drink_shop_flutter/models/location/location.dart';
import 'package:drink_shop_flutter/utils/constant.dart';
import 'package:drink_shop_flutter/utils/utils.dart';
import 'package:drink_shop_flutter/views/search/search_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartController cartController = Get.find();
  final ItemController itemController = Get.find();
  final OrderController orderController = Get.find();
  final Location location = Location();
  int totalPrice = 0; // Change to double
  int total = 0;
  bool isLoadingLocation = true;
  @override
  void initState() {
    super.initState();
    calculateTotal();
    if (cartController.orderAddress.value.address == null) {
      location.getLocation().then((LocationData local) async {
        LocationRs tmp = await getLocation(local);
        cartController.updateAddress(Address(
          address: tmp.getAddress(),
          point: GeoPoint(
              tmp.geometry.coordinates[1], tmp.geometry.coordinates[0]),
        ));
      }).whenComplete(() => setState(() {
            isLoadingLocation = false;
          }));
    } else {
      if (mounted) {
        setState(() {
          isLoadingLocation = false;
        });
      }
    }
  }

  Future<LocationRs> getLocation(LocationData local) async {
    dio.Response response = await dio.Dio().get(
        'https://photon.komoot.io/reverse',
        queryParameters: {'lon': local.longitude, 'lat': local.latitude});
    final json = response.data["features"] as List;
    return LocationRs.fromMap(json[0] as Map<String, dynamic>);
  }

  void calculateTotal() {
    totalPrice = 0;
    total = 0;
    for (OrderLineModel line in cartController.cart) {
      totalPrice += line.quantity * line.subTotal;
    }
    total = (totalPrice + deliveryFee).toInt();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(width: 0.5, color: Colors.grey)),
                    height: 70.0,
                    width: w - 20,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 130,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: AssetImage(
                                    'assets/images/delivery.png',
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Delivery',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      '20-30 min',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.grey),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                      width: 1.0, color: Colors.green)),
                              height: 40.0,
                              width: 100.0,
                              alignment: Alignment.center,
                              child: const Text(
                                "Change",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Text('Delivery location'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: 220,
                          child: Obx(() =>
                              cartController.orderAddress.value.address != null
                                  ? Text(
                                      cartController
                                          .orderAddress.value.address!,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator()))),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const SearchView());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border:
                                  Border.all(width: 1.0, color: Colors.green)),
                          height: 40.0,
                          width: 150.0,
                          alignment: Alignment.center,
                          child: const Text(
                            "Change location",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Obx(() => AnimationLimiter(
                  child: ListView.builder(
                shrinkWrap: true, // Add this line
                physics: const ClampingScrollPhysics(),
                itemCount: cartController.cart.length,
                itemBuilder: (BuildContext context, int index) {
                  OrderLineModel line = cartController.cart[index];
                  ProductModel product =
                      itemController.products[line.productId];
                  SizeModel size = itemController.sizes[line.sizeId];
                  List<String> toppings = [];
                  if (line.listTopping.isNotEmpty) {
                    toppings = line.listTopping.map((String toppingId) {
                      ToppingModel topping = itemController.toppings[toppingId];
                      return topping.toppingName;
                    }).toList();
                  }
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            product.productName,
                                            style: const TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            "SIZE: ${size.size}",
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        line.listTopping.isNotEmpty
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                    "TOPPING: ${toppings.join(', ')}",
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )
                                            : Container(),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                              "SUBTOTAL: ${line.quantity * line.subTotal} VND",
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ]),
                                ),
                                Container(
                                  width: 70,
                                  height: 93,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(product.thumbnail!),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 60,
                                      height: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.edit_rounded,
                                              weight: 600.0,
                                              size: 20,
                                            ),
                                            Text(
                                              'Edit',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (line.quantity > 1) {
                                                line.quantity--;
                                                cartController.updateQuantity(
                                                    index: index,
                                                    newQuantity: line.quantity);
                                                calculateTotal();
                                              } else {
                                                cartController
                                                    .removeFromCart(line);
                                                calculateTotal();
                                              }
                                            });
                                          },
                                          icon: const Icon(
                                              Icons.remove_circle_outline,
                                              size: 32.0,
                                              color: Colors.green)),
                                      Text(
                                        line.quantity.toString(),
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              line.quantity++;

                                              cartController.updateQuantity(
                                                  index: index,
                                                  newQuantity: line.quantity);
                                              calculateTotal();
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                            size: 32.0,
                                            color: Colors.green,
                                          )),
                                    ])
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.1,
                            )
                          ],
                        ),
                      ));
                },
              ))),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey),
                borderRadius: BorderRadius.circular(15.0)),
            width: w - 20,
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment summary',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Price', style: TextStyle(fontSize: 16)),
                        Text('$totalPrice',
                            style: const TextStyle(fontSize: 16))
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery fee', style: TextStyle(fontSize: 16)),
                        Text('$deliveryFee', style: TextStyle(fontSize: 16))
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total payment',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text('$total', style: const TextStyle(fontSize: 16))
                      ],
                    )
                  ],
                )),
          ),
        ),
        const SizedBox(
          height: 130.0,
        )
      ]),
      floatingActionButton: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.5, color: Colors.grey),
          ),
          color: Colors.white,
        ),
        height: 120.0,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.money,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Cash"),
                        Text(
                          "$total VND",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 50,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.grey),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const Center(
                      child: Icon(
                        Icons.more_horiz,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: totalPrice > 0 && !isLoadingLocation
                ? () {
                    String orderId = const Uuid().v4();
                    orderController.createOrder(
                        order: OrderModel(
                            orderId: orderId,
                            customerId: FirebaseAuth.instance.currentUser!.uid,
                            createAt: DateTime.now(),
                            status: Status.pending,
                            isPaid: false,
                            total: total,
                            address: cartController.orderAddress.value));
                    cartController
                        .pushOrderLine(orderId: orderId)
                        .whenComplete(() {
                      cartController.clearCart();
                      success(context, 'Order created', "Thank you!");
                      setState(() {
                        totalPrice = 0;
                        total = deliveryFee;
                      });
                    });
                  }
                : null,
            child: Container(
                decoration: BoxDecoration(
                    color: totalPrice > 0 ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(31.0)),
                width: MediaQuery.of(context).size.width - 20.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const Text(
                  "Place delivery order ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
