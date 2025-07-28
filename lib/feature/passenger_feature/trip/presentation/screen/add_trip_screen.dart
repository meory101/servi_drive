import 'package:flutter/material.dart';
import 'package:servi_drive/core/resource/size_manager.dart';
import 'package:servi_drive/core/widget/container/drag_container.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/widget/new_trip_button.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/widget/new_trip_form_fields.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/widget/new_trip_map.dart';
import 'package:servi_drive/feature/passenger_feature/trip/presentation/widget/prefered_conditions_list_view.dart';

import '../../../../../core/resource/color_manager.dart';

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
    travellers.text = travellerCount.toString();
    luggage.text = luggageCount.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: AppHeightManager.h100,
            width: AppWidthManager.w100,
            child: NewTripMap(),
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
                              });
                            },
                            onLuggageCountChanged: (count) {
                              setState(() {
                                luggageCount = count;
                                luggage.text = luggageCount.toString();
                              });
                            },
                            onDateChanged: (date) {
                              // handle date
                            },
                            onTimeChanged: (time) {
                              // handle time
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
                        NewTripButton(),
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
