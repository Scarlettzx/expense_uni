import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:uni_expense/src/features/user/familyrights/presentation/pages/familyrights_add_list.dart';
import 'package:uni_expense/src/features/user/familyrights/presentation/widgets/family_list_view.dart';

import '../../../../../../injection_container.dart';
import '../../../../../core/features/user/presentation/provider/profile_provider.dart';
import '../../../allowance/presentation/widgets/customappbar.dart';
import '../bloc/familyrights_bloc.dart';

class FamilyRightsHome extends StatefulWidget {
  const FamilyRightsHome({super.key});

  @override
  State<FamilyRightsHome> createState() => _FamilyRightsHomeState();
}

class _FamilyRightsHomeState extends State<FamilyRightsHome> {
  final familyRightsBloc = sl<FamilyrightsBloc>();
  @override
  void initState() {
    super.initState();
    final ProfileProvider userData =
        Provider.of<ProfileProvider>(context, listen: false);
    familyRightsBloc.add(GetAllrightsEmployeeFamilyEvent(
        idEmployees: userData.profileData.idEmployees!));
  }
  // Mock data
  // final List<Map<String, dynamic>> familyData = [
  //   {
  //     'id': '001',
  //     'fname': 'สมใจ',
  //     'lname': 'สดใสดี',
  //     'status': 3,
  //     'IDcard': "0000000000000000",
  //     'relation': 'สิทธิตนเอง'
  //   },
  //   {
  //     'id': '002',
  //     'fname': 'สมใจ',
  //     'lname': 'สดใสดี',
  //     'status': 3,
  //     'IDcard': "0000000000000000",
  //     'relation': 'สิทธิบุตร'
  //   },
  //   {
  //     'id': '003',
  //     'fname': 'สมใจ',
  //     'lname': 'สดใสดี',
  //     'status': 3,
  //     'IDcard': "0000000000000000",
  //     'relation': 'สิทธิบิดา'
  //   },
  //   {
  //     'id': '004',
  //     'fname': 'สมใจ',
  //     'lname': 'สดใสดี',
  //     'status': 3,
  //     'IDcard': "0000000000000000",
  //     'relation': 'สิทธิบุตร'
  //   },
  //   {
  //     'id': '005',
  //     'fname': 'สมใจ',
  //     'lname': 'สดใสดี',
  //     'status': 3,
  //     'IDcard': "0000000000000000",
  //     'relation': 'สิทธิมารดา'
  //   },
  //   // {
  //   'id': '006',
  //   'fname': 'สมใจ',
  //   'lname': 'สดใสดี',
  //   'status': 3,
  //   'IDcard': "0000000000000000",
  // },
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => familyRightsBloc,
      child: Scaffold(
        appBar: CustomAppBar(
            image: 'appbar_familyrights.png', title: "สิทธิครอบครัว"),
        body: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ! button FamilyRightsAddlist
                // Padding(
                //   padding: const EdgeInsets.only(
                //       left: 30.0, right: 30, top: 30, bottom: 20),
                //   child: Align(
                //     alignment: Alignment.bottomRight,
                //     child: Container(
                //       decoration: BoxDecoration(
                //         color: Color(0xffff99ca),
                //         borderRadius: BorderRadius.circular(30.0),
                //       ),
                //       padding: EdgeInsets.symmetric(
                //         horizontal: MediaQuery.of(context).devicePixelRatio * 6,
                //         vertical: MediaQuery.of(context).devicePixelRatio * 3,
                //       ),
                //       child: InkWell(
                //         borderRadius: BorderRadius.circular(30.0),
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             PageTransition(
                //               duration: Durations.medium1,
                //               type: PageTransitionType.rightToLeft,
                //               child: FamilyRightsAddList(),
                //             ),
                //           );
                //         },
                //         child: Text(
                //           '+ เพิ่มสิทธิครอบครัว',
                //           style: TextStyle(color: Colors.white),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Gap(15),
                BlocBuilder<FamilyrightsBloc, FamilyrightsState>(
                    builder: (context, state) {
                  if (state is FamilyrightsInitial) {
                    return Text(
                      "ไม่พบข้อมูล",
                    );
                  } else if (state is FamilyrightsLoading) {
                    return LoadingAnimationWidget.inkDrop(
                      color: const Color(0xffff99ca),
                      size: 35,
                    );
                  } else if (state is FamilyrightsFinish) {
                    if (state.allrightempfamily.isNotEmpty) {
                      print("state.allrightempfamily");
                      print(state.allrightempfamily);
                      return FamilyList(
                        familyData: state.allrightempfamily,
                      );
                    }
                  } else if (state is FamilyrightsFailure) {
                    return const Text("error");
                  }
                  return Container();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//   // Function to get status text based on status value
//   Widget getStatusWidget(int status) {
//     String statusText;
//     Color statusColor;

//     switch (status) {
//       case 3:
//         statusText = 'เสร็จสมบูรณ์';
//         statusColor = Colors.green;
//         break;
//       // case 3:
//       //   statusText = 'ระหว่างดำเนินการ';
//       //   statusColor = Colors.yellow;
//       //   break;
//       // case 2:
//       //   statusText = 'รออนุมัติ';
//       //   statusColor = Colors.yellow;
//       //   break;
//       default:
//         statusText = 'ไม่ทราบสถานะ';
//         statusColor = Colors.red;
//     }

//     // Create a container with the specified color
//     return Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: statusColor,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         statusText,
//         style: TextStyle(
//           fontSize: 10,
//           fontWeight: FontWeight.w900,
//         ),
//       ),
//     );
//   }
