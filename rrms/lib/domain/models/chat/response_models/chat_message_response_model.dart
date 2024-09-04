import 'package:rrms/_all.dart';

class ChatMessageResponseModel {
  final String? message;
  final DateTime? messageDateTimeUtc;
  final bool? isMyMessage;
  final String? profilePhotoUrl;

  ChatMessageResponseModel({
    this.message,
    this.messageDateTimeUtc,
    this.isMyMessage,
    this.profilePhotoUrl,
  });

  factory ChatMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageResponseModel(
      message: json.parseValue('message'),
      messageDateTimeUtc: json.parseDate('messageDateTimeUtc'),
      isMyMessage: json.parseValue('isMyMessage'),
      profilePhotoUrl: json.parseValue('profilePhotoUrl'),
    );
  }
}
