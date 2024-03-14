import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:gap/gap.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/bloc/allowance_bloc.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/customappbar.dart';
import '../../../../../../injection_container.dart';
import '../../../../../components/custombutton.dart';
import '../../../../../components/custominputdecoration.dart';
import '../../../../../components/customremark.dart';
import '../../../../../components/customselectedtabbar.dart';
import '../../../../../components/filepicker.dart';
import '../../../../../components/motion_toast.dart';
import '../../../../../core/features/user/presentation/provider/profile_provider.dart';
import '../../../manageitems/presentation/pages/manageitems.dart';
import '../../data/models/addexpenseallowance_model.dart';
import '../../data/models/listallowance.dart';
import '../widgets/carboncopy_allowance.dart';
import '../widgets/approvefield_allowance.dart';
import '../widgets/required_text.dart';
import '../widgets/showlist_allowance_widget.dart';
import '../widgets/summary_widget.dart';
import 'allowance_edit.dart';

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
  final nameExpenseController = TextEditingController();
  final approverController = TextEditingController();
  final remarkController = TextEditingController();
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  String _enteredText = '';
  String? ccemail;
  int? approver;
  int status = 1;
  @override
  void initState() {
    super.initState();
    allowanceBloc.add(GetEmployeesAllRolesDataEvent());
  }

  @override
  void dispose() {
    allowanceBloc.close();
    super.dispose();
  }

  void addAllowanceBloc(
    int status,
    ProfileProvider userProfile,
    List<ListAllowance> listallowance,
    int isInternational,
    num? sumAllowance,
    num? sumSurplus,
    num? sumDays,
    num? sumNet,
  ) {
    FocusScope.of(context).unfocus();
    if (_keyForm.currentState!.validate()) {
      if (listallowance.isEmpty) {
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
      List<AddExpenseListExpenseModel> listExpense =
          listallowance.map((listallowance) {
        return AddExpenseListExpenseModel(
          startDate: listallowance.startDate,
          endDate: listallowance.endDate,
          description: listallowance.description,
          countDays: listallowance.countDays,
        );
      }).toList();
      allowanceBloc.add(
        AddExpenseAllowanceEvent(
            idEmployees: userProfile.profileData.idEmployees!,
            addallowancedata: AddExpenseAllowanceModel(
              nameExpense: nameExpenseController.text,
              isInternational: isInternational,
              listExpense: listExpense,
              file: selectedFile,
              remark: remarkController.text,
              typeExpense: 2,
              typeExpenseName: 'Allowance',
              lastUpdateDate:
                  DateFormat("yyyy/MM/dd HH:mm").format(DateTime.now()),
              status: status,
              sumAllowance: sumAllowance!.toInt(),
              sumSurplus: sumSurplus!.toInt(),
              sumDays: sumDays,
              sumNet: sumNet!.toInt(),
              idEmpApprover: approver,
              ccEmail: ccemail,
              idPosition: userProfile.profileData.idPosition,
            )),
      );
    }
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
                    print(state);
                    if (state.status == FetchStatus.finish && status == 1) {
                      if (state.responseaddallowance != null &&
                          state.responseaddallowance!.idExpense != null) {
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: Durations.medium1,
                            type: PageTransitionType.rightToLeft,
                            child: AllowanceEdit(
                              idExpense: state.responseaddallowance!.idExpense!,
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
                      // print(state);
                      // print(state.listExpense);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RequiredText(
                                  labelText: 'ข้อมูลทั่วไป',
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'kanit',
                                    color: Colors.black,
                                  ),
                                  asteriskText: ""),
                            ],
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
                                return 'Please enter a nameExpense';
                              }
                              return null; // Return null if the input is valid
                            },
                            decoration:
                                CustomInputDecoration.getInputDecoration(),
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
                            labels: const ['ในประเทศ', 'ต่างประเทศ'],
                            selectedIndex: state.isInternational!,
                            onTabChanged: (index) {
                              allowanceBloc
                                  .add(ToggleIsInternationEvent(index: index));
                              allowanceBloc.add(CalculateSumEvent());
                            },
                          ),
                          CarbonCopyAllowance(
                            onCCEmailChanged: (newCCEmail) {
                              setState(() {
                                ccemail = newCCEmail;
                              });
                            },
                          ),
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
                              addAllowanceBloc(
                                status,
                                userProfile,
                                state.listExpense,
                                state.isInternational!,
                                state.sumAllowance,
                                state.sumSurplus,
                                state.sumDays,
                                state.sumNet,
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
                              addAllowanceBloc(
                                status,
                                userProfile,
                                state.listExpense,
                                state.isInternational!,
                                state.sumAllowance,
                                state.sumSurplus,
                                state.sumDays,
                                state.sumNet,
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
