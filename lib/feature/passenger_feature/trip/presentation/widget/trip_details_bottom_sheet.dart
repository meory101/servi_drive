import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servi_drive/core/model/trip_data.dart';
import 'package:servi_drive/core/resource/enum_manager.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/widget/pending_trip_actions.dart';

import 'deal_trip_actions.dart';

class TripDetailsBottomSheet extends StatelessWidget {
  final TripData tripData;

  const TripDetailsBottomSheet({super.key, required this.tripData});

  @override
  Widget build(BuildContext context) {

    return tripData.status == EnumManager.pendingTripCode
        ? PendingTripActions(
      tripData: tripData,
    )
        :  tripData.status == EnumManager.dealTripCode
            ? DealTripActions(
                tripData:  tripData,
              )
            : Row(
                children: [],
              );
  }
}
