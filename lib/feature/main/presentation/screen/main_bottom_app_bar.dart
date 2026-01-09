import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servi_drive/core/resource/icon_manager.dart';
import 'package:servi_drive/core/resource/size_manager.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/widget/text/app_text_widget.dart';
import '../../../home/presentation/screen/home_screen.dart';
import '../../../more/presentation/screen/more_screen.dart';
import '../../../trip/presentation/screen/add_trip_screen.dart';

///
/// created by eng nour othman ***
/// at 18/7/2025
///
int currentIndex = 1;

class MainAppBottomAppBar extends StatefulWidget {
  const MainAppBottomAppBar({super.key});

  @override
  State<MainAppBottomAppBar> createState() => _MainAppBottomAppBarState();
}

class _MainAppBottomAppBarState extends State<MainAppBottomAppBar> {

  final List<Widget> screens = [
    HomeScreen(),
    AddTripScreen(),
    MoreScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  final iconList = <String>[
    AppIconManager.home,
    AppIconManager.person,
  ];

  final labelList = <String>[
    'home'.tr(),
    'more'.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: screens[currentIndex],
      ),
      floatingActionButton: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: AppColorManager.white)),
        child: FloatingActionButton(
          backgroundColor: AppColorManager.lightMainColor,
          shape: const CircleBorder(),
          onPressed: () {
            setState(() {
              currentIndex = 1;
            });
          },
          child: SizedBox(
            height: AppHeightManager.h3Point5,
            width: AppHeightManager.h3Point5,
            child: SvgPicture.asset(
              AppIconManager.add,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        leftCornerRadius: AppRadiusManager.r10,
        splashColor: AppColorManager.transparent,
        rightCornerRadius: AppRadiusManager.r10,
        backgroundGradient: LinearGradient(colors: [
          AppColorManager.darkMainColor,
          AppColorManager.darkMainColor,
          AppColorManager.darkMainColor,
        ]),
        itemCount: iconList.length,
        height: AppHeightManager.h9,
        activeIndex: currentIndex < 1
            ? 0
            : currentIndex > 1
                ? 1
                : -1,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        tabBuilder: (index, isActive) {
          final actualIndex = index == 0 ? 0 : 2;
          final color = currentIndex == actualIndex
              ? AppColorManager.white
              : AppColorManager.grey;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconList[index],
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              const SizedBox(height: 4),
              AppTextWidget(
                text: labelList[index],
                color: color,
              ),
            ],
          );
        },
        onTap: (index) {
          final newIndex = index == 0 ? 0 : 2;
          setState(() {
            currentIndex = newIndex;
          });
        },
      ),
    );
  }
}
