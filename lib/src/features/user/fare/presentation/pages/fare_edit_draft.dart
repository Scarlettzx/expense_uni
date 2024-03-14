import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
// import 'package:iconamoon/iconamoon.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:uni_expense/injection_container.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/customappbar.dart';
// import 'package:uni_expense/src/features/user/fare/data/models/add_fare_model.dart';
import 'package:uni_expense/src/features/user/fare/domain/entities/getfarebyid.dart';

import '../../../../../components/custombutton.dart';
import '../../../../../components/customremark.dart';
// import '../../../../../components/filepicker.dart';
import '../../../../../components/motion_toast.dart';
import '../../../../../core/features/user/presentation/provider/profile_provider.dart';
import '../../../manageitems/presentation/pages/manageitems.dart';
import '../../data/models/addlist_location_fuel.dart';
import '../../data/models/edit_draft_fare_model.dart';
import '../bloc/fare_bloc.dart';
import '../widgets/approverfield.dart';
// import '../widgets/carboncopy.dart';
import '../widgets/general/general_input_data.dart';
// import '../widgets/info.dart';
import '../widgets/locationfuel_widget.dart';
import '../widgets/showimg_editdraft.dart';
import '../widgets/summary_list.dart';

class FareEditDraft extends StatefulWidget {
  final int idExpense;
  final bool? isManageItemtoPageEdit;
  const FareEditDraft({
    super.key,
    required this.idExpense,
    this.isManageItemtoPageEdit,
  });

  @override
  State<FareEditDraft> createState() => _FareEditDraftState();
}

class _FareEditDraftState extends State<FareEditDraft> {
  List<int> deletedItem = [];
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  PlatformFile? selectedFile;
  final nameExpenseController = TextEditingController();
  final approverController = TextEditingController();
  final remarkController = TextEditingController();
  String? ccemail;
  int? approver;
  FileUrl? showimg;
  bool checkdohaveimg = true;
  final fareBloc = sl<FareBloc>();
  String _enteredText = '';
  bool draftisBool = false;
  int status = 1;
  @override
  void initState() {
    super.initState();
    print('init');

    fareBloc.add((GetFareByIdEvent(idExpense: widget.idExpense)));
    fareBloc.add(GetEmployeesAllRolesEvent());
  }

  void callGetFareByIdData() {
    fareBloc.add(GetFareByIdEvent(
      idExpense: widget.idExpense,
    ));
  }

  void updateToFareBloc(
    int status,
    ProfileProvider userProfile,
    List<ListLocationandFuel> listlocationandfuel,
    GetFareByIdEntity getfarebyid,
    List<int> deletedItem,
  ) {
    FocusScope.of(context).unfocus();
    if (_keyForm.currentState!.validate()) {
      if (listlocationandfuel.isEmpty) {
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
      List<ListExpenseEditFareModel> listExpense =
          listlocationandfuel.map((locationFuel) {
        return ListExpenseEditFareModel(
          idExpenseMileageItem:
              (locationFuel.id != null) ? int.tryParse(locationFuel.id!) : null,
          date: locationFuel.date,
          startLocation: locationFuel.startLocation,
          stopLocation: locationFuel.stopLocation,
          startMile: locationFuel.startMile,
          stopMile: locationFuel.stopMile,
          total: locationFuel.total,
          personal: locationFuel.personal,
          net: locationFuel.net,
        );
      }).toList();
      fareBloc.add(
        UpdateFareEvent(
          idEmployees: userProfile.profileData.idEmployees!,
          editfaredata: EditDraftFareModel(
            idExpense: getfarebyid.idExpense!,
            idExpenseMileage: getfarebyid.idExpenseMileage!,
            documentId: getfarebyid.documentId!,
            nameExpense: nameExpenseController.text,
            listExpense: listExpense,
            remark: remarkController.text,
            typeExpense: 3,
            typeExpenseName: 'Mileage',
            lastUpdateDate:
                DateFormat("yyyy/MM/dd HH:mm").format(DateTime.now()),
            status: status,
            totalDistance: listlocationandfuel
                .map((item) => item.total)
                .reduce((value, element) => value + element),
            personalDistance: listlocationandfuel
                .map((item) => item.personal)
                .reduce((value, element) => value + element),
            netDistance: listlocationandfuel
                .map((item) => item.net)
                .reduce((value, element) => value + element),
            net: listlocationandfuel
                    .map((item) => item.net)
                    .reduce((value, element) => value + element) *
                5,
            comment: (getfarebyid.comments!.isEmpty)
                ? null
                : getfarebyid.comments.toString(),
            // (getfarebyid.comments!.isEmpty) ? null : getfarebyid.comments,
            deletedItem: deletedItem,
            idEmpApprover: approver,
            file: selectedFile,
          ),
        ),
      );
    } else {
      debugPrint("not success");
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(image: "appbar_fare.png", title: 'ค่าเดินทาง'),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: BlocProvider(
            create: (context) => fareBloc,
            child: Form(
              key: _keyForm,
              child: BlocConsumer<FareBloc, FareState>(
                listener: (context, state) {
                  if (state.status == FetchStatus.updatesuccess) {
                    callGetFareByIdData();
                  }
                  if (state.status == FetchStatus.finish &&
                      state.getfarebyid != null &&
                      status == 1) {
                    print(state.status);
                    final getFareResponse = state.getfarebyid;
                    if (getFareResponse != null) {
                      // print(getFareResponse.);
                      // print(getFareResponse.comments == []);
                      // print(getFareResponse.comments);
                      nameExpenseController.text = getFareResponse.nameExpense!;
                      approverController.text =
                          "${getFareResponse.approverFirstnameTh} ${getFareResponse.approverLastnameTh}";
                      remarkController.text = getFareResponse.remark!;
                      if (state.getfarebyid!.fileUrl != null) {
                        showimg = state.getfarebyid!.fileUrl!;
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
                },
                builder: (context, state) {
                  if (state.status == FetchStatus.initial) {
                    return const Text(
                      "FareInitial",
                      style: TextStyle(fontSize: 17),
                    );
                  } else if (state.status == FetchStatus.failure) {
                    return Text(
                      "${state.error}",
                      style: const TextStyle(fontSize: 17),
                    );
                  } else if (state.status == FetchStatus.loading) {
                    return LoadingAnimationWidget.inkDrop(
                      color: const Color(0xffff99ca),
                      size: 35,
                    );
                  } else if (state.status == FetchStatus.finish ||
                      state.status == FetchStatus.list) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GeneralInputData(
                          isManageItemtoPageEdit: widget.isManageItemtoPageEdit,
                          namexpense: nameExpenseController,
                          fareBloc: fareBloc,
                          idEmp: userProfile.profileData.idEmployees,
                          idExpense: state.getfarebyid!.idExpense!,
                          idExpenseMileage:
                              state.getfarebyid!.idExpenseMileage!,
                          fileUrl: (state.getfarebyid!.fileUrl != null)
                              ? state.getfarebyid!.fileUrl
                              : null,
                          listExpense: state.getfarebyid!.listExpense!,
                        ),
                        ApproverField(
                            approver: approverController,
                            // empallrole: state.empallrole,
                            onApproverSuccess: (idaproover) {
                              setState(() {
                                approver = idaproover;
                              });
                            }),
                        LocationFuelWidget(
                          fareBloc: fareBloc,
                          isdraft: state.isdraft!,
                        ),
                        const Gap(25),
                        // ! SummaryList
                        const Text(
                          'สรุปรายการ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SummaryList(fareBloc: fareBloc),
                        const Gap(25),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        const Gap(25),
                        // ! upload Image
                        ImagePickerAndViewer(
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
                            updateToFareBloc(
                              status,
                              userProfile,
                              state.listlocationandfuel,
                              state.getfarebyid!,
                              state.deleteItem!,
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
                            updateToFareBloc(
                              status,
                              userProfile,
                              state.listlocationandfuel,
                              state.getfarebyid!,
                              state.deleteItem!,
                            );
                          },
                          type: CustomButtonType.elevated,
                        ),
                        const Gap(10),
                      ],
                    );
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
