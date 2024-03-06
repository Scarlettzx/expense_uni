import 'package:flutter/material.dart';
import '../../data/models/delete_welfare_model.dart';
import '../bloc/welfare_bloc.dart';
import '../../domain/entities/entities.dart';

class DeleteDraftWelfare extends StatefulWidget {
  final WelfareBloc welfareBloc;
  final int? idEmp;
  final int? idExpense;
  final int? idExpenseWelfare;
  final List<ListExpenseWelfareEntity>? listExpense;
  final FileUrlWelfareEntity? fileUrl;
  final VoidCallback onDeleted;

  const DeleteDraftWelfare({
    super.key,
    required this.welfareBloc,
    required this.idEmp,
    required this.idExpense,
    required this.idExpenseWelfare,
    required this.listExpense,
    required this.fileUrl,
    required this.onDeleted,
  });

  @override
  State<DeleteDraftWelfare> createState() => _DeleteDraftWelfareState();
}

class _DeleteDraftWelfareState extends State<DeleteDraftWelfare> {
  List<int>? idExpenseWelfareItems = [];
  bool isAttachFile = false;
  String? filepath;

  @override
  Widget build(BuildContext context) {
    if (widget.idEmp != null &&
        widget.idExpense != null &&
        widget.idExpenseWelfare != null &&
        widget.listExpense != null) {
      idExpenseWelfareItems = widget.listExpense!
          .map((expenseItem) {
            return expenseItem.idExpenseWelfareItem;
          })
          .cast<int>()
          .toList();
    } else {
      print(
          "One or more of idEmp, idExpense, idExpenseWelfare, listExpense is null.");
    }
    return Container(
      constraints: const BoxConstraints(maxWidth: 200.0),
      child: OutlinedButton.icon(
        onPressed: () {
          if (widget.idEmp != null &&
              widget.idExpense != null &&
              widget.idExpenseWelfare != null &&
              widget.listExpense != null) {
            if (widget.fileUrl != null) {
              isAttachFile = true;
              filepath = widget.fileUrl!.path;
            }

            widget.welfareBloc.add(DeleteWelfareEvent(
              idEmployees: widget.idEmp!,
              deletewelfaredata: DeleteWelfareModel(
                idExpense: widget.idExpense,
                idExpenseWelfare: widget.idExpenseWelfare,
                listExpense: idExpenseWelfareItems,
                filePath: filepath,
                isAttachFile: isAttachFile,
              ),
            ));
            widget.onDeleted();
          }
        },
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          side: BorderSide(
            width: 3.0,
            color: Colors.red,
          ),
        ),
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        label: Text(
          'ลบแบบร่าง',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
