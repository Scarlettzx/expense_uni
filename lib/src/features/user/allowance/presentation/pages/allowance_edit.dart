// import 'dart:convert';
// import 'dart:async';
// import 'dart:ui' as ui;
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:gap/gap.dart';
// import 'package:iconamoon/iconamoon.dart';
// import 'package:intl/intl.dart';
// import 'package:motion_toast/motion_toast.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:searchfield/searchfield.dart';

// import '../../../../../components/approverfield.dart';
// import '../../../../../components/customselectedtabbar.dart';
// import '../../../../../components/filepicker.dart';
// import '../../../../../components/motion_toast.dart';
// import '../../../../../core/features/user/domain/entity/profile_entity.dart';
// import '../../../manageitems/presentation/pages/manageitems.dart';
// import '../../data/models/edit_draft_allowance_model.dart';
// import '../../domain/entities/entities.dart';
// import '../bloc/allowance_bloc.dart';
// import '../widgets/customappbar.dart';
// import '../widgets/customtextformfield.dart';
// import '../widgets/delete_draft.dart';
// import '../widgets/required_text.dart';
// import 'allowance_add_list.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/bloc/allowance_bloc.dart';

import '../../../../../../injection_container.dart';
import '../../../../../components/custombutton.dart';
import '../../../../../components/customremark.dart';
import '../../../../../components/customselectedtabbar.dart';
import '../../../../../core/features/user/presentation/provider/profile_provider.dart';
import '../../../manageitems/presentation/pages/manageitems.dart';
import '../../domain/entities/entities.dart';
import '../widgets/approvefield_allowance.dart';
import '../widgets/customappbar.dart';
import '../widgets/general_input/general_inputdata._alowance.dart';
import '../widgets/showlist_allowance_widget.dart';
import '../widgets/summary_widget.dart';

class AllowanceEdit extends StatefulWidget {
  final int idExpense;
  final bool? isManageItemtoPageEdit;
  const AllowanceEdit({
    super.key,
    required this.idExpense,
    this.isManageItemtoPageEdit,
  });

  @override
  State<AllowanceEdit> createState() => _AllowanceEditState();
}

class _AllowanceEditState extends State<AllowanceEdit> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final allowanceBloc = sl<AllowanceBloc>();
  final nameExpenseController = TextEditingController();
  final approverController = TextEditingController();
  final remarkController = TextEditingController();
  FileUrlGetAllowanceByIdEntity? showimg;
  bool checkdohaveimg = true;
  int? approver;
  PlatformFile? file;
  PlatformFile? selectedFile;
  int status = 1;
  String _enteredText = '';
  @override
  void initState() {
    super.initState();
    allowanceBloc.add(GetEmployeesAllRolesDataEvent());
    allowanceBloc.add(GetExpenseAllowanceByIdData(idExpense: widget.idExpense));
  }

  void callGetAllowanceByIdData() {
    allowanceBloc.add(GetExpenseAllowanceByIdData(
      idExpense: widget.idExpense,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final ProfileProvider userProfile = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(
          image: 'appbar_aollowance.png', title: 'เบี้ยเลี้ยง'),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: BlocProvider(
              create: (context) => allowanceBloc,
              child: Form(
                key: _keyForm,
                child: BlocConsumer<AllowanceBloc, AllowanceState>(
                  listener: (context, state) {
                    if (state.status == FetchStatus.updatesuccess) {
                      callGetAllowanceByIdData();
                    }
                    if (state.status == FetchStatus.finish &&
                        state.expenseallowancebyid != null &&
                        state.expenseallowancebyid!.idExpense != null &&
                        status == 1) {
                      final getAllowanceResponse = state.expenseallowancebyid;
                      if (getAllowanceResponse != null) {
                        nameExpenseController.text =
                            getAllowanceResponse.nameExpense!;
                        approver = getAllowanceResponse.idEmpApprover;
                        // EmployeesAllRolesEntity? approverxx;
                        // if (state.empsallrole.isNotEmpty && approver != null) {
                        //   approverxx = state.empsallrole.firstWhere(
                        //     (e) =>
                        //         e.idEmployees ==
                        //         getAllowanceResponse.idEmpApprover,
                        //   );
                        // }
                        approverController.text =
                            getAllowanceResponse.approverName!;
                        remarkController.text = getAllowanceResponse.remark!;
                        if (getAllowanceResponse.fileUrl != null) {
                          showimg = getAllowanceResponse.fileUrl!;
                          checkdohaveimg = true;
                        } else {
                          showimg = null;
                          checkdohaveimg = false;
                        }
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
                    // print(state);
                    // if (state.status == FetchStatus.finish && status == 1) {
                    //   if (state.responseaddallowance != null &&
                    //       state.responseaddallowance!.idExpense != null) {
                    //     Navigator.push(
                    //       context,
                    //       PageTransition(
                    //         duration: Durations.medium1,
                    //         type: PageTransitionType.rightToLeft,
                    //         child: AllowanceEdit(
                    //           idExpense: state.responseaddallowance!.idExpense!,
                    //         ),
                    //       ),
                    //     );
                    //   }
                    // }
                    // if (state.status == FetchStatus.finish && status == 2) {
                    //   Navigator.pushReplacement(
                    //     context,
                    //     PageTransition(
                    //       duration: Durations.medium1,
                    //       type: PageTransitionType.rightToLeft,
                    //       child: const ManageItems(),
                    //     ),
                    //   );
                    // }
                  },
                  builder: (context, state) {
                    if (state.status == FetchStatus.initial) {
                      return Text(
                        "ไม่พบข้อมูล",
                      );
                    } else if (state.status == FetchStatus.loading) {
                      return LoadingAnimationWidget.inkDrop(
                        color: Color(0xffff99ca),
                        size: 35,
                      );
                    } else if (state.status == FetchStatus.finish ||
                        state.status == FetchStatus.toggle ||
                        state.status == FetchStatus.list) {
                      print(state);
                      print(state.listExpense);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralInputDataAllowance(
                            isManageItemtoPageEdit:
                                widget.isManageItemtoPageEdit,
                            namexpense: nameExpenseController,
                            allowanceBloc: allowanceBloc,
                            idEmp: userProfile.profileData.idEmployees,
                            idExpense: state.expenseallowancebyid!.idExpense,
                            idExpenseAllowance:
                                state.expenseallowancebyid!.idExpenseAllowance,
                            fileUrl:
                                (state.expenseallowancebyid!.fileUrl != null)
                                    ? state.expenseallowancebyid!.fileUrl
                                    : null,
                            listExpense:
                                state.expenseallowancebyid!.listExpense!,
                          ),
                          Text(
                            'สถานที่เกิดค่าใช้จ่าย',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade600),
                          ),
                          const Gap(10),
                          CustomSelectedTabbar(
                            labels: const ['ในประเทศ', 'ต่างประเทศ'],
                            selectedIndex: state.isInternational!,
                            onTabChanged: (index) {
                              allowanceBloc
                                  .add(ToggleIsInternationEvent(index: index));
                              allowanceBloc.add(CalculateSumEvent());
                            },
                          ),
                          const Gap(20),
                          ApproverFieldAllowance(
                              approver: approverController,
                              onApproverSuccess: (idaproover) {
                                setState(() {
                                  approver = idaproover;
                                });
                              }),
                          ShowListAllowanceWidget(
                            allowanceBloc: allowanceBloc,
                            isdraft: state.isdraft!,
                          ),
                          const SummaryWidget(),
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
                              // addAllowanceBloc(
                              //   status,
                              //   userProfile,
                              //   state.listExpense,
                              //   state.isInternational!,
                              //   state.sumAllowance,
                              //   state.sumSurplus,
                              //   state.sumDays,
                              //   state.sumNet,
                              // );
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
                              // addAllowanceBloc(
                              //   status,
                              //   userProfile,
                              //   state.listExpense,
                              //   state.isInternational!,
                              //   state.sumAllowance,
                              //   state.sumSurplus,
                              //   state.sumDays,
                              //   state.sumNet,
                              // );
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         image: 'appbar_aollowance.png',
//         title: 'เบี้ยเลี้ยง',
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(30),
//         child: Form(
//           key: _keyForm,
//           child: BlocProvider(
//             create: (context) => widget.allowancebloc,
//             child: BlocConsumer<AllowanceBloc, AllowanceState>(
//               listener: (context, state) {
//                 print(state);
//                 print("passlistener");
//                 print(status);
//                 if (state.status ==  FetchStatus.finish &&
//                     state.expenseallowancebyid != null &&
//                     status == 1) {
//                   print('yes');
//                   print("old list${listExpense}");

//                   listExpense = state.expenseallowancebyid!.listExpense!
//                       .map((expenseEntity) => expenseEntity.toJson())
//                       .toList();
//                   print("new list${listExpense}");
//                   nameExpenseController.text =
//                       state.expenseallowancebyid!.nameExpense!;
//                   approverController.text =
//                       state.expenseallowancebyid!.approverName!;
//                   idempapprover = state.expenseallowancebyid!.idEmpApprover!;
//                   remarkController.text = state.expenseallowancebyid!.remark!;
//                   isInternational =
//                       state.expenseallowancebyid!.isInternational! ? 1 : 0;
//                   if (state.expenseallowancebyid!.fileUrl != null) {
//                     showimg = state.expenseallowancebyid!.fileUrl!;
//                     checkdohaveimg = true;
//                   } else {
//                     showimg = null;
//                     checkdohaveimg = false;
//                   }
//                   calculateSum(listExpense);
//                 } else if (state.status ==  FetchStatus.finish && status == 2) {
//                   Navigator.pushReplacement(
//                     context,
//                     PageTransition(
//                       duration: Durations.medium1,
//                       type: PageTransitionType.rightToLeft,
//                       child: const ManageItems(),
//                     ),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 if (state is AllowanceInitial) {
//                   return Text(
//                     "ไม่พบข้อมูล",
//                   );
//                 } else if (state.status == FetchStatus.loading) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (state.status == FetchStatus.failure) {
//                   return const Text("error");
//                 } else if (state.status == FetchStatus.finish) {
//                   // setState(() {
//                   //   print("old list${listExpense}");

//                   //   print("new list${listExpense}");
//                   // });
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           RequiredText(
//                             labelText: 'ข้อมูลทั่วไป',
//                             textStyle: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'kanit',
//                               color: Colors.black,
//                             ),
//                             asteriskText: ' ( แบบร่าง ) ',
//                             asteriskStyle: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.normal,
//                               fontFamily: 'kanit',
//                               color: Color.fromRGBO(117, 117, 117, 1),
//                             ),
//                           ),
//                           if (widget.profiledata.idEmployees != null &&
//                               state.expenseallowancebyid?.idExpense != null &&
//                               state.expenseallowancebyid?.idExpenseAllowance !=
//                                   null &&
//                               state.expenseallowancebyid?.listExpense !=
//                                   null) ...[
//                             DeleteDraftAllowance(
//                                 allowanceBloc: widget.allowancebloc,
//                                 idEmp: widget.profiledata.idEmployees,
//                                 idExpense:
//                                     state.expenseallowancebyid!.idExpense!,
//                                 idExpenseAllowance: state
//                                     .expenseallowancebyid!.idExpenseAllowance!,
//                                 listExpense:
//                                     state.expenseallowancebyid!.listExpense,
//                                 fileUrl: (state.expenseallowancebyid!.fileUrl !=
//                                         null)
//                                     ? state.expenseallowancebyid!.fileUrl
//                                     : null,
//                                 onDeleted: () {
//                                   setState(() {
//                                     widget.checkonclickdraft ==
//                                         false; // เมื่อลบเสร็จเรียกใช้ callback เพื่อ set checkonclickdraft เป็น false
//                                   });
//                                 }),
//                           ]
//                         ],
//                       ),
//                       const Gap(20),
//                       RequiredText(
//                         labelText: 'ชื่อรายการ',
//                         asteriskText: '*',
//                       ),
//                       const Gap(10),
//                       CustomTextField(
//                         controller: nameExpenseController,
//                         onChanged: (value) {
//                           print(value);
//                           print(nameExpenseController.text);
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a nameExpense';
//                           }
//                           return null;
//                         },
//                       ),
//                       const Gap(20),
//                       Text(
//                         'สถานที่เกิดค่าใช้จ่าย',
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.normal,
//                             color: Colors.grey.shade600),
//                       ),
//                       const Gap(10),
//                       CustomSelectedTabbar(
//                         labels: const ['ในประเทศ', 'ต่างประเทศ'],
//                         selectedIndex: isInternational,
//                         onTabChanged: (index) {
//                           print(widget.checkonclickdraft);
//                           setState(() {
//                             // ตรวจสอบ index เพื่อกำหนดค่า isInternational และ formData['isInternational']
//                             if (index == 0) {
//                               isInternational = 0;
//                             } else {
//                               isInternational = 1;
//                             }

//                             // // ตรวจสอบค่า isInternational เพื่อกำหนดค่า allowanceRate และ allowanceRateGoverment
//                             // if (getFormData()["isInternational"] == 1) {
//                             //   getFormData()["allowanceRate"] =
//                             //       allowanceRateInternational;
//                             //   getFormData()["allowanceRateGoverment"] =
//                             //       govermentAllowanceRateInternational;
//                             // } else {
//                             //   getFormData()["allowanceRate"] = allowanceRate;
//                             //   getFormData()["allowanceRateGoverment"] =
//                             //       govermentAllowanceRate;
//                             // }

//                             // // อื่น ๆ ที่คุณต้องการทำในการเปลี่ยนแท็บ
//                             calculateSum(listExpense);
//                             // _tabTextIndexSelected = index;
//                             // print(_tabTextIndexSelected);
//                             // print(isInternational);
//                             // calculateSum(listExpense);
//                           });
//                         },
//                       ),
//                       const Gap(20),
//                       RequiredText(
//                         labelText: 'ผู้อนุมัติ',
//                         asteriskText: '*',
//                       ),
//                       const Gap(10),
//                       CustomSearchField(
//                         controller: approverController,
//                         onSuggestionTap: (selectedItem) {
//                           if (selectedItem is SearchFieldListItem<String>) {
//                             approverController.text = selectedItem.item!;
//                             FocusScope.of(context).unfocus();
//                           }
//                           print(approverController.text);
//                         },
//                         suggestions: state.empsallrole!
//                             .map((e) => SearchFieldListItem(
//                                   "${e.firstnameTh} ${e.lastnameTh}",
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                         "${e.firstnameTh} ${e.lastnameTh}"),
//                                   ),
//                                 ))
//                             .toList(),
//                         validator: (String? value) {
//                           if (value != null && value.isNotEmpty) {
//                             String enteredText = value.trim();
//                             print("enteredText: '$enteredText'");

//                             List<String> suggestionTexts = state.empsallrole!
//                                 .map((e) =>
//                                     "${e.firstnameTh} ${e.lastnameTh}".trim())
//                                 .toList();
//                             print("Suggestion Texts: $suggestionTexts");

//                             List<Object> suggestionIds = state.empsallrole!
//                                 .map((e) => e.idEmployees ?? "")
//                                 .toList();
//                             print("Suggestion Ids: $suggestionIds");

//                             if (suggestionTexts
//                                 .map((e) => e.replaceAll(RegExp(r'\s+'), ''))
//                                 .contains(enteredText.replaceAll(
//                                     RegExp(r'\s+'), ''))) {
//                               int index = suggestionTexts
//                                   .map((e) => e.replaceAll(RegExp(r'\s+'), ''))
//                                   .toList()
//                                   .indexOf(enteredText.replaceAll(
//                                       RegExp(r'\s+'), ''));

//                               if (value == enteredText) {
//                                 setState(() {
//                                   print(index);
//                                   print(suggestionIds[index]);
//                                   idempapprover = int.tryParse(
//                                       suggestionIds[index].toString())!;
//                                   // getFormData()['approver'] =
//                                   //     suggestionIds[index];
//                                   // print(getFormData()['approver']);
//                                   // print(" test ${suggestionIds[index]}");
//                                 });
//                                 return null;
//                               }
//                             }
//                           }
//                           return 'Please Enter a valid State';
//                         },
//                       ),
//                       const Gap(30),
//                       Divider(
//                         color: Colors.grey.shade300,
//                         height: 1,
//                       ),
//                       const Gap(20),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           RequiredText(
//                             labelText: 'รายการ',
//                             asteriskText: '*',
//                             textStyle: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'kanit',
//                                 color: Colors.black),
//                           ),
//                           InkWell(
//                             borderRadius: BorderRadius.circular(30.0),
//                             onTap: () async {
//                               List<ExpenseDataDraft>? dataInitial =
//                                   await Navigator.push(
//                                 context,
//                                 PageTransition(
//                                   duration: Durations.medium1,
//                                   type: PageTransitionType.rightToLeft,
//                                   child: AllowanceAddList(
//                                     checkonclickdraft: widget.checkonclickdraft,
//                                   ),
//                                 ),
//                               );
//                               (dataInitial != null && dataInitial.isNotEmpty)
//                                   ? ExpenseData.updateListExpense(
//                                       dataInitial, listExpense)
//                                   : null;
//                               print(json.encode(listExpense));
//                               // getFormData()['listExpense'] = listExpense;
//                               // print(
//                               //     "${getFormData()['listExpense']} 'listExpense'");
//                               setState(() {
//                                 calculateSum(listExpense);
//                               });
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Color(0xffff99ca),
//                                 borderRadius: BorderRadius.circular(30.0),
//                               ),
//                               padding: EdgeInsets.symmetric(
//                                   horizontal:
//                                       MediaQuery.of(context).devicePixelRatio *
//                                           7,
//                                   vertical:
//                                       MediaQuery.of(context).devicePixelRatio *
//                                           2.5),
//                               // shape: Border.all(width: 2),
//                               // onPressed: () => {},
//                               // fillColor: ,
//                               child: Text(
//                                 '+ เพิ่มรายการ',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Gap(10),
//                       (listExpense.isEmpty)
//                           ? Padding(
//                               padding: EdgeInsets.only(
//                                   top: MediaQuery.of(context).devicePixelRatio *
//                                       1,
//                                   bottom:
//                                       MediaQuery.of(context).devicePixelRatio *
//                                           1),
//                               child: Container(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.08,
//                                 alignment: AlignmentDirectional.center,
//                                 width: double.infinity,
//                                 // color: Colors.red,
//                                 child: Text(
//                                   'ยังไม่มีรายการ',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.normal,
//                                       color: Colors.grey),
//                                 ),
//                               ))
//                           : ListView.builder(
//                               physics: BouncingScrollPhysics(),
//                               shrinkWrap: true,
//                               reverse: true,
//                               itemCount: listExpense.length,
//                               itemBuilder: (context, index) {
//                                 return Slidable(
//                                   endActionPane: ActionPane(
//                                       motion: const StretchMotion(),
//                                       children: [
//                                         SlidableAction(
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                             icon: IconaMoon.edit,
//                                             onPressed: (_) async {
//                                               setState(() {
//                                                 _selectedIndex = index;
//                                               });
//                                               List<ExpenseDataDraft>?
//                                                   dataInitial =
//                                                   await Navigator.push(
//                                                 context,
//                                                 PageTransition(
//                                                   duration: Durations.medium1,
//                                                   type: PageTransitionType
//                                                       .rightToLeft,
//                                                   child: AllowanceAddList(
//                                                     checkonclickdraft: widget
//                                                         .checkonclickdraft,
//                                                     listexpense:
//                                                         listExpense[index],
//                                                   ),
//                                                 ),
//                                               );
//                                               if (dataInitial != null &&
//                                                   dataInitial.isNotEmpty) {
//                                                 listExpense[_selectedIndex]
//                                                     .clear();
//                                                 dataInitial
//                                                     .map((expense) =>
//                                                         expense.toJson())
//                                                     .toList()
//                                                     .forEach((item) {
//                                                   listExpense[_selectedIndex]
//                                                       .addAll(item);
//                                                 });
//                                               } else {
//                                                 null;
//                                               }
//                                               print(listExpense);
//                                               setState(() {
//                                                 calculateSum(listExpense);
//                                               });
//                                             },
//                                             backgroundColor: Colors.amber,
//                                             foregroundColor: Colors.white,
//                                             flex: 2),
//                                         SlidableAction(
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                             icon: Icons.delete_rounded,
//                                             backgroundColor: Colors.red,
//                                             foregroundColor: Colors.white,
//                                             onPressed: (_) {
//                                               setState(() {
//                                                 if (listExpense[index][
//                                                         'idExpenseAllowanceItem'] !=
//                                                     null) {
//                                                   deletedItem.add(listExpense[
//                                                           index][
//                                                       'idExpenseAllowanceItem']);
//                                                 }
//                                                 listExpense.removeAt(index);
//                                                 // recieveData!.clear();
//                                                 calculateSum(listExpense);
//                                               });
//                                             },
//                                             flex: 2),
//                                       ]),
//                                   child: Container(
//                                     padding: EdgeInsets.only(bottom: 10),
//                                     child: Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       surfaceTintColor:
//                                           Color.fromARGB(255, 255, 218, 218),
//                                       shadowColor:
//                                           Color.fromARGB(255, 249, 90, 167),
//                                       elevation: 8,
//                                       color: Color(0xffff99ca),

//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10, vertical: 15),
//                                         child: Column(
//                                           children: [
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 20.0,
//                                                       vertical: 8.0),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 children: [
//                                                   Text('รายละเอียด: ',
//                                                       style: TextStyle(
//                                                           // color: Colors.white,
//                                                           fontSize: 16,
//                                                           fontWeight:
//                                                               FontWeight.bold)),
//                                                   Gap(5),
//                                                   Text(
//                                                       '${listExpense[index]['description']}'),
//                                                 ],
//                                               ),
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceAround,
//                                               children: [
//                                                 Container(
//                                                   padding: EdgeInsets.all(8),
//                                                   // height: 50,
//                                                   decoration: BoxDecoration(
//                                                       boxShadow: [
//                                                         BoxShadow(
//                                                           color: Color(
//                                                                   0xfffc466b)
//                                                               .withOpacity(0.5),
//                                                           offset: Offset(5, 5),
//                                                           blurRadius: 10,
//                                                         )
//                                                       ],
//                                                       gradient: SweepGradient(
//                                                         colors: [
//                                                           Color(0xfffc466b),
//                                                           Color(0xff3f5efb)
//                                                         ],
//                                                         stops: [0.25, 0.75],
//                                                         center:
//                                                             Alignment.topRight,
//                                                       ),
//                                                       color: Colors.white,
//                                                       // border:
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                               Radius.circular(
//                                                                   15))),
//                                                   child: Column(
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text('Start Date',
//                                                           style: TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color: Colors
//                                                                   .white)),
//                                                       Text(
//                                                           ' ${listExpense[index]['startDate']}',
//                                                           style: TextStyle(
//                                                               color: Colors
//                                                                   .white)),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Column(
//                                                   children: [
//                                                     Icon(IconaMoon.arrowRight1),
//                                                     Text(
//                                                         '${(listExpense[index]['countDays'] as num).toStringAsFixed(2)} วัน')
//                                                   ],
//                                                 ),
//                                                 Container(
//                                                   padding: EdgeInsets.all(8),
//                                                   decoration: BoxDecoration(
//                                                       boxShadow: [
//                                                         BoxShadow(
//                                                           color: Color(
//                                                                   0xfffc466b)
//                                                               .withOpacity(0.5),
//                                                           offset: Offset(5, 5),
//                                                           blurRadius: 10,
//                                                         )
//                                                       ],
//                                                       gradient: SweepGradient(
//                                                         colors: [
//                                                           Color(0xfffc466b),
//                                                           Color(0xff3f5efb)
//                                                         ],
//                                                         stops: [0.25, 0.75],
//                                                         center:
//                                                             Alignment.topRight,
//                                                       ),
//                                                       color: Colors.white,
//                                                       // border:
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                               Radius.circular(
//                                                                   15))),
//                                                   child: Column(
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text('End Date',
//                                                           style: TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color: Colors
//                                                                   .white)),
//                                                       Text(
//                                                           '${listExpense[index]['endDate']}',
//                                                           style: TextStyle(
//                                                               color: Colors
//                                                                   .white)),
//                                                     ],
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                             Gap(5),
//                                           ],
//                                         ),
//                                       ),
//                                       // subtitle:
//                                       // Add more details as needed
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                       Gap(10),
//                       Divider(
//                         color: Colors.grey.shade300,
//                         height: 1,
//                       ),
//                       const Gap(25),
//                       const Text(
//                         'สรุปรายการ',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       const Gap(10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'สรุปจำนวนวันเดินทาง',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.grey),
//                           ),
//                           Text(
//                             '${sumDays.toStringAsFixed(2)} วัน',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                       const Gap(5),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'เบี้ยเลี้ยง/วัน',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.grey),
//                           ),
//                           (isInternational == 0)
//                               ? Text(
//                                   '${NumberFormat("###,###.00#", "en_US").format(double.parse(allowanceRate.toString()))} บาท',
//                                   // : '${NumberFormat("###,###.00#", "en_US").format(double.parse(allowanceRateInternational.toString()))} บาท',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.normal,
//                                       color: Colors.grey),
//                                 )
//                               : Text(
//                                   '${NumberFormat("###,###.00#", "en_US").format(double.parse(allowanceRateInternational.toString()))} บาท',
//                                   // : '${NumberFormat("###,###.00#", "en_US").format(double.parse(allowanceRateInternational.toString()))} บาท',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.normal,
//                                       color: Colors.grey),
//                                 )
//                         ],
//                       ),
//                       const Gap(5),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'เบี้ยเลี้ยงตามอัตราราชการ',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.grey),
//                           ),
//                           (isInternational == 0)
//                               ? Text(
//                                   '${NumberFormat("###,###.00#", "en_US").format(double.parse(govermentAllowanceRate.toString()))} บาท',
//                                   // !isInternational
//                                   //     ? '${NumberFormat("###,###.00#", "en_US").format(double.parse(govermentAllowanceRate.toString()))} บาท'
//                                   //     : '${NumberFormat("###,###.00#", "en_US").format(double.parse(govermentAllowanceRateInternational.toString()))} บาท',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.normal,
//                                       color: Colors.grey),
//                                 )
//                               : Text(
//                                   '${NumberFormat("###,###.00#", "en_US").format(double.parse(govermentAllowanceRateInternational.toString()))} บาท',
//                                   // !isInternational
//                                   //     ? '${NumberFormat("###,###.00#", "en_US").format(double.parse(govermentAllowanceRate.toString()))} บาท'
//                                   //     : '${NumberFormat("###,###.00#", "en_US").format(double.parse(govermentAllowanceRateInternational.toString()))} บาท',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.normal,
//                                       color: Colors.grey),
//                                 ),
//                         ],
//                       ),
//                       const Gap(5),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'เบี้ยเลี้ยงส่วนเกินอัตราราชการ  ',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal,
//                                     color: Colors.grey),
//                               ),
//                               Text(
//                                 '(จะถูกนำคิดภาษีเงินได้)',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal,
//                                     color: Colors.grey),
//                               ),
//                             ],
//                           ),
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               ' ${NumberFormat("#,##0.00", "en_US").format(sumSurplus)} บาท ',
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.normal,
//                                   color: Colors.grey),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Gap(5),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'มูลค่าสุทธิรวม',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black),
//                           ),
//                           Text(
//                             ' ${NumberFormat("#,##0.00", "en_US").format(sumNet)} บาท ',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black),
//                           ),
//                         ],
//                       ),
//                       const Gap(25),
//                       Divider(
//                         color: Colors.grey.shade300,
//                         height: 1,
//                       ),
//                       const Gap(25),
//                       if (checkdohaveimg == false) ...[
//                         FilePickerComponent(
//                           onFileSelected: (file) {
//                             setState(() {
//                               print(file);
//                               selectedFile = file;

//                               // getFormData()['file'] =
//                               //     file != null ? file.path : null;
//                               // print(getFormData()['file']);
//                               // print(formData);
//                             });
//                           },
//                         ),
//                       ] else if (checkdohaveimg == true && showimg != null) ...[
//                         InkWell(
//                           onTap: () async {
//                             // ดึงขนาดหน้าจอ

//                             // ดึงขนาดรูปภาพจาก URL
//                             final networkImage = NetworkImage(showimg!.url!);
//                             final ui.Image image =
//                                 await _getImageSize(showimg!.url!);
//                             await _showImageDialog(image, networkImage);
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: Color.fromRGBO(255, 234, 239, 0.29),
//                             ),
//                             width: double.infinity,
//                             child: ListTile(
//                               leading: Icon(Icons.insert_drive_file),
//                               title: Text(showimg!.path.toString()),
//                               trailing: InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     checkdohaveimg = false;
//                                   });
//                                 },
//                                 child: Icon(
//                                   Icons.delete,
//                                   color: Colors.red,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                       const Gap(25),
//                       Divider(
//                         color: Colors.grey.shade300,
//                         height: 1,
//                       ),
//                       const Gap(30),
//                       const Text(
//                         'หมายเหตุ (เพิ่มเติม)',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       const Gap(20),
//                       SizedBox(
//                         // color: Colors.red,
//                         // height: 200,
//                         width: double.infinity,
//                         child: TextFormField(
//                           controller: remarkController,
//                           onChanged: (value) {
//                             setState(() {
//                               _enteredText = value;
//                               // getFormData()['remark'] = remarkController.text;
//                             });
//                           },

//                           minLines: 2,
//                           maxLines: 5,
//                           // maxLengthEnforcement: MaxLengthEnforcement.enforced,
//                           maxLength: 500,
//                           // style: ,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(500),
//                           ],
//                           decoration: InputDecoration(
//                             isDense: true,
//                             counterText:
//                                 '${_enteredText.length.toString()} / ${500}',
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 16),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   width: 2.0,
//                                   color: Color.fromARGB(255, 252, 119, 119)),
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide: BorderSide(
//                                   width: 2.0,
//                                   color: Colors.grey.withOpacity(0.3)),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Gap(20),
//                       Divider(
//                         color: Colors.grey.shade300,
//                         height: 1,
//                       ),
//                       const Gap(30),
//                       SizedBox(
//                         width: double.infinity,
//                         child: OutlinedButton.icon(
//                           onPressed: () async {
//                             FocusScope.of(context).unfocus();
//                             if (_keyForm.currentState!.validate()) {
//                               if (listExpense.isEmpty) {
//                                 return CustomMotionToast.show(
//                                   context: context,
//                                   title: "ListExpense is empty",
//                                   description: "Please Add ListExpense",
//                                   icon: Icons.notification_important,
//                                   primaryColor: Colors.pink,
//                                   width: 300,
//                                   height: 100,
//                                   animationType: AnimationType.fromLeft,
//                                   fontSizeTitle: 18.0,
//                                   fontSizeDescription: 15.0,
//                                 );
//                               }
//                               debugPrint("success");
//                               // print(approverController.text);
//                               // getFormData().forEach((key, value) {
//                               //   print('$key: ${value.runtimeType}');
//                               // });
//                               // print(profileProvider
//                               //     .profileData.idEmployees!.runtimeType);
//                               // if (checkonclickdraft == false) {
//                               //   AddExpenseAllowanceModel model =
//                               //       convertFormDataToModel(formData);
//                               //   // เมื่อ AddExpenseAllowanceEvent เสร็จสิ้น, ทำตามเงื่อนไขนี้
//                               //   allowanceBloc.add(AddExpenseAllowanceEvent(
//                               //     idCompany:
//                               //         profileProvider.profileData.idEmployees!,
//                               //     addallowancedata: model,
//                               //   ));
//                               //   setState(() {
//                               //     checkonclickdraft = true;
//                               //   });
//                               // } else if (checkonclickdraft == true) {
//                               //   // allowanceBloc.add(UpdateExpenseAllowanceEvent(idEmp: profileProvider
//                               //   //       .profileData.idEmployees!, editallowancedata: ));
//                               // }
//                               // print(profileProvider.profileData.idpo!);

//                               // if (state.responseaddallowance != null &&
//                               //     state.responseaddallowance!.idExpense !=
//                               //         null) {
//                               //   allowanceBloc.add(GetExpenseAllowanceByIdData(
//                               //     idExpense:
//                               //         state.responseaddallowance!.idExpense!,
//                               //   ));
//                               // }
//                               print("id  $idempapprover");
//                               print("file  $selectedFile");
//                               print("idemp  ${widget.profiledata.idEmployees}");
//                               print(
//                                   "lastupdate  ${DateFormat("yyyy/MM/dd HH:mm").format(DateTime.now()).runtimeType}");
//                               print(listExpense.map((e) {
//                                 e.forEach((key, value) {
//                                   print('$key: ${value.runtimeType}');
//                                 });
//                               }));
//                               print(List<ListExpenseModel>.from(
//                                 listExpense.map(
//                                   (e) => ListExpenseModel.fromJson(e),
//                                 ),
//                               ));
//                               status = 1;
//                               // print(json.encode(listExpense));
//                               // print(json.encode(listExpense));
//                               widget.allowancebloc.add(
//                                 UpdateExpenseAllowanceEvent(
//                                   idEmp: widget.profiledata.idEmployees!,
//                                   editallowancedata: EditDraftAllowanceModel(
//                                     nameExpense: nameExpenseController.text,
//                                     idExpense:
//                                         state.expenseallowancebyid!.idExpense,
//                                     idExpenseAllowance: state
//                                         .expenseallowancebyid!
//                                         .idExpenseAllowance,
//                                     documentId:
//                                         state.expenseallowancebyid!.documentId,
//                                     isInternational: isInternational,
//                                     listExpense: List<ListExpenseModel>.from(
//                                       listExpense.map(
//                                         (e) => ListExpenseModel.fromJson(e),
//                                       ),
//                                     ),
//                                     file: selectedFile,
//                                     remark: remarkController.text,
//                                     typeExpense:
//                                         state.expenseallowancebyid!.expenseType,
//                                     typeExpenseName: state
//                                         .expenseallowancebyid!.typeExpenseName,
//                                     lastUpdateDate:
//                                         DateFormat("yyyy/MM/dd HH:mm")
//                                             .format(DateTime.now()),
//                                     status: status,
//                                     sumAllowance: sumAllowance.toInt(),
//                                     sumSurplus: sumSurplus.toInt(),
//                                     sumDays: sumDays.toInt(),
//                                     sumNet: sumNet.toInt(),
//                                     comment: 'null',
//                                     deletedItem: deletedItem,
//                                     idEmpApprover: idempapprover,
//                                   ),
//                                 ),
//                               );
//                               setState(() {
//                                 callGetExpenseAllowanceByIdData();
//                               });
//                               // print(model.file.runtimeType);
//                               // ));
//                             } else {
//                               debugPrint("not success");
//                               print(approverController.text);
//                             }
//                           },
//                           style: OutlinedButton.styleFrom(
//                             side: BorderSide(
//                                 width: 2,
//                                 color: Color(0xffff99ca)), // สีขอบสีส้ม
//                           ),
//                           icon: const Icon(Icons.save_as,
//                               color: Color(0xffff99ca)),
//                           label: const Text(
//                             'บันทึกแบบร่าง',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xffff99ca), // สีข้อความสีส้ม
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Gap(10),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton.icon(
//                           label: const Text(
//                             'ส่งอนุมัติ',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white, // สีข้อความขาว
//                             ),
//                           ),
//                           icon: const Icon(
//                             Icons.send,
//                             color: Colors.white,
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             primary: Color(0xffff99ca), // สีปุ่มสีส้ม
//                           ),
//                           onPressed: () async {
//                             FocusScope.of(context).unfocus();
//                             if (_keyForm.currentState!.validate()) {
//                               if (listExpense.isEmpty) {
//                                 return CustomMotionToast.show(
//                                   context: context,
//                                   title: "ListExpense is empty",
//                                   description: "Please Add ListExpense",
//                                   icon: Icons.notification_important,
//                                   primaryColor: Colors.pink,
//                                   width: 300,
//                                   height: 100,
//                                   animationType: AnimationType.fromLeft,
//                                   fontSizeTitle: 18.0,
//                                   fontSizeDescription: 15.0,
//                                 );
//                               }
//                               debugPrint("waiting");
//                               print("id  $idempapprover");
//                               print("file  $selectedFile");
//                               print("idemp  ${widget.profiledata.idEmployees}");
//                               print(
//                                   "lastupdate  ${DateFormat("yyyy/MM/dd HH:mm").format(DateTime.now()).runtimeType}");
//                               print(listExpense.map((e) {
//                                 e.forEach((key, value) {
//                                   print('$key: ${value.runtimeType}');
//                                 });
//                               }));
//                               print(List<ListExpenseModel>.from(
//                                 listExpense.map(
//                                   (e) => ListExpenseModel.fromJson(e),
//                                 ),
//                               ));
//                               status = 2;
//                               // print(json.encode(listExpense));
//                               // print(json.encode(listExpense));
//                               widget.allowancebloc.add(
//                                 UpdateExpenseAllowanceEvent(
//                                   idEmp: widget.profiledata.idEmployees!,
//                                   editallowancedata: EditDraftAllowanceModel(
//                                     nameExpense: nameExpenseController.text,
//                                     idExpense:
//                                         state.expenseallowancebyid!.idExpense,
//                                     idExpenseAllowance: state
//                                         .expenseallowancebyid!
//                                         .idExpenseAllowance,
//                                     documentId:
//                                         state.expenseallowancebyid!.documentId,
//                                     isInternational: isInternational,
//                                     listExpense: List<ListExpenseModel>.from(
//                                       listExpense.map(
//                                         (e) => ListExpenseModel.fromJson(e),
//                                       ),
//                                     ),
//                                     file: selectedFile,
//                                     remark: remarkController.text,
//                                     typeExpense:
//                                         state.expenseallowancebyid!.expenseType,
//                                     typeExpenseName: state
//                                         .expenseallowancebyid!.typeExpenseName,
//                                     lastUpdateDate:
//                                         DateFormat("yyyy/MM/dd HH:mm")
//                                             .format(DateTime.now()),
//                                     status: status,
//                                     sumAllowance: sumAllowance.toInt(),
//                                     sumSurplus: sumSurplus.toInt(),
//                                     sumDays: sumDays.toInt(),
//                                     sumNet: sumNet.toInt(),
//                                     comment: 'null',
//                                     deletedItem: [],
//                                     idEmpApprover: idempapprover,
//                                   ),
//                                 ),
//                               );
//                             } else {
//                               debugPrint("not success");
//                             }
//                           },
//                         ),
//                       ),
//                       const Gap(10),
//                     ],
//                   );
//                 }
//                 return Container();
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
