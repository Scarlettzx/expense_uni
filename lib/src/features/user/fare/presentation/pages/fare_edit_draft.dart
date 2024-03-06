import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
// import 'package:iconamoon/iconamoon.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:uni_expense/injection_container.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/customappbar.dart';
import 'package:uni_expense/src/features/user/fare/data/models/add_fare_model.dart';
import 'package:uni_expense/src/features/user/fare/domain/entities/getfarebyid.dart';

import '../../../../../components/customremark.dart';
// import '../../../../../components/filepicker.dart';
import '../../../../../components/motion_toast.dart';
import '../../../../../core/features/user/presentation/provider/profile_provider.dart';
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
  const FareEditDraft({super.key, required this.idExpense});

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

  // void callGetFareByIdData() {
  //   fareBloc.add(GetFareByIdEvent(
  //     idExpense: widget.idExpense,
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    print('nameExpenseController.text: ${nameExpenseController.text}');
    print('approverController.text: ${approverController.text}');
    // print('ccemail: $ccemail');
    print('selectedFile: ${selectedFile}');
    print('approver: ${approver}');
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
                  if (state.status == FetchStatus.finish &&
                      state.getfarebyid != null) {
                    final getFareResponse = state.getfarebyid;
                    if (getFareResponse != null) {
                      print(state);
                      print('yes');
                      print(state.getfarebyid);
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
                  } else if (state.status == FetchStatus.finish) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GeneralInputData(namexpense: nameExpenseController),
                        ApproverField(
                            approver: approverController,
                            empallrole: state.empallrole,
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
                        // FilePickerComponent(
                        //   onFileSelected: (file) {
                        //     setState(() {
                        //       print(file);
                        //       selectedFile = file;
                        //       // formData['file'] = file?.path;
                        //       // print(formData['file']);
                        //       // print(formData);
                        //     });
                        //   },
                        // ),
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
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              // print(approver);

                              // print(
                              FocusScope.of(context).unfocus();
                              //     "state.listlocationandfuel ${state.listlocationandfuel}");
                              if (_keyForm.currentState!.validate()) {
                                if (state.listlocationandfuel.isEmpty) {
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
                                    state.listlocationandfuel
                                        .map((locationFuel) {
                                  return ListExpenseEditFareModel(
                                    idExpenseMileageItem:
                                        (locationFuel.id != null)
                                            ? int.tryParse(locationFuel.id!)
                                            : null,
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
                                    idEmployees:
                                        userProfile.profileData.idEmployees!,
                                    editfaredata: EditDraftFareModel(
                                      idExpense: state.getfarebyid!.idExpense!,
                                      idExpenseMileage:
                                          state.getfarebyid!.idExpenseMileage!,
                                      documentId:
                                          state.getfarebyid!.documentId!,
                                      nameExpense: nameExpenseController.text,
                                      listExpense: listExpense,
                                      remark: remarkController.text,
                                      typeExpense: 3,
                                      typeExpenseName: 'Mileage',
                                      lastUpdateDate:
                                          DateFormat("yyyy/MM/dd HH:mm")
                                              .format(DateTime.now()),
                                      status: status,
                                      totalDistance: state.listlocationandfuel
                                          .map((item) => item.total)
                                          .reduce((value, element) =>
                                              value + element),
                                      personalDistance: state
                                          .listlocationandfuel
                                          .map((item) => item.personal)
                                          .reduce((value, element) =>
                                              value + element),
                                      netDistance: state.listlocationandfuel
                                          .map((item) => item.net)
                                          .reduce((value, element) =>
                                              value + element),
                                      net: state.listlocationandfuel
                                              .map((item) => item.net)
                                              .reduce((value, element) =>
                                                  value + element) *
                                          5,
                                      comment:
                                          (state.getfarebyid!.comments! == [])
                                              ? null
                                              : state.getfarebyid!.comments!,
                                      deletedItem: state.deleteItem,
                                      idEmpApprover: approver,
                                      file: selectedFile,
                                    ),
                                    // idEmployees:
                                    //     userProfile.profileData.idEmployees!,
                                    // addfaredata: AddFareModel(
                                    //   nameExpense: nameExpenseController.text,
                                    //   listExpense: listExpense,
                                    //   file: selectedFile,
                                    //   remark: remarkController.text,
                                    //   typeExpense: 3,
                                    //   typeExpenseName: 'Mileage',
                                    //   lastUpdateDate:
                                    //       DateFormat("yyyy/MM/dd HH:mm")
                                    //           .format(DateTime.now()),
                                    //   status: status,
                                    //   totalDistance: state.listlocationandfuel
                                    //       .map((item) => item.total)
                                    //       .reduce((value, element) =>
                                    //           value + element),
                                    //   personalDistance: state
                                    //       .listlocationandfuel
                                    //       .map((item) => item.personal)
                                    //       .reduce((value, element) =>
                                    //           value + element),
                                    //   netDistance: state.listlocationandfuel
                                    //       .map((item) => item.net)
                                    //       .reduce((value, element) =>
                                    //           value + element),
                                    //   net: state.listlocationandfuel
                                    //           .map((item) => item.net)
                                    //           .reduce((value, element) =>
                                    //               value + element) *
                                    //       5,
                                    //   idEmpApprover: approver,
                                    //   ccEmail: ccemail,
                                    //   idPosition:
                                    //       userProfile.profileData.idPosition,
                                  ),
                                );
                                setState(() {
                                  // callGetFareByIdData();
                                });
                                // }
                                // print(state.listlocationandfuel);
                                // print(state.deleteItem);
                              } else {
                                debugPrint("not success");
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
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
                              primary: const Color(0xffff99ca), // สีปุ่มสีส้ม
                            ),
                            onPressed: () {},
                          ),
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
