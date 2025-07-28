import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper/language_helper.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../../../../core/widget/image/main_image_widget.dart';

///
/// created by eng nour othman ***
/// at 8/4/2025
///

class HomeBanners extends StatefulWidget {
  const HomeBanners({super.key});

  @override
  State<HomeBanners> createState() => _HomeBannersState();
}

class _HomeBannersState extends State<HomeBanners> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  aspectRatio: AppWidthManager.w78 / AppHeightManager.h17,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  viewportFraction: 0.8,
                  autoPlayAnimationDuration: Duration(milliseconds: 500),
                  enlargeCenterPage: true,
                ),
                items: List.generate(
                  2,
                  (index) {
                    return InkWell(
                      onTap: () {

                      },
                      child: Container(
                        width: AppWidthManager.w92,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppRadiusManager.r10)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: MainImageWidget(
                          fit: BoxFit.fill,
                          imageUrl:"..",
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: AppHeightManager.h1point8,
              ),
              Visibility(
                // visible:3,
                child: DotsIndicator(
                  dotsCount:3,
                  position: double.parse(selectedIndex.toString()),
                  decorator: DotsDecorator(
                    spacing: EdgeInsets.only(
                        left: LanguageHelper.checkIfLTR(context: context)
                            ? AppWidthManager.w1Point8
                            : 0,
                        right: !LanguageHelper.checkIfLTR(context: context)
                            ? AppWidthManager.w1Point8
                            : 0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppRadiusManager.r10,
                      ),
                    ),
                    activeSize: Size(
                      AppWidthManager.w6,
                      AppHeightManager.h08,
                    ),
                    size: Size(
                      AppWidthManager.w1Point5,
                      AppWidthManager.w1Point5,
                    ),
                    activeColor: AppColorManager.mainColor,
                    color: AppColorManager.dotGrey,
                  ),
                ),
              ),
            ],



    );
  }
}
