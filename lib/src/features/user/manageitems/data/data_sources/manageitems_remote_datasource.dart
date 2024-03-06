import 'package:uni_expense/src/core/constant/network_api.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/storage/secure_storage.dart';
import '../models/manageitems_model.dart';
import 'package:http/http.dart' as http;

abstract class ManageItemsRemoteDatasource {
  Future<ManageItemsModel> getManageItems();
}

class ManageItemsRemoteDatasourceImpl implements ManageItemsRemoteDatasource {
  final http.Client client;
  ManageItemsRemoteDatasourceImpl({required this.client});
  @override
  Future<ManageItemsModel> getManageItems() async {
    final response = await client.get(
        Uri.parse(
          "${NetworkAPI.baseURL}/api/expense",
        ),
        headers: {'x-access-token': '${await LoginStorage.readToken()}'});
    if (response.statusCode == 200) {
      // print(response.body);
      return manageItemsModelFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }
}
