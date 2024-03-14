import 'package:equatable/equatable.dart';

class ResponseDoDeleteFareEntity extends Equatable {
  final String? status;

  const ResponseDoDeleteFareEntity({
    required this.status,
  });

  @override
  List<Object?> get props => [
        status,
      ];
}
