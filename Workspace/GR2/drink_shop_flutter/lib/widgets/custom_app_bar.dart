import 'package:flutter/material.dart';

AppBar appBar() {
  return AppBar(
    backgroundColor: const Color(0xFFEEDcC6),
    title: const Text(
      'Good day, Long',
      style: TextStyle(
        color: Color(0xFF230C02),
        fontSize: 16,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        height: 0,
      ),
    ),
    // leading: IconButton(
    //   icon: const Icon(
    //     Icons.menu,
    //     color: Colors.black,
    //   ),
    //   // onPressed: () => scaffoldKey.currentState!.openDrawer(),
    // ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none,
            color: Colors.black,
          )),
      IconButton(
        icon: const Icon(
          Icons.search,
          size: 24,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    ],
    // bottom: TabBar(
    //   isScrollable: true,
    //   // indicatorColor: Colors.white,
    //   labelColor: Colors.white,
    //   unselectedLabelColor: const Color(0xFF230C02),
    //   indicator: BoxDecoration(
    //     color: const Color(0xFF230C02),
    //     borderRadius: BorderRadius.circular(68),
    //   ),
    //   tabAlignment: TabAlignment.start,
    //   // padding: const EdgeInsets.all(5.0), tabs: [],
    //   // tabs: category,
    // ),
    elevation: 20,
    titleSpacing: 20,
  );
}
