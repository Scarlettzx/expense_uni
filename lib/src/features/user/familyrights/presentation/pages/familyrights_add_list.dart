import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:iconamoon/iconamoon.dart';

import '../../../allowance/presentation/widgets/customappbar.dart';

class FamilyRightsAddList extends StatefulWidget {
  const FamilyRightsAddList({super.key});

  @override
  State<FamilyRightsAddList> createState() => _FamilyRightsAddListState();
}

class _FamilyRightsAddListState extends State<FamilyRightsAddList> {
  String _enteredText = '';
  List<String> _list = [
    'Developer',
    'Designer',
    'Consultant',
    'Student',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(image: 'appbar_familyrights.png', title: "เบี้ยเลี้ยง"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ข้อมูลทั่วไป',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Gap(20),
            Text(
              'เลือกผู้ใช้สิทธิ์',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade600),
            ),
            const Gap(10),
            SizedBox(
              height: 80,
              width: double.infinity,
              child: CustomDropdown<String>(
                errorStyle:
                    const TextStyle(color: Colors.deepPurple, fontSize: 18),
                validateOnChange: true,
                validator: (value) {
                  if (value == null) {
                    return "Must not be null";
                  }
                  return null;
                },
                // maxlines: 1,
                hideSelectedFieldWhenExpanded: true,
                excludeSelected: false,
                closedBorderRadius: BorderRadius.circular(30),
                closedBorder:
                    Border.all(width: 2.0, color: Colors.grey.withOpacity(0.3)),
                expandedBorderRadius: BorderRadius.circular(30),
                hintText: 'Select job role',
                items: _list,
                // initialItem: _list[0],
                onChanged: (value) {
                  print('changing value to: $value');
                },
              ),
            ),
            const Gap(10),
            Text(
              'ชื่อ-สกุล',
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
                        width: 2.0, color: Color.fromARGB(255, 252, 119, 119)),
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
            Text(
              'เลขบัตรประชาชน',
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
                        width: 2.0, color: Color.fromARGB(255, 252, 119, 119)),
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

            // SizedBox(
            //   height: 40,
            //   width: double.infinity,
            //   child: TextFormField(
            //     decoration: InputDecoration(
            //       contentPadding:
            //           const EdgeInsets.symmetric(horizontal: 16),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: const BorderSide(
            //             width: 2.0,
            //             color: Color.fromARGB(255, 252, 119, 119)),
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(30),
            //         borderSide: BorderSide(
            //             width: 2.0, color: Colors.grey.withOpacity(0.3)),
            //       ),
            //     ),
            //   ),
            // ),
            const Gap(30),
            Divider(
              color: Colors.grey.shade300,
              height: 1,
            ),
            const Gap(30),
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
                            child: Icon(IconaMoon.share2, color: Colors.white)),
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 2.0, color: Color.fromARGB(255, 252, 119, 119)),
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
            const Gap(40),
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
            const Gap(40),
          ],
        ),
      ),
    );
  }
}
