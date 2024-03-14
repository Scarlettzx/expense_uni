import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uni_expense/src/features/user/manageitems/presentation/pages/manageitems.dart';

// import '../../../manageitems/presentation/pages/manageitems.dart';
import '../../data/models/delete_expensegood_model.dart';
import '../../domain/entities/entities.dart';
import '../bloc/expensegood_bloc.dart';
import '../pages/expense.dart';

class DeleteDraftExpenseGood extends StatelessWidget {
  final ExpenseGoodBloc? expenseBloc;
  final int? idEmp;
  final int? idExpense;
  final int? idExpenseGood;
  final FileUrlGetExpenseGoodByIdEntity? fileUrl;
  final bool? isManageItemtoPageEdit;
  final List<ListExpenseGetExpenseGoodByIdEntity>? listExpense;
  const DeleteDraftExpenseGood({
    super.key,
    required this.expenseBloc,
    required this.idEmp,
    required this.idExpense,
    required this.idExpenseGood,
    required this.fileUrl,
    this.isManageItemtoPageEdit,
    required this.listExpense,
  });
  @override
  Widget build(BuildContext context) {
    List<int>? idExpenseGoodsItem = [];
    bool isAttachFile = false;
    String? filepath;
    if (idEmp != null &&
        idExpense != null &&
        idExpenseGood != null &&
        listExpense != null) {
      idExpenseGoodsItem = listExpense!
          .map((expenseItem) {
            return expenseItem.idExpenseGoodsItem;
          })
          .cast<int>()
          .toList();
    } else {
      print(
          "One or more of idEmp, idExpense, idExpenseGoodsItem, listExpense is null.");
    }
    return Container(
      constraints: const BoxConstraints(maxWidth: 200.0),
      child: OutlinedButton.icon(
        onPressed: () {
          if (idEmp != null &&
              idExpense != null &&
              idExpenseGoodsItem != null &&
              listExpense != null) {
            if (fileUrl != null) {
              isAttachFile = true;
              filepath = fileUrl!.path;
            }
            expenseBloc!.add(DeleteExpenseGoodEvent(
              idEmp: idEmp!,
              deletefaredata: DeleteDraftExpenseGoodModel(
                idExpense: idExpense,
                idExpenseGoods: idExpenseGood,
                listExpense: idExpenseGoodsItem,
                filePath: filepath,
                isAttachFile: isAttachFile,
              ),
            ));
            (isManageItemtoPageEdit != null && isManageItemtoPageEdit == true)
                ? Navigator.pop(context)
                : Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                      duration: Durations.medium1,
                      type: PageTransitionType.rightToLeft,
                      child: const Expense(),
                    ),
                    (route) => route.isFirst,
                    // ใช้เงื่อนไขนี้เพื่อลบทุกหน้าอื่นที่ไม่ใช่หน้าแรกออกจาก stack
                  );
            print(idExpenseGoodsItem);
            print(idEmp);
            print(idExpense);
            print(idExpenseGood);
            print(filepath);
            print(isAttachFile);
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
