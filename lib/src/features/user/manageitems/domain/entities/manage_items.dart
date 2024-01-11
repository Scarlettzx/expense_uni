import 'package:equatable/equatable.dart';

class ManageItems extends Equatable {
  final List<AllEntity>? waiting;
  final List<AllEntity>? holding;
  final List<AllEntity>? rejected;
  final List<AllEntity>? processing;
  final List<AllEntity>? completed;
  final List<AllEntity>? draft;
  final List<AllEntity>? waitingForAdmin;
  final List<AllEntity>? all;
  final List<AllEntity>? waitingForReview;

  const ManageItems(
      {required this.waiting,
      required this.holding,
      required this.rejected,
      required this.processing,
      required this.completed,
      required this.draft,
      required this.waitingForAdmin,
      required this.all,
      required this.waitingForReview});
  @override
  List<Object?> get props => [
        waiting,
        holding,
        rejected,
        processing,
        completed,
        draft,
        waitingForAdmin,
        all,
        waitingForReview
      ];
}

class AllEntity extends Equatable {
  final String? documentId;
  final int? idExpense;
  final String? expenseName;
  final double? net;
  final String? name;
  final int? expenseTypeId;
  final String? expenseType;

  const AllEntity(
      {required this.documentId,
      required this.idExpense,
      required this.expenseName,
      required this.net,
      required this.name,
      required this.expenseTypeId,
      required this.expenseType});

  @override
  List<Object?> get props => [
        documentId,
        idExpense,
        expenseName,
        net,
        name,
        expenseTypeId,
        expenseType
      ];

  // toJson() {}
}
