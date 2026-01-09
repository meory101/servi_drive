import 'package:flutter/material.dart';
import 'package:servi_drive/core/resource/color_manager.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/container/shimmer_container.dart';

class EditProfileShimmer extends StatelessWidget {
  const EditProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppWidthManager.w3Point8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppHeightManager.h4),

            _buildFormFieldShimmer(),
            SizedBox(height: AppHeightManager.h1point8),
            _buildFormFieldShimmer(),
            SizedBox(height: AppHeightManager.h1point8),
            _buildFormFieldShimmer(),
            SizedBox(height: AppHeightManager.h1point8),
            _buildFormFieldShimmer(),
            SizedBox(height: AppHeightManager.h4),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFieldShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Field title shimmer
        ShimmerContainer(
          width: AppWidthManager.w20,
          height: AppHeightManager.h1point8,
        ),
        SizedBox(height: AppHeightManager.h06),
        // Field input shimmer
        ShimmerContainer(
          width: AppWidthManager.w100,
          height: AppHeightManager.h6,
        ),
      ],
    );
  }
} 