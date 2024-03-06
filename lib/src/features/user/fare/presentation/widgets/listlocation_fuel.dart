import 'package:flutter/material.dart';

import '../../data/models/addlist_location_fuel.dart';
import '../bloc/fare_bloc.dart';
import 'tasklisl_locationfuel_detail.dart';

class ListLocationAndFuel extends StatelessWidget {
  final FareBloc fareBloc;
  final List<ListLocationandFuel> listlocationandfuel;
  const ListLocationAndFuel({
    super.key,
    required this.listlocationandfuel,
    required this.fareBloc,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        reverse: true,
        itemCount: listlocationandfuel.length,
        itemBuilder: (context, index) {
          final task = listlocationandfuel[index];
          return TaskListLocationFuelDetail(
            listlocationandfuel: task,
            fareBloc: fareBloc,
            index: index,
          );
        });
  }
}
