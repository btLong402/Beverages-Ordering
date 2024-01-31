import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_shop_shipper/db/item/item_service.dart';
import 'package:drink_shop_shipper/models/category/item_of_category.dart';
import 'package:drink_shop_shipper/models/item/item_model.dart';
import 'package:drink_shop_shipper/models/item/product/product_model.dart';
import 'package:drink_shop_shipper/models/item/size/size_model.dart';
import 'package:drink_shop_shipper/models/item/topping/topping_model.dart';
import 'package:drink_shop_shipper/models/order/order_line_model.dart';
import 'package:get/get.dart';

class ItemController extends GetxController {
  final RxMap products = <String, ProductModel>{}.obs;
  final RxMap toppings = <String, ToppingModel>{}.obs;
  final RxMap sizes = <String, SizeModel>{}.obs;
  final RxMap itemList = <String, ItemModel>{}.obs;
  final RxList categoryList = <ItemOfCategory>[].obs;

  StreamSubscription<QuerySnapshot>? productStreamSubscription;
  StreamSubscription<QuerySnapshot>? toppingStreamSubscription;
  StreamSubscription<QuerySnapshot>? sizeStreamSubscription;
  StreamSubscription<QuerySnapshot>? itemStreamSubscription;
  StreamSubscription<QuerySnapshot>? categoryStreamSubscription;

  @override
  void onReady() {
    super.onReady();
    initData();
  }

  @override
  void onClose() {
    super.onClose();
    productStreamSubscription?.cancel();
    toppingStreamSubscription?.cancel();
    sizeStreamSubscription?.cancel();
    itemStreamSubscription?.cancel();
    categoryStreamSubscription?.cancel();
  }

  void getProductData() {
    productStreamSubscription =
        ItemService().queryProduct().listen((QuerySnapshot snapshot) {
      Map<String, ProductModel> map = {};
      for (var doc in snapshot.docs) {
        Map<String, dynamic> product = doc.data() as Map<String, dynamic>;
        ProductModel p = ProductModel.fromMap(product);
        map[p.productId] = p;
      }
      products.assignAll(map);
    });
  }

  void getToppingData() {
    toppingStreamSubscription =
        ItemService().queryTopping().listen((QuerySnapshot snapshot) {
      Map<String, ToppingModel> map = {};
      for (var doc in snapshot.docs) {
        Map<String, dynamic> item = doc.data() as Map<String, dynamic>;
        ToppingModel i = ToppingModel.fromMap(item);
        map[i.toppingId] = i;
      }
      toppings.assignAll(map);
    });
  }

  void getSizeData() {
    sizeStreamSubscription =
        ItemService().querySize().listen((QuerySnapshot snapshot) {
      Map<String, SizeModel> map = {};
      for (var doc in snapshot.docs) {
        Map<String, dynamic> size = doc.data() as Map<String, dynamic>;
        SizeModel s = SizeModel.fromMap(size);
        map[s.sizeId] = s;
      }
      sizes.assignAll(map);
    });
  }

  void getItemData() {
    itemStreamSubscription =
        ItemService().queryItem().listen((QuerySnapshot snapshot) {
      Map<String, ItemModel> items = {};
      for (var doc in snapshot.docs) {
        Map<String, dynamic> item = doc.data() as Map<String, dynamic>;
        ItemModel i = ItemModel.fromMap(item);
        items[i.itemId] = i;
      }
      itemList.assignAll(items);
    });
  }

  void getCategory() {
    categoryStreamSubscription =
        ItemService().queryCategory().listen((QuerySnapshot snapshot) {
      List<ItemOfCategory> items = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ItemOfCategory.fromMap(data);
      }).toList();
      categoryList.assignAll(items);
    });
  }

  String getOrderLineString(List<OrderLineModel> orderLines) {
    List<String> parts = [];
    for (var line in orderLines) {
      ProductModel product = products[line.productId]!;
      String productName = product.productName;
      int quantity = line.quantity;
      String result = '$quantity $productName';
      parts.add(result);
    }
    return parts.join(', ');
  }

  void initData() {
    getProductData();
    getSizeData();
    getToppingData();
    getItemData();
    getCategory();
  }
}

