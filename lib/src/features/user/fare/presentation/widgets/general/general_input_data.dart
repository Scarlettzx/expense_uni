import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:uni_expense/src/features/user/fare/presentation/bloc/fare_bloc.dart';

import '../../../../../../components/custominputdecoration.dart';
import '../../../../allowance/presentation/widgets/required_text.dart';

class GeneralInputData extends StatelessWidget {
  final TextEditingController namexpense;
  const GeneralInputData({
    super.key,
    required this.namexpense,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<FareBloc, FareState>(
          builder: (context, state) {
            return RequiredText(
              labelText: 'ข้อมูลทั่วไป',
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'kanit',
                color: Colors.black,
              ),
              asteriskText: (state.isdraft == true) ? ' ( แบบร่าง ) ' : "",
              asteriskStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: 'kanit',
                color: Color.fromRGBO(117, 117, 117, 1),
              ),
            );
          },
        ),
        const Gap(20),
        RequiredText(
          labelText: 'ชื่อรายการ',
          asteriskText: '*',
        ),
        const Gap(10),
        TextFormField(
          controller: namexpense,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null; // Return null if the input is valid
          },
          decoration: CustomInputDecoration.getInputDecoration(),
        ),
        const Gap(20),
      ],
    );
  }
}
