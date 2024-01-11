import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
// import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/bloc/allowance_bloc.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/pages/allowance_add_list.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/customappbar.dart';

// import '../../../../../components/concurrency.dart';
import '../../../../../../injection_container.dart';
import '../../../../../components/customselectedtabbar.dart';
import '../../../../../components/filepicker.dart';
import '../../../../../components/motion_toast.dart';
import '../../../../../core/features/user/presentation/provider/profile_provider.dart';
import '../../data/models/addexpenseallowance_model.dart';
// import '../../../../../components/models/concurrency_model,.dart';

class AllowanceGeneralInformation extends StatefulWidget {
  const AllowanceGeneralInformation({super.key});

  @override
  State<AllowanceGeneralInformation> createState() =>
      _AllowanceGeneralInformationState();
}

class _AllowanceGeneralInformationState
    extends State<AllowanceGeneralInformation> {
  PlatformFile? selectedFile;
  final allowanceBloc = sl<AllowanceBloc>();
  // final concurrencyRateController = TextEditingController();
  final nameExpenseController = TextEditingController();
  final approverController = TextEditingController();
  final remarkController = TextEditingController();
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  String _enteredText = '';
  List<String> selectedValues = [];
  // int totalDays = 0;
  // List<ExpenseData> dataInitial = [];
  List<Map<String, dynamic>> listExpense = [];
  static const allowanceRate = 500;
  static const allowanceRateInternational = 4000;
  static const govermentAllowanceRate = 270;
  static const govermentAllowanceRateInternational = 3100;
  static bool isInternational = false;
  late double sumAllowance;
  late double totalGovermentAllowance;
  late int _tabTextIndexSelected;
  @override
  void initState() {
    super.initState();
    _tabTextIndexSelected = 0;
    // final ProfileProvider user =
    //     Provider.of<ProfileProvider>(context, listen: false);
    allowanceBloc.add(GetEmployeesAllRolesDataEvent());
  }

  Map<String, dynamic> formData = {
    'nameExpense': '',
    'isInternational': isInternational ? 1 : 0,
    'allowanceRate': 500,
    'allowanceRateGoverment': 270,
    'listExpense': [], // ตัวอย่างนี้ listExpense ถูกกำหนดเป็น List เปล่าก่อน
    'remark': '',
    'typeExpense': 2,
    'typeExpenseName': 'Allowance',
    'lastUpdateDate': DateFormat('yyyy/MM/dd').format(DateTime.now()),
    'status': 1,
    'sumAllowance': 0.0,
    'sumSurplus': 0.0,
    'sumDays': 1.0,
    'sumNet': 0.0,
    'approver': 0,
    'cc_email': [],
    'idPosition': 0,
  };
  // Create a function to convert formData to AddExpenseAllowanceModel
  AddExpenseAllowanceModel convertFormDataToModel(
      Map<String, dynamic> formData) {
    return AddExpenseAllowanceModel(
      nameExpense: formData['nameExpense'],
      isInternational: formData['isInternational'],
      listExpense: formData['listExpense'] == null
          ? []
          : List<ListExpenseModel>.from(
              formData['listExpense'].map((x) => ListExpenseModel.fromJson(x))),
      file: selectedFile,
      remark: formData['remark'],
      typeExpense: formData['typeExpense'],
      typeExpenseName: formData['typeExpenseName'],
      lastUpdateDate: DateTime.now()
          .toLocal()
          .subtract(
            Duration(
              hours: DateTime.now().hour,
              minutes: DateTime.now().minute,
              seconds: DateTime.now().second,
              milliseconds: DateTime.now().millisecond,
              microseconds: DateTime.now().microsecond,
            ),
          )
          .toLocal(),
      status: formData['status'],
      sumAllowance: formData['sumAllowance'].toInt(),
      sumSurplus: formData['sumSurplus'].toInt(),
      sumDays: formData['sumDays'].toInt(),
      sumNet: formData['sumNet'].toInt(),
      idEmpApprover: formData['approver'],
      ccEmail: formData['cc_email'],
      idPosition: formData['idPosition'],
    );
  }

// Use the function to convert formData to AddExpenseAllowanceModel
  void calculateSum(List<dynamic> array) {
    formData['sumDays'] = array.fold<double>(0, (sum, expense) {
      return sum + ((expense['countDays'] ?? 0) as double);
    });
    // if (!isInternational) {
    sumAllowance = (formData['sumDays'] * formData['allowanceRate']).toDouble();
    totalGovermentAllowance =
        (formData['sumDays'] * formData['allowanceRateGoverment'])
            .ceil()
            .toDouble();
    formData['sumSurplus'] = totalGovermentAllowance - sumAllowance < 0
        ? sumAllowance - totalGovermentAllowance
        : 0;
    formData['sumAllowance'] = sumAllowance;
    formData['sumNet'] = sumAllowance;
    print(formData);
  }

  @override
  Widget build(BuildContext context) {
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(
          image: 'appbar_aollowance.png', title: 'เบี้ยเลี้ยง'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: BlocProvider(
            create: (context) => allowanceBloc,
            child: Form(
              key: _keyForm,
              child: BlocBuilder<AllowanceBloc, AllowanceState>(
                builder: (context, state) {
                  if (state is AllowanceInitial) {
                    return Text(
                      "ไม่พบข้อมูล",
                    );
                  } else if (state is AllowanceLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AllowanceFinish) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ข้อมูลทั่วไป',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Gap(20),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'ชื่อรายการ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily:
                                      'kanit', // Explicitly set the fontFamily
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(10),
                        TextFormField(
                          controller: nameExpenseController,
                          onChanged: (value) {
                            print(value);
                            print(nameExpenseController.text);
                            nameExpenseController.text = value;
                            print(nameExpenseController.text);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a nameExpense';
                            }
                            setState(() {
                              formData['nameExpense'] = value;
                            });
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
                          'สถานที่เกิดค่าใช้จ่าย',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        const Gap(10),
                        CustomSelectedTabbar(
                          labels: ['ในประเทศ', 'ต่างประเทศ'],
                          selectedIndex: _tabTextIndexSelected,
                          onTabChanged: (index) {
                            formData["isInternational"] =
                                !formData["isInternational"];
                            print(
                                "formData['isInternational'] ${formData['isInternational']}");
                            setState(() {
                              if (formData["isInternational"]) {
                                formData["allowanceRate"] =
                                    allowanceRateInternational;
                                formData["allowanceRateGoverment"] =
                                    govermentAllowanceRateInternational;
                              } else {
                                formData["allowanceRate"] = allowanceRate;
                                formData["allowanceRateGoverment"] =
                                    govermentAllowanceRate;
                              }
                              calculateSum(formData["listExpense"]);
                              _tabTextIndexSelected = index;
                              print(_tabTextIndexSelected);
                              isInternational = !isInternational;
                              print(isInternational);
                              setState(() {
                                calculateSum(listExpense);
                              });
                            });
                          },
                        ),
                        const Gap(20),
                        Text(
                          'CC ถึง',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        const Gap(10),
                        MultiSelectDropDown(
                          onOptionSelected: (options) {
                            setState(() {
                              selectedValues = options
                                  .map((item) {
                                    if (item.value != null) {
                                      final email = item.label.split('\n')[1];

                                      return email.trim();
                                    }
                                    return null;
                                  })
                                  .whereType<String>() // Filter out null values
                                  .toList();
                              formData['cc_email'] = selectedValues;
                              print(formData);
                              print("FORMDATA EMAIL${formData['cc_email']}");
                            });
                            FocusScope.of(context).unfocus();
                            debugPrint(selectedValues.toString());
                          },
                          showClearIcon: true,
                          options: state.empsallrole!
                              .map((employee) => ValueItem(
                                  label:
                                      '${employee.firstnameTh!}  ${employee.lastnameTh} \n${employee.email}',
                                  value: employee.firstnameTh! +
                                      employee.lastnameTh!))
                              .toList(),
                          maxItems: 3,
                          searchEnabled: true,
                          borderRadius: 30,
                          selectionType: SelectionType.multi,
                          chipConfig: const ChipConfig(
                              wrapType: WrapType.scroll, autoScroll: true),
                          dropdownHeight: 300,
                          optionTextStyle: const TextStyle(fontSize: 16),
                          selectedOptionIcon: const Icon(Icons.check_circle),
                        ),
                        const Gap(20),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'ผู้อนุมัติ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily:
                                      'kanit', // Explicitly set the fontFamily
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(10),
                        SearchField(
                          // onSearchTextChanged: ,
                          // Validation logic
                          validator: (x) {
                            print("Value of x: $x");

                            if (approverController.text.isNotEmpty) {
                              String enteredText =
                                  approverController.text.trim();
                              print("enteredText: '$enteredText'");

                              List<String> suggestionTexts = state.empsallrole!
                                  .map((e) =>
                                      "${e.firstnameTh} ${e.lastnameTh}".trim())
                                  .toList();
                              print("Suggestion Texts: $suggestionTexts");

                              List<Object> suggestionIds = state.empsallrole!
                                  .map((e) =>
                                      e.idManagerLV1 ??
                                      "") // Replace "" with a default value if idManagerLV1 can be null
                                  .toList();
                              print("Suggestion Ids: $suggestionIds");

                              // Check if the trimmed entered text exactly matches any suggestion
                              if (suggestionTexts
                                  .map((e) => e.replaceAll(RegExp(r'\s+'), ''))
                                  .contains(enteredText.replaceAll(
                                      RegExp(r'\s+'), ''))) {
                                int index = suggestionTexts
                                    .map(
                                        (e) => e.replaceAll(RegExp(r'\s+'), ''))
                                    .toList()
                                    .indexOf(enteredText.replaceAll(
                                        RegExp(r'\s+'), ''));

                                if (x == enteredText) {
                                  setState(() {
                                    formData['approver'] = suggestionIds[index];
                                    print(formData['approver']);
                                  });
                                  return null; // Validation passed
                                }
                              }
                            }
                            return 'Please Enter a valid State';
                          },

                          onSuggestionTap: (selectedItem) {
                            if (selectedItem is SearchFieldListItem<String>) {
                              approverController.text = selectedItem.item!;
                              FocusScope.of(context).unfocus();
                            }
                            print(approverController.text);
                          },

                          textInputAction: TextInputAction.done,
                          controller: approverController,
                          suggestionState: Suggestion.expand,
                          // focusNode: focus,
                          // onSuggestionTap: (SearchFieldListItem<String> x) {
                          //   focus.unfocus();
                          // },
                          scrollbarDecoration: ScrollbarDecoration(
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(2),
                                      bottom: Radius.circular(2)),
                                  side: BorderSide(
                                      width: 1, color: Color(0xffff99ca))),
                              thumbColor: Color(0xffff99ca)),
                          itemHeight: 50,
                          emptyWidget: Container(
                            alignment: Alignment.center,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 8.0, // soften the shadow
                                  spreadRadius: 20.0, //extend the shadow
                                  offset: Offset(
                                    2.0,
                                    5.0,
                                  ),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Text('ไม่พบข้อมูล'),
                          ),
                          suggestions: state.empsallrole!
                              .map((e) => SearchFieldListItem(
                                  "${e.firstnameTh}  ${e.lastnameTh}",
                                  // "${e.idEmployees}",
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "${e.firstnameTh}  ${e.lastnameTh}"),
                                  )))
                              .toList(),
                          suggestionsDecoration: SuggestionDecoration(
                            border: Border.all(
                                width: 2, color: Colors.grey.shade300),
                            padding:
                                EdgeInsets.only(right: 8, top: 8, bottom: 8),
                            // shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 8.0, // soften the shadow
                                spreadRadius: 20.0, //extend the shadow
                                offset: Offset(
                                  2.0,
                                  5.0,
                                ),
                              ),
                            ],
                          ),
                          searchInputDecoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2.0,
                                  color: Color.fromARGB(255, 252, 119, 119)),
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
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 2.0,
                                  color: Colors.grey.withOpacity(0.3)),
                            ),
                          ),
                        ),
                        const Gap(30),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        const Gap(20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'รายการ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          'kanit', // Explicitly set the fontFamily
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      // fontSize: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Text(
                            //   'รายการ',
                            //   style: TextStyle(
                            //       fontSize: 16, fontWeight: FontWeight.bold),
                            // ),
                            InkWell(
                              borderRadius: BorderRadius.circular(30.0),
                              onTap: () async {
                                List<ExpenseData> dataInitial =
                                    await Navigator.push(
                                  context,
                                  PageTransition(
                                    duration: Durations.medium1,
                                    type: PageTransitionType.rightToLeft,
                                    child: const AllowanceAddList(),
                                  ),
                                );
// Update listExpense with new data from dataInitial
                                ExpenseData.updateListExpense(
                                    dataInitial, listExpense);

// Print the updated listExpense as JSON
                                print(json.encode(listExpense));
                                formData['listExpense'] = listExpense;
                                print(
                                    "${formData['listExpense']} 'listExpense'");
                                setState(() {
                                  calculateSum(listExpense);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffff99ca),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context)
                                            .devicePixelRatio *
                                        7,
                                    vertical: MediaQuery.of(context)
                                            .devicePixelRatio *
                                        2.5),
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
                        Gap(10),
                        (listExpense.isEmpty)
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context)
                                            .devicePixelRatio *
                                        1,
                                    bottom: MediaQuery.of(context)
                                            .devicePixelRatio *
                                        1),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
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
                                ))
                            : ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                reverse: true,
                                itemCount: listExpense.length,
                                itemBuilder: (context, index) {
                                  return Slidable(
                                    endActionPane: ActionPane(
                                        motion: const StretchMotion(),
                                        children: [
                                          SlidableAction(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              icon: IconaMoon.edit,
                                              onPressed: (_) async {
                                                print('edit');
                                              },
                                              backgroundColor: Colors.amber,
                                              foregroundColor: Colors.white,
                                              flex: 2),
                                          SlidableAction(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              icon: Icons.delete_rounded,
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              onPressed: (_) {
                                                setState(() {
                                                  listExpense.removeAt(index);
                                                  // recieveData!.clear();
                                                  calculateSum(listExpense);
                                                });
                                              },
                                              flex: 2),
                                        ]),
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        surfaceTintColor:
                                            Color.fromARGB(255, 255, 218, 218),
                                        shadowColor:
                                            Color.fromARGB(255, 249, 90, 167),
                                        elevation: 8,
                                        color: Color(0xffff99ca),

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 15),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text('รายละเอียด: ',
                                                        style: TextStyle(
                                                            // color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Gap(5),
                                                    Text(
                                                        '${listExpense[index]['description']}'),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(8),
                                                    // height: 50,
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Color(
                                                                    0xfffc466b)
                                                                .withOpacity(
                                                                    0.5),
                                                            offset:
                                                                Offset(5, 5),
                                                            blurRadius: 10,
                                                          )
                                                        ],
                                                        gradient: SweepGradient(
                                                          colors: [
                                                            Color(0xfffc466b),
                                                            Color(0xff3f5efb)
                                                          ],
                                                          stops: [0.25, 0.75],
                                                          center: Alignment
                                                              .topRight,
                                                        ),
                                                        color: Colors.white,
                                                        // border:
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15))),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text('Start Date',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white)),
                                                        Text(
                                                            ' ${listExpense[index]['startDate']}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Icon(IconaMoon
                                                          .arrowRight1),
                                                      Text(
                                                          '${listExpense[index]['countDays']} วัน')
                                                    ],
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Color(
                                                                    0xfffc466b)
                                                                .withOpacity(
                                                                    0.5),
                                                            offset:
                                                                Offset(5, 5),
                                                            blurRadius: 10,
                                                          )
                                                        ],
                                                        gradient: SweepGradient(
                                                          colors: [
                                                            Color(0xfffc466b),
                                                            Color(0xff3f5efb)
                                                          ],
                                                          stops: [0.25, 0.75],
                                                          center: Alignment
                                                              .topRight,
                                                        ),
                                                        color: Colors.white,
                                                        // border:
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15))),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text('End Date',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white)),
                                                        Text(
                                                            '${listExpense[index]['endDate']}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Gap(5),
                                            ],
                                          ),
                                        ),
                                        // subtitle:
                                        // Add more details as needed
                                      ),
                                    ),
                                  );
                                },
                              ),
                        Gap(10),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        const Gap(25),
                        const Text(
                          'สรุปรายการ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'สรุปจำนวนวันเดินทาง',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            Text(
                              '${formData['sumDays'].toStringAsFixed(2)} วัน',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'เบี้ยเลี้ยง/วัน',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            Text(
                              '${NumberFormat("###,###.00#", "en_US").format(double.parse(formData["allowanceRate"].toString()))} บาท',
                              // : '${NumberFormat("###,###.00#", "en_US").format(double.parse(allowanceRateInternational.toString()))} บาท',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'เบี้ยเลี้ยงตามอัตราราชการ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            Text(
                              '${NumberFormat("###,###.00#", "en_US").format(double.parse(formData["allowanceRateGoverment"].toString()))} บาท',
                              // !isInternational
                              //     ? '${NumberFormat("###,###.00#", "en_US").format(double.parse(govermentAllowanceRate.toString()))} บาท'
                              //     : '${NumberFormat("###,###.00#", "en_US").format(double.parse(govermentAllowanceRateInternational.toString()))} บาท',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'เบี้ยเลี้ยงส่วนเกินอัตราราชการ  ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey),
                                ),
                                Text(
                                  '(จะถูกนำคิดภาษีเงินได้)',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                ' ${NumberFormat("#,##0.00", "en_US").format(formData['sumSurplus'])} บาท ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'มูลค่าสุทธิรวม',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                            Text(
                              ' ${NumberFormat("#,##0.00", "en_US").format(formData['sumNet'])} บาท ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        const Gap(25),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        const Gap(25),
                        // const Text(
                        //   'แนบไฟล์เอกสาร',
                        //   style: TextStyle(
                        //       fontSize: 16, fontWeight: FontWeight.bold),
                        // ),
                        // const Gap(25),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(
                        //         20), // Use BorderRadius.circular for rounded corners
                        //     color: Color.fromRGBO(255, 234, 239, 0.29),
                        //   ),
                        //   // width: MediaQuery.of(context).size.width * 0.9,
                        //   // height: MediaQuery.of(context).size.height * 0.17,
                        //   width: double.infinity,
                        //   height: 208,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Image.asset(
                        //         "assets/images/img_expense_pick.png",
                        //         fit: BoxFit.fill,
                        //       ),
                        //       const Text('อัพโหลดไฟล์ที่นี่'),
                        //       const Gap(5),
                        //       ClipOval(
                        //         child: Material(
                        //           color: Color(0xffff99ca), // Button color
                        //           child: InkWell(
                        //             splashColor:
                        //                 Color(0xffff99ca), // Splash color
                        //             onTap: () {},
                        //             child: const SizedBox(
                        //                 width: 56,
                        //                 height: 56,
                        //                 child: Icon(IconaMoon.share2,
                        //                     color: Colors.white)),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        FilePickerComponent(
                          onFileSelected: (file) {
                            setState(() {
                              print(file);
                              selectedFile = file;
                              formData['file'] =
                                  file != null ? file.path : null;
                              print(formData['file']);
                              print(formData);
                            });
                          },
                        ),
                        const Gap(25),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        const Gap(30),
                        const Text(
                          'หมายเหตุ (เพิ่มเติม)',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Gap(20),
                        SizedBox(
                          // color: Colors.red,
                          // height: 200,
                          width: double.infinity,
                          child: TextFormField(
                            controller: remarkController,
                            onChanged: (value) {
                              setState(() {
                                _enteredText = value;
                                formData['remark'] = remarkController.text;
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
                              counterText:
                                  '${_enteredText.length.toString()} / ${500}',
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
                                    width: 2.0,
                                    color: Colors.grey.withOpacity(0.3)),
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
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_keyForm.currentState!.validate()) {
                                if (formData['listExpense'] == null ||
                                    formData['listExpense'].isEmpty) {
                                  return CustomMotionToast.show(
                                    context: context,
                                    title: "ListExpense is empty",
                                    description: "Please Add ListExpense",
                                    icon: Icons.notification_important,
                                    primaryColor: Colors.pink,
                                    width: 300,
                                    height: 100,
                                    animationType: AnimationType.fromLeft,
                                    fontSizeTitle: 18.0,
                                    fontSizeDescription: 15.0,
                                  );
                                }
                                formData['idPosition'] =
                                    profileProvider.profileData.idPosition!;
                                debugPrint("success");
                                print(formData);
                                print(approverController.text);
                                formData.forEach((key, value) {
                                  print('$key: ${value.runtimeType}');
                                });
                                print(profileProvider
                                    .profileData.idEmployees!.runtimeType);
                                AddExpenseAllowanceModel model =
                                    convertFormDataToModel(formData);
                                // print(profileProvider.profileData.idpo!);
                                allowanceBloc.add(AddExpenseAllowanceEvent(
                                  idCompany:
                                      profileProvider.profileData.idEmployees!,
                                  addallowancedata: model,
                                ));
                                setState(() {});
                                // print(model.file.runtimeType);
                                // ));
                              } else {
                                print(formData);
                                debugPrint("not success");
                                print(approverController.text);
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  width: 2,
                                  color: Color(0xffff99ca)), // สีขอบสีส้ม
                            ),
                            icon: const Icon(Icons.save_as,
                                color: Color(0xffff99ca)),
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
                    );
                  } else if (state is AllowanceFailure) {
                    return const Text("error");
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
