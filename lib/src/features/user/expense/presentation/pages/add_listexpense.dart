import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uni_expense/src/components/models/typeprice_model.dart';
import 'package:uni_expense/src/features/user/expense/presentation/bloc/expensegood_bloc.dart';

import '../../../../../components/custominputdecoration.dart';
import '../../../allowance/presentation/widgets/customappbar.dart';
import '../../../fare/presentation/widgets/add_list/labeled_textfield.dart';
import '../../data/models/addlist_expensegood.dart';
import '../widgets/calender_page.dart';

class AddListExpenseDemo extends StatefulWidget {
  final ExpenseGoodBloc expensegoodBloc;
  final TypePriceModel? typeprice;
  final bool? isdraft;
  final AddListExpenseGood? listexpensegood;
  const AddListExpenseDemo({
    super.key,
    required this.expensegoodBloc,
    required this.typeprice,
    this.isdraft,
    this.listexpensegood,
  });

  @override
  State<AddListExpenseDemo> createState() => _AddListExpenseDemoState();
}

class _AddListExpenseDemoState extends State<AddListExpenseDemo> {
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
  bool isEditing = false;
  AddListExpenseGood? listexpensegood;
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  String? selectedDay;
  Future<void> checkselectdate() async {
    if (selectedDate != null) {
      setState(() {
        final DateFormat format = DateFormat('yyyy/MM/dd');
        final formattedDates = format.format(selectedDate!);
        selectedDay = formattedDates;
        //  ! more
        var thaiLocale = const Locale('th', 'TH');
        var formatter = DateFormat.yMMMMd(thaiLocale.toString());
        var formattedDate = formatter.format(selectedDate!);
        selectDateController.text = formattedDate;
        print(selectedDay);
        print(formatter);
        print(formattedDate);
        print((selectDateController.text));
      });
    }
  }

  void calculateTotal() {
    if (amountController.text.isNotEmpty &&
        unitPriceController.text.isNotEmpty) {
      double totalvalue = (widget.typeprice!.isVatIncluded!)
          ? double.tryParse(amountController.text)! *
              double.tryParse(unitPriceController.text)! /
              (double.tryParse(taxPercentController.text)! / 100 + 1)
          : double.tryParse(amountController.text)! *
              double.tryParse(unitPriceController.text)!;
      totalController.text = totalvalue.toStringAsFixed(2);
    }
  }

  void checkTypepriceandSetdefault() {
    amountController.text = "1";
    unitPriceController.text = "0";
    withholdingpercentController.text = "0";
    totalController.text = "0";
    taxPercentController.text = widget.typeprice!.vat.toString();
    calculateTotal();
  }

  @override
  void initState() {
    print(widget.isdraft);
    // print(jsonEncode(widget.typeprice));
    if (widget.listexpensegood != null) {
      isEditing = true;
      listexpensegood = widget.listexpensegood;
      print(listexpensegood);
      serviceController.text = listexpensegood!.service!;
      descriptionController.text = listexpensegood!.description!;
      amountController.text = listexpensegood!.amount.toString();
      unitPriceController.text = listexpensegood!.unitPrice.toString();
      taxPercentController.text = listexpensegood!.taxPercent.toString();
      withholdingpercentController.text =
          listexpensegood!.withholdingPercent.toString();
      totalController.text = listexpensegood!.total.toString();
      try {
        selectedDate =
            DateFormat('yyyy/MM/dd').parse(listexpensegood!.documentDate!);
        // Use selectedDate here (if parsing was successful)
      } catch (e) {
        if (e is FormatException) {
          print('Failed to parse date: $e');
          // Handle parsing error (e.g., display message, set selectedDate to null)
        }
      }
      print(selectedDate);
      print(listexpensegood!.documentDate!);
      checkselectdate();
    } else {
      checkTypepriceandSetdefault();
    }
    super.initState();
  }

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
                const Gap(10),
                // ! Container (Calendar)
                // ?  //  ! more
                Container(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () async {
                      selectedDate = await Navigator.push(
                        context,
                        PageTransition(
                          child: CalenderPage(selectedDay: selectedDate),
                          type: PageTransitionType.topToBottom,
                        ),
                      );
                      checkselectdate();
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
                            Icons.calendar_today,
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
                // Gap(20),
                // Text(
                //   'สินค้า/บริการ',
                //   style: TextStyle(
                //       fontSize: 14,
                //       fontWeight: FontWeight.normal,
                //       color: Colors.grey.shade600),
                // ),
                const Gap(20),
                LabeledTextField(
                  label: 'สินค้า/บริการ',
                  controller: serviceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                // Container(
                //   width: double.infinity,
                //   child: TextFormField(
                //     controller: serviceController,
                //     decoration: InputDecoration(
                //         contentPadding: EdgeInsets.symmetric(
                //             vertical: 5,
                //             horizontal: 16), // Adjust vertical padding
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             width: 2.0,
                //             color: Color.fromARGB(255, 252, 119, 119),
                //           ),
                //           borderRadius: BorderRadius.circular(30),
                //         ),
                //         isDense: true,
                //         // constraints:
                //         //     const BoxConstraints(maxHeight: 60, minHeight: 30),
                //         enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             width: 2.0,
                //             color: Colors.grey.withOpacity(0.3),
                //           ),
                //           borderRadius: BorderRadius.circular(30),
                //         ),
                //         border: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             width: 2.0,
                //             color: Colors.grey.withOpacity(0.3),
                //           ),
                //           borderRadius: BorderRadius.all(Radius.circular(30)),
                //         ),
                //         errorStyle: TextStyle(fontSize: 15),
                //         errorBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             width: 2.0,
                //             color: Colors.grey.withOpacity(0.3),
                //           ),
                //           borderRadius: BorderRadius.all(Radius.circular(30)),
                //         )),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter a value';
                //       }
                //       return null; // Return null if the input is valid
                //     },
                //   ),
                // ),
                // Gap(20),
                LabeledTextField(
                  label: 'รายละเอียด',
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                // Text(
                //   'รายละเอียด',
                //   style: TextStyle(
                //       fontSize: 14,
                //       fontWeight: FontWeight.normal,
                //       color: Colors.grey.shade600),
                // ),
                // Gap(10),
                // SizedBox(
                //   // height: 30,
                //   width: double.infinity,
                //   child: TextFormField(
                //     // style: ,
                //     controller: descriptionController,
                //     decoration: InputDecoration(
                //         contentPadding: EdgeInsets.symmetric(
                //             vertical: 5,
                //             horizontal: 16), // Adjust vertical padding
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             width: 2.0,
                //             color: Color.fromARGB(255, 252, 119, 119),
                //           ),
                //           borderRadius: BorderRadius.circular(30),
                //         ),
                //         isDense: true,
                //         // constraints:
                //         //     const BoxConstraints(maxHeight: 60, minHeight: 30),
                //         enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             width: 2.0,
                //             color: Colors.grey.withOpacity(0.3),
                //           ),
                //           borderRadius: BorderRadius.circular(30),
                //         ),
                //         border: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             width: 2.0,
                //             color: Colors.grey.withOpacity(0.3),
                //           ),
                //           borderRadius: BorderRadius.all(Radius.circular(30)),
                //         ),
                //         errorStyle: TextStyle(fontSize: 15),
                //         errorBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             width: 2.0,
                //             color: Colors.grey.withOpacity(0.3),
                //           ),
                //           borderRadius: BorderRadius.all(Radius.circular(30)),
                //         )),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter a value';
                //       }
                //       return null; // Return null if the input is valid
                //     },
                //   ),
                // ),
                // Gap(20),
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
                                print(value);
                                print(amountController.text);
                                print(double.parse(amountController.text));
                                setState(() {
                                  calculateTotal();
                                });
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ], // จำกัดให้เป็นตัวเลขเท่านั้น

                              controller: amountController,
                              decoration:
                                  CustomInputDecoration.getInputDecoration()),
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
                            decoration:
                                CustomInputDecoration.getInputDecoration(),
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
                              decoration:
                                  CustomInputDecoration.getInputDecoration()),
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
                              decoration:
                                  CustomInputDecoration.getInputDecoration()),
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
                      // resetData();
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
                        final unitPrice = (widget.typeprice!.isVatIncluded ==
                                true)
                            ? (double.tryParse(unitPriceController.text)! *
                                    100) /
                                (100 +
                                    double.tryParse(taxPercentController.text)!)
                            : double.tryParse(unitPriceController.text);
                        final newtotal =
                            double.tryParse(amountController.text)! *
                                unitPrice!;
                        final newtax = newtotal *
                            double.tryParse(taxPercentController.text)! /
                            100;
                        final newwithholding = newtotal *
                            double.tryParse(
                                withholdingpercentController.text)! /
                            100;
                        final newTotalPrice = newtotal + newtax;
                        final net = newtotal + newtax - newwithholding;
                        print("unitPrice $unitPrice");
                        print("newtotal $newtotal");
                        print("newtax $newtax");
                        print("newTotalPrice $newTotalPrice");
                        print("newwithholding $newwithholding");
                        print("net $net");
                        print("totalController.text ${totalController.text}");
                        if (isEditing) {
                          final listlocationfuel =
                              widget.listexpensegood!.copyWith(
                            documentDate: selectedDay,
                            service: serviceController.text,
                            description: descriptionController.text,
                            amount: int.tryParse(amountController.text),
                            unitPrice: int.tryParse(unitPriceController.text),
                            taxPercent: int.tryParse(taxPercentController.text),
                            tax: newtax,
                            net: net,
                            total: newtotal,
                            withholdingPercent:
                                int.tryParse(withholdingpercentController.text),
                            totalPrice: newTotalPrice,
                            withholding: newwithholding,
                          );
                          print(listlocationfuel);
                          widget.expensegoodBloc.add(
                            UpdateListExpenseEvent(
                                listExpense: listlocationfuel),
                          );
                        } else {
                          final listlocationfuel = AddListExpenseGood(
                            idExpenseGoodsItem: (widget.isdraft != null &&
                                    widget.isdraft == true)
                                ? null
                                : DateTime.now().toIso8601String(),
                            documentDate: selectedDay,
                            service: serviceController.text,
                            description: descriptionController.text,
                            amount: int.tryParse(amountController.text),
                            unitPrice: int.tryParse(unitPriceController.text),
                            taxPercent: int.tryParse(taxPercentController.text),
                            tax: newtax,
                            net: net,
                            total: newtotal,
                            withholdingPercent:
                                int.tryParse(withholdingpercentController.text),
                            totalPrice: newTotalPrice,
                            withholding: newwithholding,
                          );
                          widget.expensegoodBloc.add(
                            AddListExpenseEvent(listExpense: listlocationfuel),
                          );
                        }
                        widget.expensegoodBloc.add(
                          CalcualteSumEvent(),
                        );
                        Navigator.pop(context);
                        // print(newData);
                        // addData();
                        // print(newData);
                        // Navigator.pop(context, newData);
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
