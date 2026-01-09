import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servi_drive/core/storage/shared/shared_pref.dart';
import 'package:servi_drive/router/router.dart';

import '../../../core/helper/app_info_helper.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/constant_manager.dart';
import '../../../core/resource/image_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/loading/app_circular_progress_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigateToNextPage() async {
    Future.delayed(const Duration(seconds: 4), () async {

      if(AppSharedPreferences.getToken().isEmpty)
{      Navigator.of(context).pushReplacementNamed(RouteNamedScreens.login);
return;

}
      Navigator.of(context).pushNamedAndRemoveUntil(RouteNamedScreens.main,(route) => false,);

    });
  }
  @override
  void initState() {
    navigateToNextPage()
    ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  SafeArea(
       top: false,
      bottom: true,
      child: Scaffold(
                body: Container(
                  height: AppHeightManager.h100,
                  width: AppWidthManager.w100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppImageManager.splash)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppTextWidget(
                        text:  "V ${AppInfoHelper.getAppVersion()}",
                        color: AppColorManager.mainColor,
                      ),
                      SizedBox(
                        height: AppHeightManager.h1point8,
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: AppWidthManager.w5),
                        child: SizedBox(
                          height: AppHeightManager.h2,
                          width: AppHeightManager.h2,
                          child: const AppCircularProgressWidget(),
                        ),
                      ),
                      SizedBox(
                        height: AppHeightManager.h5,
                      ),
                    ],
                  ),
                ),




      ),
    );
  }
}
