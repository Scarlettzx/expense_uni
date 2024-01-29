import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart ' as http;
import 'package:intl/intl.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/familys_model.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/reponse_add_welfare_model.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../../core/constant/network_api.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/storage/secure_storage.dart';
import '../models/add_welfare_model.dart';
import '../models/employeesallroles_model.dart';

abstract class WelfareRemoteDatasource {
  Future<List<FamilysModel>> getFamilys(int idEmployees);
  Future<List<EmployeesAllRolesModel>> getEmployeesAllRoles();
  Future<ResponseWelfareModel> addWelfare(
      int idEmployees, AddWelfareModel formdata);
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

  // String convertEmailsToJson(String? ccEmail) {
  //   print(jsonEncode(ccEmail));
  //   return ccEmail ?? "";
  // }
}
