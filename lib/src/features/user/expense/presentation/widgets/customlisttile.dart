// Separate stateless widget for ListTile
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uni_expense/src/components/models/concurrency_model,.dart';

import '../../../../../components/models/typeprice_model.dart';
import '../../data/models/addlist_expensegood.dart';
import '../bloc/expensegood_bloc.dart';
import '../pages/add_listexpense.dart';

class CustomListTile extends StatelessWidget {
  final AddListExpenseGood data;
  final ExpenseGoodBloc expensegoodBloc;
  final TypePriceModel? typeprice;
  final int index;
  final ConcurrencyModel? selectcurreny;
  // final Function(int) onDelete;
  // final Function(int) onEdit;

  const CustomListTile({
    Key? key,
    required this.data,
    this.selectcurreny,
    required this.expensegoodBloc,
    required this.typeprice,
    required this.index,
    // required this.onDelete,
    // required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(20),
            icon: IconaMoon.edit,
            onPressed: (_) async {
              await Navigator.push(
                context,
                PageTransition(
                  duration: Durations.medium1,
                  type: PageTransitionType.rightToLeft,
                  child: AddListExpenseDemo(
                    expensegoodBloc: expensegoodBloc,
                    typeprice: (typeprice != null) ? typeprice! : null,
                    listexpensegood: data,
                  ),
                ),
              );
            },
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
            flex: 2,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(20),
            icon: Icons.delete_rounded,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            onPressed: (_) {
              expensegoodBloc.add(
                DeleteListExpenseEvent(
                  index: index,
                  id: data.idExpenseGoodsItem,
                ),
              );
              expensegoodBloc.add(CalcualteSumEvent());
            },
            flex: 2,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          expandedAlignment: Alignment.centerLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          maintainState: true,
          collapsedTextColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 247, 24, 132).withOpacity(0.7),
          textColor: Colors.white,
          childrenPadding: EdgeInsets.symmetric(horizontal: 10.0),
          collapsedBackgroundColor: Color(0xffff99ca),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          title: Text(
            'สินค้า/รายการ: ${data.service}',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'รายละเอียด: ${data.description}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                data.documentDate != null && data.documentDate != ""
                    ? 'วันที่เอกสาร: ${data.documentDate!}'
                    : "ยังไม่ได้ระบุ",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!(selectcurreny?.code == 'TH')) ...[
                            Text(''),
                          ],
                          Text('จำนวน: '),
                          Text('ราคาต่อหน่วย: '),
                          Text('ภาษี:'),
                          Text('หักภาษี ณ ที่จ่าย: '),
                          Text('มูลค่าก่อนภาษี: '),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!(selectcurreny?.code == 'TH')) ...[
                            Text('หน่วย (${selectcurreny?.unit})'),
                          ],
                          Text(data.amount!.toStringAsFixed(2)),
                          Text(data.unitPrice!.toStringAsFixed(2)),
                          Text(data.taxPercent!.toStringAsFixed(2)),
                          Text(data.withholdingPercent!.toStringAsFixed(2)),
                          Text(data.total!.toStringAsFixed(2)),
                        ],
                      ),
                      if (!(selectcurreny?.code == 'TH')) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('หน่วย (บาท)'),
                            Text(data.amount!.toStringAsFixed(2)),
                            // Text(data.unitPriceInternational!.toStringAsFixed(2)),

                            Text((data.unitPriceInternational != null &&
                                    data.unitPriceInternational != 0)
                                ? NumberFormat("#,##0.00", "en_US")
                                    .format(data.unitPriceInternational)
                                : data.unitPriceInternational!
                                    .toStringAsFixed(2)),

                            Text((data.taxInternational != null &&
                                    data.taxInternational != 0)
                                ? NumberFormat("#,##0.00", "en_US")
                                    .format(data.taxInternational)
                                : data.taxInternational!.toStringAsFixed(2)),
                            Text((data.withholdingInternational != null &&
                                    data.withholdingInternational != 0)
                                ? NumberFormat("#,##0.00", "en_US")
                                    .format(data.withholdingInternational)
                                : data.withholdingInternational!
                                    .toStringAsFixed(2)),
                            Text((data.totalBeforeTaxInternational != null &&
                                    data.totalBeforeTaxInternational != 0)
                                ? NumberFormat("#,##0.00", "en_US")
                                    .format(data.totalBeforeTaxInternational)
                                : data.totalBeforeTaxInternational!
                                    .toStringAsFixed(2)),
                          ],
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
