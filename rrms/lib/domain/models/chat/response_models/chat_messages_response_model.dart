import 'package:rrms/_all.dart';

class ChatMessagesResponseModel {
  final int? residenceId;
  final String? chatPartnerId;
  final String? chatPartnerProfilePictureUrl;
  final String? chatPartnerName;
  final List<ChatMessageResponseModel>? chatMessages;

  ChatMessagesResponseModel({
    this.residenceId,
    this.chatPartnerId,
    this.chatPartnerProfilePictureUrl,
    this.chatPartnerName,
    this.chatMessages,
  });

  factory ChatMessagesResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatMessagesResponseModel(
      residenceId: json.parseValue('residenceId'),
      chatPartnerId: json.parseValue('chatPartnerId'),
      chatPartnerProfilePictureUrl: json.parseValue('chatPartnerProfilePictureUrl'),
      chatPartnerName: json.parseValue('chatPartnerName'),
      chatMessages: json.parseList('chatMessages', (x) => ChatMessageResponseModel.fromJson(x)),
    );
  }
}
