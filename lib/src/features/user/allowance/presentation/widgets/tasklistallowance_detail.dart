import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:page_transition/page_transition.dart';
import '../../data/models/listallowance.dart';
import '../bloc/allowance_bloc.dart';
import '../pages/allowance_add_list.dart';

class TaskListAllowanceDetail extends StatelessWidget {
  final AllowanceBloc allowanceBloc;
  final ListAllowance listallowance;
  final int index;
  const TaskListAllowanceDetail({
    super.key,
    required this.listallowance,
    required this.allowanceBloc,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
            borderRadius: BorderRadius.circular(20),
            icon: IconaMoon.edit,
            onPressed: (_) async {
              Navigator.push(
                context,
                PageTransition(
                  duration: Durations.medium1,
                  type: PageTransitionType.rightToLeft,
                  child: AllowanceAddList(
                    allowanceBloc: allowanceBloc,
                    listallowance: listallowance,
                  ),
                ),
              );
            },
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
            flex: 2),
        SlidableAction(
            borderRadius: BorderRadius.circular(20),
            icon: Icons.delete_rounded,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            onPressed: (_) {
              allowanceBloc.add(DeleteListAllowanceEvent(
                index: index,
                id: listallowance.idExpenseAllowanceItem,
              ));
              allowanceBloc.add(CalculateSumEvent());
            },
            flex: 2),
      ]),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          surfaceTintColor: const Color.fromARGB(255, 255, 218, 218),
          shadowColor: const Color.fromARGB(255, 249, 90, 167),
          elevation: 8,
          color: const Color(0xffff99ca),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('รายละเอียด: ',
                          style: TextStyle(
                              // color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const Gap(5),
                      Text(listallowance.description),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      // height: 50,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xfffc466b).withOpacity(0.5),
                              offset: const Offset(5, 5),
                              blurRadius: 10,
                            )
                          ],
                          gradient: const SweepGradient(
                            colors: [Color(0xfffc466b), Color(0xff3f5efb)],
                            stops: [0.25, 0.75],
                            center: Alignment.topRight,
                          ),
                          color: Colors.white,
                          // border:
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Start Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text(' ${listallowance.startDate}',
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const Icon(IconaMoon.arrowRight1),
                        Text(
                            '${(listallowance.countDays).toStringAsFixed(2)} วัน')
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xfffc466b).withOpacity(0.5),
                              offset: const Offset(5, 5),
                              blurRadius: 10,
                            )
                          ],
                          gradient: const SweepGradient(
                            colors: [Color(0xfffc466b), Color(0xff3f5efb)],
                            stops: [0.25, 0.75],
                            center: Alignment.topRight,
                          ),
                          color: Colors.white,
                          // border:
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('End Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text(listallowance.endDate,
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                ),
                const Gap(5),
              ],
            ),
          ),
          // subtitle:
          // Add more details as needed
        ),
      ),
    );
  }
}
