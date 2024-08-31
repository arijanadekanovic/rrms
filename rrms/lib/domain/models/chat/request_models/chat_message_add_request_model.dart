class ChatMessageAddRequestModel {
  final String? chatPartnerId;
  String? messageText;
  final int? residenceId;

  ChatMessageAddRequestModel({
    this.chatPartnerId,
    this.messageText,
    this.residenceId,
  });

  ChatMessageAddRequestModel copyWith({
    String? chatPartnerId,
    String? messageText,
    int? residenceId,
  }) {
    return ChatMessageAddRequestModel(
      chatPartnerId: chatPartnerId ?? this.chatPartnerId,
      messageText: messageText ?? this.messageText,
      residenceId: residenceId ?? this.residenceId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (chatPartnerId != null) 'chatPartnerId': chatPartnerId,
      if (messageText != null) 'messageText': messageText,
      if (residenceId != null) 'residenceId': residenceId,
    };
  }
}
