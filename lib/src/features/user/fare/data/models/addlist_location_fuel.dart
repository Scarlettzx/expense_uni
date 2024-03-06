import 'package:equatable/equatable.dart';

class ListLocationandFuel extends Equatable {
  final String? id;
  final String date;
  final String startLocation;
  final String stopLocation;
  final int startMile;
  final int stopMile;
  final int total;
  final int personal;
  final int net;

  const ListLocationandFuel({
    required this.id,
    required this.date,
    required this.startLocation,
    required this.stopLocation,
    required this.startMile,
    required this.stopMile,
    required this.total,
    required this.personal,
    required this.net,
  });

  ListLocationandFuel copyWith({
    String? date,
    String? startLocation,
    String? stopLocation,
    int? startMile,
    int? stopMile,
    int? total,
    int? personal,
    int? net,
  }) {
    return ListLocationandFuel(
      id: id,
      date: date ?? this.date,
      startLocation: startLocation ?? this.startLocation,
      stopLocation: stopLocation ?? this.stopLocation,
      startMile: startMile ?? this.startMile,
      stopMile: stopMile ?? this.stopMile,
      total: total ?? this.total,
      personal: personal ?? this.personal,
      net: net ?? this.net,
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        startLocation,
        stopLocation,
        startMile,
        stopMile,
        total,
        personal,
        net,
      ];
}
