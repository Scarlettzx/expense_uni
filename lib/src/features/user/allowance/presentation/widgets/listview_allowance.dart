import 'package:flutter/material.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/bloc/allowance_bloc.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/tasklistallowance_detail.dart';

import '../../data/models/listallowance.dart';

class ListViewAllowance extends StatelessWidget {
  final AllowanceBloc allowanceBloc;
  final List<ListAllowance> lisallowance;
  const ListViewAllowance({
    super.key,
    required this.lisallowance,
    required this.allowanceBloc,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        reverse: true,
        itemCount: lisallowance.length,
        itemBuilder: (context, index) {
          final task = lisallowance[index];
          return TaskListAllowanceDetail(
            listallowance: task,
            allowanceBloc: allowanceBloc,
            index: index,
          );
        });
  }
}
