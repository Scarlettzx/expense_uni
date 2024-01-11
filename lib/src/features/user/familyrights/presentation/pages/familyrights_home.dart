import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uni_expense/src/features/user/familyrights/presentation/pages/familyrights_add_list.dart';

import '../../../allowance/presentation/widgets/customappbar.dart';

class FamilyRightsHome extends StatefulWidget {
  const FamilyRightsHome({super.key});

  @override
  State<FamilyRightsHome> createState() => _FamilyRightsHomeState();
}

class _FamilyRightsHomeState extends State<FamilyRightsHome> {
  // Mock data
  final List<Map<String, dynamic>> familyData = [
    {
      'id': '001',
      'fname': 'สมใจ',
      'lname': 'สดใสดี',
      'status': 3,
      'IDcard': "0000000000000000",
    },
    {
      'id': '002',
      'fname': 'สมใจ',
      'lname': 'สดใสดี',
      'status': 3,
      'IDcard': "0000000000000000",
    },
    {
      'id': '003',
      'fname': 'สมใจ',
      'lname': 'สดใสดี',
      'status': 3,
      'IDcard': "0000000000000000",
    },
    {
      'id': '004',
      'fname': 'สมใจ',
      'lname': 'สดใสดี',
      'status': 3,
      'IDcard': "0000000000000000",
    },
    {
      'id': '005',
      'fname': 'สมใจ',
      'lname': 'สดใสดี',
      'status': 3,
      'IDcard': "0000000000000000",
    },
    {
      'id': '006',
      'fname': 'สมใจ',
      'lname': 'สดใสดี',
      'status': 3,
      'IDcard': "0000000000000000",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(image: 'appbar_familyrights.png', title: "เบี้ยเลี้ยง"),
      body: Column(
        children: [
          // ! button FamilyRightsAddlist
          Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30, top: 30, bottom: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffff99ca),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).devicePixelRatio * 6,
                  vertical: MediaQuery.of(context).devicePixelRatio * 3,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Durations.medium1,
                        type: PageTransitionType.rightToLeft,
                        child: FamilyRightsAddList(),
                      ),
                    );
                  },
                  child: Text(
                    '+ เพิ่มสิทธิครอบครัว',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Gap(15),
          Expanded(
            child: SizedBox(
              // height: 500,
              width: double.infinity,
              child: ListView.builder(
                  // the number of items in the list
                  itemCount: familyData.length,

                  // display each item of the product list
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Column(
                        children: [
                          // Gap(10),
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ความสัมพันธ์',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                getStatusWidget(familyData[index]["status"]),
                              ],
                            ),

                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('ชื่อ-สกุล'),
                                      Text(
                                          ' ${familyData[index]['fname']}  ${familyData[index]['lname']}'),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('เลขบัตรประชาชน'),
                                        Text('${familyData[index]['IDcard']}'
                                            .toString()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // You can add more widgets or customize the ListTile as needed
                          ),
                          Gap(15),
                          Divider(
                            color: Colors.grey.shade300,
                            height: 1,
                            endIndent: 25,
                            indent: 19,
                          ),
                          Gap(15)
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  // Function to get status text based on status value
  Widget getStatusWidget(int status) {
    String statusText;
    Color statusColor;

    switch (status) {
      case 3:
        statusText = 'เสร็จสมบูรณ์';
        statusColor = Colors.green;
        break;
      // case 3:
      //   statusText = 'ระหว่างดำเนินการ';
      //   statusColor = Colors.yellow;
      //   break;
      // case 2:
      //   statusText = 'รออนุมัติ';
      //   statusColor = Colors.yellow;
      //   break;
      default:
        statusText = 'ไม่ทราบสถานะ';
        statusColor = Colors.red;
    }

    // Create a container with the specified color
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
