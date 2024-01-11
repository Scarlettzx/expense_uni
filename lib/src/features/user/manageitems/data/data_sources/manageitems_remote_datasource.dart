import 'package:uni_expense/src/core/constant/network_api.dart';

import '../../../../../core/error/exception.dart';
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
        headers: {
          'x-access-token':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZEVtcGxveWVlcyI6MiwiaWRDb21wYW55IjoxLCJpZFJvbGUiOjEsImlhdCI6MTcwNDI1MDA4MCwiZXhwIjoxNzA2ODQyMDgwfQ.nufqQZx9P2BUJveKlEBVPAyiqhXPeG6_0x2RfvnT8hc'
        });
    if (response.statusCode == 200) {
      // print(response.body);
      return manageItemsModelFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }
}
