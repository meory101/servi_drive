import 'package:flutter/cupertino.dart';
import '../../resource/size_manager.dart';

///
/// created by eng nour othman ***
/// at 10/2/2025
///

class DotContainer extends StatelessWidget {
  final Color color;
  const DotContainer({super.key,required this.color});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: AppWidthManager.w1Point8,
      height: AppWidthManager.w1Point8,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:color
      ),

    );
  }
}
