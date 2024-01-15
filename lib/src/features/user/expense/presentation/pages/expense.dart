// import 'dart:js_interop';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:gap/gap.dart';
import 'package:iconamoon/iconamoon.dart';
// import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
// import 'package:collection/collection.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:open_file/open_file.dart';
// import 'package:multiple_search_selection/helpers/search_controller.dart';
// import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:page_transition/page_transition.dart';
import 'package:searchfield/searchfield.dart';
import 'package:uni_expense/injection_container.dart';
import 'package:uni_expense/src/features/user/expense/presentation/bloc/expensegood_bloc.dart';
import 'package:uni_expense/src/features/user/expense/presentation/pages/add_list_expense.dart';
import 'package:uni_expense/src/features/user/expense/presentation/pages/edit_list_expense.dart';

import '../../../../../components/concurrency.dart';
import '../../../../../components/models/concurrency_model,.dart';
import '../../../../../components/models/typeprice_model.dart';
import '../../../../../components/motion_toast.dart';
import '../../../../../components/typeprice.dart';
import '../../../allowance/presentation/widgets/customappbar.dart';
// import '../../domain/entities/entities.dart';
// import '../../domain/entities/entities.dart';

class Expense extends StatefulWidget {
  const Expense({
    super.key,
  });

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  List<String> locationexpensel = ['ในประเทศ', 'ต่างประเทศ'];
  late int _tabTextIndexSelected;
  late ConcurrencyModel _selectedCurrency;
  late TypePriceModel _selectedTypeprice;
  List<ConcurrencyModel> currencies = [];
  List<TypePriceModel> datatypeprice = [];
  Map<dynamic, String>? recieveData = {};
  Map<dynamic, String>? recieveeditData = {};
  List<Map<dynamic, String>> getData = [];
  int _selectedIndex = -1;
  final concurrencyRateController = TextEditingController();
  // ! check Filepicker
  FilePickerResult? result;
  PlatformFile? file;
  // final MultipleSearchController controller = MultipleSearchController();
  // final MultiSelectController _controller = MultiSelectController();
  final expenseGoodBloc = sl<ExpenseGoodBloc>();
  List<String> selectedValues = [];
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  // late ScrollController _scrollController;
  // Color _bgColor = Colors.white;
  // Color _textColor = Colors.black;
  List<String> nameaudit = [];

  // static const kExpandedHeight = 200.0;
  var currentLength = 0;
  bool isFocused = true;
  String _enteredText = '';
  // var _taxPercentSum;
  // var finalResult;
  var totalsum;
  // var finalResults;
  var withholdingResults;
  var netResults;
  var totalSum;
  var taxResults;
  @override
  void initState() {
    super.initState();
    _tabTextIndexSelected = 0;
    _loadCurrencies();
    _loadTypePrice();

    expenseGoodBloc.add(GetEmployeesAllRolesDataEvent());
  }

  Future<void> calculateSum() async {
    setState(() {
      print("recieveData ${recieveData}");
      print("getData ${getData}");
      // Extract values from getData
      var amount = getData
          .map((data) => double.tryParse(data["amount"] ?? '0') ?? 0)
          .toList();
      var unitprice = getData
          .map((data) => double.tryParse(data["unitprice"] ?? '0') ?? 0)
          .toList();
      var tax = getData
          .map((data) => double.tryParse(data["taxpercent"] ?? '0') ?? 0)
          .toList();
      var withoding = getData
          .map((data) => double.tryParse(data["withholding"] ?? '0') ?? 0)
          .toList();

      totalSum = 0.0;
      var totaltax = 0.0; // Move outside the loop
      var totalwithholding = 0.0; // Move outside the loop

      for (var i = 0; i < getData.length; i++) {
        var currentItemTotal = 0.0;
        var newunitprice = (_selectedTypeprice.isVatIncluded!)
            // ? (unitprice.elementAt(i) / (tax.elementAt(i) / 100 + 1))
            ? (unitprice.elementAt(i) * 100) / (100 + tax.elementAt(i))
            : unitprice.elementAt(i);

        currentItemTotal = amount.elementAt(i) * newunitprice;
        getData[i]["total"] = currentItemTotal.toStringAsFixed(2);
        getData[i]["tax"] =
            (currentItemTotal * (tax.elementAt(i) / 100)).toStringAsFixed(2);

        if (_selectedCurrency.code != "TH") {
          getData[i]["unitPriceInternational"] =
              convertCurrency(unitprice.elementAt(i));
          getData[i]["taxInternational"] =
              convertCurrency(double.tryParse(getData[i]["tax"]!)!);
          getData[i]["withholdingInternational"] = convertCurrency(
              double.tryParse(fixPoint(
                      currentItemTotal * (withoding.elementAt(i) / 100))) ??
                  0.0);
          getData[i]["totalBeforeTaxInternational"] = convertCurrency(
              double.tryParse(fixPoint(currentItemTotal.toStringAsFixed(2))) ??
                  0.0);

          getData[i]["totalPriceTaxInternational"] = convertCurrency(
              double.tryParse(fixPoint(currentItemTotal +
                      currentItemTotal * (tax.elementAt(i) / 100))) ??
                  0.0);

          totalSum +=
              double.parse(getData[i]["totalBeforeTaxInternational"] ?? '0');
          totaltax += double.parse(getData[i]["taxInternational"] ?? '0');
          totalwithholding +=
              double.parse(getData[i]["withholdingInternational"] ?? '0');
        } else {
          totaltax += currentItemTotal * (tax.elementAt(i) / 100);
          totalSum += currentItemTotal;
          totalwithholding += currentItemTotal * (withoding.elementAt(i) / 100);
        }

        print(getData[i]["tax"]);
        print("${getData[i]["taxInternational"]} taxinter");
        print(getData[i]["totalBeforeTaxInternational"]);
        print(getData[i]["totalPriceTaxInternational"]);
        print('currentItemTotal $currentItemTotal');
      }
      // สรุปรายการ
      taxResults = totaltax.toStringAsFixed(2);
      withholdingResults = totalwithholding.toStringAsFixed(2);
      netResults = (totalSum + totaltax - totalwithholding).toStringAsFixed(2);

      print('taxResults $taxResults');
      print('withholdingResults $withholdingResults');
      print('totalsum $totalSum');
      print('getData.length ${getData.length}');
      print('netResults ${netResults.runtimeType}');
      print("getData ${getData}");
    });
  }

  void pickFiles(BuildContext context) async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom, allowedExtensions: ['jpg', "png", 'pdf'],
      allowMultiple: false, // Allow only a single file to be picked);
    );
    if (result == null || result!.files.isEmpty) return;

    PlatformFile pickedFile = result!.files.first;
    print(pickedFile);
    // Check the file size
    if (pickedFile.size > 500 * 1024) {
      // File size exceeds 500 KB

      CustomMotionToast.show(
        context: context,
        title: "Alert File Size",
        description: "File size exceeds 500 KB",
        icon: Icons.notification_important,
        primaryColor: Colors.pink,
        width: 300,
        height: 100,
        animationType: AnimationType.fromLeft,
        fontSizeTitle: 18.0,
        fontSizeDescription: 15.0,
      );
      // You can handle this case according to your requirements
      print("File size exceeds 500 KB");
      return;
    }

    file = pickedFile;
    setState(() {});
  }

  void viewFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
  // Future<void> calculateSum() async {
  //   setState(() {
  //     print("recieveData ${recieveData}");
  //     print("getData ${getData}");
  //     // ! จำนวน
  //     var amount = getData.map((data) => double.parse(data["amount"] ?? "0"));
  //     // ! ราคาต่อหน่วย
  //     var unitprice =
  //         getData.map((data) => double.parse(data["unitprice"] ?? "0"));
  //     // ! ภาษี
  //     var tax = getData.map((data) => double.parse(data["taxpercent"] ?? "0"));
  //     // ! หัก ณ ที่จ่าย
  //     var withoding =
  //         getData.map((data) => double.parse(data["withholding"] ?? "0"));
  //     totalSum = 0.0;
  //     var totaltax = 0.0; // Move outside the loop
  //     var totalwithholding = 0.0; // Move outside the loop
  //     // var totalPriceTaxInternational = 0.0;
  //     print("unitprice ${unitprice}");
  //     for (var i = 0; i < getData.length; i++) {
  //       var currentItemTotal = 0.0;
  //       var newunitprice = (_selectedTypeprice.isVatIncluded!)
  //           ? (unitprice.elementAt(i) / (tax.elementAt(i) / 100 + 1))
  //           : unitprice.elementAt(i);
  //       currentItemTotal = amount.elementAt(i) * newunitprice;
  //       // getData[i]["unitPrice"] = fixPoint(newunitprice);
  //       getData[i]["calculatedTotal"] = currentItemTotal.toStringAsFixed(2);
  //       print(getData[i]["calculatedTotal"]);
  //       print(currentItemTotal);

  //       print("totaltax $totaltax");

  //       // totalPriceTaxInternational =
  //       //     convertCurrency(currentItemTotal) - convertCurrency(totaltax);
  //       if (_selectedCurrency.code != "TH") {
  //         getData[i]["unitPriceInternational"] = convertCurrency(newunitprice);
  //         getData[i]["taxInternational"] =
  //             convertCurrency(currentItemTotal * (tax.elementAt(i) / 100));
  //         getData[i]["withholdingInternational"] = convertCurrency(
  //             currentItemTotal * (withoding.elementAt(i) / 100));
  //         getData[i]["totalBeforeTaxInternational"] =
  //             convertCurrency(currentItemTotal);
  //         getData[i]["totalPriceTaxInternational"] = convertCurrency(
  //             currentItemTotal + currentItemTotal * (tax.elementAt(i) / 100));
  //         totalSum += double.parse(getData[i]["totalBeforeTaxInternational"]!);
  //         totaltax += double.parse(getData[i]["taxInternational"]!);
  //         totalwithholding +=
  //             double.parse(getData[i]["withholdingInternational"]!);
  //       } else {
  //         totaltax += currentItemTotal * (tax.elementAt(i) / 100);
  //         totalSum += currentItemTotal;
  //         totalwithholding += currentItemTotal * (withoding.elementAt(i) / 100);
  //       }
  //     }
  //     print('taxResults $taxResults');
  //     print('withholdingResults $withholdingResults');
  //     print('totalsum $totalSum');
  //     print('getData.length ${getData.length}');
  //     // print("totalPriceTaxInternational${totalPriceTaxInternational}");
  //     // print(
  //     //     "totalPriceTaxInternational ${getData["totalBeforeTaxInternational"]}");
  //     // print("totalSum $totalSum");
  //     // print(currentItemTotal)
  //     // ! สรุปรายการ
  //     // ! สรุปรายการ
  //     taxResults = totaltax.toStringAsFixed(2);
  //     withholdingResults = totalwithholding.toStringAsFixed(2);
  //     netResults = (totalSum + totaltax - totalwithholding).toStringAsFixed(2);

  //     print('netResults ${netResults.runtimeType}');
  //   });
  // }

  String convertCurrency(double value) {
    if (_selectedCurrency.code != "TH" &&
        concurrencyRateController.text.isNotEmpty == true) {
      double currencyRate =
          double.tryParse(concurrencyRateController.text) ?? 0.0;
      return fixPoint(value * currencyRate);
    } else {
      return '0.0';
    }
  }

  String fixPoint(dynamic value) {
    if (value != null) {
      // Check if the value is already a string, and if so, parse it to a double
      double doubleValue = (value is String) ? double.tryParse(value) : value;
      return doubleValue.toStringAsFixed(2);
    } else {
      return '0.0';
    }
  }

  void _loadCurrencies() async {
    final jsonContent = await DefaultAssetBundle.of(context)
        .loadString('assets/json/concurrency.json');
    setState(() {
      currencies = loadConcurrencyData(jsonContent);
      _selectedCurrency = currencies.first; // Set a default currency
    });
  }

  void _loadTypePrice() async {
    final jsonContent = await DefaultAssetBundle.of(context)
        .loadString('assets/json/typeprice.json');
    setState(() {
      datatypeprice = loadTypePriceData(jsonContent);
      _selectedTypeprice = datatypeprice.first; // Set a default currency
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(
            image: "appbar_expenseandgood.png", title: 'ซื้อสินค้า/ค่าใช้จ่าย'),
        body: BlocProvider(
          create: (_) => expenseGoodBloc,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(30),
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _keyForm,
              child: BlocBuilder<ExpenseGoodBloc, ExpenseGoodState>(
                builder: (BuildContext context, ExpenseGoodState state) {
                  if (state is ExpenseGoodInitial) {
                    return Text(
                      "ไม่พบข้อมูล",
                      // style: TextStyle(),
                    );
                  } else if (state is ExpenseGoodLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ExpenseGoodFinish) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 5,
                        ),
                        Text(
                          'ข้อมูลทั่วไป',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 8,
                        ),
                        Text(
                          'ชื่อรายการ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 4,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 8,
                        ),
                        Text(
                          'ผู้อนุมัติ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 4,
                        ),

                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: SearchField(
                            suggestionState: Suggestion.expand,
                            scrollbarDecoration: ScrollbarDecoration(
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(2),
                                        bottom: Radius.circular(2)),
                                    side: BorderSide(
                                        width: 1, color: Colors.red)),
                                thumbColor: Colors.grey),
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
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 8,
                        ),
                        Text(
                          'CC ถึง',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 4,
                        ),

                        MultiSelectDropDown(
                          // inputDecoration: ,
                          // selectedOptions: [],
                          // optionSeparator: ,
                          onOptionSelected: (options) {
                            // Extract email addresses from selected values and update the list
                            setState(() {
                              selectedValues = options
                                  .map((item) {
                                    if (item.value != null) {
                                      // Assuming email is included in the label
                                      // Split the label and extract the email part
                                      final email = item.label.split('\n')[1];
                                      return email.trim();
                                    }
                                    return null;
                                  })
                                  .whereType<String>() // Filter out null values
                                  .toList();
                            });
                            // Dismiss the focus of the MultiSelectDropDown
                            FocusScope.of(context).unfocus();
                            // Dismiss the focus of the MultiSelectDropDown
                            // FocusScope.of(context).unfocus();
                            // Print selected email addresses for debugging
                            debugPrint(selectedValues.toString());
                          },
                          showClearIcon: true,
                          // controller: _controller,
                          // onOptionSelected: (options) {
                          //   debugPrint(options.toString());
                          // },
                          options: state.empsallrole!
                              .map((employee) => ValueItem(
                                  label:
                                      '${employee.firstnameTh!}  ${employee.lastnameTh} \n${employee.email}',
                                  value: employee.firstnameTh! +
                                      employee.lastnameTh!))
                              .toList(),
                          maxItems: 3,
                          // disabledOptions: const [
                          //   ValueItem(label: 'Option 1', value: '1')
                          // ],
                          searchEnabled: true,
                          borderRadius: 30,
                          selectionType: SelectionType.multi,

                          chipConfig: const ChipConfig(
                              wrapType: WrapType.scroll, autoScroll: true),
                          dropdownHeight: 300,
                          optionTextStyle: const TextStyle(fontSize: 16),
                          selectedOptionIcon: const Icon(Icons.check_circle),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 4,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 8,
                        ),
                        Text(
                          'ผู้ตรวจสอบ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 4,
                        ),

                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: SearchField(
                            // focusNode: focus,
                            suggestionState: Suggestion.expand,
                            scrollbarDecoration: ScrollbarDecoration(
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(2),
                                        bottom: Radius.circular(2)),
                                    side: BorderSide(
                                        width: 1, color: Colors.red)),
                                thumbColor: Colors.grey),
                            itemHeight: 50,
                            emptyWidget: Container(
                              alignment: Alignment.center,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade300),
                                // padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
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
                              padding: const EdgeInsets.all(8.0),
                              child: Text('ไม่พบข้อมูล'),
                            ),
                            suggestions: state.empsroleadmin!
                                .map((e) => SearchFieldListItem(
                                    "${e.firstnameTh}  ${e.lastnameTh}",
                                    // "${e.idEmployees}",
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          "${e.firstnameTh}  ${e.lastnameTh}"),
                                    )))
                                .toList(),
                            // style: ,
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
                              // fillColor: const Color.fromARGB(255, 237, 237, 237)
                              //     .withOpacity(0.5),
                              // filled: true,

                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 8,
                        ),
                        Text(
                          'สถานที่เกิดค่าใช้จ่าย',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 4,
                        ),

// Here default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                        FlutterToggleTab(
                          width: MediaQuery.of(context).devicePixelRatio *
                              20, // width in percent
                          borderRadius: 30,
                          height: MediaQuery.of(context).devicePixelRatio * 15,
                          selectedIndex: _tabTextIndexSelected,
                          selectedBackgroundColors: [Color(0xffff99ca)],
                          selectedTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                          unSelectedTextStyle: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          labels: locationexpensel,
                          selectedLabelIndex: (index) {
                            setState(() {
                              _tabTextIndexSelected = index;
                            });
                          },
                          isScroll: false,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 8,
                        ),
                        Text(
                          'สกุลเงิน',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 4,
                        ),
                        CurrencyDropdown(
                          currencies: currencies,
                          selectedCurrency: _selectedCurrency,
                          onCurrencyChanged: (newCurrency) {
                            setState(() {
                              _selectedCurrency = newCurrency;
                              calculateSum();
                            });
                          },
                        ),

                        Visibility(
                          visible: !(_selectedCurrency.code == 'TH'),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).devicePixelRatio * 8,
                              ),
                              Text(
                                'อัตราการแลกเปลี่ยน ( บาท ต่อ 1 ${_selectedCurrency.unit})',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey.shade600),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).devicePixelRatio * 4,
                              ),
                              SizedBox(
                                height: 40,
                                width: double.infinity,
                                child: TextFormField(
                                  // style: ,
                                  onChanged: (val) {
                                    setState(() {
                                      concurrencyRateController.text = val;
                                      calculateSum();
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    // FilteringTextInputFormatter.allow(
                                    //   RegExp(r'^\d{0,2}$'),
                                    // ),
                                  ],
                                  controller: concurrencyRateController,
                                  //  maxLength: 2,
                                  decoration: InputDecoration(
                                    // fillColor: const Color.fromARGB(255, 237, 237, 237)
                                    //     .withOpacity(0.5),
                                    // filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2.0,
                                          color: Color.fromARGB(
                                              255, 252, 119, 119)),
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 8,
                        ),
                        Text(
                          'ประเภทราคา',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 4,
                        ),
                        CustomDropdownTypePrice(
                          items: datatypeprice,
                          selectedValue: _selectedTypeprice,
                          onChanged: (TypePriceModel? newValue) {
                            setState(() {
                              _selectedTypeprice = newValue!;
                              calculateSum();
                            });
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 8,
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'รายการ ',
                                    style: TextStyle(
                                      color: Colors
                                          .black, // Set the desired color for 'รายการ'
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (_selectedCurrency.code != 'TH')
                                    TextSpan(
                                      text:
                                          '(หน่วย ${_selectedCurrency.unit!})',
                                      style: TextStyle(
                                        color: Colors
                                            .grey, // Set the desired color for '(หน่วย ${_selectedCurrency.unit!})'
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(30.0),
                              onTap: () async {
                                recieveData = await Navigator.push(
                                  context,
                                  PageTransition(
                                    duration: Durations.extralong1,
                                    type: PageTransitionType.rightToLeft,
                                    child: AddListExpense(
                                        typeprice: _selectedTypeprice),
                                  ),
                                );
                                // print(Date recieveeditData?['documentDate']);
                                if (recieveData != null &&
                                    recieveData!.isNotEmpty) {
                                  getData.addAll([recieveData!]);
                                }
                                calculateSum();
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
                        (getData.isNotEmpty)
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: getData.length,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  // var reverseindex = getData.length - 1 - index;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Slidable(
                                      endActionPane: ActionPane(
                                          motion: const StretchMotion(),
                                          children: [
                                            SlidableAction(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                icon: IconaMoon.edit,
                                                onPressed: (_) async {
                                                  setState(() {
                                                    _selectedIndex = index;
                                                  });
                                                  recieveeditData =
                                                      await Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      duration:
                                                          Durations.extralong1,
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: EditListExpense(
                                                        typeprice:
                                                            _selectedTypeprice,
                                                        listexpense:
                                                            getData[index],
                                                      ),
                                                    ),
                                                  );

                                                  // Check if recieveData is not null and contains updated data
                                                  // Update the data in the list
                                                  (recieveeditData != {})
                                                      ? setState(() {
                                                          getData[_selectedIndex] =
                                                              recieveeditData!;
                                                        })
                                                      : {};
                                                  calculateSum();
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
                                                    getData.removeAt(index);
                                                    // recieveData!.clear();
                                                    calculateSum();
                                                  });
                                                },
                                                flex: 2),
                                          ]),
                                      child: ExpansionTile(
                                        tilePadding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        expandedAlignment: Alignment.centerLeft,
                                        expandedCrossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // maintainState: true,
                                        // initiallyExpanded: true,
                                        maintainState: true,
                                        collapsedTextColor: Colors.white,
                                        backgroundColor:
                                            Color.fromARGB(255, 247, 24, 132)
                                                .withOpacity(0.7),
                                        textColor: Colors.white,
                                        childrenPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        collapsedBackgroundColor:
                                            Color(0xffff99ca),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        collapsedShape:
                                            const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                        title: Text(
                                            'สินค้า/รายการ: ${getData[index]['service']}',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        subtitle: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'รายละเอียด: ${getData[index]['description']}',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            Text(
                                              getData[index]['documentDate'] !=
                                                          null &&
                                                      getData[index][
                                                              'documentDate'] !=
                                                          ""
                                                  ? 'วันที่เอกสาร: ${DateFormat.yMMMd('th').format(DateTime.parse(getData[index]['documentDate']!))}'
                                                  : "ยังไม่ได้ระบุ",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),

                                        children: [
                                          // Padding(
                                          //   padding: const EdgeInsets.all(8.0),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 15),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Stack(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      // mainAxisAlignment:
                                                      //     MainAxisAlignment.start,
                                                      children: [
                                                        if (!(_selectedCurrency
                                                                .code ==
                                                            'TH')) ...[
                                                          Text(''),
                                                        ],
                                                        Text('จำนวน: '),
                                                        Text('ราคาต่อหน่วย: '),
                                                        Text('ภาษี:'),
                                                        Text(
                                                            'หักภาษี ณ ที่จ่าย: '),
                                                        Text(
                                                            'มูลค่าก่อนภาษี: '),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      // mainAxisAlignment:
                                                      //     MainAxisAlignment.start,
                                                      children: [
                                                        if (!(_selectedCurrency
                                                                .code ==
                                                            'TH')) ...[
                                                          Text(
                                                              'หน่วย (${_selectedCurrency.unit})'),
                                                        ],
                                                        Text(getData[index]
                                                            ["amount"]!),
                                                        Text(getData[index]
                                                            ["unitprice"]!),
                                                        Text(getData[index]
                                                            ["taxpercent"]!),
                                                        Text(getData[index]
                                                            ["withholding"]!),
                                                        Text(getData[index]
                                                            ["total"]!),
                                                      ],
                                                    ),
                                                    if (!(_selectedCurrency
                                                            .code ==
                                                        'TH')) ...[
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        // mainAxisAlignment:
                                                        //     MainAxisAlignment.start,
                                                        children: [
                                                          Text('หน่วย (บาท)'),
                                                          Text(double.parse(
                                                                  getData[index]
                                                                      [
                                                                      "amount"]!)
                                                              .toStringAsFixed(
                                                                  2)),
                                                          Text(NumberFormat(
                                                                  "#,##0.00",
                                                                  "en_US")
                                                              .format(double
                                                                  .tryParse((getData[
                                                                          index]
                                                                      [
                                                                      "unitPriceInternational"]!)))),
                                                          Text(NumberFormat(
                                                                  "#,##0.00",
                                                                  "en_US")
                                                              .format(double
                                                                  .tryParse(getData[
                                                                          index]
                                                                      [
                                                                      "taxInternational"]!))),
                                                          Text(NumberFormat(
                                                                  "#,##0.00",
                                                                  "en_US")
                                                              .format(double
                                                                  .tryParse(getData[
                                                                          index]
                                                                      [
                                                                      "withholdingInternational"]!))),
                                                          Text(NumberFormat(
                                                                  "#,##0.00",
                                                                  "en_US")
                                                              .format(double
                                                                  .tryParse(getData[
                                                                          index]
                                                                      [
                                                                      "totalBeforeTaxInternational"]!))),
                                                          // Text(!),
                                                          // Text(!),
                                                          // Text(!),
                                                        ],
                                                      ),
                                                    ]
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            // )
                            : Container(
                                // color: Colors.amber,
                                alignment: Alignment.center,
                                height: 100,
                                child: Text(
                                  'ยังไม่มีรายการ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey),
                                ),
                              ),
                        // ),
                        // ),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 10,
                        ),
                        Text(
                          'สรุปรายการ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'มูลค่ารวม',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            Text(
                              (totalSum != null)
                                  ? '${NumberFormat("#,##0.00", "en_US").format(totalSum.toDouble())} บาท'
                                  : '${0.toStringAsFixed(2)} บาท',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'ภาษีมูลค่าเพิ่มรวม',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            Text(
                              (taxResults != null)
                                  ? '${NumberFormat("###,###.00#", "en_US").format(double.parse(taxResults))} บาท'
                                  : '${0.toStringAsFixed(2)} บาท',
                              // '${taxResults ?? 0.toStringAsFixed(2)} บาท',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'หัก ณ ที่จ่ายรวม',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            Text(
                              // '${withholdingResults ?? 0.toStringAsFixed(2)} บาท',
                              (withholdingResults != null)
                                  ? '${NumberFormat("###,###.00#", "en_US").format(double.parse(withholdingResults))} บาท'
                                  : '${0.toStringAsFixed(2)} บาท',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'มูลค่าสุทธิรวม',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                            Text(
                              (netResults != null)
                                  ? '${NumberFormat("###,###.00#", "en_US").format(double.parse(netResults))} บาท'
                                  : '${0.toStringAsFixed(2)} บาท',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 10,
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 10,
                        ),
                        Text(
                          'แนบไฟล์เอกสาร',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            'ไฟล์ *.jpeg, *.jpg, *.png, *.pdf จำนวน 1 ไฟล์ \n( ขนาดไม่เกิน 500 KB )',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 10,
                        ),
                        (file == null)
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      20), // Use BorderRadius.circular for rounded corners
                                  color: Color.fromRGBO(255, 234, 239, 0.29),
                                ),
                                // width: MediaQuery.of(context).size.width * 0.9,
                                // height: MediaQuery.of(context).size.height * 0.17,
                                width: double.infinity,
                                height: 250,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/img_expense_pick.png",
                                      fit: BoxFit.fill,
                                    ),
                                    Text('อัพโหลดไฟล์ที่นี่'),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                              .devicePixelRatio *
                                          3,
                                    ),
                                    ClipOval(
                                      child: Material(
                                        color:
                                            Color(0xffff99ca), // Button color
                                        child: InkWell(
                                          splashColor:
                                              Color(0xffff99ca), // Splash color
                                          onTap: () {
                                            pickFiles(context);
                                          },
                                          child: SizedBox(
                                              width: 56,
                                              height: 56,
                                              child: Icon(IconaMoon.share2,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  viewFile(file!);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        20), // Use BorderRadius.circular for rounded corners
                                    color: Color.fromRGBO(255, 234, 239, 0.29),
                                  ),
                                  // width: MediaQuery.of(context).size.width * 0.9,
                                  // height: MediaQuery.of(context).size.height * 0.17,
                                  width: double.infinity,
                                  // height: 50,
                                  child: ListTile(
                                    leading: Icon(IconaMoon.fileImage),
                                    title: Text(file!.name.toString()),
                                    trailing: InkWell(
                                      onTap: () {
                                        setState(() {
                                          file = null;
                                        });
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 10,
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 10,
                        ),
                        Text(
                          'หมายเหตุ (เพิ่มเติม)',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).devicePixelRatio * 10,
                        ),
                        Container(
                          // color: Colors.red,
                          // height: 200,
                          width: double.infinity,
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _enteredText = value;
                              });
                            },

                            minLines: 3,
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
                        Container(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  width: 2,
                                  color: Color(0xffff99ca)), // สีขอบสีส้ม
                            ),
                            icon: Icon(Icons.save_as, color: Color(0xffff99ca)),
                            label: Text(
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
                        Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            label: Text(
                              'ส่งอนุมัติ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // สีข้อความขาว
                              ),
                            ),
                            icon: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffff99ca), // สีปุ่มสีส้ม
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    );
                  } else if (state is ExpenseGoodFailure) {
                    return const Text("error");
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
      // body: CustomScrollView(
      //   physics: const BouncingScrollPhysics(),
      //   controller: _scrollController,
      //   slivers: [
      //     SliverAppBar(
      //         leading: IconButton(
      //           icon: Icon(IconaMoon.arrowLeft2, color: _textColor),
      //           onPressed: () => Navigator.of(context).pop(PageTransition(
      //               duration: Durations.extralong4,
      //               type: PageTransitionType.leftToRight,
      //               child: Expense())),
      //         ),
      //         stretch: true,
      //         // strec
      //         // shape: RoundedRectangleBorder(
      //         //   borderRadius: BorderRadius.only(
      //         //       bottomLeft:
      //         //           Radius.circular(70) // Adjust the radius as needed
      //         //       ),
      //         // ),
      //         // titleTextStyle: TextStyle(
      //         //   color: _textColor,
      //         // ),
      //         pinned: true,
      //         floating: true,
      //         snap: true,
      //         expandedHeight: kExpandedHeight,
      //         backgroundColor: _bgColor,
      //         flexibleSpace: FlexibleSpaceBar(
      //           background: Image.asset(
      //             "assets/images/Rectangle.png",
      //             // repeat: ImageRepeat.noRepeat,
      //             fit: BoxFit.fill,
      //           ),
      //           // collapseMode: CollapseMode.parallax,
      //           stretchModes: const [StretchMode.zoomBackground],
      //           // Stack(
      //           //   children: [
      //           //     Container(
      //           //       decoration: const BoxDecoration(
      //           //         image: DecorationImage(
      //           //           image: AssetImage("assets/images/Rectangle.png"),
      //           //           repeat: ImageRepeat.noRepeat,
      //           //           fit: BoxFit.cover,
      //           //         ),
      //           //       ),
      //           //     ),
      //           //   ],
      //           // ),

      //           title:
      //               // top: MediaQuery.of(context).devicePixelRatio * 60,
      //               // left: MediaQuery.of(context).devicePixelRatio * 8,
      //               Text(
      //             // textScaleFactor: 1,
      //             'ซื้อสินค้า/ค่าใช้จ่าย',
      //             style: TextStyle(
      //                 fontSize: 20,
      //                 fontWeight: FontWeight.bold,
      //                 color: _textColor),
      //           ),
      //           // ),
      //         )
      //         // ]
      //         ),
      //     SliverToBoxAdapter(
      //       child: Padding(
      //         padding: EdgeInsets.symmetric(
      //             horizontal: MediaQuery.of(context).devicePixelRatio * 8,
      //             vertical: MediaQuery.of(context).devicePixelRatio * 10),
      //         child: Form(
      //           key: _keyForm,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 'ข้อมูลทั่วไป',
      //                 style: TextStyle(
      //                     fontSize: 16, fontWeight: FontWeight.bold),
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 8,
      //               ),
      //               Text(
      //                 'ชื่อรายการ',
      //                 style: TextStyle(
      //                     fontSize: 14,
      //                     fontWeight: FontWeight.normal,
      //                     color: Colors.grey.shade600),
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 4,
      //               ),
      //               SizedBox(
      //                 height: 40,
      //                 width: double.infinity,
      //                 child: TextFormField(
      //                   // style: ,
      //                   decoration: InputDecoration(
      //                     // fillColor: const Color.fromARGB(255, 237, 237, 237)
      //                     //     .withOpacity(0.5),
      //                     // filled: true,
      //                     contentPadding:
      //                         const EdgeInsets.symmetric(horizontal: 16),
      //                     focusedBorder: OutlineInputBorder(
      //                       borderSide: const BorderSide(
      //                           width: 2.0,
      //                           color: Color.fromARGB(255, 252, 119, 119)),
      //                       borderRadius: BorderRadius.circular(30),
      //                     ),
      //                     enabledBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(30),
      //                       borderSide: BorderSide(
      //                           width: 2.0,
      //                           color: Colors.grey.withOpacity(0.3)),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 8,
      //               ),
      //               Text(
      //                 'สถานที่เกิดค่าใช้จ่าย',
      //                 style: TextStyle(
      //                     fontSize: 14,
      //                     fontWeight: FontWeight.normal,
      //                     color: Colors.grey.shade600),
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 4,
      //               ),
      //               Row(
      //                 children: [
      //                   ElevatedButton(
      //                       onPressed: () {}, child: Text('ในประเทศ')),
      //                   SizedBox(
      //                     width: MediaQuery.of(context).size.width * 0.03,
      //                   ),
      //                   ElevatedButton(
      //                       onPressed: () {}, child: Text('ต่างประเทศ')),
      //                 ],
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 8,
      //               ),
      //               Text(
      //                 'สกุลเงิน',
      //                 style: TextStyle(
      //                     fontSize: 14,
      //                     fontWeight: FontWeight.normal,
      //                     color: Colors.grey.shade600),
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 4,
      //               ),
      //               // DropdownButton(
      //               //   // padding: const EdgeInsets.symmetric(horizontal: 16),
      //               //   borderRadius: BorderRadius.circular(30),
      //               //   icon: Icon(Icons.arrow_drop_down),
      //               //   iconSize: 36.0,
      //               //   underline: SizedBox(),
      //               //   style: TextStyle(
      //               //     color: Colors.red,
      //               //     fontSize: 24.0,
      //               //   ),
      //               //   value: 'Option 1',
      //               //   items: [
      //               //     DropdownMenuItem(
      //               //       value: 'Option 1',
      //               //       child: Text('Option 1'),
      //               //     ),
      //               //     DropdownMenuItem(
      //               //       value: 'Option 2',
      //               //       child: Text('Option 2'),
      //               //     ),
      //               //     DropdownMenuItem(
      //               //       value: 'Option 3',
      //               //       child: Text('Option 3'),
      //               //     ),
      //               //   ],
      //               //   onChanged: (value) {
      //               //     // Do something with the selected value
      //               //   },
      //               // ),
      //               Container(
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(30),
      //                     border: Border.all(
      //                         color: Colors.grey.withOpacity(0.3), width: 2)),
      //                 // color: Colors.red,
      //                 height: 40,
      //                 width: double.infinity,
      //                 child: DropdownButtonHideUnderline(
      //                   child: DropdownButton(
      //                     borderRadius: BorderRadius.circular(30),
      //                     icon: Icon(
      //                       IconaMoon.arrowDown2,
      //                       color: Colors.grey.withOpacity(0.3),
      //                     ),
      //                     // iconSize: 36.0,
      //                     padding: EdgeInsets.only(
      //                       left:
      //                           MediaQuery.of(context).devicePixelRatio * 7.5,
      //                       right:
      //                           MediaQuery.of(context).devicePixelRatio * 3,
      //                     ),
      //                     isExpanded: true,
      //                     value: 'THB',
      //                     items: [
      //                       DropdownMenuItem(
      //                         value: 'THB',
      //                         child: Text('THB - ไทย'),
      //                       ),
      //                       DropdownMenuItem(
      //                         value: 'Option 2',
      //                         child: Text('Option 2'),
      //                       ),
      //                       DropdownMenuItem(
      //                         value: 'Option 3',
      //                         child: Text('Option 3'),
      //                       ),
      //                     ],
      //                     onChanged: (value) {},
      //                     // style: Theme.of(context).textTheme.title,
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 8,
      //               ),
      //               Divider(
      //                 color: Colors.grey.shade300,
      //                 height: 1,
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 8,
      //               ),
      //               Row(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text(
      //                     'รายการ',
      //                     style: TextStyle(
      //                         fontSize: 16, fontWeight: FontWeight.bold),
      //                   ),
      //                   InkWell(
      //                     borderRadius: BorderRadius.circular(30.0),
      //                     onTap: () {
      //                       Navigator.push(
      //                         context,
      //                         PageTransition(
      //                           duration: Durations.extralong1,
      //                           type: PageTransitionType.rightToLeft,
      //                           child: AddListExpense(),
      //                         ),
      //                       );
      //                     },
      //                     child: Container(
      //                       decoration: BoxDecoration(
      //                         color: Color(0xffff99ca),
      //                         borderRadius: BorderRadius.circular(30.0),
      //                       ),
      //                       padding: EdgeInsets.symmetric(
      //                           horizontal:
      //                               MediaQuery.of(context).devicePixelRatio *
      //                                   7,
      //                           vertical:
      //                               MediaQuery.of(context).devicePixelRatio *
      //                                   2.5),
      //                       // shape: Border.all(width: 2),
      //                       // onPressed: () => {},
      //                       // fillColor: ,
      //                       child: Text(
      //                         '+ เพิ่มรายการ',
      //                         style: TextStyle(color: Colors.white),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),

      //               Padding(
      //                 padding: EdgeInsets.only(
      //                     top: MediaQuery.of(context).devicePixelRatio * 1,
      //                     bottom:
      //                         MediaQuery.of(context).devicePixelRatio * 1),
      //                 child: Container(
      //                   height: MediaQuery.of(context).size.height * 0.08,
      //                   alignment: AlignmentDirectional.center,
      //                   width: double.infinity,
      //                   // color: Colors.red,
      //                   child: Text(
      //                     'ยังไม่มีรายการ',
      //                     style: TextStyle(
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.normal,
      //                         color: Colors.grey),
      //                   ),
      //                 ),
      //               ),
      //               Divider(
      //                 color: Colors.grey.shade300,
      //                 height: 1,
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 10,
      //               ),
      //               Text(
      //                 'สรุปรายการ',
      //                 style: TextStyle(
      //                     fontSize: 16, fontWeight: FontWeight.bold),
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 4,
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   Text(
      //                     'มูลค่ารวม',
      //                     style: TextStyle(
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.normal,
      //                         color: Colors.grey),
      //                   ),
      //                   Text(
      //                     '0 บาท',
      //                     style: TextStyle(
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.normal,
      //                         color: Colors.grey),
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 1,
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   Text(
      //                     'ภาษีมูลค่าเพิ่มรวม',
      //                     style: TextStyle(
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.normal,
      //                         color: Colors.grey),
      //                   ),
      //                   Text(
      //                     '0 บาท',
      //                     style: TextStyle(
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.normal,
      //                         color: Colors.grey),
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 1,
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   Text(
      //                     'หัก ณ ที่จ่ายรวม',
      //                     style: TextStyle(
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.normal,
      //                         color: Colors.grey),
      //                   ),
      //                   Text(
      //                     '0 บาท',
      //                     style: TextStyle(
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.normal,
      //                         color: Colors.grey),
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 1,
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   Text(
      //                     'มูลค่าสุทธิรวม',
      //                     style: TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.normal,
      //                         color: Colors.black),
      //                   ),
      //                   Text(
      //                     '0 บาท',
      //                     style: TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.normal,
      //                         color: Colors.black),
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 10,
      //               ),
      //               Divider(
      //                 color: Colors.grey.shade300,
      //                 height: 1,
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 10,
      //               ),
      //               Text(
      //                 'แนบไฟล์เอกสาร',
      //                 style: TextStyle(
      //                     fontSize: 16, fontWeight: FontWeight.bold),
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 10,
      //               ),
      //               Container(
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(
      //                       20), // Use BorderRadius.circular for rounded corners
      //                   color: Color.fromRGBO(255, 234, 239, 0.29),
      //                 ),
      //                 // width: MediaQuery.of(context).size.width * 0.9,
      //                 // height: MediaQuery.of(context).size.height * 0.17,
      //                 width: double.infinity,
      //                 height: 208,
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.center,
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Image.asset(
      //                       "assets/images/img_expense_pick.png",
      //                       fit: BoxFit.fill,
      //                     ),
      //                     Text('อัพโหลดไฟล์ที่นี่'),
      //                     SizedBox(
      //                       height:
      //                           MediaQuery.of(context).devicePixelRatio * 3,
      //                     ),
      //                     ClipOval(
      //                       child: Material(
      //                         color: Color(0xffff99ca), // Button color
      //                         child: InkWell(
      //                           splashColor:
      //                               Color(0xffff99ca), // Splash color
      //                           onTap: () {},
      //                           child: SizedBox(
      //                               width: 56,
      //                               height: 56,
      //                               child: Icon(IconaMoon.share2,
      //                                   color: Colors.white)),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 10,
      //               ),
      //               Divider(
      //                 color: Colors.grey.shade300,
      //                 height: 1,
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 10,
      //               ),
      //               Text(
      //                 'หมายเหตุ (เพิ่มเติม)',
      //                 style: TextStyle(
      //                     fontSize: 16, fontWeight: FontWeight.bold),
      //               ),
      //               SizedBox(
      //                 height: MediaQuery.of(context).devicePixelRatio * 10,
      //               ),
      //               Container(
      //                 // color: Colors.red,
      //                 // height: 200,
      //                 width: double.infinity,
      //                 child: TextFormField(
      //                   onChanged: (value) {
      //                     setState(() {
      //                       _enteredText = value;
      //                     });
      //                   },

      //                   minLines: 3,
      //                   maxLines: 5,
      //                   // maxLengthEnforcement: MaxLengthEnforcement.enforced,
      //                   maxLength: 500,
      //                   // style: ,
      //                   inputFormatters: [
      //                     LengthLimitingTextInputFormatter(500),
      //                   ],
      //                   decoration: InputDecoration(
      //                     // counterStyle: TextStyle(
      //                     //   height: double,
      //                     // ),
      //                     // counter: Offstage(),

      //                     // counter: SizedBox.shrink(),
      //                     // suffixText:
      //                     //     '${textLength.toString()}/${maxLength.toString()}',
      //                     // counterText: "",
      //                     isDense: true,
      //                     // Display the number of entered characters
      //                     // counter: SizedBox.expand(),
      //                     counterText:
      //                         '${_enteredText.length.toString()} / ${500}',
      //                     // style counter text
      //                     // counterStyle:
      //                     //     TextStyle(fontSize: 22, color: Colors.purple),
      //                     // fillColor: const Color.fromARGB(255, 237, 237, 237)
      //                     //     .withOpacity(0.5),
      //                     // filled: true,
      //                     contentPadding: const EdgeInsets.symmetric(
      //                         horizontal: 16, vertical: 16),
      //                     focusedBorder: OutlineInputBorder(
      //                       borderSide: const BorderSide(
      //                           width: 2.0,
      //                           color: Color.fromARGB(255, 252, 119, 119)),
      //                       borderRadius: BorderRadius.circular(30),
      //                     ),
      //                     enabledBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(30),
      //                       borderSide: BorderSide(
      //                           width: 2.0,
      //                           color: Colors.grey.withOpacity(0.3)),
      //                     ),
      //                   ),
      //                 ),
      //                 //       child: TextField(
      //                 //         maxLength: 250,
      //                 //         buildCounter: (_,
      //                 //                 {required currentLength,
      //                 //                 maxLength,
      //                 //                 required isFocused}) =>
      //                 //             Padding(
      //                 //           padding: const EdgeInsets.only(left: 16.0),
      //                 //           child: Container(
      //                 //               alignment: Alignment.bottomRight,
      //                 //               child: Text("$currentLength/$maxLength")),
      //                 //         ),
      //               ),
      //               const Gap(20),
      //               Divider(
      //                 color: Colors.grey.shade300,
      //                 height: 1,
      //               ),
      //               const Gap(30),
      //               Container(
      //                 width: double.infinity,
      //                 child: OutlinedButton.icon(
      //                   onPressed: () {},
      //                   style: OutlinedButton.styleFrom(
      //                     side: BorderSide(
      //                         width: 2,
      //                         color: Color(0xffff99ca)), // สีขอบสีส้ม
      //                   ),
      //                   icon: Icon(Icons.save_as, color: Color(0xffff99ca)),
      //                   label: Text(
      //                     'บันทึกแบบร่าง',
      //                     style: TextStyle(
      //                       fontSize: 16,
      //                       fontWeight: FontWeight.bold,
      //                       color: Color(0xffff99ca), // สีข้อความสีส้ม
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               const Gap(10),
      //               Container(
      //                 width: double.infinity,
      //                 child: ElevatedButton.icon(
      //                   label: Text(
      //                     'ส่งอนุมัติ',
      //                     style: TextStyle(
      //                       fontSize: 16,
      //                       fontWeight: FontWeight.bold,
      //                       color: Colors.white, // สีข้อความขาว
      //                     ),
      //                   ),
      //                   icon: Icon(
      //                     Icons.send,
      //                     color: Colors.white,
      //                   ),
      //                   style: ElevatedButton.styleFrom(
      //                     primary: Color(0xffff99ca), // สีปุ่มสีส้ม
      //                   ),
      //                   onPressed: () {},
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     // Add more Slivers as needed
      //   ],
      // ),
      // ),
    );
  }
}
