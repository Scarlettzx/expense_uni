import 'package:equatable/equatable.dart';

class FamilysEntity extends Equatable {
  final int? idFamily;
  final int? idEmployees;
  final String? relationship;
  final DateTime? birthday;
  final String? personalId;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? filename;
  final DateTime? createDate;
  final DateTime? updateDate;
  final int? isApprove;
  final DateTime? approveDate;
  final int? idAdmin;
  final int? isActive;
  final String? imageUrl;
  const FamilysEntity({
    required this.idFamily,
    required this.idEmployees,
    required this.relationship,
    required this.birthday,
    required this.personalId,
    required this.firstnameTh,
    required this.lastnameTh,
    required this.filename,
    required this.createDate,
    required this.updateDate,
    required this.isApprove,
    required this.approveDate,
    required this.idAdmin,
    required this.isActive,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        idFamily,
        idEmployees,
        relationship,
        birthday,
        personalId,
        firstnameTh,
        lastnameTh,
        filename,
        createDate,
        updateDate,
        isApprove,
        approveDate,
        idAdmin,
        isActive,
        imageUrl,
      ];
  Map<String, dynamic> toJson() => {
        "idFamily": idFamily,
        "idEmployees": idEmployees,
        "relationship": relationship,
        "birthday": birthday?.toIso8601String(),
        "personalID": personalId,
        "firstname_TH": firstnameTh,
        "lastname_TH": lastnameTh,
        "filename": filename,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
        "isApprove": isApprove,
        "approveDate": approveDate?.toIso8601String(),
        "idAdmin": idAdmin,
        "isActive": isActive,
        "imageURL": imageUrl,
      };
}
