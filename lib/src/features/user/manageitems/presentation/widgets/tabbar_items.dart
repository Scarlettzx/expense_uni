import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ManageItemsTabBar extends StatelessWidget {
  final List<int> itemCounts;
  final TabController tabController;

  const ManageItemsTabBar(
      {super.key, required this.itemCounts, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: TabBar(
        controller: tabController,
        onTap: (value) {
          // Handle tab selection
        },
        splashFactory: NoSplash.splashFactory,
        splashBorderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        isScrollable: true,
        tabs: [
          for (int i = 0; i < itemCounts.length; i++)
            Row(
              children: [
                Tab(
                  text: getTabText(i),
                ),
                Gap(5),
                Visibility(
                  visible: itemCounts[i] >
                      0, // Show if itemCounts[i] is greater than 0
                  child: Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Text(
                      '${itemCounts[i]}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
        indicatorColor: Colors.pink,
        labelColor: Colors.pink,
        tabAlignment: TabAlignment.start,
      ),
    );
  }

  String getTabText(int index) {
    switch (index) {
      case 0:
        return 'ทั้งหมด';
      case 1:
        return 'แบบร่าง';
      case 2:
        return 'รออนุมัติ';
      case 3:
        return 'รอการตรวจสอบสิทธิ';
      case 4:
        return 'รอการตรวจสอบ';
      case 5:
        return 'อยู่ระหว่างดำเนินการ';
      case 6:
        return 'รอการแก้ไข';
      case 7:
        return 'เสร็จสมบูรณ์';
      case 8:
        return 'ไม่อนุมัติ';
      default:
        return '';
    }
  }
}
