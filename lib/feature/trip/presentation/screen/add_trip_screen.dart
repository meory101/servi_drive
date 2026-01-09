import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servi_drive/core/helper/date_time_helper.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/container/drag_container.dart';
import 'package:servi_drive/core/widget/snack_bar/note_message.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../domain/entity/request/new_trip_request_entity.dart';
import '../dialog/show_desc_budget_dialog.dart';
import '../widget/new_trip_button.dart';
import '../widget/new_trip_form_fields.dart';
import '../widget/new_trip_map.dart';
import '../widget/prefered_conditions_list_view.dart';

class AddTripScreen extends StatefulWidget {
  const AddTripScreen({super.key});

  @override
  State<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  TextEditingController travellers = TextEditingController();
  TextEditingController luggage = TextEditingController();
  int travellerCount = 1;
  int luggageCount = 0;
  bool fast = false;

  @override
  void initState() {
    TripRequestHelper.entity.conditions = [];
    TripRequestHelper.entity.luggageCount = 0;
    TripRequestHelper.entity.numberOfTravelers = 1;
    travellers.text = travellerCount.toString();
    luggage.text = luggageCount.toString();

    super.initState();
  }

  bool validateRequiredFields() {
    final entity = TripRequestHelper.entity;
    
    if (entity.routeId == null || entity.routeId!.isEmpty) {
      NoteMessage.showErrorSnackBar(
        context: context, 
        text: "Please select a trip route"
      );
      return false;
    }
    
    if (entity.tripDate == null || entity.tripDate!.isEmpty) {
      NoteMessage.showErrorSnackBar(
        context: context, 
        text: "Please select a trip date"
      );
      return false;
    }
    
    if (entity.tripTime == null || entity.tripTime!.isEmpty) {
      NoteMessage.showErrorSnackBar(
        context: context, 
        text: "Please select a trip time"
      );
      return false;
    }
    
    if (entity.numberOfTravelers == null || entity.numberOfTravelers! < 1) {
      NoteMessage.showErrorSnackBar(
        context: context, 
        text: "Please select number of travelers"
      );
      return false;
    }
    
    // Validate location coordinates
    if (entity.fromLat == null || entity.fromLng == null) {
      NoteMessage.showErrorSnackBar(
        context: context, 
        text: "Please select a starting location on the map"
      );
      return false;
    }
    
    if (entity.toLat == null || entity.toLng == null) {
      NoteMessage.showErrorSnackBar(
        context: context, 
        text: "Please select a destination location on the map"
      );
      return false;
    }
    
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: AppHeightManager.h100,
            width: AppWidthManager.w100,
            child: NewTripMap(
              onFromLocationChanged: (LatLng latLng) {
                TripRequestHelper.entity.fromLat = latLng.latitude;
                TripRequestHelper.entity.fromLng = latLng.longitude;
                print('From Location: ${latLng.latitude}, ${latLng.longitude}');
              },
              onToLocationChanged: (LatLng latLng) {
                TripRequestHelper.entity.toLat = latLng.latitude;
                TripRequestHelper.entity.toLng = latLng.longitude;
                print('To Location: ${latLng.latitude}, ${latLng.longitude}');
              },
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.1,
            maxChildSize: 0.9,
            snapAnimationDuration: Duration(seconds: 3),
            builder: (context, scrollController) {
              return Container(
                  decoration: BoxDecoration(
                      color: AppColorManager.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppRadiusManager.r20),
                        topRight: Radius.circular(AppRadiusManager.r20),
                      )),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    controller: scrollController,
                    child: Column(
                      children: [
                        SizedBox(
                          height: AppHeightManager.h1point8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DragContainer(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                setState(() {
                                  fast = !fast;
                                });
                              },
                              icon: Icon(
                                Icons.speed_sharp,
                                color: fast == true
                                    ? AppColorManager.grey
                                    : AppColorManager.darkMainColor,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppWidthManager.w3Point8),
                          child: NewTripFormFields(
                            travellers: travellers,
                            fast: fast,
                            luggage: luggage,
                            travellerCount: travellerCount,
                            luggageCount: luggageCount,
                            onTravellerCountChanged: (count) {
                              setState(() {
                                travellerCount = count;
                                travellers.text = travellerCount.toString();
                                TripRequestHelper.entity.numberOfTravelers =
                                    travellerCount;
                              });
                            },
                            onLuggageCountChanged: (count) {
                              setState(() {
                                luggageCount = count;
                                luggage.text = luggageCount.toString();
                                TripRequestHelper.entity.luggageCount =
                                    luggageCount;
                              });
                            },
                            onDateChanged: (date) {
                              TripRequestHelper.entity.tripDate =
                                 date.toIso8601String();
                            },
                            onTimeChanged: (time) {
                              print(time);
                              print('------------------');
                              TripRequestHelper.entity.tripTime =
                                  DateTimeHelper.formatTimeOfDayTo24Hour(time);
                            },
                          ),
                        ),
                        Visibility(
                          visible: fast == false,
                          child: SizedBox(
                            height: AppHeightManager.h1point8,
                          ),
                        ),
                        Visibility(
                          visible: fast == false,
                          child: PreferredConditionsListView(),
                        ),
                        SizedBox(
                          height: AppHeightManager.h3,
                        ),
                        NewTripButton(
                          onValidationPassed: () {
                            if (validateRequiredFields()) {
                              showDescBudgetDialog(context: context);
                            }
                          },
                        ),
                        SizedBox(
                          height: AppHeightManager.h4,
                        ),
                      ],
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

abstract class TripRequestHelper {
  static NewTripRequestEntity entity = NewTripRequestEntity();
}
