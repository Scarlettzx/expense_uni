import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class AddWelfareEntity extends Equatable {
  final String? nameExpense;
  final List<ListExpenseEntity>? listExpense;
  final String? location;
  final PlatformFile? file;
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
  final String? ccEmail;
  final int? idPosition;
  const AddWelfareEntity({
    required this.nameExpense,
    required this.listExpense,
    required this.location,
    required this.file,
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
    required this.ccEmail,
    required this.idPosition,
  });

  @override
  List<Object?> get props => [
        nameExpense,
        listExpense,
        location,
        file,
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
        ccEmail,
        idPosition,
      ];
}

class ListExpenseEntity extends Equatable {
  final String? description;
  final String? price;

  const ListExpenseEntity({
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "price": price,
      };

  @override
  List<Object?> get props => [
        description,
        price,
      ];
}
