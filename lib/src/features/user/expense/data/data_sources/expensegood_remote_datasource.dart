import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:uni_expense/src/core/constant/network_api.dart';
import 'package:uni_expense/src/features/user/expense/data/models/addexpensegood_model.dart';
import 'package:uni_expense/src/features/user/expense/data/models/employeesallroles_model.dart';
import 'package:uni_expense/src/features/user/expense/data/models/getexpensegoodbyid_model.dart';
import 'package:uni_expense/src/features/user/expense/data/models/response_addexpensegood_model.dart';
// import 'package:uni_expense/src/features/user/expense/domain/entities/employees_allroles.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/storage/secure_storage.dart';
import '../models/delete_expensegood_model.dart';
import '../models/editdraft_expensegood_model.dart';
import '../models/employeesroleadmin_model.dart';
import '../models/response_dodelete_expensegood_model.dart';
import '../models/response_editdraft_expensegood_model.dart';

abstract class ExpenseGoodRemoteDatasource {
  Future<List<EmployeesAllRolesModel>> getEmployeesAllRoles();
  Future<List<EmployeesRoleAdminModel>> getEmployeesRoleAdmin();
  Future<ResponseAddExpenseGoodModel> addExpenseGood(
      int idEmployees, AddExpenseGoodModel formData);
  Future<GetExpenseGoodByIdModel> getExpenseById(int idExpense);
  Future<ResponseEditDraftExpenseGoodModel> updateExpenseGood(
      int idEmployees, EditDraftExpenseGoodModel data);
  Future<ResponseDoDeleteExpenseGoodModel> deleteExpense(
      int idEmp, DeleteDraftExpenseGoodModel data);
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

  @override
  Future<ResponseAddExpenseGoodModel> addExpenseGood(
      int idEmployees, AddExpenseGoodModel formData) async {
    final Uri url =
        Uri.parse('${NetworkAPI.baseURL}/api/expense/general/$idEmployees');
    try {
      var request = http.MultipartRequest('POST', url);
      print('before: ${request.toString()}');
      request.fields['nameExpense'] = formData.nameExpense!;
      request.fields['isInternational'] = formData.isInternational!.toString();
      request.fields['isVatIncluded'] = formData.isVatIncluded!.toString();
      request.fields['currency'] = formData.currency!.toString();
      request.fields['currencyItem'] = formData.currencyItem!.toString();
      request.fields['currencyRate'] = formData.currencyRate!.toString();
      request.fields['listExpense'] = jsonEncode(formData.listExpense);
      request.fields['remark'] = formData.remark!;
      request.fields['typeExpense'] = formData.typeExpense!.toString();
      request.fields['typeExpenseName'] = formData.typeExpenseName!;
      request.fields['lastUpdateDate'] = formData.lastUpdateDate!;
      request.fields['status'] = formData.status!.toString();
      request.fields['total'] = formData.total!.toString();
      request.fields['vat'] = formData.vat!.toString();
      request.fields['withholding'] = formData.withholding!.toString();
      request.fields['net'] = formData.net!.toString();
      request.fields['idEmpApprover'] = formData.idEmpApprover!.toString();
      request.fields['idEmpReviewer'] = formData.idEmpReviewer!.toString();
      request.fields['idPosition'] = formData.idPosition!.toString();
      request.fields['cc_email'] = jsonEncode(formData.ccEmail);
      if (formData.file != null) {
        var file = File(formData.file!.path!);
        var fileBytes = await file.readAsBytes();
        var stream = Stream.fromIterable([fileBytes]);
        request.files.add(http.MultipartFile(
          'file',
          stream,
          fileBytes.length,
          filename: formData.file!.name,
          contentType: MediaType('image',
              formData.file!.path!.split(".").last), // Adjust content type
        ));
      }
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'x-access-token': await LoginStorage.readToken(),
      });
      // Send the request and get the response
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print('after: ${request.fields}');
      print('after: ${request.files}');
      print('after: ${request.headers}');
      print('after: ${request.method}');
      // print('after: ${request.}');
      print(response.statusCode);
      // Check the response status code
      if (response.statusCode == 200) {
        print(response.body);
        return responseAddExpenseGoodModelFromJson(response.body);
      } else {
        // If the response status code is not 200, throw an exception
        throw ServerException(message: "Server error occurred");
      }
    } catch (e) {
      // Handle errors
      print('An error occurred: ${e.toString()}');
      rethrow; // Re-throw the exception
    }
  }

  @override
  Future<GetExpenseGoodByIdModel> getExpenseById(int idExpense) async {
    final response = await client.get(
      Uri.parse(
        "${NetworkAPI.baseURL}/api/expenseById/general/$idExpense",
      ),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      print('getExpensebyId');
      print(response.body);
      return getExpenseGoodByIdModelFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }

  @override
  Future<ResponseEditDraftExpenseGoodModel> updateExpenseGood(
      int idEmployees, EditDraftExpenseGoodModel formData) async {
    final Uri url = Uri.parse(
      "${NetworkAPI.baseURL}/api/expense/general/$idEmployees/update",
    );
    try {
      var request = http.MultipartRequest('PUT', url);
      request.fields['idExpense'] = formData.idExpense.toString();
      request.fields['idExpenseGoods'] = formData.idExpenseGoods.toString();
      request.fields['documentId'] = formData.documentId!;
      request.fields['nameExpense'] = formData.nameExpense!;
      request.fields['isInternational'] = formData.isInternational!.toString();
      request.fields['isVatIncluded'] = formData.isVatIncluded!.toString();
      request.fields['currency'] = formData.currency!.toString();
      request.fields['currencyItem'] = formData.currencyItem!.toString();
      request.fields['currencyRate'] = formData.currencyRate!.toString();
      request.fields['listExpense'] = jsonEncode(formData.listExpense);
      request.fields['remark'] = formData.remark!;
      request.fields['typeExpense'] = formData.typeExpense!.toString();
      request.fields['typeExpenseName'] = formData.typeExpenseName!;
      request.fields['lastUpdateDate'] = formData.lastUpdateDate!;
      request.fields['status'] = formData.status!.toString();
      request.fields['total'] = formData.total!.toString();
      request.fields['vat'] = formData.vat!.toString();
      request.fields['withholding'] = formData.withholding!.toString();
      request.fields['net'] = formData.net!.toString();
      request.fields['idEmpApprover'] = formData.idEmpApprover!.toString();
      request.fields['idEmpReviewer'] = formData.idEmpReviewer!.toString();
      request.fields['comment'] = jsonEncode(formData.comment);
      request.fields['deletedItem'] = jsonEncode(formData.deletedItem);
      if (formData.file != null) {
        var file = File(formData.file!.path!);
        var fileBytes = await file.readAsBytes();

        // Create a stream from the file bytes
        var stream = Stream.fromIterable([fileBytes]);

        // Add the file to the request
        request.files.add(http.MultipartFile(
          'file',
          stream,
          fileBytes.length,
          filename: formData.file!.name,
          contentType: MediaType('image',
              formData.file!.path!.split(".").last), // Adjust content type
        ));
      }
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'x-access-token': await LoginStorage.readToken(),
      });
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      // print('after: ${request.fields}');
      // print('after: ${request.files}');
      // print('after: ${request.headers}');
      // print('after: ${request.method}');
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('update');
        print(response.body);
        // print(response.statusCode);
        // print(response.request);
        // print(response.headers);
        // print(response.reasonPhrase);
        return responseEditDraftExpenseGoodModelFromJson(response.body);
      } else {
        throw ServerException(message: "Server error occurred");
      }
    } catch (e) {
      // Handle errors
      print('An error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<ResponseDoDeleteExpenseGoodModel> deleteExpense(
      int idEmp, DeleteDraftExpenseGoodModel data) async {
    final response = await client.put(
        Uri.parse(
          "${NetworkAPI.baseURL}/api/expense/general/$idEmp/delete",
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-access-token": "${await LoginStorage.readToken()}"
        },
        body: jsonEncode({
          "filePath": data.filePath,
          "idExpense": data.idExpense,
          "idExpenseGoods": data.idExpenseGoods,
          "isAttachFile": data.isAttachFile,
          "listExpense": data.listExpense
        }));
    if (response.statusCode == 200) {
      print(response.body);
      print(response.statusCode);
      print(response.request);
      print(response.headers);
      print(response.reasonPhrase);
      return responseDoDeleteExpenseGoodModelFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }
}
