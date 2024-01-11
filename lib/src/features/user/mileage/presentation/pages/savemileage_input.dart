import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../allowance/presentation/widgets/customappbar.dart';

class SaveMileageInput extends StatefulWidget {
  const SaveMileageInput({super.key});

  @override
  State<SaveMileageInput> createState() => _SaveMileageInputState();
}

class _SaveMileageInputState extends State<SaveMileageInput> {
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }
  final pinController = TextEditingController();

  final focusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Colors.white;
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 40,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      appBar: CustomAppBar(
          image: 'appbar_savemileage.png', title: 'บันทึก Mileage'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Container(
          padding: EdgeInsets.all(30),
          height: MediaQuery.of(context).devicePixelRatio * 90,
          // height: 127,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff87DC45),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gap(10),
                Text('เริ่มออกเดินทาง',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Gap(10),
                Divider(
                  // endIndent: 10,
                  // indent: 10,
                  color: Colors.white,
                  height: 1,
                  thickness: 1,
                ),
                Gap(10),
                Text('ใส่เลขไมล์ก่อนออกเดินทาง',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Gap(15),
                Align(
                  alignment: Alignment.center,
                  child: Expanded(
                    child: Directionality(
                      // Specify direction if desired
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        length: 6,
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        defaultPinTheme: defaultPinTheme,
                        controller: pinController,
                        focusNode: focusNode,
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        validator: (value) {
                          return value == '2222' ? null : 'Pin is incorrect';
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
