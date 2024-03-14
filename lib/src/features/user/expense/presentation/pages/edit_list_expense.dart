import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../../../injection_container.dart';
import '../../domain/entities/entities.dart';
import '../bloc/expensegood_bloc.dart';
import '../widgets/currencydropdowncomponent.dart';
import '../widgets/summarylist_expense.dart';
import '../../../../../components/custombutton.dart';
// import '../../../../../components/custominputdecoration.dart';
import '../../../../../components/customremark.dart';
// import '../../../../../components/filepicker.dart';
import '../../../../../components/models/concurrency_model,.dart';
import '../../../../../components/models/typeprice_model.dart';
import '../../../../../components/motion_toast.dart';
import '../../../../../components/typeprice.dart';
import '../../../../../core/features/user/presentation/provider/profile_provider.dart';
import '../../../allowance/presentation/widgets/customappbar.dart';
// import '../../../allowance/presentation/widgets/required_text.dart';
// import '../../../fare/presentation/widgets/showimg_editdraft.dart';
import '../../../manageitems/presentation/pages/manageitems.dart';
// import '../../data/models/addexpensegood_model.dart';
import '../../data/models/addlist_expensegood.dart';
import '../../data/models/editdraft_expensegood_model.dart';
import '../widgets/approvefield_expense.dart';
// import '../widgets/carboncopy_expense.dart';
import '../widgets/currentexchange_Input.dart';
import '../widgets/generalinput/general_input_data.dart';
import '../widgets/inspectorfield_expense.dart';
import '../widgets/list_expense_widget.dart';
import '../widgets/locationexpense_toggletab.dart';
import '../widgets/showing_editdraft.dart';
// import '../../domain/entities/entities.dart';
// import '../../domain/entities/entities.dart';

class EditExpenseGood extends StatefulWidget {
  final int idExpense;
  final bool? isManageItemtoPageEdit;
  const EditExpenseGood({
    super.key,
    required this.idExpense,
    this.isManageItemtoPageEdit,
  });

  @override
  State<EditExpenseGood> createState() => _EditExpenseGoodState();
}

class _EditExpenseGoodState extends State<EditExpenseGood> {
  List<String> locationexpensel = ['ในประเทศ', 'ต่างประเทศ'];
  int? tabTextIndexSelectedtoggle;
  FileUrlGetExpenseGoodByIdEntity? showimg;
  bool checkdohaveimg = true;
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
  String _enteredText = '';
  @override
  void initState() {
    super.initState();
    print('init');
    expenseGoodBloc.add(GetEmployeesAllRolesDataEvent());
    expenseGoodBloc.add(GetExpenseGoodByIdEvent(idExpense: widget.idExpense));
  }

  void callGetExpenseByIdData() {
    expenseGoodBloc.add(GetExpenseGoodByIdEvent(
      idExpense: widget.idExpense,
    ));
  }

  updateExpenseBloc(
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
    List<int> deletedItem,
    GetExpenseGoodByIdEntity getexpensebyid,
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
      List<ListExpenseEditDraftExpenseGoodModel> listExpense =
          listexpensegood.map((listexpensegood) {
        return ListExpenseEditDraftExpenseGoodModel(
          idExpenseGoodsItem: (listexpensegood.idExpenseGoodsItem != null)
              ? int.tryParse(listexpensegood.idExpenseGoodsItem!)
              : null,
          documentDate: listexpensegood.documentDate,
          service: listexpensegood.service,
          description: listexpensegood.description,
          amount: listexpensegood.amount!.toInt(),
          unitPrice: listexpensegood.unitPrice!.toInt(),
          taxPercent: listexpensegood.taxPercent,
          tax: listexpensegood.tax.toString(),
          total: listexpensegood.total.toString(),
          totalPrice: listexpensegood.totalPrice.toString(),
          withholdingPercent: listexpensegood.withholdingPercent!.toInt(),
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
        UpdateExpenseGoodEvent(
            idEmployees: userProfile.profileData.idEmployees!,
            editexpensegooddata: EditDraftExpenseGoodModel(
              idExpense: getexpensebyid.idExpense,
              idExpenseGoods: getexpensebyid.idExpenseGoods,
              documentId: getexpensebyid.documentId,
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
              total: total!.toDouble(),
              vat: vat!.toDouble(),
              withholding: withholding!.toDouble(),
              net: net!.toDouble(),
              comment: (getexpensebyid.comments!.isEmpty)
                  ? null
                  : getexpensebyid.comments.toString(),
              idEmpReviewer: reviewer,
              idEmpApprover: approver,
              deletedItem: deletedItem,
            )),
      );
    } else {
      debugPrint("not success");
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<ProfileProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(
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
                    if (state.status == FetchStatus.updatesuccess) {
                      callGetExpenseByIdData();
                    }
                    if (state.status == FetchStatus.finish &&
                        state.getexpensebyid != null &&
                        status == 1) {
                      print('listener');
                      final getExpensebyid = state.getexpensebyid;
                      if (state.currency != null && state.typeprice != null) {
                        final currency = state.currency;
                        final typeprice = state.typeprice;
                        final index = currency!.indexWhere(
                            (e) => e.unit == getExpensebyid!.currency);
                        final isVatIncluded = getExpensebyid!.isVatIncluded;
                        final taxPercent = getExpensebyid.listExpense!
                            .where((e) => e.taxPercent != null)
                            .first
                            .taxPercent;
                        final matchingIndex = typeprice!.indexWhere((element) =>
                            element.isVatIncluded == isVatIncluded &&
                            element.vat == taxPercent);
                        // print("currency[index]: ${jsonEncode(currency[index]) }");
                        // print("typeprice[index]: ${jsonEncode(typeprice[index])}");
                        print("matchingIndex: $matchingIndex");
                        print("taxPercent $taxPercent");
                        nameExpenseController.text =
                            getExpensebyid.nameExpense!;
                        approverController.text =
                            "${getExpensebyid.approverFirstnameTh} ${getExpensebyid.approverLastnameTh}";
                        reviewer = getExpensebyid.idEmpReviewer;
                        approver = getExpensebyid.idEmpApprover;
                        EmployeeRoleAdminEntity? approverxx;
                        if (state.empsroleadmin.isNotEmpty &&
                            reviewer != null) {
                          approverxx = state.empsroleadmin.firstWhere(
                            (e) =>
                                e.idEmployees == getExpensebyid.idEmpReviewer,
                          );
                          print("approverxx: $approverxx");
                          reviewerController.text =
                              "${approverxx.firstnameTh} ${approverxx.lastnameTh}";
                        }

                        (getExpensebyid.isInternational == true)
                            ? tabTextIndexSelectedtoggle = 1
                            : tabTextIndexSelectedtoggle = 0;
                        remarkController.text = getExpensebyid.remark!;
                        if (getExpensebyid.fileUrl != null) {
                          showimg = getExpensebyid.fileUrl!;
                          checkdohaveimg = true;
                        } else {
                          showimg = null;
                          checkdohaveimg = false;
                        }
                        // final selectedCurrencyIndex =
                        //     matchingUnit.isEmpty ? -1 : matchingUnit.first;
                        // if (selectedCurrencyIndex != -1) {
                        //   final selectedCurrency =
                        //       state.currency![selectedCurrencyIndex];
                        //   print(
                        //       selectedCurrency); // {"label": "THB - ไทย", "code": "TH", "unit": "THB"}
                        // }

                        // String? matchingUnit =
                        //     findMatchingUnitIndex(state.getexpensebyid!.currency, );
                        // print(matchingUnit); // ผลลัพธ์คือ 'THB'
                        expenseGoodBloc.add(
                          SelectCurrenyEvent(
                              selectedCurrency: (currency[index])),
                        );
                        expenseGoodBloc.add(
                          SelectTypePriceEvent(
                              selectedTypePrice: typeprice[matchingIndex]),
                        );
                      }
                    } else if (state.status == FetchStatus.finish &&
                        status == 2) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          duration: Durations.medium1,
                          type: PageTransitionType.rightToLeft,
                          child: const ManageItems(),
                        ),
                        (route) => route.isFirst,
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
                      print(state.isdraft);
                      // print("state.currencyRate");
                      // print(state.currencyRate);
                      // print("state");
                      // print(state);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralInputDataExpenseGood(
                            isManageItemtoPageEdit:
                                widget.isManageItemtoPageEdit,
                            namexpense: nameExpenseController,
                            expenseBloc: expenseGoodBloc,
                            idEmp: userProfile.profileData.idEmployees,
                            idExpense: state.getexpensebyid!.idExpense,
                            idExpenseGood: state.getexpensebyid!.idExpenseGoods,
                            fileUrl: (state.getexpensebyid!.fileUrl != null)
                                ? state.getexpensebyid!.fileUrl
                                : null,
                            listExpense: state.getexpensebyid!.listExpense!,
                          ),
                          ApproverFieldExpense(
                              approver: approverController,
                              onApproverSuccess: (idaproover) {
                                setState(() {
                                  approver = idaproover;
                                });
                              }),
                          // CarbonCopyExpense(
                          //   onCCEmailChanged: (newCCEmail) {
                          //     setState(() {
                          //       ccemail = newCCEmail;
                          //     });
                          //   },
                          // ),
                          InspectorFieldExpense(
                            reviewer: reviewerController,
                            onReviewerSuccess: (idReviewer) {
                              setState(() {
                                reviewer = idReviewer;
                              });
                            },
                          ),
                          LocationExpenseToggleTab(
                            initialSelectedIndex: tabTextIndexSelectedtoggle,
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
                              isdraft: state.isdraft!),
                          const SummaryListExpense(),
                          // ! upload Image
                          ImagePickerAndViewerExpenseGood(
                            checkdohaveimg: checkdohaveimg,
                            showimg: showimg,
                            selectedFile: selectedFile,
                            onFileSelected: (file) {
                              setState(() {
                                print(file);
                                selectedFile = file;
                              });
                            },
                            onTapcheckdohaveimg: (newValue) {
                              // แก้ไขนี้ให้รับค่า newValue
                              setState(() {
                                checkdohaveimg =
                                    newValue; // ใช้ค่า newValue ในการเปลี่ยนค่า checkdohaveimg
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
                              updateExpenseBloc(
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
                                state.deleteItem!,
                                state.getexpensebyid!,
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
                              updateExpenseBloc(
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
                                state.deleteItem!,
                                state.getexpensebyid!,
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
