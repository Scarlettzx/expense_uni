import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/entities.dart';
import '../../widgets/status_widget.dart';

class WaitingForAdminManageItemsTab extends StatelessWidget {
  final List<AllEntity> waitingforadmin; // Replace with your actual data type
  const WaitingForAdminManageItemsTab(
      {super.key, required this.waitingforadmin});

  @override
  Widget build(BuildContext context) {
    print(waitingforadmin);
    return Container(
      margin: EdgeInsets.only(left: 15, top: 10, bottom: 10),
      child: (waitingforadmin.isEmpty)
      ? Center(
              child: Text('ไม่พบข้อมูล '),
            )
          : 
      ListView.builder(
        itemCount: waitingforadmin.length,
        itemBuilder: (context, index) {
          final item = waitingforadmin[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('เลขที่เอกสาร: ${item.documentId}',
                          style: TextStyle(fontSize: 14)),
                      StatusWidget(
                        status: item.name!,
                      )
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ชื่อรายการ: '),
                            Text('${item.expenseName}'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('มูลค่าสุทธิรวม: '),
                              Text(
                                  '${NumberFormat("###,###.00#", "en_US").format(item.net)} บาท'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  height: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
