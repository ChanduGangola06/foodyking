import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodyking/app/controllers/home_controller.dart';
import 'package:foodyking/app/modules/home/widgets/home_menu_section.dart';
import 'package:foodyking/utils/constant.dart';
import 'package:foodyking/utils/style.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widget/shimmer/menu_section_shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    Get.find<HomeController>().getBranchList();
    Get.find<HomeController>().getCategoryList();
    Get.find<HomeController>().getPopularItemDataList();
    Get.find<HomeController>().getFeaturedItemDataList();
    //Get.find<OfferController>().getOfferList();
    if (box.read('isLogedIn') == true) {
      Get.find<HomeController>().getActiveOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeController>(builder: (homeController) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leadingWidth: 100.w,
                leading: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Image.asset(
                    Images.logo,
                    width: 85.w,
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Row(
                      children: [
                        homeController.loader
                            ? Shimmer.fromColors(
                                child: Container(
                                  height: 40.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: Colors.white,
                                  ),
                                ),
                                baseColor: Colors.grey[200]!,
                                highlightColor: Colors.grey[300]!,
                              )
                            : homeController.branchDataList.length != 1
                                ? SizedBox(
                                    height: 50.h,
                                    width: 120.w,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Text(
                                          'SELECT_BRANCH'.tr,
                                          style: fontRegular,
                                        ),
                                        // hint: SvgPicture.asset(
                                        //   Images.iconBranch,
                                        //   fit: BoxFit.cover,
                                        //   // ignore: deprecated_member_use
                                        //   color: AppColor.primaryColor,
                                        //   height: 25.h,
                                        //   width: 25.w,
                                        // ),
                                        // iconSize: 20.sp,
                                        // buttonHeight: 50.h,
                                        // dropdownDecoration: BoxDecoration(
                                        //   borderRadius:
                                        //       BorderRadius.circular(15.r),
                                        // ),
                                        items: homeController.branchDataList
                                            .map((item) {
                                          return DropdownMenuItem<String>(
                                            value: item.name.toString(),
                                            child: Text(
                                              item.name.toString(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        value: homeController.selectedBranch,
                                        onChanged: (value) {
                                          homeController.selectedBranch =
                                              value.toString();
                                          homeController.setIndexOfBranch();
                                          (context as Element).markNeedsBuild();
                                        },
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                      ],
                    ),
                  ),
                ],
                centerTitle: false,
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              body: GetBuilder<HomeController>(
                builder: (homeController) {
                  return Stack(
                    children: [
                      Padding(
                        padding: homeController.activeOrderData.isEmpty ||
                                box.read('isLogedIn') == false
                            ? EdgeInsets.only(left: 16.h, right: 16.h)
                            : EdgeInsets.only(
                                left: 16.h, right: 16.h, bottom: 100.h),
                        child: Column(
                          children: [
                            SizedBox(
                              child: homeController.loader
                                  ? Shimmer.fromColors(
                                      child: Container(
                                        height: 52.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          color: Colors.white,
                                        ),
                                      ),
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.grey[300]!,
                                    )
                                  : SizedBox(
                                      child: TextField(
                                        showCursor: true,
                                        readOnly: true,
                                        onTap: () {
                                          //Get.to(() => const SearchView());
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 0.w, vertical: 0.h),
                                          hintText: "SEARCH".tr,
                                          hintStyle: const TextStyle(
                                              color: AppColor.gray),
                                          prefixIcon: SizedBox(
                                            child: Padding(
                                              padding: EdgeInsets.all(12.r),
                                              child: SvgPicture.asset(
                                                Images.iconSearch,
                                                fit: BoxFit.cover,
                                                color: AppColor.gray,
                                                height: 16.h,
                                                width: 16.w,
                                              ),
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: AppColor.itembg,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r)),
                                            borderSide: BorderSide(
                                                color: AppColor.itembg,
                                                width: 1.w),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r)),
                                            borderSide: BorderSide(
                                                width: 0.w,
                                                color: AppColor.itembg),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(height: 14.h),
                            RefreshIndicator(
                              color: AppColor.primaryColor,
                              onRefresh: () async {
                                homeController.getBranchList();
                                homeController.getCategoryList();
                                homeController.getFeaturedItemDataList();
                                homeController.getPopularItemDataList();
                                if (box.read('isLogedIn') == true) {
                                  homeController.getActiveOrderList();
                                }
                              },
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                primary: false,
                                scrollDirection: Axis.vertical,
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        // Menu Section
                                        homeController.menuLoader ||
                                                homeController
                                                    .categoryDataList.isEmpty
                                            ? const MenuSectionShimmer()
                                            : homeMenuSection(),
                                        // homeController.featuredLoader ||
                                        //         homeController
                                        //             .featuredItemDataList
                                        //             .isEmpty
                                        //     ? featureditemSectionShimmer()
                                        //     : featureditemSection(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
