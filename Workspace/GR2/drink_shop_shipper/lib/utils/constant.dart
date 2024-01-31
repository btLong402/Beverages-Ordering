import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drink_shop_shipper/models/address/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Status {
  pending,
  shipperReceived,
  delivering,
  completed,
  canceled,
}

enum ColorStatus {
  red,
  green,
  blue,
}

extension ColorExt on ColorStatus {
  String get name {
    switch (this) {
      case ColorStatus.red:
        return 'Red';
      case ColorStatus.green:
        return 'Green';
      default:
        return 'Blue';
    }
  }

  int get hexCode {
    const hexCodes = [0xFFF44336, 0xFFFFE57F, 0xFF0277BD];
    return hexCodes[index];
  }
}

extension StatusColor on Status {
  String get title {
    switch (this) {
      case Status.pending:
        return 'Pending';
      case Status.shipperReceived:
        return 'Shipper received';
      case Status.delivering:
        return 'Delivering';
      case Status.completed:
        return 'Drink delivered';
      case Status.canceled:
        return 'Order canceled';
    }
  }

  String get icon {
    switch (this) {
      case Status.pending:
        return 'assets/icons/pending.svg';
      case Status.shipperReceived:
        return 'assets/icons/shipper_received.svg';
      case Status.delivering:
        return 'assets/icons/delivery.svg';
      case Status.completed:
        return 'assets/icons/icon_confirm.svg';
      case Status.canceled:
        return 'assets/icons/icon_cancel.svg';
    }
  }
}

const String ggApiKey = 'AIzaSyAtCEjn3gYCwDfDJGqd4pbSIAXpvORCXTc';
const Color primaryColor = Color(0xFF006491);
const Color textColorLightTheme = Color(0xFF0D0D0E);

const Color secondaryColor80LightTheme = Color(0xFF202225);
const Color secondaryColor60LightTheme = Color(0xFF313336);
const Color secondaryColor40LightTheme = Color(0xFF585858);
const Color secondaryColor20LightTheme = Color(0xFF787F84);
const Color secondaryColor10LightTheme = Color(0xFFEEEEEE);
const Color secondaryColor5LightTheme = Color(0xFFF8F8F8);

const defaultPadding = 16.0;

Address resAddress = Address(
    address: "Hanoi University of Science and Technology",
    point: const GeoPoint(21.0050, 105.8439));

const int deliveryFee = 16000;

 Widget noOrder(context) {
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