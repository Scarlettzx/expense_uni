import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uni_expense/src/features/user/fare/presentation/pages/fare_edit_draft.dart';
// import '../../../../allowance/presentation/pages/allowance_edit.dart';
import '../../../../expense/presentation/pages/edit_list_expense.dart';
import '../../../domain/entities/entities.dart';
import '../../widgets/status_widget.dart';
import 'package:flutter/src/widgets/scroll_controller.dart';

class DraftManageItemsTab extends StatefulWidget {
  final List<AllEntity> draft; // Replace with your actual data type
  const DraftManageItemsTab({Key? key, required this.draft}) : super(key: key);

  @override
  _DraftManageItemsTabState createState() => _DraftManageItemsTabState();
}

class _DraftManageItemsTabState extends State<DraftManageItemsTab> {
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);
  bool visibletotop = false;
  bool visibletobottom = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // print(_scrollController.position.pixels);
      // print((_scrollController.offset >
      //     (_scrollController.position.maxScrollExtent / 2)));
      if (_scrollController.offset >
          (_scrollController.position.maxScrollExtent / 2)) {
        setState(() {
          visibletotop = true;
        });
      } else {
        setState(() {
          visibletotop = false;
        });
      }
      if (_scrollController.offset <
          (_scrollController.position.maxScrollExtent / 2)) {
        setState(() {
          visibletobottom = true;
        });
      } else {
        visibletobottom = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 10, bottom: 10),
      child: (widget.draft.isEmpty)
          ? Center(
              child: Text('ไม่พบข้อมูล '),
            )
          : Stack(
              children: [
                ListView.builder(
                  controller: _scrollController,
                  itemCount: widget.draft.length,
                  itemBuilder: (context, index) {
                    final item = widget.draft[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(item.expenseTypeId!);
                              print(item.idExpense!);
                              Navigator.push(
                                context,
                                PageTransition(
                                  duration: Durations.medium1,
                                  type: PageTransitionType.rightToLeft,
                                  child: navigateToPageObj(
                                    context,
                                    item.expenseTypeId!,
                                    item.idExpense!,
                                  )!,
                                ),
                              );
                            },
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('ชื่อรายการ: '),
                                        Text('${item.expenseName}'),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: Visibility(
                      visible: visibletotop,
                      child: FloatingActionButton(
                        onPressed: () {
                          _scrollController.animateTo(
                            _scrollController.position.minScrollExtent,
                            duration: const Duration(seconds: 2),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Icon(Icons.arrow_upward),
                      ),
                    )),
                Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: Visibility(
                      visible: visibletobottom,
                      child: FloatingActionButton(
                        onPressed: () {
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(seconds: 2),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Icon(Icons.arrow_downward),
                      ),
                    )),
              ],
            ),
    );
  }

  Widget? navigateToPageObj(
      BuildContext context, int expenseType, int idExpense) {
    switch (expenseType) {
      // ? Service and Good
      case 1:
        print('1');
        return EditExpenseGood(
          isManageItemtoPageEdit: true,
          idExpense: idExpense,
        );
      case 3:
        print('3');
        return FareEditDraft(
          isManageItemtoPageEdit: true,
          idExpense: idExpense,
        );
      default:
        // Handle other cases if needed
        print('default');
        return null;
    }
  }
}
