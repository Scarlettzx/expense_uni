import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

// import '../../../../../../injection_container.dart';
import '../../data/models/addlist_location_fuel.dart';
import '../bloc/fare_bloc.dart';
import '../pages/fare_add_list_location.dart';

class TaskListLocationFuelDetail extends StatelessWidget {
  final ListLocationandFuel listlocationandfuel;
  final FareBloc fareBloc;
  final int index;
  const TaskListLocationFuelDetail({
    super.key,
    required this.listlocationandfuel,
    required this.fareBloc,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
            borderRadius: BorderRadius.circular(20),
            icon: IconaMoon.edit,
            onPressed: (_) {
              Navigator.push(
                (context),
                PageTransition(
                  duration: Durations.medium1,
                  type: PageTransitionType.rightToLeft,
                  child: FareAddListLocation(
                    fareBloc: fareBloc,
                    listlocationandfuel: listlocationandfuel,
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
              print(index);
              fareBloc.add(
                DeleteListLocationAndFuelEvent(
                  index: index,
                  id: listlocationandfuel.id,
                ),
              );
            },
            flex: 2),
      ]),
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 252, 117, 182),
                offset: Offset(0, 10),
                blurRadius: 5,
                spreadRadius: 3,
              )
            ],
            gradient: const RadialGradient(
              colors: [
                Color.fromARGB(255, 252, 117, 182),
                Color.fromARGB(255, 255, 110, 180)
              ],
              focal: Alignment.topCenter,
              radius: .85,
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            // color: Colors.amber,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('วันที่: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const Gap(5),
                    Text(
                      listlocationandfuel.date,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 255, 48, 148),
                      ),
                      child: const Text('จุดเริ่มต้น:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Text(listlocationandfuel.startLocation,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 255, 48, 148),
                      ),
                      child: const Text('ปลายทาง:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Text(listlocationandfuel.stopLocation,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'เลขไมล์เริ่มต้น: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(5),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            width: double.infinity,
                            height: 40,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                NumberFormat("###,###", "en_US")
                                    .format(listlocationandfuel.startMile),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 55,
                      // color: Colors.amber,
                      child: const Icon(
                        Icons.arrow_drop_down_circle,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'เลขไมล์สิ้นสุด: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(5),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            width: double.infinity,
                            height: 40,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                NumberFormat("###,###", "en_US")
                                    .format(listlocationandfuel.stopMile),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                Container(
                  width: double.infinity,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.car_rental),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("ระยะทางรวม (กม.): "),
                            Text(
                              NumberFormat("###,###", "en_US")
                                  .format(listlocationandfuel.total),
                              style: const TextStyle(
                                color: Colors.pink,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const Gap(10),
                Container(
                  width: double.infinity,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.car_rental),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('ใช้ส่วนตัว (กม.): '),
                            Text(
                              NumberFormat("###,###", "en_US")
                                  .format(listlocationandfuel.personal),
                              style: const TextStyle(
                                color: Colors.pink,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     const Text('ระยะทางรวม (กม.): ',
                //         style: TextStyle(
                //             // color: Colors.white,
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold)),
                //     Gap(5),
                //     Text(NumberFormat("###,###", "en_US")
                //         .format(listlocationandfuel.total)),
                //   ],
                // ),
                const Gap(10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     const Text('ใช้ส่วนตัว (กม.): ',
                //         style: TextStyle(
                //             // color: Colors.white,

                //             fontSize: 16,
                //             fontWeight: FontWeight.bold)),
                //     Gap(5),
                //     Text(
                //       NumberFormat("###,###", "en_US")
                //           .format(listlocationandfuel.personal),
                //     ),
                //   ],
                // ),
                // const Gap(10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     const Text('ระยะทางสุทธิ (กม.): ',
                //         style: TextStyle(
                //             // color: Colors.white,
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold)),
                //     Gap(5),
                //     Text(NumberFormat("###,###", "en_US")
                //         .format(listlocationandfuel.net)),
                //   ],
                // ),
                Container(
                  width: double.infinity,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.car_rental),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("ระยะทางสุทธิ (กม.) "),
                            Text(
                              NumberFormat("###,###", "en_US")
                                  .format(listlocationandfuel.net),
                              style: const TextStyle(
                                color: Colors.pink,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // subtitle:
        // Add more details as needed
      ),
    );
  }
}
