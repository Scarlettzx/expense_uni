import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart ' as http;
import 'package:http_parser/http_parser.dart';
// import 'package:intl/intl.dart';
import 'package:uni_expense/src/features/user/fare/data/models/response_editdraft_fare_model.dart';
import '../../../../../core/constant/network_api.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/storage/secure_storage.dart';
import '../models/add_fare_model.dart';
import '../models/edit_draft_fare_model.dart';
import '../models/employeesallroles_model.dart';
import '../models/getfarebyid_model.dart';
import '../models/response_fare_model.dart';

abstract class FareRemoteDatasource {
  Future<List<EmployeesAllRolesModel>> getEmployeesAllRoles();
  Future<ResponseFareModel> addExpenseFare(
      int idEmployees, AddFareModel formData);
  Future<GetFareByIdModel> getFareById(int idExpense);
  Future<ResponseEditDraftFareModel> updateFare(
      int idEmployees, EditDraftFareModel data);
}

class FareRemoteDatasourceImpl implements FareRemoteDatasource {
  final http.Client client;

  FareRemoteDatasourceImpl({required this.client});
  @override
  Future<List<EmployeesAllRolesModel>> getEmployeesAllRoles() async {
    final response = await client.get(
      Uri.parse(
        "${NetworkAPI.baseURL}/api/employees-allRoles",
      ),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      // print(response.body);
      return employeesAllRolesModelFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }

  @override
  Future<ResponseFareModel> addExpenseFare(
      int idEmployees, AddFareModel formData) async {
    // Construct the API endpoint URL
    final Uri url =
        Uri.parse('${NetworkAPI.baseURL}/api/expense/mileage/$idEmployees');
    try {
      var request = http.MultipartRequest('POST', url);
      print('before: ${request.toString()}');
      request.fields['nameExpense'] = formData.nameExpense!;
      request.fields['listExpense'] = jsonEncode(formData.listExpense);
      request.fields['remark'] = formData.remark!;
      request.fields['typeExpense'] = formData.typeExpense!.toString();
      request.fields['typeExpenseName'] = formData.typeExpenseName!;
      request.fields['lastUpdateDate'] = formData.lastUpdateDate!;
      request.fields['status'] = formData.status!.toString();
      request.fields['totalDistance'] = formData.totalDistance!.toString();
      request.fields['personalDistance'] =
          formData.personalDistance!.toString();
      request.fields['netDistance'] = formData.netDistance!.toString();
      request.fields['netDistance'] = formData.netDistance!.toString();
      request.fields['net'] = formData.net!.toString();
      request.fields['idEmpApprover'] = formData.idEmpApprover!.toString();
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
        return responseFareModelFromJson(response.body);
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
  Future<GetFareByIdModel> getFareById(int idExpense) async {
    final response = await client.get(
      Uri.parse(
        "${NetworkAPI.baseURL}/api/expenseById/mileage/$idExpense",
      ),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      print('asasdasdas');
      return getFareByIdModelFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }

  @override
  Future<ResponseEditDraftFareModel> updateFare(
      int idEmployees, EditDraftFareModel data) async {
    print(data);
    final Uri url = Uri.parse(
      "${NetworkAPI.baseURL}/api/expense/mileage/$idEmployees/update",
    );
    try {
      var request = http.MultipartRequest('PUT', url);

      request.fields['nameExpense'] = data.nameExpense!;
      request.fields['idExpense'] = data.idExpense.toString();
      request.fields['idExpenseMileage'] = data.idExpenseMileage.toString();
      request.fields['documentId'] = data.documentId!;
      request.fields['listExpense'] = jsonEncode(data.listExpense!);
      request.fields['remark'] = data.remark!;
      request.fields['typeExpense'] = data.typeExpense!.toString();
      request.fields['typeExpenseName'] = data.typeExpenseName!;
      request.fields['lastUpdateDate'] = data.lastUpdateDate!;
      request.fields['status'] = data.status!.toString();
      request.fields['totalDistance'] = data.totalDistance!.toString();
      request.fields['personalDistance'] = data.personalDistance!.toString();
      request.fields['netDistance'] = data.netDistance!.toString();
      request.fields['net'] = data.net!.toString();
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
        return responseEditDraftFareModelFromJson(response.body);
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
