import 'package:drink_shop_flutter/controllers/auth/auth_controller.dart';
import 'package:drink_shop_flutter/controllers/item/item_controller.dart';
import 'package:drink_shop_flutter/models/category/item_of_category.dart';
import 'package:drink_shop_flutter/models/item/item_model.dart';
import 'package:drink_shop_flutter/models/item/product/product_model.dart';
import 'package:drink_shop_flutter/views/order/add_view.dart';
// import 'package:drink_shop_flutter/widgets/custom_app_bar.dart';
import 'package:drink_shop_flutter/widgets/drink_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key, required this.scaffoldKey});
  final AuthController authController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ItemController itemController = Get.find();
  @override
  Widget build(BuildContext context) {
    return _home(context, scaffoldKey);
  }

  Widget _home(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    return Obx(() {
      if (itemController.categoryList.isEmpty) {
        return const Center(
            child: SpinKitFadingCircle(
          color: Colors.blue, // Màu sắc của spinner
          size: 50.0,
        ));
      } else {
        List<Widget> category = [];
        List<Widget> pages = [];
        void buildCategoryTabsAndPages() {
          for (var element in itemController.categoryList) {
            category.add(
              Tab(
                child: tabCustom(text: element.categoryId),
              ),
            );
            pages.add(
              buildPage(element, context),
            );
          }
        }

        buildCategoryTabsAndPages();
        return DefaultTabController(
            length: itemController.categoryList.length,
            initialIndex: 0,
            child: Scaffold(
              
              appBar: AppBar(
                backgroundColor: const Color(0xFFEEDcC6),
                title: Text(
                  'Good day, ${authController.user.value.userName}',
                  style: const TextStyle(
                    color: Color(0xFF230C02),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed: () => scaffoldKey.currentState!.openDrawer(),
                ),
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
                bottom: TabBar(
                  isScrollable: true,
                  // indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xFF230C02),
                  indicator: BoxDecoration(
                    color: const Color(0xFF230C02),
                    borderRadius: BorderRadius.circular(68),
                  ),
                  tabAlignment: TabAlignment.start,
                  padding: const EdgeInsets.all(5.0),
                  tabs: category,
                ),
                elevation: 20,
                titleSpacing: 20,
              ),
              body: Center(
                child: TabBarView(
                  children: pages,
                ),
              ),
            ));
      }
    });
  }

  Widget buildPage(ItemOfCategory items, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF230C02)),
      child: AnimationLimiter(
          child: ListView.builder(
              scrollDirection:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? Axis.vertical
                      : Axis.horizontal,
              itemCount: items.listItem.length,
              itemBuilder: (BuildContext context, int index) {
                ItemModel item = itemController.itemList[items.listItem[index]];
                ProductModel product = itemController.products[item.productId];
                return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: Duration(milliseconds: 500 + index * 20),
                    child: SlideAnimation(
                      horizontalOffset: 400.0,
                      child: FadeInAnimation(
                          child: GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child: DrinkCard(
                              itemName: product.productName,
                              basePrice: product.price,
                              thumbnail: product.thumbnail!),
                        ),
                        onTap: () => Get.to(() => AddView(item: item)),
                      )),
                    ));
              })),
    );
  }

  Widget tabCustom({required String text}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 0.14,
          ),
        ),
      );
}
