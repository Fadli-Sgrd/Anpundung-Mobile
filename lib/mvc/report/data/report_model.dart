import 'package:equatable/equatable.dart';

class ReportModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String location;
  final String status; // Pending, Processed, Done
  final String category;

  const ReportModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    this.status = 'Pending',
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      category: json['category'] ?? 'Lainnya',
      status: json['status'] ?? 'Pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'category': category,
      'status': status,
    };
  }

  @override
  List<Object> get props => [
    id,
    title,
    description,
    location,
    category,
    status,
  ];
}
