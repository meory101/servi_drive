import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servi_drive/core/resource/enum_manager.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/widget/pending_trip_actions.dart';

import 'deal_trip_actions.dart';

class TripDetailsBottomSheet extends StatelessWidget {
  final String tripCode;

  const TripDetailsBottomSheet({super.key, required this.tripCode});

  @override
  Widget build(BuildContext context) {
    return tripCode == EnumManager.pendingTripCode
        ? PendingTripActions()
        : tripCode == EnumManager.dealTripCode
            ? DealTripActions()
            : Row(
                children: [],
              );
  }
}
