class ChatMessagesSearchRequestModel {
  final int? residenceId;
  final String? chatPartnerId;

  ChatMessagesSearchRequestModel({
    this.residenceId,
    this.chatPartnerId,
  });

  ChatMessagesSearchRequestModel copyWith({
    int? residenceId,
    String? chatPartnerId,
  }) {
    return ChatMessagesSearchRequestModel(
      residenceId: residenceId ?? this.residenceId,
      chatPartnerId: chatPartnerId ?? this.chatPartnerId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if(residenceId != null) 'residenceId': residenceId,
      if(chatPartnerId != null) 'chatPartnerId': chatPartnerId,
    };
  }
}
