import 'package:equatable/equatable.dart';

class ListItemEntity extends Equatable {
  final int id;
  final String title;
  final DateTime date;

  const ListItemEntity({required this.id, required this.title, required this.date});

  @override
  List<Object?> get props => [id, title, date];
}