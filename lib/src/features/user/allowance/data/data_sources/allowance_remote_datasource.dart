import 'dart:convert';
import 'dart:io';
// import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:uni_expense/src/features/user/allowance/data/models/addexpenseallowance_model.dart';
import 'package:uni_expense/src/features/user/allowance/data/models/edit_draft_allowance_model.dart';
import 'package:uni_expense/src/features/user/allowance/data/models/employeesallroles_model.dart';
import 'package:http/http.dart' as http;
import 'package:uni_expense/src/features/user/allowance/data/models/response_allowance_model.dart';
import '../../../../../core/constant/network_api.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/storage/secure_storage.dart';
import '../models/delete_expenseallowance_model.dart';
import '../models/getallowancebyid_model.dart';
import '../models/response_dodelete.dart';
import '../models/response_editdraft_allowance.dart';

abstract class AllowanceRemoteDatasource {
  Future<List<EmployeesAllRolesModel>> getEmployeesAllRoles();
  Future<ResponseAllowanceModel> addExpenseAllowance(
      int idCompany, AddExpenseAllowanceModel formData);
  Future<GetExpenseAllowanceByIdModel> getExpenseAllowanceById(int idExpense);
  Future<ResponseDoDeleteAllowanceModel> deleteExpenseAllowance(
      int idEmp, DeleteExpenseAllowanceModel data);
  Future<ResponseEditDraftAllowanceModel> updateExpenseAllowance(
      int idEmp, EditDraftAllowanceModel data);
}

class AllowanceRemoteDatasourceImpl implements AllowanceRemoteDatasource {
  final http.Client client;
  AllowanceRemoteDatasourceImpl({required this.client});
  @override
  Future<List<EmployeesAllRolesModel>> getEmployeesAllRoles() async {
    final response = await client.get(
      Uri.parse(
        "${NetworkAPI.baseURL}/api/employees-allRoles",
      ),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      return employeesAllRolesModelFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }

  @override
  Future<ResponseAllowanceModel> addExpenseAllowance(
    int idCompany,
    AddExpenseAllowanceModel formData,
  ) async {
    // Construct the API endpoint URL
    final Uri url =
        Uri.parse('${NetworkAPI.baseURL}/api/expense/allowance/$idCompany');
    print(jsonEncode(formData.listExpense));
    try {
      // Create a multipart/form-data request
      var request = http.MultipartRequest('POST', url);
      print('before: ${request.toString()}');
      // Add fields to the request
      // These are the parameters that will be sent as part of the request
      request.fields['nameExpense'] = formData.nameExpense!;
      request.fields['isInternational'] = formData.isInternational!.toString();
      request.fields['listExpense'] = jsonEncode(formData.listExpense);
      request.fields['remark'] = formData.remark!;
      request.fields['typeExpense'] = formData.typeExpense!.toString();
      request.fields['typeExpenseName'] = formData.typeExpenseName!;
      request.fields['lastUpdateDate'] =
          DateFormat("yyyy/MM/dd HH:mm").format(formData.lastUpdateDate!);
      request.fields['status'] = formData.status!.toString();
      request.fields['sumAllowance'] = formData.sumAllowance!.toString();
      request.fields['sumSurplus'] = formData.sumSurplus!.toString();
      request.fields['sumNet'] = formData.sumNet!.toString();
      request.fields['sumDays'] = formData.sumDays!.toString();
      request.fields['idEmpApprover'] = formData.idEmpApprover!.toString();
      request.fields['idPosition'] = formData.idPosition!.toString();

      // Convert ccEmail list to JSON and add it as a field
      request.fields['cc_email'] = jsonEncode(formData.ccEmail!);

      // Add the file (if any) to the request
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

      // Add headers to the request
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
        return responseAllowanceModelFromJson(response.body);
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

// // Convert a list of emails to a JSON string
//   String convertEmailsToJson(List<dynamic> emails) {
//     print(jsonEncode(emails.join(';')));
//     return emails.isNotEmpty ? jsonEncode(emails.join(';')) : "";
//   }

  @override
  Future<GetExpenseAllowanceByIdModel> getExpenseAllowanceById(
      int idExpense) async {
    final response = await client.get(
      Uri.parse(
        "${NetworkAPI.baseURL}/api/expenseById/allowance/$idExpense",
      ),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      return getExpenseAllowanceByIdModelFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }

  @override
  Future<ResponseDoDeleteAllowanceModel> deleteExpenseAllowance(
      int idEmp, DeleteExpenseAllowanceModel data) async {
    print(data);
    print(data.idExpense);
    final response = await client.put(
        Uri.parse(
          "${NetworkAPI.baseURL}/api/expense/allowance/$idEmp/delete",
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-access-token": "${await LoginStorage.readToken()}"
        },
        body: jsonEncode({
          "filePath": data.filePath,
          "idExpense": data.idExpense,
          "idExpenseAllowance": data.idExpenseAllowance,
          "isAttachFile": data.isAttachFile,
          "listExpense": data.listExpense
        }));
    // print(json.decode(response));
    if (response.statusCode == 200) {
      print(response.body);
      print(response.statusCode);
      print(response.request);
      print(response.headers);
      print(response.reasonPhrase);
      return responseDoDeleteAllowanceModelFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }

  @override
  Future<ResponseEditDraftAllowanceModel> updateExpenseAllowance(
      int idEmp, EditDraftAllowanceModel data) async {
    final Uri url = Uri.parse(
      "${NetworkAPI.baseURL}/api/expense/allowance/$idEmp/update",
    );
    try {
      var request = http.MultipartRequest('PUT', url);

      request.fields['nameExpense'] = data.nameExpense!;
      request.fields['idExpense'] = data.idExpense.toString();
      request.fields['idExpenseAllowance'] = data.idExpenseAllowance.toString();
      request.fields['documentId'] = data.documentId!;
      request.fields['isInternational'] = data.isInternational!.toString();
      request.fields['listExpense'] = jsonEncode(data.listExpense!);
      request.fields['remark'] = data.remark!;
      request.fields['typeExpense'] = data.typeExpense!.toString();
      request.fields['typeExpenseName'] = data.typeExpenseName!;
      request.fields['lastUpdateDate'] = data.lastUpdateDate!;
      request.fields['status'] = data.status!.toString();
      request.fields['sumAllowance'] = data.sumAllowance!.toString();
      request.fields['sumSurplus'] = data.sumSurplus!.toString();
      request.fields['sumDays'] = data.sumDays!.toString();
      request.fields['sumNet'] = data.sumNet!.toString();
      request.fields['comment'] = data.comment!.toString();
      request.fields['deletedItem'] = data.deletedItem!.toString();
      request.fields['idEmpApprover'] = data.idEmpApprover!.toString();
      if (data.file != null) {
        var file = File(data.file!.path!);
        var fileBytes = await file.readAsBytes();

        // Create a stream from the file bytes
        var stream = Stream.fromIterable([fileBytes]);

        // Add the file to the request
        request.files.add(http.MultipartFile(
          'file',
          stream,
          fileBytes.length,
          filename: data.file!.name,
          contentType: MediaType(
              'image', data.file!.path!.split(".").last), // Adjust content type
        ));
      }
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'x-access-token': await LoginStorage.readToken(),
      });
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print('after: ${request.fields}');
      print('after: ${request.files}');
      print('after: ${request.headers}');
      print('after: ${request.method}');
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        print(response.statusCode);
        print(response.request);
        print(response.headers);
        print(response.reasonPhrase);
        return responseEditDraftAllowanceModelFromJson(response.body);
      } else {
        throw ServerException(message: "Server error occurred");
      }
    } catch (e) {
      // Handle errors
      print('An error occurred: ${e.toString()}');
      rethrow;
    }
  }
}
