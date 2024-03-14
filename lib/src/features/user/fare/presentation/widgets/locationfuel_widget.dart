import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uni_expense/src/features/user/fare/presentation/bloc/fare_bloc.dart';

// import '../../data/models/addlist_location_fuel.dart';
// import '../../data/models/addlist_location_fuel.dart';
import '../pages/fare_add_list_location.dart';
import 'listlocation_fuel.dart';

class LocationFuelWidget extends StatefulWidget {
  final FareBloc fareBloc;
  final bool isdraft;
  const LocationFuelWidget({
    super.key,
    required this.fareBloc,
    required this.isdraft,
  });

  @override
  State<LocationFuelWidget> createState() => _LocationFuelWidgetState();
}

class _LocationFuelWidgetState extends State<LocationFuelWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'รายการสถานที่',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30.0),
              onTap: () {
                Navigator.push(
                  (context),
                  PageTransition(
                    duration: Durations.medium1,
                    type: PageTransitionType.rightToLeft,
                    child: FareAddListLocation(
                        fareBloc: widget.fareBloc, isdraft: widget.isdraft),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffff99ca),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).devicePixelRatio * 7,
                    vertical: MediaQuery.of(context).devicePixelRatio * 2.5),
                child: Text(
                  '+ เพิ่มรายการ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const Gap(10),
        BlocBuilder<FareBloc, FareState>(
          builder: (context, state) {
            // print("showlist");
            // print(state);
            final listlocationfuel = state.listlocationandfuel;
            if (state.listlocationandfuel.isNotEmpty) {
              return ListLocationAndFuel(
                listlocationandfuel: listlocationfuel,
                fareBloc: widget.fareBloc,
              );
            }
            return Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).devicePixelRatio * 1,
                  bottom: MediaQuery.of(context).devicePixelRatio * 1),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                alignment: AlignmentDirectional.center,
                width: double.infinity,
                // color: Colors.red,
                child: const Text(
                  'ยังไม่มีรายการ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
              ),
            );
          },
        ),
        const Gap(10),
        Divider(
          color: Colors.grey.shade300,
          height: 1,
        ),
      ],
    );
  }
}
