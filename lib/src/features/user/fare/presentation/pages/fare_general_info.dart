import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:uni_expense/injection_container.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/customappbar.dart';
import 'package:uni_expense/src/features/user/fare/data/models/add_fare_model.dart';
import 'package:uni_expense/src/features/user/fare/presentation/pages/fare_edit_draft.dart';

import '../../../../../components/customremark.dart';
import '../../../../../components/filepicker.dart';
import '../../../../../components/motion_toast.dart';
import '../../../../../core/features/user/presentation/provider/profile_provider.dart';
import '../bloc/fare_bloc.dart';
import '../widgets/approverfield.dart';
import '../widgets/carboncopy.dart';
import '../widgets/general/general_input_data.dart';
// import '../widgets/info.dart';
import '../widgets/locationfuel_widget.dart';
import '../widgets/summary_list.dart';

class FareGeneralInformation extends StatefulWidget {
  const FareGeneralInformation({super.key});

  @override
  State<FareGeneralInformation> createState() => _FareGeneralInformationState();
}

class _FareGeneralInformationState extends State<FareGeneralInformation> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  PlatformFile? selectedFile;
  final nameExpenseController = TextEditingController();
  final approverController = TextEditingController();
  final remarkController = TextEditingController();
  String? ccemail;
  int? approver;

  final fareBloc = sl<FareBloc>();
  String _enteredText = '';
  bool draftisBool = false;
  int status = 1;
  @override
  void initState() {
    super.initState();
    fareBloc.add((GetEmployeesAllRolesEvent()));
    // 1.  Subscribe to `FareState` stream to listen for changes

    // fareBloc.stream.listen((state) {
    //   // 2.  Check for `FetchStatus.finish` after `AddExpenseFareEvent`

    //   if (state.status == FetchStatus.finish &&
    //       state.runtimeType is AddExpenseFareEvent) {
    //     final addFareResponse = state.responseaddfare;

    //     // 3.  Extract `idexpense` and call `GetFareByIdEvent` if `addFareResponse` is successful

    //     if (addFareResponse != null) {
    //       final idExpense = addFareResponse.idExpense;
    //       print('use getbyid');
    //       fareBloc.add(GetFareByIdEvent(idExpense: idExpense!));
    //     }
    //   }

    //   // 4.  Update `TextEditingController` on `GetFareByIdEvent` success

    //   if (state.status == FetchStatus.finish &&
    //       state.runtimeType is GetFareByIdEvent) {
    //     print('pass getbyid');
    //     final getFareResponse = state.getfarebyid;
    //     print(state.getfarebyid);
    //     if (getFareResponse != null) {
    //       nameExpenseController.text = getFareResponse.nameExpense!;
    //       approverController.text = getFareResponse.approverFirstnameTh! +
    //           getFareResponse.approverLastnameTh!;
    //       remarkController.text = getFareResponse.remark!;
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    // Bloc.observer = blocObserver;
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
                // listenWhen: (previous, current) {
                //   return true;
                // },
                listener: (context, state) {
                  // print(state.runtimeType);
                  // if (state.status == FetchStatus.finish) {
                  //   if (state.responseaddfare != null &&
                  //       state.responseaddfare!.idExpense != null) {
                  //     fareBloc.add(GetFareByIdEvent(
                  //         idExpense: state.responseaddfare!.idExpense!));
                  //     print("aa ${state.getfarebyid}");
                  //     final getFareResponse = state.getfarebyid;
                  //     print('pass getbyid');
                  //     if (getFareResponse != null) {
                  //       print('yes');
                  //       print(state.getfarebyid);
                  //       nameExpenseController.text =
                  //           getFareResponse.nameExpense!;
                  //       approverController.text =
                  //           getFareResponse.approverFirstnameTh! +
                  //               getFareResponse.approverLastnameTh!;
                  //       remarkController.text = getFareResponse.remark!;
                  //     }
                  //   }
                  if (state.status == FetchStatus.finish) {
                    if (state.responseaddfare != null &&
                        state.responseaddfare!.idExpense != null) {
                      Navigator.push(
                        context,
                        PageTransition(
                          duration: Durations.medium1,
                          type: PageTransitionType.rightToLeft,
                          child: FareEditDraft(
                            idExpense: state.responseaddfare!.idExpense!,
                          ),
                        ),
                      );
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
                    // print(state.runtimeType);
                    // print(state.);
                    // print(state);
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
                        CarbonCopy(
                          empallrole: state.empallrole,
                          onCCEmailChanged: (newCCEmail) {
                            setState(() {
                              ccemail = newCCEmail;
                            });
                          },
                        ),
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
                        const Gap(20),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        const Gap(25),
                        // ! upload Image
                        FilePickerComponent(
                          onFileSelected: (file) {
                            setState(() {
                              print(file);
                              selectedFile = file;
                              // formData['file'] = file?.path;
                              // print(formData['file']);
                              // print(formData);
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
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              // print(approver);
                              // print(
                              //     'nameExpenseController.text: ${nameExpenseController.text}');
                              // print(
                              //     'approverController.text: ${approverController.text}');
                              // print('ccemail: $ccemail');
                              // print('selectedFile: ${selectedFile}');
                              // print(
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
                                List<AddListExpenseModel> listExpense = state
                                    .listlocationandfuel
                                    .map((locationFuel) {
                                  return AddListExpenseModel(
                                    date: locationFuel.date,
                                    startLocation: locationFuel.startLocation,
                                    stopLocation: locationFuel.stopLocation,
                                    startMile:
                                        locationFuel.startMile.toString(),
                                    stopMile: locationFuel.stopMile.toString(),
                                    total: locationFuel.total,
                                    personal: locationFuel.personal.toString(),
                                    net: locationFuel.net,
                                  );
                                }).toList();
                                fareBloc.add(
                                  AddExpenseFareEvent(
                                      idEmployees:
                                          userProfile.profileData.idEmployees!,
                                      addfaredata: AddFareModel(
                                        nameExpense: nameExpenseController.text,
                                        listExpense: listExpense,
                                        file: selectedFile,
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
                                        idEmpApprover: approver,
                                        ccEmail: ccemail,
                                        idPosition:
                                            userProfile.profileData.idPosition,
                                      )),
                                );
                                // final addFareResponse = state.responseaddfare;
                                // if (state.status == FetchStatus.finish &&
                                //     addFareResponse != null) {
                                //   final idExpense = addFareResponse.idExpense;
                                //   print('use getbyid');
                                //   print(idExpense);
                                //   fareBloc.add(
                                //       GetFareByIdEvent(idExpense: idExpense!));
                                // }
                                // print(approver);
                                // print(nameExpenseController.text);
                                // print(approverController.text);
                                // print(ccemail);
                                // print(selectedFile);
                                // print(state.listlocationandfuel);
                                // print(remarkController.text);
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
