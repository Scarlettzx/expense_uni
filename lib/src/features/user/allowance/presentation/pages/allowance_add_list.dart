import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/pages/allowance_general_infor.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/customappbar.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/customcalendarbetweendate.dart';

// import '../../../expense/presentation/widgets/calender_page.dart';

class AllowanceAddList extends StatefulWidget {
  final bool checkonclickdraft;
  const AllowanceAddList({
    super.key,
    required this.checkonclickdraft,
  });

  @override
  State<AllowanceAddList> createState() => _AllowanceAddListState();
}

class _AllowanceAddListState extends State<AllowanceAddList> {
  final _formKey = GlobalKey<FormState>();
  DateTime? startDate;
  DateTime? endDate;
  // String? betweenDays;
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descriptionController = TextEditingController();
  final betweenDays = TextEditingController();
  void setdefault() {
    var now = DateTime.now();
    print(now);
    var formatter = DateFormat('yyyy/MM/dd');
    String formattedDate = formatter.format(now);
    startDateController.text = formattedDate;
    endDateController.text = formattedDate;
    betweenDays.text = '1';
  }

  @override
  void initState() {
    super.initState();
    print(widget.checkonclickdraft);
    initializeDateFormatting('th');
    setdefault();
  }

  void addData() {
    ExpenseData newExpenseData;

    if (widget.checkonclickdraft == true) {
      print('yes');
      newExpenseData = ExpenseData(
        idExpenseAllowanceItem: null,
        startDate: startDateController.text,
        endDate: endDateController.text,
        description: descriptionController.text,
        countDays: double.parse(betweenDays.text),
      );
    } else {
      newExpenseData = ExpenseData(
        startDate: startDateController.text,
        endDate: endDateController.text,
        description: descriptionController.text,
        countDays: double.parse(betweenDays.text),
      );
    }
// อัปเดต List ใน dataInitial โดยเพิ่มข้อมูลใหม่
    List<ExpenseData> updatedDataInitial = [
      // ...widget.dataInitial,
      newExpenseData
    ];
    Navigator.pop(context, updatedDataInitial);
  }

  int daysDifferenceBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
  // DateTime? selectedDate;
  // Future<void> checkselectdate() async {
  //   if (selectedDate != null) {
  //     setState(() {
  //       // selectedDay = selectedDate;
  //       //  ! more
  //       startDateController.text = DateFormat.yMMMd('th').format(selectedDate!);
  //     });
  //   }
  // }

  // void resetData() {
  //   setState(() {
  //     selectDateController.clear();
  //     // selectedDay = null;
  //     // serviceController.clear();
  //     // descriptionController.clear();
  //     // checkTypepriceandSetdefault();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar:
            CustomAppBar(image: 'appbar_aollowance.png', title: "เบี้ยเลี้ยง"),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'เพิ่มรายการ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(20),
                Text(
                  'วันที่เริ่มต้น',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade600),
                ),
                const Gap(10),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).devicePixelRatio * 7),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // SizedBox(width: 4),
                        // Gap(0.2),
                        Text(startDateController.text),
                        IconButton(
                          // alignment: Alignment.bottomLeft,
                          onPressed: () {
                            showCustomDateRangePicker(
                              context,
                              dismissible: true,
                              backgroundColor: Colors.white,
                              minimumDate: startDate ??
                                  DateTime
                                      .now(), // ให้ minimumDate เป็น startDate ถ้ามีค่า, ไม่มีค่าก็ให้เป็น DateTime.now()
                              maximumDate:
                                  DateTime.now().add(const Duration(days: 365)),
                              endDate: endDate,
                              startDate: startDate,
                              onApplyClick: (start, end) {
                                setState(() {
                                  endDate = end;
                                  startDate = start;
                                  final currentDay =
                                      DateTime.now(); // Current date
                                  final differenceFormTwoDates =
                                      daysDifferenceBetween(start, end);
                                  final differenceFormCurrent =
                                      daysDifferenceBetween(start, end);
                                  var daysGet = differenceFormTwoDates + 1;
                                  betweenDays.text = daysGet.toString();
                                  // var formatterStartdate =
                                  //     DateFormat.yMMMd('th');
                                  // var formatter = DateFormat.yMMMd('th');
                                  // String formattedDate =
                                  //     formatterStartdate.format(start);
                                  // var formatterEnddate = DateFormat.yMMMd('th');
                                  // String formattedEDate =
                                  //     formatterEnddate.format(end);
                                  var formatter = DateFormat('yyyy/MM/dd');
                                  String formattedstartDate =
                                      formatter.format(start);
                                  String formattedendDate =
                                      formatter.format(end);
                                  startDateController.text = formattedstartDate;
                                  // formattedDate.toString();
                                  endDateController.text = formattedendDate;
                                  // formattedEDate.toString();
                                });
                                print(betweenDays);
                              },
                              onCancelClick: () {
                                // Navigator.pop
                                setState(() {
                                  endDate = null;
                                  startDate = null;
                                });
                              },
                              primaryColor: Colors.purple,
                            );
                          },
                          icon: Icon(
                            size: 20,
                            color: Colors.grey.withOpacity(0.6),
                            // color: Colors.grey.shade600,
                            IconaMoon.calendar2,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Gap(20),
                Text(
                  'วันที่สิ้นสุด',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade600),
                ),
                const Gap(10),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).devicePixelRatio * 7),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // SizedBox(width: 4),
                        // Gap(0.2),
                        Text(endDateController.text),
                        IconButton(
                          // alignment: Alignment.bottomLeft,
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //         child: CalenderPage(),
                            //         type: PageTransitionType.bottomToTop));
                          },
                          icon: Icon(
                            size: 20,
                            color: Colors.grey.withOpacity(0.6),
                            // color: Colors.grey.shade600,
                            IconaMoon.calendar2,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Gap(20),
                Text(
                  'รายละเอียด',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade600),
                ),
                Gap(10),
                TextFormField(
                  controller: descriptionController,
                  // style: ,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null; // Return null if the input is valid
                  },
                  decoration: InputDecoration(
                    // fillColor: const Color.fromARGB(255, 237, 237, 237)
                    //     .withOpacity(0.5),
                    // filled: true,
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    errorStyle: TextStyle(fontSize: 15),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 252, 119, 119)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

                const Gap(20),
                Text(
                  'จำวนวนวัน',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade600),
                ),
                Gap(10),
                TextFormField(
                  // style: ,
                  // readOnly: true,
                  keyboardType: TextInputType.number,
                  controller: betweenDays,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a countday';
                    }
                    return null; // Return null if the input is valid
                  },
                  decoration: InputDecoration(
                    // fillColor: const Color.fromARGB(255, 237, 237, 237)
                    //     .withOpacity(0.5),
                    // filled: true,
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    errorStyle: TextStyle(fontSize: 15),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 252, 119, 119)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                // Spacer(),
                const Gap(110),
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          width: 2, color: Color(0xffff99ca)), // สีขอบสีส้ม
                    ),
                    child: Text(
                      'ล้าง',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xffff99ca), // สีข้อความสีส้ม
                      ),
                    ),
                  ),
                ),
                const Gap(5),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'บันทึกรายการ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white, // สีข้อความขาว
                      ),
                    ),
                    // icon: Icon(
                    //   Icons.send,
                    //   color: Colors.white,
                    // ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffff99ca), // สีปุ่มสีส้ม
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        debugPrint("success");
                        addData();
                      } else {
                        debugPrint("not success");
                      }
                    },
                  ),
                ),
                const Gap(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExpenseData {
  int? idExpenseAllowanceItem;
  String? startDate;
  String? endDate;
  String? description;
  num? countDays;

  ExpenseData({
    this.idExpenseAllowanceItem,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.countDays,
  });

  // Convert ExpenseData to Map
  Map<String, dynamic> toJson() {
    return {
      'idExpenseAllowanceItem': idExpenseAllowanceItem,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
      'countDays': countDays,
    };
  }

  // Convert List<ExpenseData> to List<Map<String, dynamic>>
  static List<Map<String, dynamic>> listToJson(List<ExpenseData> expenseList) {
    return expenseList.map((expense) => expense.toJson()).toList();
  }

  // Update listExpense with new data
  static void updateListExpense(
      List<ExpenseData> expenseList, List<Map<String, dynamic>> listExpense) {
    List<Map<String, dynamic>> jsonList = listToJson(expenseList);
    listExpense.addAll(jsonList);
  }
}
