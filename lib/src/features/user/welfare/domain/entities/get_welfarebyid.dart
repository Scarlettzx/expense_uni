import 'package:equatable/equatable.dart';

class GetWelfareByIdEntity extends Equatable {
  final String? documentId;
  final int? idExpense;
  final int? idExpenseWelfare;
  final int? status;
  final String? nameExpense;
  final List<ListExpenseWelfareEntity>? listExpense;
  final String? remark;
  final String? typeExpenseName;
  final int? expenseType;
  final num? total;
  final num? net;
  final dynamic withdrawal;
  final dynamic difference;
  final dynamic helpingSurplus;
  final String? documentDate;
  final String? type;
  final String? location;
  final List<dynamic>? comments;
  final List<dynamic>? actions;
  final bool? isUseForFamilyMember;
  final int? idFamily;
  final String? relation;
  final int? idEmployees;
  final String? userName;
  final int? suggestedIdRightsManage;
  final FileUrlWelfareEntity? fileUrl;

  const GetWelfareByIdEntity({
    required this.documentId,
    required this.idExpense,
    required this.idExpenseWelfare,
    required this.status,
    required this.nameExpense,
    required this.listExpense,
    required this.remark,
    required this.typeExpenseName,
    required this.expenseType,
    required this.total,
    required this.net,
    required this.withdrawal,
    required this.difference,
    required this.helpingSurplus,
    required this.documentDate,
    required this.type,
    required this.location,
    required this.comments,
    required this.actions,
    required this.isUseForFamilyMember,
    required this.idFamily,
    required this.relation,
    required this.idEmployees,
    required this.userName,
    required this.suggestedIdRightsManage,
    required this.fileUrl,
  });

  @override
  List<Object?> get props => [
        documentId,
        idExpense,
        idExpenseWelfare,
        status,
        nameExpense,
        listExpense,
        remark,
        typeExpenseName,
        expenseType,
        total,
        net,
        withdrawal,
        difference,
        helpingSurplus,
        documentDate,
        type,
        location,
        comments,
        actions,
        isUseForFamilyMember,
        idFamily,
        relation,
        idEmployees,
        userName,
        suggestedIdRightsManage,
        fileUrl,
      ];
}

class ListExpenseWelfareEntity extends Equatable {
  final int? idExpenseWelfareItem;
  final String? description;
  final num? price;
  final dynamic withdrawablePrice;
  final dynamic difference;

  const ListExpenseWelfareEntity({
    required this.idExpenseWelfareItem,
    required this.description,
    required this.price,
    required this.withdrawablePrice,
    required this.difference,
  });

  @override
  List<Object?> get props => [
        idExpenseWelfareItem,
        description,
        price,
        withdrawablePrice,
        difference,
      ];

  Map<String, dynamic> toJson() => {
        "idExpenseWelfareItem": idExpenseWelfareItem,
        "description": description,
        "price": price,
        "withdrawablePrice": withdrawablePrice,
        "difference": difference,
      };
}

class FileUrlWelfareEntity extends Equatable {
  final String? url;
  final String? path;

  const FileUrlWelfareEntity({
    required this.url,
    required this.path,
  });

  @override
  List<Object?> get props => [url, path];

  Map<String, dynamic> toJson() => {
        "URL": url,
        "path": path,
      };
}
