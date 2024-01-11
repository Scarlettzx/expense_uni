import 'package:equatable/equatable.dart';

class EmployeeRoleAdminEntity extends Equatable {
  final String? firstnameTh;
  final String? lastnameTh;
  final String? email;
  final int? idEmployees;

  const EmployeeRoleAdminEntity(
      {required this.firstnameTh,
      required this.lastnameTh,
      required this.email,
      required this.idEmployees});
  @override
  List<Object?> get props => [
        firstnameTh,
        lastnameTh,
        email,
        idEmployees,
      ];
}
