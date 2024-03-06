import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart ' as http;
import 'package:intl/intl.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/edit_draft_welfare_model.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/familys_model.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/reponse_add_welfare_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/response_dodelete_model.dart';
import '../../../../../core/constant/network_api.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/storage/secure_storage.dart';
import '../models/add_welfare_model.dart';
import '../models/delete_welfare_model.dart';
import '../models/employeesallroles_model.dart';
import '../models/getwelfarebyid_model.dart';
import '../models/response_edit_welfare.dart';

abstract class WelfareRemoteDatasource {
  Future<List<FamilysModel>> getFamilys(int idEmployees);
  Future<List<EmployeesAllRolesModel>> getEmployeesAllRoles();
  Future<ResponseWelfareModel> addWelfare(
      int idEmployees, AddWelfareModel formdata);
  Future<GetWelFarebyIdModel> getWelfareById(int idExpense);
  Future<ResponseEditWelfareModel> updateWelfare(
      int idEmployees, EditWelfareModel data);
  Future<ResponseDoDeleteWelfareModel> deleteWelfare(
      int idEmployees, DeleteWelfareModel data);
}

class WelfareRemoteDatasourceImpl implements WelfareRemoteDatasource {
  final http.Client client;
  WelfareRemoteDatasourceImpl({required this.client});
  @override
  Future<List<FamilysModel>> getFamilys(int idEmployees) async {
    final response = await client.get(
      Uri.parse(
        "${NetworkAPI.baseURL}/api/family/$idEmployees",
      ),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      return familysModelFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }

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
  Future<ResponseWelfareModel> addWelfare(
      int idEmployees, AddWelfareModel formData) async {
    final Uri url =
        Uri.parse('${NetworkAPI.baseURL}/api/expense/welfare/$idEmployees');
    print(jsonEncode(formData.listExpense));
    try {
      // Create a multipart/form-data request
      var request = http.MultipartRequest('POST', url);
      print('before: ${request.toString()}');
      // Add fields to the request
      // These are the parameters that will be sent as part of the request
      request.fields['nameExpense'] = formData.nameExpense!;
      request.fields['listExpense'] = jsonEncode(formData.listExpense);
      request.fields['location'] = formData.location!;
      request.fields['documentDate'] = formData.documentDate!;
      request.fields['type'] = formData.type!;
      request.fields['remark'] = formData.remark!;
      request.fields['typeExpense'] = formData.typeExpense!.toString();
      request.fields['typeExpenseName'] = formData.typeExpenseName!;
      request.fields['lastUpdateDate'] = formData.lastUpdateDate!;
      request.fields['status'] = formData.status!.toString();
      request.fields['total'] = formData.total!.toString();
      request.fields['net'] = formData.net!.toString();
      request.fields['idFamily'] = formData.idFamily!.toString();
      request.fields['isUseForFamilyMember'] =
          formData.isUseForFamilyMember!.toString();
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
        return responseWelfareModelFromJson(response.body);
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
  Future<GetWelFarebyIdModel> getWelfareById(int idExpense) async {
    final response = await client.get(
      Uri.parse(
        "${NetworkAPI.baseURL}/api/expenseById/welfare/$idExpense",
      ),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      return getWelFarebyIdModelFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }

  @override
  Future<ResponseEditWelfareModel> updateWelfare(
      int idEmployees, EditWelfareModel data) async {
    final Uri url = Uri.parse(
      "${NetworkAPI.baseURL}/api/expense/welfare/$idEmployees/update",
    );
    try {
      var request = http.MultipartRequest('PUT', url);

      request.fields['nameExpense'] = data.nameExpense!;
      request.fields['idExpense'] = data.idExpense.toString();
      request.fields['idExpenseWelfare'] = data.idExpenseWelfare.toString();
      request.fields['documentId'] = data.documentId!;
      request.fields['listExpense'] = jsonEncode(data.listExpense!);
      request.fields['location'] = data.location!.toString();
      request.fields['documentDate'] = data.documentDate!.toString();
      request.fields['documentDate'] = data.documentDate!.toString();
      request.fields['type'] = data.type!;
      request.fields['typeExpense'] = data.typeExpense!.toString();
      request.fields['typeExpenseName'] = data.typeExpenseName!;
      request.fields['lastUpdateDate'] = data.lastUpdateDate!;
      request.fields['status'] = data.status!.toString();
      request.fields['total'] = data.total!.toString();
      request.fields['net'] = data.net!.toString();
      request.fields['idFamily'] = data.idFamily!.toString();
      request.fields['isUseForFamilyMember'] =
          data.isUseForFamilyMember!.toString();
      request.fields['comment'] = jsonEncode(data.comment);
      request.fields['deletedItem'] = jsonEncode(data.deletedItem);
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
        return responseEditWelfareModelFromJson(response.body);
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
  Future<ResponseDoDeleteWelfareModel> deleteWelfare(
      int idEmployees, DeleteWelfareModel data) async {
    final response = await client.put(
        Uri.parse(
          "${NetworkAPI.baseURL}/api/expense/welfare/$idEmployees/delete",
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-access-token": "${await LoginStorage.readToken()}"
        },
        body: jsonEncode({
          "filePath": data.filePath,
          "idExpense": data.idExpense,
          "idExpenseWelfare": data.idExpenseWelfare,
          "isAttachFile": data.isAttachFile,
          "listExpense": data.listExpense
        }));
    if (response.statusCode == 200) {
      print(response.body);
      print(response.statusCode);
      print(response.request);
      print(response.headers);
      print(response.reasonPhrase);
      return responseDoDeleteWelfareModelFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }
}
