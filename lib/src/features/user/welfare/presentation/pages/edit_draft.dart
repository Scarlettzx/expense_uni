// import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart' as mt;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:searchfield/searchfield.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uni_expense/src/core/features/user/domain/entity/profile_entity.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/edit_draft_welfare_model.dart';
import 'package:uni_expense/src/features/user/welfare/presentation/pages/add_list.dart';

import '../../../../../components/custombutton.dart';
import '../../../../../components/custominputdecoration.dart';
import '../../../../../components/customremark.dart';
import '../../../../../components/filepicker.dart';
import '../../../../../components/motion_toast.dart';
import '../../../allowance/presentation/widgets/customappbar.dart';
import '../../../allowance/presentation/widgets/required_text.dart';
import '../../../manageitems/presentation/pages/manageitems.dart';
import '../../domain/entities/entities.dart';
import '../bloc/welfare_bloc.dart';
import '../widgets/circular_chart.dart';
import '../widgets/customdatepicker2.dart';
import '../widgets/delete_draft.dart';
import 'general_infor.dart';

class EditDraft extends StatefulWidget {
  final WelfareBloc welfareBloc;
  final bool checkonclickdraft;
  final int idExpense;
  final ProfileEntity profiledata;
  const EditDraft(
      {super.key,
      required this.welfareBloc,
      required this.checkonclickdraft,
      required this.idExpense,
      required this.profiledata});

  @override
  State<EditDraft> createState() => _EditDraftState();
}

class _EditDraftState extends State<EditDraft> {
  // StreamSubscription<WelfareState>? streamSubscription;
  @override
  void initState() {
    super.initState();
    status = 1;
    widget.welfareBloc.add(GetWelfareByIdEvent(idExpense: widget.idExpense));
    // streamSubscription = widget.welfareBloc.stream
    //     .where(
    //         (state) => state is WelfareFinish && state.getwelfarebyid != null)
    //     .listen((state) async {
    //   print("stream");
    //   print((state as WelfareFinish).getwelfarebyid!);
    //   print("stream");
    //   setValue(state.getwelfarebyid!);
    // });
  }

  @override
  void dispose() {
    // streamSubscription?.cancel();
    super.dispose();
  }

  List<Map<String, dynamic>> resFamilyWithIsUse = [];
  List<int> deletedItem = [];
  String? concatenatedString;
  final selectDateController = TextEditingController();
  final nameExpenseController = TextEditingController();
  final localtionController = TextEditingController();
  final remarkController = TextEditingController();
  String _enteredText = '';
  // String type = ';'
  Map<String, String>? selectedValueFamily;
  int isUseForFamilyMember = 0;
  String? type;
  // List mockresfamily = [''];
  late int status;
  int idFamily = 0;
  double total = 0.0;
  double net = 0.0;
  final List<Map<String, String>> listMenuType = UnmodifiableListView([
    {"label": "OPD", "type": "OPD", "id": "1"},
    {"label": "IPD", "type": "IPD", "id": "2"},
    {"label": "ทันตกรรม", "type": "Dental", "id": "3"},
  ]);
  PlatformFile? selectedFile;
  String? nameFamilyuse;
  // String nameFamilyuse2 = '';
  final GlobalKey<FormState> _keyFormEdit = GlobalKey<FormState>();
  List<Map<String, dynamic>>? listExpense = [];
  final List<double> stops = [0.2, 0.5, 0.8];
  final List<Color> colors = [
    const Color(0xffFDC793),
    const Color(0xffE793B8),
    const Color(0xff6FC9E4),
  ];
  void submitWelfare(int status, ProfileEntity userProfile,
      GetWelfareByIdEntity? getwelfarebyid) {
    FocusScope.of(context).unfocus();
    try {
      print("ok");
      // print(_keyFormEdit.currentState!.validate());
      // print(_keyFormEdit.currentState!);
      // print(_keyFormEdit.currentWidget!.key);
      // print(_keyFormEdit.currentContext!.mounted);
      // print(getwelfarebyid);
      if (getwelfarebyid != null) {
        print(listExpense);
        print("pass");
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
        debugPrint("success");
        widget.welfareBloc.add(
          UpdateWelfareEvent(
            editwelfaredata:
                buildWelfareModel(status, userProfile, getwelfarebyid),
            idEmployees: userProfile.idEmployees!,
          ),
        );
        debugPrint("success");
        // print('${selectDateController.text}');
      } else {
        print(getwelfarebyid);
        // print('${selectDateController.text}');
        debugPrint("not success");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  EditWelfareModel buildWelfareModel(int status, ProfileEntity userProfile,
      GetWelfareByIdEntity? getwelfarebyid) {
    return EditWelfareModel(
      idExpense: getwelfarebyid!.idExpense!,
      idExpenseWelfare: getwelfarebyid.idExpenseWelfare!,
      documentId: getwelfarebyid.documentId,
      deletedItem: deletedItem,
      comment: null,
      nameExpense: nameExpenseController.text,
      listExpense: List<ListExpenseEditWelfareModel>.from(
        listExpense!.map(
          (e) => ListExpenseEditWelfareModel.fromJson(e),
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
      idFamily: idFamily,
      isUseForFamilyMember: isUseForFamilyMember,
    );
  }

  void setValue(GetWelfareByIdEntity getwelfarebyid) {
    // await Future.delayed(Duration.zero);
    setState(() {
      nameExpenseController.text = getwelfarebyid.nameExpense!;
      String userName = getwelfarebyid.userName!;
      String relation = getwelfarebyid.relation!;
      nameFamilyuse = '$userName ($relation)';
      print(nameFamilyuse);
      print("old list $listExpense");
      listExpense = getwelfarebyid.listExpense!.map((expenseEntity) {
        // แปลงค่า price เป็น double
        double priceDouble =
            double.parse(expenseEntity.price!.toStringAsFixed(2));

        // สร้าง Map ใหม่ที่มี price เป็น double
        return {
          'idExpenseWelfareItem': expenseEntity.idExpenseWelfareItem,
          'description': expenseEntity.description,
          'price': priceDouble,
          "withdrawablePrice": expenseEntity.withdrawablePrice,
          "difference": expenseEntity.difference,
        };
      }).toList();
      print("new list $listExpense");
      selectDateController.text = getwelfarebyid.documentDate!;
      localtionController.text = getwelfarebyid.location!;
      type = getwelfarebyid.type!;
      remarkController.text = getwelfarebyid.remark!;
      idFamily = getwelfarebyid.idFamily!;
      isUseForFamilyMember = getwelfarebyid.isUseForFamilyMember! ? 1 : 0;
      print(type);
      total = calculateTotal(listExpense);
      net = total;
    });

    // print(type);
  }

  // AddWelfareModel buildWelfareModel(int status, ProfileProvider userProfile) {
  //   return AddWelfareModel(
  //     nameExpense: nameExpenseController.text,
  //     listExpense: List<ListExpenseModelWelfare>.from(
  //       listExpense!.map(
  //         (e) => ListExpenseModelWelfare.fromJson(e),
  //       ),
  //     ),
  //     location: localtionController.text,
  //     file: selectedFile,
  //     documentDate: selectDateController.text,
  //     type: type,
  //     remark: remarkController.text,
  //     typeExpense: 4,
  //     typeExpenseName: "Welfare",
  //     lastUpdateDate: DateFormat("yyyy/MM/dd HH:mm").format(DateTime.now()),
  //     status: status,
  //     total: total,
  //     net: net,
  //     idPosition: userProfile.profileData.idPosition,
  //     idFamily: idFamily,
  //     ccEmail: concatenatedString,
  //     isUseForFamilyMember: isUseForFamilyMember,
  //   );
  // }
  Float64List _resolveTransform(Rect bounds, ui.TextDirection textDirection) {
    final GradientTransform transform = GradientRotation(_degreeToRadian(-90));
    return transform.transform(bounds, textDirection: textDirection)!.storage;
  }

  // Convert degree to radian
  double _degreeToRadian(int deg) => deg * (3.141592653589793 / 180);

  @override
  Widget build(BuildContext context) {
    // print(nameFamilyuse);
    // print();
    // print(resFamilyWithIsUse.firstWhere((family) => nameFamilyuse.contains(
    //     "${family['firstname_TH']}  ${family['lastname_TH']} (${family['relationship']})")));
    // print(resFamilyWithIsUse.any((family) => nameFamilyuse.contains(
    //     "${family['firstname_TH']}  ${family['lastname_TH']} (${family['relationship']})")));
    // print(resFamilyWithIsUse.map((e) => e.containsValue(nameFamilyuse)));
    return Scaffold(
      appBar: CustomAppBar(
          image: "appbar_medicalbenefits.png", title: "สวัสดิการรักษาพยาบาล"),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: BlocProvider(
            create: (context) => widget.welfareBloc,
            child: Form(
                key: _keyFormEdit,
                child: BlocConsumer<WelfareBloc, WelfareState>(
                  listener: (context, state) {
                    print(state);
                    if (state is WelfareFinish &&
                        state.getwelfarebyid != null &&
                        status == 1) {
                      // if () {
                      // setValue(state.getwelfarebyid!);
                      // widget.checkonclickdraft = true;
                      setState(() {
                        nameExpenseController.text =
                            state.getwelfarebyid!.nameExpense!;
                        String userName = state.getwelfarebyid!.userName!;
                        String relation = state.getwelfarebyid!.relation!;
                        nameFamilyuse = '$userName ($relation)';

                        print(nameFamilyuse);
                        print("old list $listExpense");
                        listExpense = state.getwelfarebyid!.listExpense!
                            .map((expenseEntity) {
                          // แปลงค่า price เป็น double
                          double priceDouble = double.parse(
                              expenseEntity.price!.toStringAsFixed(2));

                          // สร้าง Map ใหม่ที่มี price เป็น double
                          return {
                            'idExpenseWelfareItem':
                                expenseEntity.idExpenseWelfareItem,
                            'description': expenseEntity.description,
                            'price': priceDouble,
                            "withdrawablePrice":
                                expenseEntity.withdrawablePrice,
                            "difference": expenseEntity.difference,
                          };
                        }).toList();
                        print("new list $listExpense");
                        selectDateController.text =
                            state.getwelfarebyid!.documentDate!;
                        localtionController.text =
                            state.getwelfarebyid!.location!;
                        type = state.getwelfarebyid!.type!;
                        remarkController.text = state.getwelfarebyid!.remark!;
                        idFamily = state.getwelfarebyid!.idFamily!;
                        isUseForFamilyMember =
                            state.getwelfarebyid!.isUseForFamilyMember! ? 1 : 0;
                        print(type);
                        total = calculateTotal(listExpense);
                        net = total;
                      });
                    }
                    // },
                    else if (state is WelfareFinish && status == 8) {
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
                      resFamilyWithIsUse = state.resfamily!
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
                          'firstname_TH': widget.profiledata.firstnameTh,
                          'lastname_TH': widget.profiledata.lastnameTh,
                          'idEmployees': widget.profiledata.idEmployees,
                        },
                      );
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
                                asteriskText: ' ( แบบร่าง ) ',
                                asteriskStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'kanit',
                                  color: Color.fromRGBO(117, 117, 117, 1),
                                ),
                              ),
                              if (widget.profiledata.idEmployees != null &&
                                  state.getwelfarebyid?.idExpense != null &&
                                  state.getwelfarebyid?.idExpenseWelfare !=
                                      null &&
                                  state.getwelfarebyid?.listExpense !=
                                      null) ...[
                                DeleteDraftWelfare(
                                    welfareBloc: widget.welfareBloc,
                                    idEmp: widget.profiledata.idEmployees,
                                    idExpense: state.getwelfarebyid!.idExpense!,
                                    idExpenseWelfare:
                                        state.getwelfarebyid!.idExpenseWelfare!,
                                    listExpense:
                                        state.getwelfarebyid!.listExpense,
                                    fileUrl:
                                        (state.getwelfarebyid!.fileUrl != null)
                                            ? state.getwelfarebyid!.fileUrl
                                            : null,
                                    onDeleted: () {
                                      setState(() {
                                        widget.checkonclickdraft ==
                                            false; // เมื่อลบเสร็จเรียกใช้ callback เพื่อ set checkonclickdraft เป็น false
                                      });
                                    }),
                              ]
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
                                return 'Please enter a value';
                              }
                              return null;
                            },
                            decoration:
                                CustomInputDecoration.getInputDecoration(),
                          ),

                          const Gap(20),
                          RequiredText(
                            labelText: 'เลือกผู้ใช้สิทธิ์',
                            asteriskText: '*',
                          ),
                          const Gap(10),
                          // StreamBuilder(
                          //   stream: widget.welfareBloc.stream.where((state) =>
                          //       state is WelfareFinish &&
                          //       state.getwelfarebyid != null),
                          //   builder: (context, snapshot) {
                          //     if (!snapshot.hasData) return Container();
                          // if (snapshot.hasData) {
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
                              return "${family['firstname_TH']}  ${family['lastname_TH']} (${family['relationship']})";
                            }).toList(),
                            canCloseOutsideBounds: true,
                            // initialItem: resFamilyWithIsUse
                            //     .firstWhere(
                            //       (family) => nameFamilyuse.contains(
                            //           "${family['firstname_TH']}  ${family['lastname_TH']} (${family['relationship']})"),
                            //       orElse: () => <String, dynamic>{},
                            //     )
                            //     .toString(),
                            initialItem: nameFamilyuse,
                            onChanged: (value) {
                              final selectedFamily =
                                  resFamilyWithIsUse.firstWhere(
                                (family) =>
                                    "${family['firstname_TH']}  ${family['lastname_TH']} (${family['relationship']})" ==
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
                          // }
                          // return Container();
                          // },
                          // ),
                          const Gap(10),
                          Text(
                            'วันที่',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade600),
                          ),
                          const Gap(10),
                          CustomDatePicker2(controller: selectDateController),
                          const Gap(20),
                          RequiredText(
                            labelText: 'สถานที่',
                            asteriskText: '*',
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
                          RequiredText(
                            labelText: 'ประเภทสิทธิ',
                            asteriskText: '*',
                          ),
                          const Gap(10),
                          DropdownButtonFormField2(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
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
                            value: type,
                            items: listMenuType.map<DropdownMenuItem<String>>(
                                (Map<String, String> mapItem) {
                              return DropdownMenuItem<String>(
                                value: mapItem["type"],
                                child: Text(
                                  mapItem["type"] ?? "",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'kanit',
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? selectedValue) {
                              setState(() {
                                type = selectedValue ?? "";
                              });
                              print('Selected type: $type');
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
                              RequiredText(
                                labelText: 'รายการสถานที่',
                                asteriskText: '*',
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'kanit',
                                    color: Colors.black),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(30.0),
                                onTap: () async {
                                  List<WelfareDataDraft>? datawelfare =
                                      await Navigator.push(
                                    context,
                                    PageTransition(
                                      duration: Durations.medium1,
                                      type: PageTransitionType.rightToLeft,
                                      child: MedicalBefitsAddList(
                                        checkonclickdraft:
                                            widget.checkonclickdraft,
                                      ),
                                    ),
                                  );
                                  (datawelfare != null &&
                                          datawelfare.isNotEmpty)
                                      ? WelfareDataDraft.updateListExpense(
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
                                                    if (listExpense![index][
                                                            'idExpenseWelfareItem'] !=
                                                        null) {
                                                      // เก็บ idExpenseWelfareItem ใน List
                                                      deletedItem.add(listExpense![
                                                              index][
                                                          'idExpenseWelfareItem']);
                                                    }

                                                    // ลบข้อมูลที่ต้องการ
                                                    listExpense!
                                                        .removeAt(index);

                                                    setState(() {
                                                      total = calculateTotal(
                                                          listExpense);
                                                      net = total;
                                                    });
                                                    print(listExpense);
                                                    // ในที่นี้คุณสามารถใช้ค่าที่เก็บไว้ใน removedIds ต่อไปตามต้องการ
                                                    print(
                                                        'Removed ids: $deletedItem');
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
                                                        ' ${NumberFormat("#,##0.00", "en_US").format(double.tryParse(listExpense![index]['price'].toString()))} บาท ',
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
                              // print(status);
                              // print(state.getwelfarebyid);
                              // if (_keyFormEdit.currentWidget!.validate()) {
                              // widget.welfareBloc.add(
                              //   UpdateWelfareEvent(
                              //     editwelfaredata: buildWelfareModel(status,
                              //         widget.profiledata, state.getwelfarebyid),
                              //     idEmployees: widget.profiledata.idEmployees!,
                              //   ),
                              // );
                              submitWelfare(
                                  status,
                                  widget.profiledata,
                                  (state.getwelfarebyid != null)
                                      ? state.getwelfarebyid
                                      : null);
                              // }
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
                              submitWelfare(
                                  status,
                                  widget.profiledata,
                                  (state.getwelfarebyid != null)
                                      ? state.getwelfarebyid
                                      : null);
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
