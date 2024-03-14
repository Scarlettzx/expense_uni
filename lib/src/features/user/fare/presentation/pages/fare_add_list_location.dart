import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// import 'package:iconamoon/iconamoon.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/customappbar.dart';
import 'package:uni_expense/src/features/user/fare/presentation/bloc/fare_bloc.dart';
// import 'setDefaultDateFunction';
// import '../../../../../components/custominputdecoration.dart';
import '../../../welfare/presentation/widgets/customdatepicker.dart';
import '../../data/models/addlist_location_fuel.dart';
import '../widgets/add_list/labeled_textfield.dart';

class FareAddListLocation extends StatefulWidget {
  final FareBloc fareBloc;
  final ListLocationandFuel? listlocationandfuel;
  final bool? isdraft;
  const FareAddListLocation({
    super.key,
    required this.fareBloc,
    this.isdraft,
    this.listlocationandfuel,
  });

  @override
  State<FareAddListLocation> createState() => _FareAddListLocationState();
}

class _FareAddListLocationState extends State<FareAddListLocation> {
  bool isEditing = false;
  ListLocationandFuel? listlocationfuel;
  @override
  void initState() {
    if (widget.listlocationandfuel != null) {
      isEditing = true;
      listlocationfuel = widget.listlocationandfuel;
      _selectDateController.text = listlocationfuel!.date;
      _startLocationController.text = listlocationfuel!.startLocation;
      _stopLocationController.text = listlocationfuel!.stopLocation;
      _startMileController.text = listlocationfuel!.startMile.toString();
      _stopMileController.text = listlocationfuel!.stopMile.toString();
      _totalController.text = listlocationfuel!.total.toString();
      _personalController.text = listlocationfuel!.personal.toString();
      _netController.text = listlocationfuel!.net.toString();
    }
    super.initState();
  }

  final _selectDateController = TextEditingController();
  final _startLocationController = TextEditingController();
  final _stopLocationController = TextEditingController();
  final _startMileController = TextEditingController();
  final _stopMileController = TextEditingController();
  final _totalController = TextEditingController();
  final _personalController = TextEditingController();
  final _netController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void handleChangeMile(String startMile, String stopMile, String personal) {
    int? parsedStartMile = int.tryParse(startMile);
    int? parsedStopMile = int.tryParse(stopMile);
    int? parsePersonal = int.tryParse(_personalController.text);
    if (parsedStartMile != null && parsedStopMile != null) {
      int newTotal = parsedStopMile - parsedStartMile;
      print('New total: $newTotal');
      _totalController.text = ((newTotal > 0) ? newTotal : 0).toString();
      if (parsePersonal != null) {
        // print('New net: $parsePersonal');
        _netController.text = ((newTotal - parsePersonal) > 0)
            ? (newTotal - parsePersonal).toString()
            : 0.toString();
        print('New person: $parsePersonal');
        print('New net: ${_netController.text}');
      } else {
        _netController.text = newTotal.toString();
      }
    } else {
      print('Invalid input');
    }
  }

  void handleCleardata() {
    // _selectDateController.clear();
    _startLocationController.clear();
    _stopLocationController.clear();
    _startMileController.clear();
    _stopMileController.clear();
    _totalController.clear();
    _personalController.clear();
    _netController.clear();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isdraft);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar:
            const CustomAppBar(image: "appbar_fare.png", title: "ค่าเดินทาง"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'เพิ่มรายการ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(20),
                Text(
                  'วันที่',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade600),
                ),
                const Gap(10),
                CustomDatePicker(controller: _selectDateController),
                const Gap(20),
                // ! _startMile
                LabeledTextField(
                  label: 'เลขไมล์เริ่มต้น',
                  controller: _startMileController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    handleChangeMile(
                      _startMileController.text,
                      _stopMileController.text,
                      _personalController.text,
                    );
                  },
                ),
                // ! _stopMile
                LabeledTextField(
                  label: 'เลขไมล์สิ้นสุด',
                  controller: _stopMileController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    handleChangeMile(
                      _startMileController.text,
                      _stopMileController.text,
                      _personalController.text,
                    );
                  },
                ),
                // ! _startLocation
                LabeledTextField(
                  label: 'สถานที่เริ่มต้น',
                  controller: _startLocationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                // ! _stopLocation
                LabeledTextField(
                  label: 'สถานที่สิ้นสุด',
                  controller: _stopLocationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                // ! _total
                LabeledTextField(
                  label: 'ระยะทางรวม (กม.)',
                  controller: _totalController,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade600),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                // ! _personal
                LabeledTextField(
                  label: 'ใช้ส่วนตัว (กม.)',
                  controller: _personalController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    handleChangeMile(
                      _startMileController.text,
                      _stopMileController.text,
                      _personalController.text,
                    );
                  },
                ),
                // ! _net
                LabeledTextField(
                  label: 'ระยะทางสุทธิ (กม.)',
                  controller: _netController,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade600),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                const Gap(40),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      handleCleardata();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          width: 2, color: Color(0xffff99ca)), // สีขอบสีส้ม
                    ),
                    child: const Text(
                      'ล้าง',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xffff99ca), // สีข้อความสีส้ม
                      ),
                    ),
                  ),
                ),
                const Gap(5),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'บันทึกรายการ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white, // สีข้อความขาว
                      ),
                    ),
                    // icon: Icon(
                    //   Icons.send,
                    //   color: Colors.white,
                    // ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffff99ca), // สีปุ่มสีส้ม
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        if (isEditing) {
                          final listlocationfuel =
                              widget.listlocationandfuel!.copyWith(
                            date: _selectDateController.text,
                            startLocation: _startLocationController.text,
                            stopLocation: _stopLocationController.text,
                            startMile: int.tryParse(_startMileController.text)!,
                            stopMile: int.tryParse(_stopMileController.text)!,
                            net: int.tryParse(_netController.text)!,
                            total: int.tryParse(_totalController.text)!,
                            personal: int.tryParse(_personalController.text)!,
                          );
                          print(listlocationfuel);
                          widget.fareBloc.add(
                            UpdateListLocationAndFuelEvent(
                                listlocationandfuel: listlocationfuel),
                          );
                        } else {
                          final listlocationfuel = ListLocationandFuel(
                            id: (widget.isdraft != null &&
                                    widget.isdraft == true)
                                ? null
                                : DateTime.now().toIso8601String(),
                            date: _selectDateController.text,
                            startLocation: _startLocationController.text,
                            stopLocation: _stopLocationController.text,
                            startMile: int.tryParse(_startMileController.text)!,
                            stopMile: int.tryParse(_stopMileController.text)!,
                            net: int.tryParse(_netController.text)!,
                            total: int.tryParse(_totalController.text)!,
                            personal: int.tryParse(_personalController.text)!,
                          );
                          widget.fareBloc.add(
                            AddListLocationAndFuelEvent(
                                listlocationandfuel: listlocationfuel),
                          );
                        }
                        debugPrint("success");
                        Navigator.pop(context);
                      } else {
                        debugPrint("not success");
                      }
                    },
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
