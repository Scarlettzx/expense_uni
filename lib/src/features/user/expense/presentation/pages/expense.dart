// import 'dart:js_interop';

// import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
// import 'package:iconamoon/iconamoon.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
// import 'package:motion_toast/motion_toast.dart';
// import 'package:collection/collection.dart';
// import 'package:multi_dropdown/multiselect_dropdown.dart';
// import 'package:open_file/open_file.dart';
// import 'package:multiple_search_selection/helpers/search_controller.dart';
// import 'package:multiple_search_selection/multiple_search_selection.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:searchfield/searchfield.dart';
import 'package:uni_expense/injection_container.dart';
import 'package:uni_expense/src/features/user/expense/presentation/bloc/expensegood_bloc.dart';
// import 'package:uni_expense/src/features/user/expense/presentation/pages/add_list_expense.dart';
// import 'package:uni_expense/src/features/user/expense/presentation/pages/edit_list_expense.dart';
import 'package:uni_expense/src/features/user/expense/presentation/widgets/currencydropdowncomponent.dart';
import 'package:uni_expense/src/features/user/expense/presentation/widgets/summarylist_expense.dart';

// import '../../../../../components/concurrency.dart';
import '../../../../../components/custombutton.dart';
import '../../../../../components/custominputdecoration.dart';
import '../../../../../components/customremark.dart';
import '../../../../../components/filepicker.dart';
import '../../../../../components/models/concurrency_model,.dart';
import '../../../../../components/models/typeprice_model.dart';
// import '../../../../../components/motion_toast.dart';
import '../../../../../components/motion_toast.dart';
import '../../../../../components/typeprice.dart';
import '../../../../../core/features/user/presentation/provider/profile_provider.dart';
import '../../../allowance/presentation/widgets/customappbar.dart';
import '../../../allowance/presentation/widgets/required_text.dart';
// import '../../../fare/presentation/widgets/approverfield.dart';
import '../../../manageitems/presentation/pages/manageitems.dart';
import '../../data/models/addexpensegood_model.dart';
import '../../data/models/addlist_expensegood.dart';
import '../widgets/approvefield_expense.dart';
import '../widgets/carboncopy_expense.dart';
import '../widgets/currentexchange_Input.dart';
import '../widgets/inspectorfield_expense.dart';
import '../widgets/list_expense_widget.dart';
import '../widgets/locationexpense_toggletab.dart';
import 'edit_list_expense.dart';
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
  int? tabTextIndexSelectedtoggle;
  PlatformFile? selectedFile;
  List<ConcurrencyModel> currencies = [];
  List<TypePriceModel> datatypeprice = [];
  Map<dynamic, String>? recieveData = {};
  Map<dynamic, String>? recieveeditData = {};
  List<Map<dynamic, String>> getData = [];
  int status = 1;
  final concurrencyRateController = TextEditingController();
  final nameExpenseController = TextEditingController();
  final approverController = TextEditingController();
  final reviewerController = TextEditingController();
  final remarkController = TextEditingController();
  int? approver;
  PlatformFile? file;
  // final MultipleSearchController controller = MultipleSearchController();
  // final MultiSelectController _controller = MultiSelectController();
  final expenseGoodBloc = sl<ExpenseGoodBloc>();
  List<String> selectedValues = [];
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  String? ccemail;
  int? reviewer;
  var currentLength = 0;
  bool isFocused = true;
  String _enteredText = '';
  @override
  void initState() {
    super.initState();
    tabTextIndexSelectedtoggle = 0;
    expenseGoodBloc.add(GetEmployeesAllRolesDataEvent());
  }

  void addExpenseBloc(
    int status,
    ProfileProvider userProfile,
    List<AddListExpenseGood> listexpensegood,
    TypePriceModel? selectedTypePrice,
    ConcurrencyModel? selectedCurrency,
    num? currencyRate,
    num? total,
    num? vat,
    num? withholding,
    num? net,
  ) {
    FocusScope.of(context).unfocus();
    if (_keyForm.currentState!.validate()) {
      if (listexpensegood.isEmpty) {
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
      List<ListExpenseAddExpenseGoodModel> listExpense =
          listexpensegood.map((listexpensegood) {
        return ListExpenseAddExpenseGoodModel(
          documentDate: listexpensegood.documentDate,
          service: listexpensegood.service,
          description: listexpensegood.description,
          amount: listexpensegood.amount.toString(),
          unitPrice: listexpensegood.unitPrice.toString(),
          taxPercent: listexpensegood.taxPercent,
          tax: listexpensegood.tax.toString(),
          total: listexpensegood.total.toString(),
          totalPrice: listexpensegood.totalPrice.toString(),
          withholdingPercent: listexpensegood.withholdingPercent.toString(),
          withholding: listexpensegood.withholding.toString(),
          net: listexpensegood.net.toString(),
          unitPriceInternational:
              (listexpensegood.unitPriceInternational != null &&
                      listexpensegood.unitPriceInternational != -1)
                  ? listexpensegood.unitPriceInternational
                  : null,
          taxInternational: (listexpensegood.taxInternational != null &&
                  listexpensegood.taxInternational != -1)
              ? listexpensegood.taxInternational
              : null,
          totalBeforeTaxInternational:
              (listexpensegood.totalBeforeTaxInternational != null &&
                      listexpensegood.totalBeforeTaxInternational != -1)
                  ? listexpensegood.totalBeforeTaxInternational
                  : null,
          totalPriceInternational:
              (listexpensegood.totalPriceInternational != null &&
                      listexpensegood.totalPriceInternational != -1)
                  ? listexpensegood.totalPriceInternational
                  : null,
          withholdingInternational:
              (listexpensegood.withholdingInternational != null &&
                      listexpensegood.withholdingInternational != -1)
                  ? listexpensegood.withholdingInternational
                  : null,
          netInternational: (listexpensegood.netInternational != null &&
                  listexpensegood.netInternational != -1)
              ? listexpensegood.netInternational
              : null,
        );
      }).toList();
      expenseGoodBloc.add(
        AddExpenseGoodEvent(
            idEmployees: userProfile.profileData.idEmployees!,
            addexpensegooddata: AddExpenseGoodModel(
              nameExpense: nameExpenseController.text,
              isInternational: tabTextIndexSelectedtoggle,
              isVatIncluded: (selectedTypePrice != null &&
                      selectedTypePrice.isVatIncluded == true)
                  ? 1
                  : 0,
              currency: selectedCurrency!.unit,
              currencyItem: selectedCurrency,
              currencyRate: (currencyRate != null) ? currencyRate.toInt() : 1,
              listExpense: listExpense,
              file: selectedFile,
              remark: remarkController.text,
              typeExpense: 1,
              typeExpenseName: 'ServiceAndGoods',
              lastUpdateDate:
                  DateFormat("yyyy/MM/dd HH:mm").format(DateTime.now()),
              status: status,
              total: total.toString(),
              vat: vat.toString(),
              withholding: withholding.toString(),
              net: net.toString(),
              idEmpReviewer: reviewer,
              idEmpApprover: approver,
              ccEmail: ccemail,
              idPosition: userProfile.profileData.idPosition,
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<ProfileProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(
            image: "appbar_expenseandgood.png", title: 'ซื้อสินค้า/ค่าใช้จ่าย'),
        body: BlocProvider(
          create: (_) => expenseGoodBloc,
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(30),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _keyForm,
                child: BlocConsumer<ExpenseGoodBloc, ExpenseGoodState>(
                  listener: (context, state) {
                    if (state.status == FetchStatus.finish &&
                        state.typeprice != null &&
                        state.currency != null) {
                      print('listener');
                      expenseGoodBloc.add(
                        SelectCurrenyEvent(
                            selectedCurrency: state.currency!.first),
                      );
                      expenseGoodBloc.add(
                        SelectTypePriceEvent(
                            selectedTypePrice: state.typeprice!.first),
                      );
                    }
                    if (state.status == FetchStatus.finish && status == 1) {
                      if (state.responseaddexpensegood != null &&
                          state.responseaddexpensegood!.idExpense != null) {
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: Durations.medium1,
                            type: PageTransitionType.rightToLeft,
                            child: EditExpenseGood(
                              idExpense:
                                  state.responseaddexpensegood!.idExpense!,
                            ),
                          ),
                        );
                      }
                    }
                    if (state.status == FetchStatus.finish && status == 2) {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          duration: Durations.medium1,
                          type: PageTransitionType.rightToLeft,
                          child: const ManageItems(),
                        ),
                      );
                    }
                  },
                  builder: (BuildContext context, ExpenseGoodState state) {
                    if (state.status == FetchStatus.initial) {
                      return Text(
                        "ไม่พบข้อมูล",
                      );
                    } else if (state.status == FetchStatus.loading) {
                      return LoadingAnimationWidget.inkDrop(
                        color: const Color(0xffff99ca),
                        size: 35,
                      );
                    } else if (state.status == FetchStatus.finish ||
                        state.status == FetchStatus.loadcurrency ||
                        state.status == FetchStatus.list) {
                      print(state.listExpense);
                      // print("state.currencyRate");
                      // print(state.currencyRate);
                      // print("state");
                      // print(state);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(10),
                          Text(
                            'ข้อมูลทั่วไป',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Gap(20),
                          RequiredText(
                            labelText: 'ชื่อรายการ',
                            asteriskText: '*',
                          ),
                          const Gap(10),
                          TextFormField(
                            controller: nameExpenseController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null; // Return null if the input is valid
                            },
                            decoration:
                                CustomInputDecoration.getInputDecoration(),
                          ),
                          const Gap(20),
                          ApproverFieldExpense(
                              approver: approverController,
                              onApproverSuccess: (idaproover) {
                                setState(() {
                                  approver = idaproover;
                                });
                              }),
                          CarbonCopyExpense(
                            onCCEmailChanged: (newCCEmail) {
                              setState(() {
                                ccemail = newCCEmail;
                              });
                            },
                          ),
                          InspectorFieldExpense(
                            reviewer: reviewerController,
                            onReviewerSuccess: (idReviewer) {
                              setState(() {
                                reviewer = idReviewer;
                              });
                            },
                          ),
                          LocationExpenseToggleTab(
                            locationOptions: locationexpensel,
                            onLabelSelected: (index) {
                              tabTextIndexSelectedtoggle = index;
                              // Handle selection change here
                              print('Selected index: $index');
                            },
                          ),
                          CurrencyDropdownComponent(
                            expenseGoodBloc: expenseGoodBloc,
                          ),
                          CurrencyExchangeRateInput(
                            onCurrencyRateChanged: (val) {
                              print('sss');
                              expenseGoodBloc
                                  .add(UpdateCurrency(currenRate: val));
                              expenseGoodBloc.add(CalcualteSumEvent());
                              // setState(() {
                              concurrencyRateController.text = val;
                              // });
                            },
                          ),
                          CustomDropdownTypePrice(
                            onChanged: (TypePriceModel? newValue) {
                              expenseGoodBloc.add(SelectTypePriceEvent(
                                  selectedTypePrice: newValue));
                              expenseGoodBloc.add(CalcualteSumEvent());
                            },
                          ),
                          ListExpenseWidget(
                            expensegoodBloc: expenseGoodBloc,
                            isdraft: state.isdraft!,
                          ),
                          const SummaryListExpense(),
                          // ! upload Image
                          FilePickerComponent(
                            onFileSelected: (file) {
                              setState(() {
                                print(file);
                                selectedFile = file;
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
                          CustomRemark(
                            controller: remarkController,
                            onChanged: (value) {
                              setState(() {
                                _enteredText = value;
                              });
                            },
                            maxLines: 5,
                            maxLength: 500,
                            counterText: '${_enteredText.length} / 500',
                          ),
                          const Gap(20),
                          Divider(
                            color: Colors.grey.shade300,
                            height: 1,
                          ),
                          const Gap(30),
                          CustomButton(
                            label: 'บันทึกแบบร่าง',
                            icon: Icons.save_as,
                            iconColor: Color(0xffff99ca),
                            buttonColor: Color(0xffff99ca),
                            onPressed: () {
                              status = 1;
                              addExpenseBloc(
                                status,
                                userProfile,
                                state.listExpense,
                                state.selectedTypePrice,
                                state.selectedCurrency,
                                state.currencyRate,
                                state.total,
                                state.vat,
                                state.withholding,
                                state.net,
                              );
                            },
                            type: CustomButtonType.outlined,
                          ),
                          const Gap(10),
                          CustomButton(
                            label: 'ส่งอนุมัติ',
                            icon: Icons.send,
                            iconColor: Colors.white,
                            buttonColor: Color(0xffff99ca),
                            onPressed: () {
                              status = 2;
                              print(state.currencyRate);
                              addExpenseBloc(
                                status,
                                userProfile,
                                state.listExpense,
                                state.selectedTypePrice,
                                state.selectedCurrency,
                                state.currencyRate,
                                state.total,
                                state.vat,
                                state.withholding,
                                state.net,
                              );
                            },
                            type: CustomButtonType.elevated,
                          ),
                          const Gap(10),
                        ],
                      );
                    } else if (state.status == FetchStatus.failure) {
                      return const Text("error");
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
