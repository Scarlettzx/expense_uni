import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:uni_expense/src/features/user/fare/presentation/bloc/fare_bloc.dart';

import '../../../../../../components/custominputdecoration.dart';
import '../../../../allowance/presentation/widgets/required_text.dart';
import '../../../domain/entities/entities.dart';
import '../deletedraftfare.dart';

class GeneralInputData extends StatelessWidget {
  final TextEditingController namexpense;
  final FareBloc? fareBloc;
  final FileUrl? fileUrl;
  final int? idEmp;
  final int? idExpense;
  final int? idExpenseMileage;
  final bool? isManageItemtoPageEdit;
  final List<ListExpenseFareEntity>? listExpense;
  const GeneralInputData({
    super.key,
    required this.namexpense,
    this.fareBloc,
    this.fileUrl,
    this.idEmp,
    this.idExpense,
    this.idExpenseMileage,
    this.isManageItemtoPageEdit,
    this.listExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<FareBloc, FareState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RequiredText(
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
                ),
                if (state.isdraft == true) ...[
                  DeleteDraftFare(
                    isManageItemtoPageEdit: isManageItemtoPageEdit,
                    fareBloc: fareBloc,
                    fileUrl: fileUrl,
                    idEmp: idEmp,
                    idExpense: idExpense,
                    idExpenseMileage: idExpenseMileage,
                    listExpense: listExpense,
                  )
                ]
              ],
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
