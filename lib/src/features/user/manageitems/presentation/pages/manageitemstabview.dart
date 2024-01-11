import 'package:flutter/material.dart';

import '../bloc/manage_items_bloc.dart';
import 'ManageAllTabs/all_manageitems.dart';
import 'ManageCompletedTabs/completed_manageitems.dart';
import 'ManageDraftTabs/draft_manageitems.dart';
import 'ManageHoldingTabs/holding_manageitems.dart';
import 'ManageProcessingTabs/processing_manageitems.dart';
import 'ManageRejectedTabs/rejected_manageitems.dart';
import 'ManageWaitingForAdminTabs/waitforadmin_manageitems.dart';
import 'ManageWaitingForReviewTabs/waitingforreview_manageitems.dart';
import 'ManageWaitingTabs/waiting_manageitems.dart';

class ManageItemsTabView extends StatefulWidget {
  final ManageItemsState manageItemsState;
  final TabController tabcontroller;

  const ManageItemsTabView(
      {super.key, required this.manageItemsState, required this.tabcontroller});

  @override
  State<ManageItemsTabView> createState() => _ManageItemsTabViewState();
}

class _ManageItemsTabViewState extends State<ManageItemsTabView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.manageItemsState is ManageItemsInitial) {
      return Text(
        "ไม่พบข้อมูล",
      );
    } else if (widget.manageItemsState is ManageItemsLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (widget.manageItemsState is ManageItemsFinish) {
      return Expanded(
        child: TabBarView(
          controller: widget.tabcontroller,
          children: [
            AllManageItemsTab(
              all: (widget.manageItemsState as ManageItemsFinish)
                  .manageItems!
                  .all!,
            ),
            DraftManageItemsTab(
              draft: (widget.manageItemsState as ManageItemsFinish)
                  .manageItems!
                  .draft!,
            ),
            WaitingManageItemsTab(
              waiting: (widget.manageItemsState as ManageItemsFinish)
                  .manageItems!
                  .waiting!,
            ),
            WaitingForAdminManageItemsTab(
              waitingforadmin: (widget.manageItemsState as ManageItemsFinish)
                  .manageItems!
                  .waitingForAdmin!,
            ),
            WaitingForReviewManageItemsTab(
              waitingforreview: (widget.manageItemsState as ManageItemsFinish)
                  .manageItems!
                  .waitingForReview!,
            ),
            ProcessingManageItemsTab(
              processing: (widget.manageItemsState as ManageItemsFinish)
                  .manageItems!
                  .processing!,
            ),
            HoldingManageItemsTab(
              holding: (widget.manageItemsState as ManageItemsFinish)
                  .manageItems!
                  .holding!,
            ),
            CompletedManageItemsTab(
              completed: (widget.manageItemsState as ManageItemsFinish)
                  .manageItems!
                  .completed!,
            ),
            RejectedManageItemsTab(
              rejected: (widget.manageItemsState as ManageItemsFinish)
                  .manageItems!
                  .rejected!,
            ),
          ],
        ),
      );
    } else if (widget.manageItemsState is ManageItemsFailure) {
      return const Text("error");
    }
    return Container();
  }
}
