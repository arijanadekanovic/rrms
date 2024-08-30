import 'package:rrms/_all.dart';

class ChatGroupResponseModel {
  final int? residenceId;
  final String? chatPartnerId;
  final String? chatPartnerProfilePictureUrl;
  final String? chatPartnerName;
  final String? lastMessage;
  final DateTime? lastMessageDateTime;
  final bool? seen;

  ChatGroupResponseModel({
    this.residenceId,
    this.chatPartnerId,
    this.chatPartnerProfilePictureUrl,
    this.chatPartnerName,
    this.lastMessage,
    this.lastMessageDateTime,
    this.seen,
  });

  factory ChatGroupResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatGroupResponseModel(
      residenceId: json.parseValue('residenceId'),
      chatPartnerId: json.parseValue('chatPartnerId'),
      chatPartnerProfilePictureUrl: json.parseValue('chatPartnerProfilePictureUrl'),
      chatPartnerName: json.parseValue('chatPartnerName'),
      lastMessage: json.parseValue('lastMessage'),
      lastMessageDateTime: json.parseDate('lastMessageDateTimeUtc'),
      seen: json.parseValue('seen'),
    );
  }
}
