import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/customappbar.dart';
import 'package:uni_expense/src/features/user/manageitems/presentation/bloc/manage_items_bloc.dart';
import 'package:uni_expense/src/features/user/manageitems/presentation/pages/manageitemstabview.dart';
import 'package:uni_expense/src/features/user/manageitems/presentation/pages/mangeitems_add_list.dart';

import '../../../../../../injection_container.dart';
import '../widgets/tabbar_items.dart';

class ManageItems extends StatefulWidget {
  const ManageItems({super.key});
  @override
  State<ManageItems> createState() => _ManageItemsState();
}

int allItemsCount = 0;
int draftItemsCount = 0;
int holdingItemsCount = 0;
int waitingItemsCount = 0;
int waitingforadminItemsCount = 0;
int waitingforreviewItemsCount = 0;
int processingItemsCount = 0;
int completedItemsCount = 0;
int rejectedItemsCount = 0;
late TabController tabController;

class _ManageItemsState extends State<ManageItems>
    with SingleTickerProviderStateMixin {
  final manageItemsBloc = sl<ManageItemsBloc>();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 9, vsync: this);
    manageItemsBloc.add(GetManageItemsDataEvent());
    // Calculate the total count
    manageItemsBloc.stream.listen((state) {
      if (state is ManageItemsFinish) {
        setState(() {
          allItemsCount = state.manageItems?.all?.length ?? 0;
          draftItemsCount = state.manageItems?.draft?.length ?? 0;
          waitingItemsCount = state.manageItems?.waiting?.length ?? 0;
          waitingforadminItemsCount =
              state.manageItems?.waitingForAdmin?.length ?? 0;
          waitingforreviewItemsCount =
              state.manageItems?.waitingForReview?.length ?? 0;
          processingItemsCount = state.manageItems?.processing?.length ?? 0;
          holdingItemsCount = state.manageItems?.holding?.length ?? 0;
          completedItemsCount = state.manageItems?.completed?.length ?? 0;
          rejectedItemsCount = state.manageItems?.rejected?.length ?? 0;
        });
        // print(allItemsCount);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: BlocProvider(
        create: (context) => manageItemsBloc,
        child: Scaffold(
            appBar: const CustomAppBar(
                image: "appbar_manageitems.png", title: 'จัดการรายการ'),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30.0),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: Durations.medium1,
                            type: PageTransitionType.rightToLeft,
                            child: const ManageItemsAddList(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffff99ca),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).devicePixelRatio * 6,
                            vertical:
                                MediaQuery.of(context).devicePixelRatio * 3),
                        child: Text(
                          '+ เพิ่มรายการ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                ManageItemsTabBar(
                  itemCounts: [
                    allItemsCount,
                    draftItemsCount,
                    waitingItemsCount,
                    waitingforadminItemsCount,
                    waitingforreviewItemsCount,
                    processingItemsCount,
                    holdingItemsCount,
                    completedItemsCount,
                    rejectedItemsCount,
                  ],
                  tabController: tabController,
                ),
                BlocBuilder<ManageItemsBloc, ManageItemsState>(
                  builder: (context, state) {
                    return ManageItemsTabView(
                        manageItemsState: state, tabcontroller: tabController);
                  },
                ),
              ],
            )),
      ),
    );
  }
}
