import 'package:equatable/equatable.dart';

class ResponseDoDeleteAllowanceEntity extends Equatable {
  final String? status;

  const ResponseDoDeleteAllowanceEntity({
    required this.status,
  });

  @override
  List<Object?> get props => [
        status,
      ];
}
