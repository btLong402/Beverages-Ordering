import 'package:drink_shop_flutter/db/order/order_service.dart';
import 'package:drink_shop_flutter/models/address/address.dart';
import 'package:drink_shop_flutter/models/order/order_line_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList cart = <OrderLineModel>[].obs;
  final OrderService orderService = OrderService();
  Rx<Address> orderAddress = Address().obs;

  void addToCart(OrderLineModel orderLineModel) {
    cart.add(orderLineModel);
  }

  void removeFromCart(OrderLineModel orderLineModel) {
    cart.remove(orderLineModel);
  }

  Future pushOrderLine({required String orderId}) async {
    for (OrderLineModel line in cart) {
      await orderService.createOrderLine(orderLine: line, orderId: orderId);
    }
  }

  void clearCart() {
    cart.clear();
  }

  void updateQuantity({required int index, required int newQuantity}) {
    cart[index].quantity = newQuantity;
  }

  void updateAddress(Address newAddress) {
    orderAddress.value = newAddress;
  }
}
