import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:gap/gap.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/customappbar.dart';
import 'package:uni_expense/src/features/user/welfare/presentation/pages/general_infor.dart';

import '../../../../../components/custominputdecoration.dart';

// import '../../../expense/presentation/widgets/calender_page.dart';
class MedicalBefitsAddList extends StatefulWidget {
  const MedicalBefitsAddList({super.key});

  @override
  State<MedicalBefitsAddList> createState() => _MedicalBefitsAddListState();
}

class _MedicalBefitsAddListState extends State<MedicalBefitsAddList> {
  Map<String, dynamic> listexpense = {};
  final _formKey = GlobalKey<FormState>();
  final selectDateController = TextEditingController();
  final dateDateController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? selectedDate;
  // DateTime? selectedDay;
  var thaiDateFormat = DateFormat('d MMMM y', 'th_TH');
  @override
  void initState() {
    super.initState();
    setdefault();
  }

  void setdefault() {
    var now = DateTime.now();
    String formattedDate = thaiDateFormat
        .format(now)
        .replaceAll('${now.year}', '${now.year + 543}');
    selectDateController.text = formattedDate;
  }

  void resetData() {
    setState(() {
      setdefault();
      selectedDate = null;
      descriptionController.clear();
      priceController.clear();
    });
  }

  void addData() {
    WelfareData welfareData;
    welfareData = WelfareData(
      description: descriptionController.text,
      price: priceController.text.replaceAll(",", ""),
    );
    // อัปเดต List ใน dataInitial โดยเพิ่มข้อมูลใหม่
    List<WelfareData> updatedDataInitial = [
      // ...widget.dataInitial,
      welfareData
    ];
    Navigator.pop(context, updatedDataInitial);
  }

  Future<void> checkselectdate() async {
    if (selectedDate != null) {
      setState(() {
        // DateFormat
        // selectedDay = selectedDate;

        // var thaiLocale = const Locale('th', 'TH');
        var formatter = DateFormat('yyyy/MM/dd');
        dateDateController.text = formatter.format(selectedDate!);

        print('data ${dateDateController.text}');
        var formattedDate = thaiDateFormat
            .format(selectedDate!)
            .replaceAll('${selectedDate!.year}', '${selectedDate!.year + 543}');
        selectDateController.text = formattedDate;
        print(selectedDate);
        print((selectDateController.text));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          image: "appbar_medicalbenefits.png", title: "สวัสดิการรักษาพยาบาล"),
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
              const Gap(20),
              Text(
                'วันที่เอกสาร',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade600),
              ),
              const Gap(10),
              Container(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () async {
                    selectedDate = await showRoundedDatePicker(
                      fontFamily: 'kanit',
                      initialDatePickerMode: DatePickerMode.day,
                      theme: ThemeData(
                        primaryColor: const Color.fromARGB(255, 252, 119, 119),
                        // backgroundColor: Color.fromARGB(255, 252, 119, 119),
                        hintColor: Colors.green[800],
                      ),
                      styleDatePicker: MaterialRoundedDatePickerStyle(
                        textStyleButtonNegative: const TextStyle(
                          color: Color.fromARGB(255, 252, 119, 119),
                        ),
                        textStyleButtonPositive: const TextStyle(
                          color: Color.fromARGB(255, 252, 119, 119),
                        ),
                        textStyleDayOnCalendarSelected:
                            const TextStyle(color: Colors.white),
                        decorationDateSelected: const BoxDecoration(
                            color: Color.fromARGB(255, 252, 119, 119),
                            shape: BoxShape.circle),
                        textStyleDayButton: const TextStyle(
                            fontFamily: 'kanit',
                            fontSize: 20,
                            color: Colors.white),
                        textStyleYearButton: const TextStyle(
                          fontFamily: 'kanit',
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      height: 300,
                      initialDate: (selectedDate != null) ? selectedDate : null,
                      context: context,
                      locale: const Locale("th", "TH"),
                      era: EraMode.BUDDHIST_YEAR,
                    );
                    checkselectdate();
                    // Update the state with the selected date
                  },
                  child: AbsorbPointer(
                    absorbing: true,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: selectDateController,
                      readOnly: true, // Set to true to make it non-editable
                      enabled: false, // Set to false to disable the input field
                      decoration: CustomInputDecoration.getInputDecoration(
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.grey.withOpacity(0.6),
                        ),
                        labelText: selectDateController.text.isEmpty
                            ? 'Select Date'
                            : null,
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
              const Gap(20),
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
                    return 'Please enter a value';
                  }
                  return null; // Return null if the input is valid
                },
                decoration: CustomInputDecoration.getInputDecoration(),
              ),
              const Gap(20),
              Text(
                'จำนวนเงิน',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade600),
              ),
              const Gap(10),
              TextFormField(
                controller: priceController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim() == '' ||
                      value.trim() == '0.00') {
                    return 'Please enter a value';
                  }
                  priceController.text = value.replaceAll(",", "");
                  return null; // Return null if the input is valid
                },
                // onTap: () {
                //   var textFieldNum = priceController.value.text;
                //   var numSanitized = numSanitizedFormat.parse(textFieldNum);
                //   _subscriptionPriceController.value = TextEditingValue(
                //     /// Clear if TextFormField value is 0
                //     text: numSanitized == 0 ? '' : '$numSanitized',
                //     selection:
                //         TextSelection.collapsed(offset: '$numSanitized'.length),
                //   );
                // },

                onFieldSubmitted: (price) {
                  final formattedPrice = NumberFormat("###,##0.00#", "en_US")
                      .format(double.parse(price));
                  debugPrint('Formatted $formattedPrice');
                  priceController.value = TextEditingValue(
                    text: formattedPrice,
                    selection:
                        TextSelection.collapsed(offset: formattedPrice.length),
                  );
                },
                // onChanged: (price) {
                //   final formattedPrice = NumberFormat("#,###,##0", "en_US")
                //       .format(double.parse(price));
                //   debugPrint('Formatted $formattedPrice');
                //   priceController.value = TextEditingValue(
                //     text: formattedPrice,
                //     selection:
                //         TextSelection.collapsed(offset: formattedPrice.length),
                //   );
                // },
                decoration: CustomInputDecoration.getInputDecoration(),
              ),
              const Gap(170),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    resetData();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        width: 2, color: Color(0xffff99ca)), // สีขอบสีส้ม
                  ),
                  child: const Text(
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
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xffff99ca), // สีปุ่มสีส้ม
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      debugPrint("success");
                      addData();
                    } else {
                      debugPrint("not success");
                    }
                    // Navigator.pop(context)
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         child: const MedicalBenefitsGeneralInformation(),
                    //         type: PageTransitionType.topToBottom));
                  },
                  child: const Text(
                    'บันทึกรายการ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white, // สีข้อความขาว
                    ),
                  ),
                ),
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}

class WelfareData {
  // int? idExpenseAllowanceItem;
  String? description;
  String? price;

  WelfareData({
    // this.,
    required this.description,
    required this.price,
  });

  // Convert ExpenseData to Map
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'price': price,
    };
  }

  // Convert List<ExpenseData> to List<Map<String, dynamic>>
  static List<Map<String, dynamic>> listToJson(List<WelfareData> expenseList) {
    return expenseList.map((expense) => expense.toJson()).toList();
  }

  // Update listExpense with new data
  static void updateListExpense(
      List<WelfareData> expenseList, List<Map<String, dynamic>> listExpense) {
    List<Map<String, dynamic>> jsonList = listToJson(expenseList);
    listExpense.addAll(jsonList);
  }
}
