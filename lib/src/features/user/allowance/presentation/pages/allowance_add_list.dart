import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/customappbar.dart';

import '../../../../../components/custominputdecoration.dart';
import '../../data/models/listallowance.dart';
import '../bloc/allowance_bloc.dart';
import '../widgets/dateinputfield.dart';

class AllowanceAddList extends StatefulWidget {
  final AllowanceBloc allowanceBloc;
  final bool? isdraft;
  final ListAllowance? listallowance;
  const AllowanceAddList({
    super.key,
    required this.allowanceBloc,
    this.isdraft,
    this.listallowance,
  });

  @override
  State<AllowanceAddList> createState() => _AllowanceAddListState();
}

class _AllowanceAddListState extends State<AllowanceAddList> {
  ListAllowance? listallowance;
  final _formKey = GlobalKey<FormState>();
  DateTime? startDate;
  DateTime? endDate;
  bool isEditing = false;
  // String? betweenDays;
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descriptionController = TextEditingController();
  final betweenDays = TextEditingController();
  var formatter = DateFormat('yyyy/MM/dd');
  @override
  void initState() {
    initializeDateFormatting('th');
    if (widget.listallowance != null) {
      isEditing = true;
      listallowance = widget.listallowance;
      startDateController.text = listallowance!.startDate;
      endDateController.text = listallowance!.endDate;
      descriptionController.text = listallowance!.description;
      startDate = formatter.parse(startDateController.text);
      endDate = formatter.parse(endDateController.text);
      print(startDate);
      print(endDate);
      betweenDays.text = listallowance!.countDays.toString();
    } else {
      var now = DateTime.now();
      String formattedDate = formatter.format(now);
      startDateController.text = formattedDate;
      endDateController.text = formattedDate;
      startDate = formatter.parse(startDateController.text);
      endDate = formatter.parse(endDateController.text);
      betweenDays.text = '1';
    }
    super.initState();
  }

  void clearData() {
    setState(() {
      var now = DateTime.now();
      String formattedDate = formatter.format(now);
      startDateController.text = formattedDate;
      endDateController.text = formattedDate;
      startDate = null;
      endDate = null;
      descriptionController.clear();
      betweenDays.text = '1';
    });
  }

  int daysDifferenceBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    // print(isEditing);
    // print(widget.isdraft);
    // print('startDate: $startDate');
    // print("endDate: $endDate");
    // print(startDateController.text);
    // print(endDateController.text);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(
            image: 'appbar_aollowance.png', title: "เบี้ยเลี้ยง"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'เพิ่มรายการ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                DateInputField(
                  labelText: 'วันที่เริ่มต้น',
                  startDate: startDate,
                  endDate: endDate,
                  startDateController: startDateController,
                  endDateController: endDateController,
                  onApplyClick: (start, end) {
                    setState(() {
                      endDate = end;
                      startDate = start;
                      final differenceFormTwoDates =
                          daysDifferenceBetween(start, end);
                      var daysGet = differenceFormTwoDates + 1;
                      betweenDays.text = daysGet.toString();
                      String formattedstartDate = formatter.format(start);
                      String formattedendDate = formatter.format(end);
                      startDateController.text = formattedstartDate;
                      endDateController.text = formattedendDate;
                    });
                  },
                  onCancelClick: () {},
                ),
                DateInputField(
                  labelText: 'วันที่สิ้นสุด',
                  startDate: startDate,
                  endDate: endDate,
                  startDateController: startDateController,
                  endDateController: endDateController,
                  onApplyClick: (start, end) {
                    setState(() {
                      endDate = end;
                      startDate = start;
                      final differenceFormTwoDates =
                          daysDifferenceBetween(start, end);
                      var daysGet = differenceFormTwoDates + 1;
                      betweenDays.text = daysGet.toString();
                      String formattedstartDate = formatter.format(start);
                      String formattedendDate = formatter.format(end);
                      startDateController.text = formattedstartDate;
                      endDateController.text = formattedendDate;
                    });
                  },
                  onCancelClick: () {
                    setState(() {
                      endDate = null;
                      startDate = null;
                    });
                  },
                ),
                const Gap(20),
                // const Gap(20),
                // Text(
                //   'วันที่สิ้นสุด',
                //   style: TextStyle(
                //       fontSize: 14,
                //       fontWeight: FontWeight.normal,
                //       color: Colors.grey.shade600),
                // ),
                // const Gap(10),
                // Container(
                //   height: 40,
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //       width: 2.0,
                //       color: Colors.grey.withOpacity(0.3),
                //     ),
                //     borderRadius: BorderRadius.circular(35),
                //   ),
                //   width: double.infinity,
                //   child: Padding(
                //     padding: EdgeInsets.only(
                //         left: MediaQuery.of(context).devicePixelRatio * 7),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(formatThaiDate(endDateController.text
                //             .split(':')[0]
                //             .replaceAll('/', '-'))),
                //         IconButton(
                //           // alignment: Alignment.bottomLeft,
                //           onPressed: () {
                //             // Navigator.push(
                //             //     context,
                //             //     PageTransition(
                //             //         child: CalenderPage(),
                //             //         type: PageTransitionType.bottomToTop));
                //           },
                //           icon: Icon(
                //             size: 20,
                //             color: Colors.grey.withOpacity(0.6),
                //             // color: Colors.grey.shade600,
                //             IconaMoon.calendar2,
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // const Gap(20),
                Text(
                  'รายละเอียด',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade600),
                ),
                const Gap(10),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null; // Return null if the input is valid
                  },
                  decoration: CustomInputDecoration.getInputDecoration(),
                ),

                const Gap(20),
                Text(
                  'จำวนวนวัน',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade600),
                ),
                const Gap(10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: betweenDays,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a countday';
                    }
                    if (!RegExp(r'^\d+(\.\d{1})?$').hasMatch(value.trim())) {
                      return 'Invalid countday format';
                    }
                    double countday = double.parse(value.trim());
                    if (countday <= 0) {
                      return 'Value countday must be greater than 0';
                    }
                    return null; // ส่งค่า null เมื่อข้อมูลถูกต้อง
                  },
                  decoration: CustomInputDecoration.getInputDecoration(),
                ),
                // Spacer(),
                const Gap(110),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      clearData();
                    },
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
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffff99ca), // สีปุ่มสีส้ม
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        final countDaysValue =
                            double.tryParse(betweenDays.text);
                        if (isEditing) {
                          final listallowancesdata = widget.listallowance!
                              .copyWith(
                                  startDate: startDateController.text,
                                  endDate: endDateController.text,
                                  description: descriptionController.text,
                                  countDays: countDaysValue!.toDouble());
                          print(listallowancesdata);
                          widget.allowanceBloc.add(UpdateListAllowanceEvent(
                              listallowance: listallowancesdata));
                        } else {
                          final listallowancesdata = ListAllowance(
                              idExpenseAllowanceItem: (widget.isdraft != null &&
                                      widget.isdraft == true)
                                  ? null
                                  : DateTime.now().toIso8601String(),
                              startDate: startDateController.text,
                              endDate: endDateController.text,
                              description: descriptionController.text,
                              countDays: countDaysValue!.toDouble());
                          widget.allowanceBloc.add(AddListAllowanceEvent(
                              listallowance: listallowancesdata));
                        }
                        widget.allowanceBloc.add(CalculateSumEvent());
                        Navigator.pop(context);
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
