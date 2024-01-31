import 'package:drink_shop_flutter/controllers/auth/auth_controller.dart';
import 'package:drink_shop_flutter/controllers/order/order_controller.dart';
import 'package:drink_shop_flutter/views/cart/cart_view.dart';
import 'package:drink_shop_flutter/views/history%20order/history_view.dart';
import 'package:drink_shop_flutter/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class BaseView extends StatefulWidget {
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  final AuthController authController = Get.find();
  final OrderController orderController = Get.put(OrderController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final Location location = Location();
  Future<void> getPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  var screens = [];
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
    screens = [
      HomeView(scaffoldKey: scaffoldKey),
      const HistoryView(),
      const CartView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              )),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 35.0,
                      backgroundImage:
                          AssetImage('assets/images/user_profile.png'),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(authController.user.value.userName!,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 30.0))
                  ],
                ),
              ),
            ),
            const ListTile(
              title: Text("Setting"),
              leading: Icon(Icons.settings),
            ),
            const Divider(
              height: 0.2,
            ),
            const ListTile(
              title: Text("Profile"),
              leading: Icon(Icons.account_circle),
            ),
            const Divider(
              height: 0.2,
            ),
            ListTile(
              title: const Text("Logout"),
              leading: const Icon(Icons.logout_rounded),
              onTap: () => authController.logout(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
          indicatorColor: Colors.green,
          height: 80.0,
          elevation: 0,
          selectedIndex: index,
          onDestinationSelected: (int i) => setState(() {
                index = i;
              }),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.history_outlined), label: 'History'),
            NavigationDestination(
                icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          ]),
      body: screens[index],
    );
  }
}
