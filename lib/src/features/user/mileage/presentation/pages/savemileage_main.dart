import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/customappbar.dart';
import 'package:uni_expense/src/features/user/mileage/presentation/pages/savemileage_input.dart';

class SaveMileageMain extends StatefulWidget {
  const SaveMileageMain({super.key});

  @override
  State<SaveMileageMain> createState() => _SaveMileageMainState();
}

class _SaveMileageMainState extends State<SaveMileageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          image: 'appbar_savemileage.png', title: 'บันทึก Mileage'),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: SaveMileageInput(),
                        type: PageTransitionType.rightToLeft));
              },
              child: Container(
                height: MediaQuery.of(context).devicePixelRatio * 50,
                // height: 127,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff87DC45),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('เริ่มออกเดินทาง',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Divider(
                                    endIndent: 20,
                                    // indent: 10,
                                    color: Colors.white,
                                    height: 1,
                                    thickness: 1,
                                  ),
                                ),
                              ),
                              Icon(
                                IconaMoon.arrowRight2,
                                color: Colors.white,
                                size: 39,
                              )
                            ],
                          ),
                        ),
                        Text('ใส่เลขไมล์ก่อนออกเดินทาง',
                            style: TextStyle(color: Colors.white, fontSize: 16))
                      ]),
                ),
              ),
            ),
            Gap(30),
            GestureDetector(
              onTap: () {
                print('test2');
              },
              child: Container(
                height: MediaQuery.of(context).devicePixelRatio * 50,
                // height: 127,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffDC4545),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('สิ้นสุดการเดินทาง',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Divider(
                                    endIndent: 20,
                                    // indent: 10,
                                    color: Colors.white,
                                    height: 1,
                                    thickness: 1,
                                  ),
                                ),
                              ),
                              Icon(
                                IconaMoon.arrowRight2,
                                color: Colors.white,
                                size: 39,
                              )
                            ],
                          ),
                        ),
                        Text('ใส่เลขไมล์เมื่อถึงจุดหมาย',
                            style: TextStyle(color: Colors.white, fontSize: 16))
                      ]),
                ),
              ),
            )
          ])),
    );
  }
}
