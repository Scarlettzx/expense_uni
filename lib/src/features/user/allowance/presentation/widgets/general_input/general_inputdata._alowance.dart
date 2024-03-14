import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/bloc/allowance_bloc.dart';

import '../../../../../../components/custominputdecoration.dart';
import '../../../../allowance/presentation/widgets/required_text.dart';
import '../../../domain/entities/entities.dart';
import '../delete_allowance.dart';

class GeneralInputDataAllowance extends StatelessWidget {
  final TextEditingController namexpense;
  final AllowanceBloc? allowanceBloc;
  final FileUrlGetAllowanceByIdEntity? fileUrl;
  final int? idEmp;
  final int? idExpense;
  final int? idExpenseAllowance;
  final bool? isManageItemtoPageEdit;
  final List<ListExpensegetallowancebyidEntity>? listExpense;
  const GeneralInputDataAllowance({
    super.key,
    required this.namexpense,
    this.allowanceBloc,
    this.fileUrl,
    this.idEmp,
    this.idExpense,
    this.idExpenseAllowance,
    this.isManageItemtoPageEdit,
    this.listExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<AllowanceBloc, AllowanceState>(
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
                  DeleteDraftAllowance(
                    isManageItemtoPageEdit: isManageItemtoPageEdit,
                    allowanceBloc: allowanceBloc,
                    fileUrl: fileUrl,
                    idEmp: idEmp,
                    idExpense: idExpense,
                    idExpenseAllowance: idExpenseAllowance,
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
