import 'package:equatable/equatable.dart';

class ResponseDoDeleteExpenseGoodEntity extends Equatable {
  final String? status;

  const ResponseDoDeleteExpenseGoodEntity({
    required this.status,
  });

  @override
  List<Object?> get props => [
        status,
      ];
}
