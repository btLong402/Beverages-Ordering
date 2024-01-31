import 'package:drink_shop_shipper/controllers/auth/auth_controller.dart';
import 'package:drink_shop_shipper/views/finished/finished_view.dart';
import 'package:drink_shop_shipper/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseView extends StatefulWidget {
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  final AuthController authController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int index = 0;
  List<dynamic> screens = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    screens = [
      HomeView(scaffoldKey: scaffoldKey),
      FinishedView(scaffoldKey: scaffoldKey)
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
                    Text(authController.user.value.shipperName!,
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
      body: screens[index],
      bottomNavigationBar: NavigationBar(
          indicatorColor: Colors.green,
          animationDuration: const Duration(milliseconds: 500),
          height: 80.0,
          elevation: 0,
          selectedIndex: index,
          onDestinationSelected: (int i) => setState(() {
                index = i;
              }),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.done), label: 'Finished'),
          ]),
    );
  }
}
