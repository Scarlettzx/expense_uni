import 'dart:convert';

import '../../domain/entities/entities.dart';

ManageItemsModel manageItemsModelFromJson(String str) =>
    ManageItemsModel.fromJson(json.decode(str));

// String manageItemsModelToJson(ManageItemsModel data) =>
//     json.encode(data.toJson());

class ManageItemsModel extends ManageItems {
  const ManageItemsModel({
    required List<AllModel>? waiting,
    required List<AllModel>? holding,
    required List<AllModel>? rejected,
    required List<AllModel>? processing,
    required List<AllModel>? completed,
    required List<AllModel>? draft,
    required List<AllModel>? waitingForAdmin,
    required List<AllModel>? all,
    required List<AllModel>? waitingForReview,
  }) : super(
          waiting: waiting,
          holding: holding,
          rejected: rejected,
          processing: processing,
          completed: completed,
          draft: draft,
          waitingForAdmin: waitingForAdmin,
          all: all,
          waitingForReview: waitingForReview,
        );

  factory ManageItemsModel.fromJson(Map<String, dynamic> json) =>
      ManageItemsModel(
        waiting: List<AllModel>.from(
            json["Waiting"].map((x) => AllModel.fromJson(x))),
        holding: List<AllModel>.from(
            json["Holding"].map((x) => AllModel.fromJson(x))),
        rejected: List<AllModel>.from(
            json["Rejected"].map((x) => AllModel.fromJson(x))),
        processing: List<AllModel>.from(
            json["Processing"].map((x) => AllModel.fromJson(x))),
        completed: List<AllModel>.from(
            json["Completed"].map((x) => AllModel.fromJson(x))),
        draft:
            List<AllModel>.from(json["Draft"].map((x) => AllModel.fromJson(x))),
        waitingForAdmin: List<AllModel>.from(
            json["WaitingForAdmin"].map((x) => AllModel.fromJson(x))),
        all: List<AllModel>.from(json["All"].map((x) => AllModel.fromJson(x))),
        waitingForReview: List<AllModel>.from(
            json["WaitingForReview"].map((x) => AllModel.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "Waiting": List<dynamic>.from(waiting.map((x) => x.toJson())),
  //       "Holding": List<dynamic>.from(holding.map((x) => x.toJson())),
  //       "Rejected": List<dynamic>.from(rejected.map((x) => x.toJson())),
  //       "Processing": List<dynamic>.from(processing.map((x) => x.toJson())),
  //       "Completed": List<dynamic>.from(completed.map((x) => x.toJson())),
  //       "Draft": List<dynamic>.from(draft.map((x) => x.toJson())),
  //       "WaitingForAdmin":
  //           List<dynamic>.from(waitingForAdmin.map((x) => x.toJson())),
  //       "AllModel": List<dynamic>.from(all.map((x) => x.toJson())),
  //       "WaitingForReview": List<dynamic>.from(waitingForReview.map((x) => x)),
  //     };
}

class AllModel extends AllEntity {
  // String documentId;
  // int idExpense;
  // String expenseName;
  // double net;
  // String name;
  // int expenseTypeId;
  // String expenseType;

  const AllModel({
    required String? documentId,
    required int? idExpense,
    required String? expenseName,
    required double? net,
    required String? name,
    required int? expenseTypeId,
    required String? expenseType,
  }) : super(
            documentId: documentId,
            idExpense: idExpense,
            expenseName: expenseName,
            net: net,
            name: name,
            expenseTypeId: expenseTypeId,
            expenseType: expenseType);

  factory AllModel.fromJson(Map<String, dynamic> json) => AllModel(
        documentId: json["documentId"],
        idExpense: json["idExpense"],
        expenseName: json["expenseName"],
        net: json["net"]?.toDouble(),
        name: json["name"],
        expenseTypeId: json["expenseTypeId"],
        expenseType: json["expenseType"],
      );

  // Map<String, dynamic> toJson() => {
  //       "documentId": documentId,
  //       "idExpense": idExpense,
  //       "expenseName": expenseName,
  //       "net": net,
  //       "name": name,
  //       "expenseTypeId": expenseTypeId,
  //       "expenseType": expenseType,
  //     };
}
