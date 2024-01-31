import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:drink_shop_flutter/controllers/cart/cart_controller.dart';
import 'package:drink_shop_flutter/models/address/address.dart';
import 'package:drink_shop_flutter/models/location/location.dart';
import 'package:drink_shop_flutter/views/search/widgets/location_list_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' as get_x;
import 'package:get/get.dart';
import 'package:location/location.dart';

import '../../utils/constant.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<LocationRs> items = [];
  final CartController cartController = Get.find();
  final Location location = Location();

  final int _debounce = 500;
  Future<List<LocationRs>> addressSuggestion(String address) async {
    dio.Response response = await dio.Dio().get('https://photon.komoot.io/api/',
        queryParameters: {'q': address, 'limit': 5});
    final json = response.data;
    return (json["features"] as List)
        .map<LocationRs>((e) => LocationRs.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<LocationRs> getLocation(LocationData local) async {
    dio.Response response = await dio.Dio().get(
        'https://photon.komoot.io/reverse',
        queryParameters: {'lon': local.longitude, 'lat': local.latitude});
    final json = response.data["features"] as List;
    return LocationRs.fromMap(json[0] as Map<String, dynamic>);
  }
  void onSearchChanged(String value) async {
    if (value.isNotEmpty) {
      List<LocationRs> suggestions = await addressSuggestion(value);
      setState(() {
        items = suggestions;
      });
    } else {
      setState(() {
        items = [];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: defaultPadding),
          child: CircleAvatar(
            backgroundColor: secondaryColor10LightTheme,
            child: SvgPicture.asset(
              "assets/icons/location.svg",
              height: 16,
              width: 16,
              color: secondaryColor40LightTheme,
            ),
          ),
        ),
        title: const Text(
          "Set Delivery Location",
          style: TextStyle(color: textColorLightTheme),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: secondaryColor10LightTheme,
            child: IconButton(
              onPressed: () => get_x.Get.back(),
              icon: const Icon(Icons.close, color: Colors.black),
            ),
          ),
          const SizedBox(width: defaultPadding)
        ],
      ),
      body: Column(
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextFormField(
                onChanged: (value) => Timer(Duration(milliseconds: _debounce),
                    () => onSearchChanged(value)),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: "Search your location",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SvgPicture.asset(
                      "assets/icons/location_pin.svg",
                      color: secondaryColor40LightTheme,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: 4,
            thickness: 4,
            color: secondaryColor5LightTheme,
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ElevatedButton.icon(
              onPressed: () {
                location.getLocation().then((LocationData local) async {
                  LocationRs tmp = await getLocation(local);
                  cartController.updateAddress(Address(
                    address: tmp.getAddress(),
                    point: GeoPoint(tmp.geometry.coordinates[1],
                        tmp.geometry.coordinates[0]),
                  ));
                });
                Get.back();
              },
              icon: SvgPicture.asset(
                "assets/icons/location.svg",
                height: 16,
              ),
              label: const Text("Use my Current Location"),
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor10LightTheme,
                foregroundColor: textColorLightTheme,
                elevation: 0,
                fixedSize: const Size(double.infinity, 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          const Divider(
            height: 4,
            thickness: 4,
            color: secondaryColor5LightTheme,
          ),
          if (items.isNotEmpty)
            Column(
              children: items
                  .map((LocationRs location) => LocationListTile(
                        press: () {
                          // Handle the selected location
                          // For example, you can navigate to another screen
                          cartController.updateAddress(Address(
                              address: location.getAddress(),
                              point: GeoPoint(location.geometry.coordinates[1],
                                  location.geometry.coordinates[0])));
                          Get.back();
                        },
                        location: location.getAddress(),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
