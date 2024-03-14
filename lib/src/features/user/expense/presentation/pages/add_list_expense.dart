import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
// import 'package:iconamoon/iconamoon.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:pinput/pinput.dart';
import 'package:uni_expense/src/components/models/typeprice_model.dart';
// import 'package:uni_expense/src/features/user/expense/presentation/pages/expense.dart';
import 'package:uni_expense/src/features/user/expense/presentation/widgets/calender_page.dart';

import '../../../allowance/presentation/widgets/customappbar.dart';
import '../bloc/expensegood_bloc.dart';

class AddListExpense extends StatefulWidget {
  final TypePriceModel typeprice;
  const AddListExpense({super.key, required this.typeprice});

  @override
  State<AddListExpense> createState() => _AddListExpenseState();
}

class _AddListExpenseState extends State<AddListExpense> {
  // ? service = สินค้า/บริการ
  final serviceController = TextEditingController();
  // ? description = รายละเอียด
  final descriptionController = TextEditingController();
  // ? amout = จำนวน
  final amountController = TextEditingController();
  // ? unitPrice = ราคาต่อหน่วย
  final unitPriceController = TextEditingController();
  // ? taxpercent = ภาษี
  final taxPercentController = TextEditingController();
  // ? withholdingpercent = หักราคา ณ ที่จ่าย
  final withholdingpercentController = TextEditingController();
  // ? total = มูลค่ารวมก่อนภาษี
  final totalController = TextEditingController();
  // ? selectDate = วันที่เอกสร
  //  ! more
  final selectDateController = TextEditingController();
  // // ? ภาษี = ราคาต่อหน่วย
  // final texPercentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  DateTime? selectedDay;
  List<String> alldata = [];
  Map<dynamic, String> newData = {};
  @override
  void initState() {
    super.initState();
    print(widget.typeprice.isVatIncluded);
    checkTypepriceandSetdefault();
  }

  Future<void> checkselectdate() async {
    if (selectedDate != null) {
      setState(() {
        selectedDay = selectedDate;
        //  ! more
        var thaiLocale = const Locale('th', 'TH');
        var formatter = DateFormat.yMMMMd(thaiLocale.toString());
        var formattedDate = formatter.format(selectedDay!);
        selectDateController.text = formattedDate;

        print(formattedDate);
        print((selectDateController.text));
      });
    }
  }

  void addData() {
    newData = {
      'service': serviceController.text,
      'description': descriptionController.text,
      'amount': amountController.text,
      'unitprice': unitPriceController.text,
      'taxpercent': taxPercentController.text,
      'withholding': withholdingpercentController.text,
      'total': totalController.text,
      'documentDate': selectedDay.toString(),
    };
    // alldata.addAll(newData as Iterable<String>);
  }

  void checkTypepriceandSetdefault() {
    amountController.text = "1";
    unitPriceController.text = "0";
    withholdingpercentController.text = "0";
    totalController.text = "0";
    if (widget.typeprice.type == "รวมภาษี" ||
        widget.typeprice.type == "แยกภาษี") {
      taxPercentController.text = "7";
    } else if (widget.typeprice.type == "ไม่มีภาษี") {
      taxPercentController.text = "0";
    }
    calculateTotal();
  }

  void calculateTotal() {
    double totalvalue = (widget.typeprice.isVatIncluded!)
        ? double.parse(amountController.text) *
            double.parse(unitPriceController.text) /
            (double.parse(taxPercentController.text) / 100 + 1)
        : double.parse(amountController.text) *
            double.parse(unitPriceController.text);
    totalController.text = totalvalue.toStringAsFixed(2);
  }

  void resetData() {
    setState(() {
      selectDateController.clear();
      selectedDay = null;
      serviceController.clear();
      descriptionController.clear();
      checkTypepriceandSetdefault();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: CustomAppBar(
            image: "appbar_expenseandgood.png", title: 'ซื้อสินค้า/ค่าใช้จ่าย'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
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
                const Gap(15),
                Text(
                  'วันที่เอกสาร',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade600),
                ),
                Gap(10),
                // ! Container (Calendar)
                // ?  //  ! more
                Container(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () async {
                      selectedDate = await Navigator.push(
                        context,
                        PageTransition(
                          child: CalenderPage(selectedDay: selectedDay),
                          type: PageTransitionType.topToBottom,
                        ),
                      );
                      checkselectdate();
                      // Update the state with the selected date
                    },
                    child: AbsorbPointer(
                      absorbing: true,
                      child: TextFormField(
                        controller: selectDateController,
                        readOnly: true, // Set to true to make it non-editable
                        enabled:
                            false, // Set to false to disable the input field
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            // Your icon data goes here
                            Icons.calendar_today,
                            // size: 20,

                            color: Colors.grey.withOpacity(0.6),
                          ),
                          labelText: selectDateController.text.isEmpty
                              ? 'Select Date'
                              : null,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 16,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Color.fromARGB(255, 252, 119, 119),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(30),
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
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a value';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                    ),
                  ),
                ),

                // Container(
                //   height: 40,
                //   decoration: BoxDecoration(
                //     // color: Colors.red,
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
                //       // crossAxisAlignment: CrossAxisAlignment,
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         // SizedBox(width: 4),
                //         // Gap(0.2),
                //         Text(
                //           (selectedDay) != null
                //               ? DateFormat.yMMMd('th').format(selectedDay!)
                //               : 'Select a date',
                //           style: TextStyle(fontSize: 16),
                //         ),
                //         IconButton(
                //           // alignment: Alignment.bottomLeft,
                //           onPressed: () async {
                //             selectedDate = await Navigator.push(
                //               context,
                //               PageTransition(
                //                 child: CalenderPage(selectedDay: selectedDay),
                //                 type: PageTransitionType.topToBottom,
                //               ),
                //             );
                //             checkselectdate();
                //             // Update the state with the selected date
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
                Gap(20),
                Text(
                  'สินค้า/บริการ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade600),
                ),
                Gap(10),
                Container(
                  // height: 50, // Adjust the height as needed
                  width: double.infinity,
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //     width: 2.0,
                  //     color: Colors.grey.withOpacity(0.3),
                  //   ),
                  //   // borderSide: BorderSide(),
                  //   borderRadius: BorderRadius.circular(30),
                  //   // boxShadow: [
                  //   //   BoxShadow(
                  //   //     color: Colors.grey.withOpacity(0.5),
                  //   //     spreadRadius: 5,
                  //   //     blurRadius: 7,
                  //   //     offset: const Offset(0, 3),
                  //   //   ),
                  //   // ],
                  // ),
                  child: TextFormField(
                    controller: serviceController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 16), // Adjust vertical padding
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(255, 252, 119, 119),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        isDense: true,
                        // constraints:
                        //     const BoxConstraints(maxHeight: 60, minHeight: 30),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(30),
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
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                ),
                Gap(20),
                Text(
                  'รายละเอียด',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade600),
                ),
                Gap(10),
                SizedBox(
                  // height: 30,
                  width: double.infinity,
                  child: TextFormField(
                    // style: ,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 16), // Adjust vertical padding
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(255, 252, 119, 119),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        isDense: true,
                        // constraints:
                        //     const BoxConstraints(maxHeight: 60, minHeight: 30),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(30),
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
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                ),
                Gap(20),
                // ! AMOUT & UNITPRICE
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ! AMOUT
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'จำนวน',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        Gap(10),
                        SizedBox(
                          // height: 30,
                          width: 150,
                          child: TextFormField(
                            // style: ,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null; // Return null if the input is valid
                            },
                            onChanged: (value) {
                              setState(() {
                                calculateTotal();
                              });
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ], // จำกัดให้เป็นตัวเลขเท่านั้น
                            controller: amountController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 16), // Adjust vertical padding
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Color.fromARGB(255, 252, 119, 119),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                isDense: true,
                                // constraints:
                                //     const BoxConstraints(maxHeight: 60, minHeight: 30),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                errorStyle: TextStyle(fontSize: 15),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Gap(30),
                    // ! UNITPRICE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ราคา/หน่วย',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        Gap(10),
                        SizedBox(
                          // height: 30,
                          width: 150,
                          child: TextFormField(
                            // style: ,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null; // Return null if the input is valid
                            },
                            onChanged: (value) {
                              setState(() {
                                calculateTotal();
                              });
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ], // จำกัดให้เป็นตัวเลขเท่านั้น
                            controller: unitPriceController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 16), // Adjust vertical padding
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Color.fromARGB(255, 252, 119, 119),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                isDense: true,
                                // constraints:
                                //     const BoxConstraints(maxHeight: 60, minHeight: 30),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                errorStyle: TextStyle(fontSize: 15),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                )),
                          ),
                        ),
                      ],
                    ),
                    // Gap(20),
                  ],
                ),
                // ! TAXPERCENT & WITHHOLDINGPERCENT
                Gap(20),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ภาษี',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        Gap(10),
                        SizedBox(
                          // height: 30,
                          width: 150,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ], // จำกัดให้เป็นตัวเลขเท่านั้น
                            controller: taxPercentController,
                            // initialValue: taxPercentController.text,
                            // style: ,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null; // Return null if the input is valid
                            },
                            onChanged: (value) {
                              setState(() {
                                calculateTotal();
                              });
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 16), // Adjust vertical padding
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Color.fromARGB(255, 252, 119, 119),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                isDense: true,
                                // constraints:
                                //     const BoxConstraints(maxHeight: 60, minHeight: 30),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                errorStyle: TextStyle(fontSize: 15),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Gap(30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'หักราคา ณ ที่จ่าย',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        Gap(10),
                        SizedBox(
                          // height: 30,
                          width: 150,
                          child: TextFormField(
                            // style: ,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null; // Return null if the input is valid
                            },
                            onChanged: (value) {
                              setState(() {
                                calculateTotal();
                              });
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ], // จำกัดให้เป็นตัวเลขเท่านั้น
                            controller: withholdingpercentController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 16), // Adjust vertical padding
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Color.fromARGB(255, 252, 119, 119),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                isDense: true,
                                // constraints:
                                //     const BoxConstraints(maxHeight: 60, minHeight: 30),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                errorStyle: TextStyle(fontSize: 15),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                )),
                          ),
                        ),
                      ],
                    ),
                    // Gap(20),
                  ],
                ),
                Gap(20),
                Text(
                  'มูลค่ารวมก่อนภาษี',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade600),
                ),
                Gap(10),
                SizedBox(
                  // height: 30,
                  width: double.infinity,
                  child: TextFormField(
                    // style: ,
                    readOnly: true,
                    controller: totalController,
                    decoration: InputDecoration(
                      // fillColor: const Color.fromARGB(255, 237, 237, 237)
                      //     .withOpacity(0.5),
                      isDense: true,
                      enabled: true,
                      // filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                      // focusColor: Colors.grey.withOpacity(0.3),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2.0, color: Colors.grey.withOpacity(0.3)),
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

                const Gap(50),
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      resetData();
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
                const Gap(10),
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
                        debugPrint("success");
                        print(newData);
                        addData();
                        print(newData);
                        Navigator.pop(context, newData);
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
    //   },
    // );
  }
}
