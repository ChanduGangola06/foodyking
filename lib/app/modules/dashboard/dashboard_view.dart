import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodyking/app/controllers/cart_controller.dart';
import 'package:foodyking/app/modules/cart/cart_view.dart';
import 'package:foodyking/app/modules/dashboard/widgets/nav_bar_item.dart';
import 'package:foodyking/app/modules/home/home_view.dart';
import 'package:foodyking/app/modules/menu/menu_view.dart';
import 'package:foodyking/app/modules/offer/offer_view.dart';
import 'package:foodyking/app/modules/profile/profile_view.dart';
import 'package:foodyking/utils/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final box = GetStorage();
  PageController? pageController;
  int pageIndex = 0;
  List<Widget>? screens;
  GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey();
  bool canExit = false;

  @override
  void initState() {
    super.initState();
    pageIndex = 0;
    pageController = PageController(initialPage: 0);
    screens = const [
      HomeView(),
      MenuView(),
      CartView(),
      OfferView(),
      ProfileView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if (canExit) {
            _setPage(0);
            return true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('PRESS_BACK_AGAIN_TO_EXIT'.tr,
                    style: const TextStyle(color: Colors.white)),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColor.primaryColor,
                duration: const Duration(seconds: 2),
                margin: const EdgeInsets.all(10),
              ),
            );
            canExit = true;
            Timer(const Duration(seconds: 2), () {
              canExit = false;
            });
            return false;
          }
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor.withOpacity(0.3),
                offset: const Offset(
                  0.0,
                  5.0,
                ),
                blurRadius: 10.r,
                spreadRadius: 2.r,
              ), //BoxShadow
              //BoxShadow
            ],
          ),
          child: FloatingActionButton(
            onPressed: () {
              _setPage(2);
            },
            child: Stack(
              children: [
                SizedBox(
                  height: 60.h,
                  width: 60.w,
                  child: CircleAvatar(
                    backgroundColor: AppColor.primaryColor,
                    child: ImageIcon(
                      AssetImage(Images.cart),
                      color: Colors.white,
                      size: 30.sp,
                    ),
                  ),
                ),
                // cartController.cart.isNotEmpty
                //     ?
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: SizedBox(
                    child: ImageIcon(
                      AssetImage(Images.cartHasItem),
                      color: Colors.yellow,
                      size: 12.sp,
                    ),
                  ),
                )
                // : const SizedBox(),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          elevation: 5,
          notchMargin: 5,
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          child: Row(
            children: [
              BottomNavItem(
                tittle: "HOME".tr,
                imageData: AssetImage(Images.home),
                isSelected: pageIndex == 0,
                onTap: () => _setPage(0),
              ),
              BottomNavItem(
                tittle: "MENU".tr,
                imageData: AssetImage(Images.menu),
                isSelected: pageIndex == 1,
                onTap: () => _setPage(1),
              ),
              const Expanded(child: SizedBox()),
              BottomNavItem(
                tittle: "OFFERS".tr,
                imageData: AssetImage(Images.offer),
                isSelected: pageIndex == 3,
                onTap: () => _setPage(3),
              ),
              BottomNavItem(
                tittle: "PROFILE".tr,
                imageData: AssetImage(Images.profile_circle),
                isSelected: pageIndex == 4,
                onTap: () {
                  _setPage(4);
                },
              ),
            ],
          ),
        ),
        body: PageView.builder(
          controller: pageController,
          itemCount: screens!.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return screens![index];
          },
        ),
      ),
    );
  }

  void _setPage(int index) {
    setState(() {
      pageController?.jumpToPage(index);
      pageIndex = index;
    });
  }
}
