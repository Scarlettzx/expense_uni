import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/pages/allowance_general_infor.dart';
import 'package:uni_expense/src/features/user/expense/presentation/pages/expense.dart';
import 'package:uni_expense/src/features/user/fare/presentation/pages/fare_general_info.dart';
import 'package:uni_expense/src/features/user/home/presentation/widgets/texthead_rec.dart';
import 'package:uni_expense/src/features/user/home/presentation/widgets/textheader.dart';
// import 'package:uni_expense/src/features/user/home/presentation/widgets/textmenu.dart';
import 'package:uni_expense/src/features/user/home/presentation/widgets/textsubheader.dart';
import 'package:uni_expense/src/features/user/manageitems/presentation/pages/manageitems.dart';
import 'package:uni_expense/src/features/user/welfare/presentation/pages/general_infor.dart';

import '../../../../../core/error/token_expires.dart';
import '../../../../../core/features/login/presentation/pages/login_page.dart';
import '../../../../../core/features/user/presentation/provider/profile_provider.dart';
import '../../../../../core/storage/secure_storage.dart';
import '../../../familyrights/presentation/pages/familyrights_home.dart';
import '../../../mileage/presentation/pages/savemileage_main.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isError = false;
  late ProfileProvider profileProvider;

  void isLoading() async {
    try {
      profileProvider = ProfileProvider.of(context, listen: false);
      profileProvider.setIsLoading(true);
      TokenExpires.checkTokenExpires(context);
      await profileProvider.getProfileData().then((value) => isError = value);
      if (isError) {
        await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            confirmBtnText: 'ตกลง',
            title: 'เกิดข้อผิดพลาด',
            text:
                "ไม่สามารถดึงข้อมูลได้ \nตรวจสอบอินเทอร์เน็ตของท่าน หรือ ติดต่อแอดมิน",
            confirmBtnColor: const Color(0xffE46A76),
            onConfirmBtnTap: () async {
              await LoginStorage.deleteAll();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            });
        await LoginStorage.deleteAll();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {}
    } catch (e) {
      await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          confirmBtnText: 'ตกลง',
          title: 'ไม่สามารถดึงข้อมูลของผู้ใช้ได้',
          text: "ตรวจสอบอินเทอร์เน็ตของท่าน หรือ ติดต่อแอดมิน",
          confirmBtnColor: const Color(0xffE46A76),
          onConfirmBtnTap: () async {
            await LoginStorage.deleteAll();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          });
      await LoginStorage.deleteAll();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      Logger().e("$e");
    }
  }

  @override
  void initState() {
    super.initState();
    isLoading();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              //! Header (TextHeader, TextSubHeader, imgprofile)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHeader(
                          title:
                              'Hi, ${profileProvider.profileData.firstnameEn}'),
                      TextSubHeader(title: 'Welcome back'),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).devicePixelRatio * 4,
                      right: MediaQuery.of(context).devicePixelRatio * 8,
                    ),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: profileProvider.profileData.imageProfile != null
                          ? CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(
                                  profileProvider.profileData.imageProfile!))
                          : CircleAvatar(
                              radius: 45,
                              backgroundImage: AssetImage(
                                  "assets/images/default_profile.png"),
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              //! Other widgets in the column
              // ! BoxdecoHeader
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      15), // Use BorderRadius.circular for rounded corners
                  color: const Color(0xffFFE7EB),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.17,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextHeadRec(title: 'Uni Expense'),
                        TextSubHeadRec(title: 'ช่วยจัดการทุกการเบิกจ่าย'),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).devicePixelRatio * 8),
                        child: Image.asset(
                          "assets/images/img_Rec.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              TextSubHeader(title: 'คุณต้องการเบิกอะไร ?'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.017,
              ),
              // ! MenuRectangle
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).devicePixelRatio * 9,
                    right: MediaQuery.of(context).devicePixelRatio * 9,
                    bottom: MediaQuery.of(context).devicePixelRatio * 4),
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
                                child: FareGeneralInformation()),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              TextSubHeader(title: 'รายการอื่นๆ'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).devicePixelRatio * 9,
                    right: MediaQuery.of(context).devicePixelRatio * 8,
                    bottom: MediaQuery.of(context).devicePixelRatio * 4),
                // color: Colors.grey,
                width: double.infinity,
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
                                duration: Durations.medium1,
                                type: PageTransitionType.rightToLeft,
                                child: const ManageItems()),
                            // MaterialPageRoute(
                            //     builder: (context) => const Expense()),
                          );
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                  'assets/images/other_menu_1_home.png'),
                              Text('จัดการรายการ')
                            ],
                          ),
                          color: Color(0xffD6F3F2),
                          // width: 155,
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
                              child: FamilyRightsHome(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                  'assets/images/other_menu_2_home.png'),
                              Text('สิทธิครอบครัว')
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
                              child: SaveMileageMain(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                  'assets/images/other_menu_3_home.png'),
                              Text('บันทึก Mileage')
                            ],
                          ),
                          color: Color(0xffFEEFFF),
                          // width: 155,
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
