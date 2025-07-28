import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helper/language_helper.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/icon_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/text/app_text_widget.dart';

class PreferredConditionsListView extends StatefulWidget {
  const PreferredConditionsListView({super.key});

  @override
  State<PreferredConditionsListView> createState() => _PreferredConditionsListViewState();
}

class _PreferredConditionsListViewState extends State<PreferredConditionsListView> {
  List<int> selectedFeatures = [];

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: AppHeightManager.h10,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          bool isSelected =
          selectedFeatures.contains(index);
          return InkWell(
            onTap: () {
              setState(() {
                if (isSelected) {
                  selectedFeatures.remove(index);
                } else {
                  selectedFeatures.add(index);
                }
              });
            },
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: index == 0
                          ? AppWidthManager.w3Point8
                          : !LanguageHelper.checkIfLTR(
                          context: context)
                          ? AppWidthManager.w2
                          : 0,
                      right: index == 0
                          ? AppWidthManager.w2
                          : LanguageHelper.checkIfLTR(
                          context: context)
                          ? AppWidthManager.w2
                          : 0),
                  width: AppWidthManager.w30,
                  decoration: BoxDecoration(
                      color: selectedFeatures
                          .contains(index)
                          ? AppColorManager.lightMainColor
                          .withAlpha(30)
                          : AppColorManager.background,
                      borderRadius: BorderRadius.circular(
                          AppRadiusManager.r10),
                      border: Border.all(
                          color: isSelected == true
                              ? AppColorManager.background
                              : AppColorManager
                              .darkMainColor,
                          width: 1.3)),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: AppHeightManager.h2point5,
                          width: AppHeightManager.h2point5,
                          child: SvgPicture.asset(
                              AppIconManager.noSmoke)),
                      SizedBox(
                        height: AppHeightManager.h04,
                      ),
                      AppTextWidget(
                        text: "No Smoking",
                        color:
                        AppColorManager.darkMainColor,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
