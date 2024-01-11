import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/customappbar.dart';
import 'package:uni_expense/src/features/user/fare/presentation/pages/fare_add_list_costfuel.dart';
import 'package:uni_expense/src/features/user/fare/presentation/pages/fare_add_list_location.dart';

class FareGeneralInformation extends StatefulWidget {
  const FareGeneralInformation({super.key});

  @override
  State<FareGeneralInformation> createState() => _FareGeneralInformationState();
}

class _FareGeneralInformationState extends State<FareGeneralInformation> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  String _enteredText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(image: "appbar_fare.png", title: 'ค่าเดินทาง'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ข้อมูลทั่วไป',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Gap(20),
              // SizedBox(
              //   height: MediaQuery.of(context).devicePixelRatio * 8,
              // ),
              Text(
                'ชื่อรายการ',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade600),
              ),
              const Gap(10),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 252, 119, 119)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          width: 2.0, color: Colors.grey.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),
              const Gap(30),
              Divider(
                color: Colors.grey.shade300,
                height: 1,
              ),
              const Gap(30),
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
                        context,
                        PageTransition(
                          duration: Durations.medium1,
                          type: PageTransitionType.rightToLeft,
                          child: const FareAddListLocation(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffff99ca),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).devicePixelRatio * 7,
                          vertical:
                              MediaQuery.of(context).devicePixelRatio * 2.5),
                      // shape: Border.all(width: 2),
                      // onPressed: () => {},
                      // fillColor: ,
                      child: Text(
                        '+ เพิ่มรายการ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 1,
                    bottom: MediaQuery.of(context).devicePixelRatio * 1),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  alignment: AlignmentDirectional.center,
                  width: double.infinity,
                  // color: Colors.red,
                  child: Text(
                    'ยังไม่มีรายการ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                ),
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 1,
              ),
              const Gap(25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'รายการค่าน้ำมัน',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(30.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          duration: Durations.medium1,
                          type: PageTransitionType.rightToLeft,
                          child: const FareAddListCostFuel(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffff99ca),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).devicePixelRatio * 7,
                          vertical:
                              MediaQuery.of(context).devicePixelRatio * 2.5),
                      // shape: Border.all(width: 2),
                      // onPressed: () => {},
                      // fillColor: ,
                      child: Text(
                        '+ เพิ่มรายการ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio * 1,
                    bottom: MediaQuery.of(context).devicePixelRatio * 1),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  alignment: AlignmentDirectional.center,
                  width: double.infinity,
                  // color: Colors.red,
                  child: Text(
                    'ยังไม่มีรายการ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                ),
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 1,
              ),
              const Gap(25),
              const Text(
                'สรุปรายการ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Gap(25),
              Divider(
                color: Colors.grey.shade300,
                height: 1,
              ),
              const Gap(25),
              const Text(
                'แนบไฟล์เอกสาร',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Gap(25),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      20), // Use BorderRadius.circular for rounded corners
                  color: Color.fromRGBO(255, 234, 239, 0.29),
                ),
                // width: MediaQuery.of(context).size.width * 0.9,
                // height: MediaQuery.of(context).size.height * 0.17,
                width: double.infinity,
                height: 208,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/img_expense_pick.png",
                      fit: BoxFit.fill,
                    ),
                    const Text('อัพโหลดไฟล์ที่นี่'),
                    const Gap(5),
                    ClipOval(
                      child: Material(
                        color: Color(0xffff99ca), // Button color
                        child: InkWell(
                          splashColor: Color(0xffff99ca), // Splash color
                          onTap: () {},
                          child: const SizedBox(
                              width: 56,
                              height: 56,
                              child:
                                  Icon(IconaMoon.share2, color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(25),
              Divider(
                color: Colors.grey.shade300,
                height: 1,
              ),
              const Gap(30),
              const Text(
                'หมายเหตุ (เพิ่มเติม)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Gap(20),
              SizedBox(
                // color: Colors.red,
                // height: 200,
                width: double.infinity,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _enteredText = value;
                    });
                  },

                  minLines: 2,
                  maxLines: 5,
                  // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLength: 500,
                  // style: ,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(500),
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    counterText: '${_enteredText.length.toString()} / ${500}',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 252, 119, 119)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          width: 2.0, color: Colors.grey.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),

              const Gap(20),
              Divider(
                color: Colors.grey.shade300,
                height: 1,
              ),
              const Gap(30),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        width: 2, color: Color(0xffff99ca)), // สีขอบสีส้ม
                  ),
                  icon: const Icon(Icons.save_as, color: Color(0xffff99ca)),
                  label: const Text(
                    'บันทึกแบบร่าง',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffff99ca), // สีข้อความสีส้ม
                    ),
                  ),
                ),
              ),
              const Gap(10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  label: const Text(
                    'ส่งอนุมัติ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // สีข้อความขาว
                    ),
                  ),
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffff99ca), // สีปุ่มสีส้ม
                  ),
                  onPressed: () {},
                ),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
