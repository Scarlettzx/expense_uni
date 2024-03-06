import 'package:equatable/equatable.dart';

class ResponseDoDeleteWelfareEntity extends Equatable {
  final String? status;

  const ResponseDoDeleteWelfareEntity({
    required this.status,
  });

  @override
  List<Object?> get props => [
        status,
      ];
}
