import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'src/core/features/user/data/datasource/remote/profile_remote_data_source.dart';
import 'src/core/features/user/data/repository/profile_repository_impl.dart';
import 'src/core/features/user/domain/usecase/get_profile.dart';
import 'src/core/features/user/presentation/provider/profile_provider.dart';

class Injection extends StatelessWidget {
  final Widget? router;
  const Injection({super.key, this.router});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          // * Profile
          ChangeNotifierProvider(
              create: (context) => ProfileProvider(
                  getProfile: GetProfile(
                      repository: ProfileRepositoryImpl(
                          remoteDataSource: ProfileRemoteDataSourceImpl(
                              client: http.Client()))))),
        ],
        child: router,
      );
}
