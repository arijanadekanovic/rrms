import 'package:rrms/_all.dart';

class NotificationResponseModel {
  final int? id;
  final String? title;
  final String? description;
  final NotificationType? type;

  NotificationResponseModel({
    this.id,
    this.title,
    this.description,
    this.type,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationResponseModel(
      id: json.parseValue('id'),
      title: json.parseValue('title'),
      description: json.parseValue('description'),
      type: json.parseEnum('type', NotificationType.parse),
    );
  }
}
