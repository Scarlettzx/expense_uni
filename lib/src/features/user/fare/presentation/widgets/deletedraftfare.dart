import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uni_expense/src/features/user/fare/presentation/pages/fare_general_info.dart';
import '../../data/models/delete_fare_model.dart';
import '../../domain/entities/entities.dart';

import '../bloc/fare_bloc.dart';

class DeleteDraftFare extends StatelessWidget {
  final FareBloc? fareBloc;
  final int? idEmp;
  final int? idExpense;
  final int? idExpenseMileage;
  final List<ListExpenseFareEntity>? listExpense;
  final bool? isManageItemtoPageEdit;
  final FileUrl? fileUrl;
  const DeleteDraftFare({
    super.key,
    required this.fareBloc,
    required this.idEmp,
    required this.idExpense,
    required this.idExpenseMileage,
    required this.listExpense,
    required this.isManageItemtoPageEdit,
    required this.fileUrl,
  });
  @override
  Widget build(BuildContext context) {
    List<int>? idExpenseMileageItems = [];
    bool isAttachFile = false;
    String? filepath;
    if (idEmp != null &&
        idExpense != null &&
        idExpenseMileage != null &&
        listExpense != null) {
      idExpenseMileageItems = listExpense!
          .map((expenseItem) {
            return expenseItem.idExpenseMileageItem;
          })
          .cast<int>()
          .toList();
    } else {
      print(
          "One or more of idEmp, idExpense, idExpenseMileage, listExpense is null.");
    }
    return Container(
      constraints: BoxConstraints(maxWidth: 200.0),
      child: OutlinedButton.icon(
        onPressed: () {
          if (idEmp != null &&
              idExpense != null &&
              idExpenseMileage != null &&
              listExpense != null) {
            if (fileUrl != null) {
              isAttachFile = true;
              filepath = fileUrl!.path;
            }

            fareBloc!.add(DeleteExpenseFareEvent(
              idEmp: idEmp!,
              deletefaredata: DeleteDraftFareModel(
                idExpense: idExpense,
                idExpenseMileage: idExpenseMileage,
                listExpense: idExpenseMileageItems,
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
                      child: const FareGeneralInformation(),
                    ),
                    (route) => route.isFirst,
                    // ใช้เงื่อนไขนี้เพื่อลบทุกหน้าอื่นที่ไม่ใช่หน้าแรกออกจาก stack
                  );
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
