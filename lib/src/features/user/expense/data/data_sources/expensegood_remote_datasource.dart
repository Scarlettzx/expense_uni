import 'package:http/http.dart' as http;
import 'package:uni_expense/src/core/constant/network_api.dart';
import 'package:uni_expense/src/features/user/expense/data/models/employeesallroles_model.dart';
// import 'package:uni_expense/src/features/user/expense/domain/entities/employees_allroles.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/storage/secure_storage.dart';
import '../models/employeesroleadmin_model.dart';

abstract class ExpenseGoodRemoteDatasource {
  Future<List<EmployeesAllRolesModel>> getEmployeesAllRoles();
  Future<List<EmployeesRoleAdminModel>> getEmployeesRoleAdmin();
}

class ExpenseGoodRemoteDatasourceImpl implements ExpenseGoodRemoteDatasource {
  final http.Client client;
  ExpenseGoodRemoteDatasourceImpl({required this.client});

  @override
  Future<List<EmployeesAllRolesModel>> getEmployeesAllRoles() async {
    final response = await client.get(
      Uri.parse(
        "${NetworkAPI.baseURL}/api/employees-allRoles",
      ),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      return employeesAllRolesModelFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }

  @override
  Future<List<EmployeesRoleAdminModel>> getEmployeesRoleAdmin() async {
    final response = await client.get(
      Uri.parse(
        "${NetworkAPI.baseURL}/api/employees-roleAdmin",
      ),
      headers: {
        'x-access-token': '${await LoginStorage.readToken()}',
      },
    );
    if (response.statusCode == 200) {
      return employeesRoleAdminFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }
}
