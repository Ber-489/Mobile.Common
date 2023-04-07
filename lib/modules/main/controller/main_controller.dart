
import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/view/home_screen.dart';

class MainController extends GetxController{
   List<TabItem> itemsBottomBar = [
    const TabItem(
      icon: Icons.home,
      // title: 'Home',
    ),
    const TabItem(
      icon: Icons.message_outlined,
      // title: 'Shop',
    ),
    const TabItem(
      icon: Icons.person_outline_sharp,
      // title: 'Wishlist',
    ),
  ];

   RxInt indexBottomBar = 0.obs;
   Rx<Widget> mainWidget = Rx<Widget>(HomeScreen());


}