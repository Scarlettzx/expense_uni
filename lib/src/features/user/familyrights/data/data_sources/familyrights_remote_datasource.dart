import 'package:http/http.dart' as http;
import 'package:uni_expense/src/features/user/familyrights/data/models/get_allrightsemployeefamily_model.dart';

import '../../../../../core/constant/network_api.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/storage/secure_storage.dart';

abstract class FamilyRightsRemoteDataSource {
  Future<List<GetAllRightsEmployeeFamilyModel>> getAllrightsEmployeeFamily(
      int idEmployees);
}

class FamilyRightsRemoteDataSourceImpl implements FamilyRightsRemoteDataSource {
  final http.Client client;

  FamilyRightsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<GetAllRightsEmployeeFamilyModel>> getAllrightsEmployeeFamily(
      int idEmployees) async {
    final response = await client.get(
      Uri.parse(
        "${NetworkAPI.baseURL}/api/rightsWelfare/getAllRightsEmployeeFamily/$idEmployees",
      ),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    if (response.statusCode == 200) {
      // print(response.body);
      return getAllRightsEmployeeFamilyModelFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }
}
