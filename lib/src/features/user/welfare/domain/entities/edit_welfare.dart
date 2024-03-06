import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class EditWelfareEntity extends Equatable {
  final int? idExpense;
  final int? idExpenseWelfare;
  final String? documentId;
  final String? nameExpense;
  final PlatformFile? file;
  final List<ListExpenseEditWelfareEntity>? listExpense;
  final String? location;
  final String? documentDate;
  final String? type;
  final String? remark;
  final int? typeExpense;
  final String? typeExpenseName;
  final String? lastUpdateDate;
  final int? status;
  final double? total;
  final double? net;
  final int? idFamily;
  final int? isUseForFamilyMember;
  final dynamic comment;
  final List<int>? deletedItem;

  const EditWelfareEntity(
      {required this.idExpense,
      required this.idExpenseWelfare,
      required this.documentId,
      required this.nameExpense,
      required this.file,
      required this.listExpense,
      required this.location,
      required this.documentDate,
      required this.type,
      required this.remark,
      required this.typeExpense,
      required this.typeExpenseName,
      required this.lastUpdateDate,
      required this.status,
      required this.total,
      required this.net,
      required this.idFamily,
      required this.isUseForFamilyMember,
      required this.comment,
      required this.deletedItem});

  @override
  List<Object?> get props => [
        idExpense,
        idExpenseWelfare,
        documentId,
        nameExpense,
        file,
        listExpense,
        location,
        documentDate,
        type,
        remark,
        typeExpense,
        typeExpenseName,
        lastUpdateDate,
        status,
        total,
        net,
        idFamily,
        isUseForFamilyMember,
        comment,
        deletedItem,
      ];
}

class ListExpenseEditWelfareEntity extends Equatable {
  final int? idExpenseWelfareItem;
  final String? description;
  final String? price;
  final dynamic withdrawablePrice;
  final dynamic difference;

  const ListExpenseEditWelfareEntity(
      {required this.idExpenseWelfareItem,
      required this.description,
      required this.price,
      required this.withdrawablePrice,
      required this.difference});

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
