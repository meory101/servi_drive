import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/font_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import '../../../../../core/widget/button/main_app_button.dart';
import '../../../../../core/widget/form_field/title_app_form_filed.dart';
import '../../../../../core/widget/text/app_text_widget.dart';
import '../../../../../core/injection/injection_container.dart' as di;




void showDescBudgetDialog({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadiusManager.r20)),
        ),
        insetPadding: EdgeInsets.symmetric(
          horizontal: AppWidthManager.w4,
        ),
        elevation: 0,
        backgroundColor: AppColorManager.white,
        child: SizedBox(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppWidthManager.w3Point8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: AppHeightManager.h2point5,
                  ),
                  AppTextWidget(
                    text: "Confirm Trip".tr(),
                    fontWeight: FontWeight.w600,
                    fontSize: FontSizeManager.fs18,
                    overflow: TextOverflow.visible,
                    color: AppColorManager.darkMainColor,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: AppHeightManager.h04,
                  ),
                  AppTextWidget(
                    text: "Please Confirm The Trip To Continue".tr(),
                    fontWeight: FontWeight.w500,
                    fontSize: FontSizeManager.fs15,
                    color: AppColorManager.grey,
                    textAlign: TextAlign.center,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppHeightManager.h3,
                      ),
                      Row(children: [
                        Expanded(
                          flex: 2,

                          child: TitleAppFormFiled(
                            hint: "Do You Have Expected Price".tr(),
                            title: "Do You Have Expected Price".tr(),
                            textInputType: TextInputType.number,
                            onChanged: (value) {
                              return null;
                            },
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],),
                      SizedBox(height: AppHeightManager.h1point8,),
                      Row(children: [
                        Expanded(
                          flex: 2,
                          child: TitleAppFormFiled(
                            hint: "Description".tr(),
                            title: "Description".tr(),

                            multiLines: true,
                            onChanged: (value) {
                              return null;
                            },
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],),
                      SizedBox(height: AppHeightManager.h1point8,),

                      Row(
                        children: [
                          Expanded(
                            child: MainAppButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppWidthManager.w10),
                              borderRadius:
                                  BorderRadius.circular(AppRadiusManager.r15),
                              height: AppHeightManager.h6,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              alignment: Alignment.center,
                              child: AppTextWidget(
                                text: "cancel".tr(),
                                fontSize: FontSizeManager.fs16,
                                color: AppColorManager.lightMainColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: AppWidthManager.w1Point2,
                          ),
                          Expanded(
                              child: MainAppButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppWidthManager.w10),
                            borderRadius:
                                BorderRadius.circular(AppRadiusManager.r15),
                            height: AppHeightManager.h6,
                            onTap: () {},
                            outLinedBorde: true,
                            borderColor: AppColorManager.mainColor,
                            alignment: Alignment.center,
                            child: AppTextWidget(
                              text: "Confirm".tr(),
                              fontSize: FontSizeManager.fs16,
                              color: AppColorManager.mainColor,
                            ),
                          )),
                          SizedBox(
                            height: AppHeightManager.h2point5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
