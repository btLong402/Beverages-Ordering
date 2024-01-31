import 'dart:ui';

import 'package:drink_shop_flutter/controllers/cart/cart_controller.dart';
import 'package:drink_shop_flutter/controllers/item/item_controller.dart';
import 'package:drink_shop_flutter/models/item/item_model.dart';
import 'package:drink_shop_flutter/models/item/product/product_model.dart';
import 'package:drink_shop_flutter/models/item/size/size_model.dart';
import 'package:drink_shop_flutter/models/item/topping/topping_model.dart';
import 'package:drink_shop_flutter/models/order/order_line_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddView extends StatefulWidget {
  const AddView({super.key, required this.item});
  final ItemModel item;
  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final ItemController itemController = Get.find();
  final CartController cartController = Get.find();
  final List<String> titles = ["Topping", "Size"];
  List<String> toppingSelected = [];
  late SizeModel size;
  late int price;
  late ProductModel product;
  late OrderLineModel orderLine;
  int quantity = 1;
  @override
  void initState() {
    product = itemController.products[widget.item.productId];
    size = itemController.sizes[widget.item.listSize[0]];
    price = product.price;
    super.initState();
  }

  void plusPrice({required int addPrice}) {
    price += addPrice;
  }

  void minusPrice({required int minusPrice}) {
    price -= minusPrice;
  }

  void addOrderLine(
      {required String productId,
      required List<String> listTopping,
      required String sizeId,
      required int quantity,
      required int subTotal}) {
    String orderLineId = const Uuid().v4();
    orderLine = OrderLineModel(
        orderLineId: orderLineId,
        productId: productId,
        listTopping: listTopping,
        quantity: quantity,
        subTotal: subTotal,
        sizeId: sizeId);
    cartController.addToCart(orderLine);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(bottom: 20.0),
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(width: 1.0),
                  bottom: BorderSide.none,
                  left: BorderSide.none,
                  right: BorderSide.none),
              color: Color.fromARGB(247, 255, 255, 255)
              // borderRadius: BorderRadius.circular(35.0)
              ),
          // width: MediaQuery.of(context).size.width / 2,
          height: 100.0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Item quantity",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                            icon: const Icon(Icons.remove_circle_outline,
                                size: 32.0, color: Colors.green)),
                        Text(
                          quantity.toString(),
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
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
              GestureDetector(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(31.0)),
                    width: MediaQuery.of(context).size.width - 20.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    child: Text(
                      "Add to cart - ${price * quantity} VND",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )),
                onTap: () {
                  addOrderLine(
                      productId: product.productId,
                      listTopping: toppingSelected,
                      sizeId: size.sizeId,
                      quantity: quantity,
                      subTotal: price);
                  Get.back();
                },
              ),
              // FloatingActionButton(
              //   onPressed: () {},
              //   child: const Icon(Icons.add),
              // )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height / 4 * 1,
              floating: false,
              pinned: false,
              snap: false,
              elevation: 0.5,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(product.productName),
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(left: 20, bottom: 20),
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(product.thumbnail!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                    ),
                  )),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(titles[0], style: const TextStyle(fontSize: 36)),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  ToppingModel topping =
                      itemController.toppings[widget.item.listTopping[index]];
                  int i = toppingSelected.indexOf(topping.toppingId);
                  return Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (i == -1) {
                            setState(() {
                              toppingSelected.assign(topping.toppingId);
                              plusPrice(addPrice: topping.price);
                            });
                          } else {
                            setState(() {
                              toppingSelected.removeAt(i);
                              minusPrice(minusPrice: topping.price);
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${topping.toppingName} + ${topping.price} VND"),
                            Icon(i == -1
                                ? Icons.check_box_outline_blank
                                : Icons.check_box_outlined)
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: widget.item.listTopping.length,
                // childCount: 20,
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
                color: Colors.black,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(titles[1], style: const TextStyle(fontSize: 36)),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  SizeModel s =
                      itemController.sizes[widget.item.listSize[index]];

                  return Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => setState(() {
                          minusPrice(minusPrice: size.price);
                          plusPrice(addPrice: s.price);
                          size = s;
                        }),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${s.size} + ${s.price} VND"),
                            Icon(size.sizeId == s.sizeId
                                ? Icons.radio_button_checked_outlined
                                : Icons.radio_button_off_outlined)
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: widget.item.listSize.length,
                // childCount: 20,
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
