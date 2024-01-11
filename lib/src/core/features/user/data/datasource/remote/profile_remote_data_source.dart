
import 'package:http/http.dart' as http;

import '../../../../../constant/network_api.dart';
import '../../../../../error/exception.dart';
import '../../../../../storage/secure_storage.dart';
import '../../model/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;

  ProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<ProfileModel> getProfile() async {
    final response = await client.get(
      Uri.parse("${NetworkAPI.baseURL}/api/profile"),
      headers: {'x-access-token': '${await LoginStorage.readToken()}'},
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      print('test');
      print(response.body);
      return profileFromJson(response.body);
    } else {
      throw ServerException(message: "Server error occurred");
    }
  }
}
