


import 'package:flutter/material.dart';
import 'color_manager.dart';

abstract class EnumManager {
  static const String pendingTripCode = "1";
  static const String dealTripCode = "2";
  static const String canceledTripCode = "3";
  static const String doneTripCode = "4";
  static const String expiredTripCode = "5";

  static Color getTripStatusColor(String? statusCode) {
    switch (statusCode) {
      case pendingTripCode:
        return AppColorManager.orange;
      case dealTripCode:
        return AppColorManager.green;
      case canceledTripCode:
        return AppColorManager.red;
      case doneTripCode:
        return AppColorManager.blue;
      case expiredTripCode:
        return AppColorManager.grey;
      default:
        return AppColorManager.grey;
    }
  }

  static String getTripStatusText(String? statusCode) {
    switch (statusCode) {
      case pendingTripCode:
        return "Pending";
      case dealTripCode:
        return "Active";
      case canceledTripCode:
        return "Canceled";
      case doneTripCode:
        return "Done";
      case expiredTripCode:
        return "Expired";
      default:
        return "Unknown";
    }
  }
}


