import 'package:uni_expense/src/features/user/expense/domain/entities/entities.dart';
import 'dart:convert';

List<EmployeesRoleAdminModel> employeesRoleAdminFromJson(String str) =>
    List<EmployeesRoleAdminModel>.from(
        json.decode(str).map((x) => EmployeesRoleAdminModel.fromJson(x)));

String employeeRoleAdminToJson(List<EmployeesRoleAdminModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeesRoleAdminModel extends EmployeeRoleAdminEntity {
  const EmployeesRoleAdminModel(
      {required super.firstnameTh,
      required super.lastnameTh,
      required super.email,
      required super.idEmployees});

  factory EmployeesRoleAdminModel.fromJson(Map<String, dynamic> json) =>
      EmployeesRoleAdminModel(
        firstnameTh: json["firstname_TH"],
        lastnameTh: json["lastname_TH"],
        email: json["email"],
        idEmployees: json["idEmployees"],
      );

  Map<String, dynamic> toJson() => {
        "firstname_TH": firstnameTh,
        "lastname_TH": lastnameTh,
        "email": email,
        "idEmployees": idEmployees,
      };
}
