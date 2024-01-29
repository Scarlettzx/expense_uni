import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';

import '../../../allowance/presentation/pages/allowance_general_infor.dart';
import '../../../allowance/presentation/widgets/customappbar.dart';
import '../../../expense/presentation/pages/expense.dart';
import '../../../fare/presentation/pages/fare_general_info.dart';
import '../../../welfare/presentation/pages/general_infor.dart';

class ManageItemsAddList extends StatelessWidget {
  const ManageItemsAddList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(image: "appbar_manageitems.png", title: 'จัดการรายการ'),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'คุณต้องการเบิกอะไร',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
              Gap(30),
              Container(
                // color: Colors.grey,
                // width: double.infinity,
                // height: 500,

                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    // StaggeredGridTile.count(
                    //   crossAxisCellCount: 2,
                    //   mainAxisCellCount: 2,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15)
                    //     ),
                    //     color: Color(0xffD6F3F2),
                    //     // width: 155,
                    //     // height: 174,
                    //   ),
                    // ),
                    // StaggeredGridTile.count(
                    //   crossAxisCellCount: 2,
                    //   mainAxisCellCount: 3,
                    //   child: Container(
                    //     color: Color(0xffFBF4E2),
                    //     width: 155,
                    //     height: 200,
                    //   ),
                    // ),
                    // StaggeredGridTile.count(
                    //   crossAxisCellCount: 2,
                    //   mainAxisCellCount: 3,
                    //   child: Container(
                    //     color: Color(0xffFEEFFF),
                    //     width: 155,
                    //     height: 200,
                    //   ),
                    // ),
                    // StaggeredGridTile.count(
                    //   crossAxisCellCount: 2,
                    //   mainAxisCellCount: 2,
                    //   child: Container(
                    //     color: Color(0xffFFE3D7),
                    //     width: 155,
                    //     height: 174,
                    //   ),
                    // ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                duration: Durations.extralong1,
                                type: PageTransitionType.rightToLeft,
                                child: Expense()),
                            // MaterialPageRoute(
                            //     builder: (context) => const Expense()),
                          );
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/images/menu_1_home.png'),
                              Text('ซื้อสินค้า/ค่าใช้จ่าย')
                            ],
                          ),
                          color: Color(0xffD6F3F2),
                          // width: MediaQuery.of(context).size.width * 0.20,
                          height: MediaQuery.of(context).size.height * 0.20,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                duration: Durations.medium1,
                                type: PageTransitionType.rightToLeft,
                                child: const AllowanceGeneralInformation()),
                            // MaterialPageRoute(
                            //     builder: (context) => const Expense()),
                          );
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/images/menu_2_home.png'),
                              Text('เบี้ยเลี้ยง')
                            ],
                          ),
                          color: Color(0xffFBF4E2),
                          // width: 155,
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                duration: Durations.medium1,
                                type: PageTransitionType.rightToLeft,
                                child: const FareGeneralInformation()),
                            // MaterialPageRoute(
                            //     builder: (context) => const Expense()),
                          );
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/images/menu_3_home.png'),
                              Text('ค่าเดินทาง')
                            ],
                          ),
                          color: Color(0xffFEEFFF),
                          // width: 155,
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                duration: Durations.medium1,
                                type: PageTransitionType.rightToLeft,
                                child:
                                    const MedicalBenefitsGeneralInformation()),
                            // MaterialPageRoute(
                            //     builder: (context) => const Expense()),
                          );
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/images/menu_4_home.png'),
                              Text('สวัสดิการรักษาพยาบาล')
                            ],
                          ),
                          color: Color(0xffFFE3D7),
                          // width: 155,
                          height: MediaQuery.of(context).size.height * 0.20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
