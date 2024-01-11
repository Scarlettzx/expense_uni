import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final String status;

  const StatusWidget({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).devicePixelRatio * 37,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: getStatusColor(status),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        getStatusText(status),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w900,
          color: getStatusTextColor(status),
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Draft':
        return Color(0xffE5E6E7);
      case 'Waiting':
        return Color(0xffede7f6);
      case 'Processing':
        return Color(0xffe3f2fd);
      case 'Holding':
        return Color(0xfffff8e1);
      case 'WaitingForAdmin':
        return Color(0xffFFF3FC);
      case 'Completed':
        return Color(0xffe8f5e9);
      case 'Rejected':
        return Color(0xffffebee);
      default:
        return Colors.red;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'Draft':
        return 'แบบร่าง';
      case 'Waiting':
        return 'รออนุมัติ';
      case 'Processing':
        return 'อยู่ระหว่างดำเนินการ';
      case 'Holding':
        return 'รอการแก้ไข';
      case 'WaitingForAdmin':
        return 'รอการตรวจสอบสิทธิ';
      case 'Completed':
        return 'เสร็จสมบูรณ์';
      case 'Rejected':
        return 'ไม่อนุมัติ';
      default:
        return 'ไม่ทราบสถานะ';
    }
  }

  Color getStatusTextColor(String status) {
    switch (status) {
      case 'Draft':
        return Color(0xff566972);
      case 'Waiting':
        return Color(0xff7c4dff);
      case 'Processing':
        return Color(0xff007AFE);
      case 'Holding':
        return Color(0xffff6d00);
      case 'WaitingForAdmin':
        return Color(0xffFF4887);
      case 'Completed':
        return Color(0xff00c853);
      case 'Rejected':
        return Color(0xffd50000);
      default:
        return Color(0xffd50000);
    }
  }
}
