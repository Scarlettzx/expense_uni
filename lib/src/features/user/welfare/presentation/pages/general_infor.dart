import 'dart:collection';
import 'dart:convert';
// import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:motion_toast/motion_toast.dart' as mt;
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:uni_expense/src/features/user/allowance/presentation/widgets/customappbar.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:uni_expense/src/features/user/welfare/presentation/bloc/welfare_bloc.dart';
import 'package:uni_expense/src/features/user/welfare/presentation/pages/add_list.dart';
// import 'dart:ui' as ui;
import '../../../../../../injection_container.dart';
import '../../../../../components/custombutton.dart';
import '../../../../../components/custominputdecoration.dart';
import '../../../../../components/customremark.dart';
import '../../../../../components/emailmultiselect_dropdown .dart';
import '../../../../../components/filepicker.dart';
import '../../../../../components/motion_toast.dart';
import '../../../../../core/features/user/presentation/provider/profile_provider.dart';
import '../../../manageitems/presentation/pages/manageitems.dart';
import '../../data/models/add_welfare_model.dart';
import '../widgets/circular_chart.dart';
import '../widgets/customdatepicker.dart';
import 'edit_draft.dart';

class MedicalBenefitsGeneralInformation extends StatefulWidget {
  const MedicalBenefitsGeneralInformation({super.key});

  @override
  State<MedicalBenefitsGeneralInformation> createState() =>
      _MedicalBenefitsGeneralInformationState();
}

class _MedicalBenefitsGeneralInformationState
    extends State<MedicalBenefitsGeneralInformation> {
  final welfareBloc = sl<WelfareBloc>();
  String? concatenatedString;
  final selectDateController = TextEditingController();
  final nameExpenseController = TextEditingController();
  final localtionController = TextEditingController();
  final remarkController = TextEditingController();
  bool checkonclickdraft = false;
  String _enteredText = '';
  Map<String, String>? selectedValueFamily;
  int isUseForFamilyMember = 0;
  String? type = "";
  int status = 1;
  int idFamily = 0;
  double total = 0.0;
  double net = 0.0;
  final List<Map<String, String>> listMenuType = UnmodifiableListView([
    {"label": "OPD", "type": "OPD", "id": "1"},
    {"label": "IPD", "type": "IPD", "id": "2"},
    {"label": "ทันตกรรม", "type": "Dental", "id": "3"},
  ]);
  PlatformFile? selectedFile;
  String nameFamilyuse = '';
  List<Map<String, dynamic>>? listExpense = [];
  @override
  void initState() {
    super.initState();
    final ProfileProvider userData =
        Provider.of<ProfileProvider>(context, listen: false);
    welfareBloc.add(
      GetFamilysEvent(
        idEmployees: userData.profileData.idEmployees!,
      ),
    );
    // setState(() {});
  }

  @override
  void dispose() {
    // _keyForm.currentState?.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  void submitWelfare(int status, ProfileProvider userProfile) {
    FocusScope.of(context).unfocus();
    if (_keyForm.currentState!.validate()) {
      print(_keyForm.currentState!);
      if (listExpense == null || listExpense!.isEmpty) {
        return CustomMotionToast.show(
          context: context,
          title: "ListExpense is empty",
          description: "Please Add ListExpense",
          icon: Icons.notification_important,
          primaryColor: Colors.pink,
          width: 300,
          height: 100,
          animationType: mt.AnimationType.fromLeft,
          fontSizeTitle: 18.0,
          fontSizeDescription: 15.0,
        );
      }
      welfareBloc.add(
        AddWelfareEvent(
          addwelfaredata: buildWelfareModel(status, userProfile),
          idEmployees: userProfile.profileData.idEmployees!,
        ),
      );
      debugPrint("success");
      // print('${selectDateController.text}');
    } else {
      // print('${selectDateController.text}');
      debugPrint("not success");
    }
  }

  AddWelfareModel buildWelfareModel(int status, ProfileProvider userProfile) {
    return AddWelfareModel(
      nameExpense: nameExpenseController.text,
      listExpense: List<ListExpenseModelWelfare>.from(
        listExpense!.map(
          (e) => ListExpenseModelWelfare.fromJson(e),
        ),
      ),
      location: localtionController.text,
      file: selectedFile,
      documentDate: selectDateController.text,
      type: type,
      remark: remarkController.text,
      typeExpense: 4,
      typeExpenseName: "Welfare",
      lastUpdateDate: DateFormat("yyyy/MM/dd HH:mm").format(DateTime.now()),
      status: status,
      total: total,
      net: net,
      idPosition: userProfile.profileData.idPosition,
      idFamily: idFamily,
      ccEmail: concatenatedString,
      isUseForFamilyMember: isUseForFamilyMember,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
          image: "appbar_medicalbenefits.png", title: "สวัสดิการรักษาพยาบาล"),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: BlocProvider(
            create: (context) => welfareBloc,
            child: Form(
                key: _keyForm,
                child: BlocConsumer<WelfareBloc, WelfareState>(
                  listener: (context, state) {
                    print(state);
                    if (state is WelfareFinish && status == 1) {
                      if (state.resaddwelfare != null &&
                          state.resaddwelfare!.idExpense != null) {
                        checkonclickdraft = true;
                        // Navigator.pop(context);
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: Durations.medium1,
                            type: PageTransitionType.rightToLeft,
                            child: EditDraft(
                              profiledata: userProfile.profileData,
                              welfareBloc: welfareBloc,
                              idExpense: state.resaddwelfare!.idExpense!,
                              checkonclickdraft: checkonclickdraft,
                            ),
                          ),
                        );
                      }
                    } else if (state is WelfareFinish && status == 2) {
                      checkonclickdraft = false;
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
                    if (state is WelfareInitial) {
                      return Text(
                        "ไม่พบข้อมูล",
                      );
                    } else if (state is WelfareLoading) {
                      // Future.delayed(Duration(seconds: 15), () {});
                      return LoadingAnimationWidget.inkDrop(
                        color: Color(0xffff99ca),
                        size: 35,
                      );
                    } else if (state is WelfareFailure) {
                      return const Text("error");
                    } else if (state is WelfareFinish) {
                      List<Map<String, dynamic>> resFamilyWithIsUse = state
                          .resfamily!
                          .map((item) => item.toJson())
                          .toList();
                      resFamilyWithIsUse = resFamilyWithIsUse.map((item) {
                        return {...item, 'isUseForFamilyMember': 1};
                      }).toList();
                      resFamilyWithIsUse.insert(
                        0,
                        {
                          'isUseForFamilyMember': 0,
                          'idFamily': 0,
                          'relationship': 'ตนเอง',
                          'firstname_TH': userProfile.profileData.firstnameTh,
                          'lastname_TH': userProfile.profileData.lastnameTh,
                          'idEmployees': userProfile.profileData.idEmployees,
                        },
                      );
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ข้อมูลทั่วไป',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Gap(20),
                          Text(
                            'ชื่อรายการ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade600),
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
                          Text(
                            'CC ถึง',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade600),
                          ),
                          const Gap(10),
                          EmailMultiSelectDropDown(
                            onOptionSelected: (selectedValues) {
                              print(selectedValues);
                              if (selectedValues.isNotEmpty &&
                                  selectedValues != []) {
                                concatenatedString = selectedValues.join(';');
                              } else {
                                concatenatedString = null;
                              }
                              // print(json.encode(concatenatedString));
                            },
                            options: state.empsallrole!
                                .map((employee) => ValueItem(
                                      label:
                                          '${employee.firstnameTh!}  ${employee.lastnameTh} \n${employee.email}',
                                      value: employee.firstnameTh! +
                                          employee.lastnameTh!,
                                    ))
                                .toList(),
                          ),
                          // ],
                          const Gap(20),
                          Text(
                            'เลือกผู้ใช้สิทธิ์',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade600),
                          ),
                          const Gap(10),
                          CustomDropdown<String>(
                            closedErrorBorderRadius: BorderRadius.circular(30),
                            errorStyle: const TextStyle(
                                color: Colors.red, fontSize: 18),
                            validateOnChange: true,
                            validator: (value) {
                              if (value == null) {
                                return "Must not be null";
                              }
                              return null;
                            },
                            hideSelectedFieldWhenExpanded: false,
                            excludeSelected: false,
                            closedBorderRadius: BorderRadius.circular(30),
                            closedBorder: Border.all(
                                width: 2.0,
                                color: Colors.grey.withOpacity(0.3)),
                            expandedBorderRadius: BorderRadius.circular(30),
                            hintText: 'โปรดเลือกผู้ใช้สิทธิ์',
                            listItemBuilder: (context, item) {
                              return ListTile(
                                // dense: true,
                                title: Text(
                                  item,
                                  style: TextStyle(fontFamily: 'kanit'),
                                ),
                              );
                            },
                            items: resFamilyWithIsUse.map<String>((family) {
                              return "${family['firstname_TH']} ${family['lastname_TH']} (${family['relationship']})";
                            }).toList(),
                            canCloseOutsideBounds: true,
                            // initialItem: _list[0],
                            onChanged: (value) {
                              final selectedFamily =
                                  resFamilyWithIsUse.firstWhere(
                                (family) =>
                                    "${family['firstname_TH']} ${family['lastname_TH']} (${family['relationship']})" ==
                                    value,
                              );
                              setState(() {
                                isUseForFamilyMember =
                                    selectedFamily['isUseForFamilyMember'];
                                idFamily = selectedFamily['idFamily'];
                                nameFamilyuse = value;
                              });

                              print('changing value to: $value');
                              print(
                                  'isUseForFamilyMember: $isUseForFamilyMember');
                              print('idFamily: $idFamily');
                            },
                          ),
                          const Gap(10),
                          Text(
                            'วันที่',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade600),
                          ),
                          const Gap(10),
                          CustomDatePicker(controller: selectDateController),

                          const Gap(20),
                          Text(
                            'ตำแหน่ง',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade600),
                          ),
                          const Gap(10),
                          TextFormField(
                            controller: localtionController,
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
                          Text(
                            'ประเภทสิทธิ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade600),
                          ),
                          const Gap(10),
                          DropdownButtonFormField2(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              // fillColor: const Color.fromARGB(255, 237, 237, 237).withOpacity(0.5),
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
                                horizontal: 2,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "     เลือกประเภทการลา";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black, fontSize: 15),
                            hint: Text(
                              "เลือกประเภทสิทธิ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontFamily: 'kanit',
                              ),
                            ),
                            isExpanded: true,
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            items: listMenuType
                                .map<DropdownMenuItem<Map<String, String>>>(
                              (Map<String, String> mapItem) {
                                return DropdownMenuItem<Map<String, String>>(
                                  value: mapItem,
                                  child: Text(
                                    mapItem["type"] ??
                                        "", // นำค่า "type" มาแสดงใน Dropdown
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'kanit',
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (Map<String, String>? selectedValue) {
                              // ทำอะไรก็ตามที่คุณต้องการเมื่อมีการเลือกค่า
                              setState(() {
                                type = selectedValue?['type'];
                              });
                              // print('Selected type: ${selectedValue?["type"]}');
                              print('Selected type: ${type}');
                            },
                          ),

                          const Gap(20),
                          const CircularChartWidget(
                            stops: [0.2, 0.5, 0.8],
                            colors: [
                              const Color(0xffFDC793),
                              const Color(0xffE793B8),
                              const Color(0xff6FC9E4),
                            ],
                          ),
                          const Gap(30),
                          Divider(
                            color: Colors.grey.shade300,
                            height: 1,
                          ),
                          const Gap(30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'รายการสถานที่',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(30.0),
                                onTap: () async {
                                  List<WelfareData>? datawelfare =
                                      await Navigator.push(
                                    context,
                                    PageTransition(
                                      duration: Durations.medium1,
                                      type: PageTransitionType.rightToLeft,
                                      child: MedicalBefitsAddList(
                                        checkonclickdraft: checkonclickdraft,
                                      ),
                                    ),
                                  );
                                  (datawelfare != null &&
                                          datawelfare.isNotEmpty)
                                      // Update listExpense with new data from dataInitial
                                      ? WelfareData.updateListExpense(
                                          datawelfare, listExpense!)
                                      : null;

                                  print(json.encode(listExpense));
                                  setState(() {
                                    total = calculateTotal(listExpense);
                                    net = total;
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
                          (listExpense!.isEmpty)
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context)
                                              .devicePixelRatio *
                                          1,
                                      bottom: MediaQuery.of(context)
                                              .devicePixelRatio *
                                          1),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
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
                                  itemCount: listExpense!.length,
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
                                                    listExpense!
                                                        .removeAt(index);
                                                    setState(() {
                                                      total = calculateTotal(
                                                          listExpense);
                                                      net = total;
                                                    });
                                                    // recieveData!.clear();
                                                    // calculateSum(listExpense);
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
                                          surfaceTintColor: Color.fromARGB(
                                              255, 255, 218, 218),
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
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
                                                          '${listExpense![index]['description']}'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('ราคา: ',
                                                          style: TextStyle(
                                                              // color: Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Gap(5),
                                                      Text(
                                                        ' ${NumberFormat("#,##0.00", "en_US").format(double.tryParse(listExpense![index]['price']))} บาท ',
                                                        // '${}',
                                                      ),
                                                    ],
                                                  ),
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
                                  }),
                          Gap(15),
                          Divider(
                            color: Colors.grey.shade300,
                            height: 1,
                          ),
                          const Gap(25),
                          Text(
                            'สรุปรายการ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Gap(10),
                          // Text('yes'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'มูลค่ารวม',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                              Text(
                                ' ${NumberFormat("#,##0.00", "en_US").format(double.tryParse(net.toString()))} บาท ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const Gap(10),
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
                                ' ${NumberFormat("#,##0.00", "en_US").format(double.tryParse(total.toString()))} บาท ',
                                style: TextStyle(
                                    fontSize: 18,
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
                          FilePickerComponent(
                            onFileSelected: (file) {
                              setState(() {
                                print(file);
                                selectedFile = file;

                                // getFormData()['file'] =
                                //     file != null ? file.path : null;
                                // print(getFormData()['file']);
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
                          CustomButton(
                            label: 'บันทึกแบบร่าง',
                            icon: Icons.save_as,
                            iconColor: Color(0xffff99ca),
                            buttonColor: Color(0xffff99ca),
                            onPressed: () {
                              status = 1;
                              print(status);
                              submitWelfare(status, userProfile);
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
                              status = 8;
                              print(status);
                              submitWelfare(status, userProfile);
                            },
                            type: CustomButtonType.elevated,
                          ),
                          const Gap(10),
                        ],
                      );
                    }
                    return Container();
                  },
                )),
          ),
        ),
      ),
    );
  }
}

double calculateTotal(List<Map<String, dynamic>>? listExpense) {
  double total = listExpense!.fold(0.0, (acc, expense) {
    try {
      double price;

      if (expense['price'] is String) {
        price = double.parse(expense['price'] ?? '0.0');
      } else if (expense['price'] is double) {
        price = expense['price'];
      } else {
        print('Invalid price type: ${expense['price'].runtimeType}');
        return acc;
      }

      return acc + price;
    } catch (e) {
      print('Invalid double: ${expense['price']}');
      return acc; // ถ้ามีข้อผิดพลาดในการแปลง, คืนค่า acc เดิม
    }
  });

  print("Total Prices: $total");
  return total;
}
