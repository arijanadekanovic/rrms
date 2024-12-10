import 'package:rrms/_all.dart';

abstract class ChatsRepository {
  Future<Result<List<ChatGroupResponseModel>>> getChatGroups();
  Future<Result<ChatMessagesResponseModel>> getChatMessages(ChatMessagesSearchRequestModel searchModel);
  Future<Result> addChatMessage(ChatMessageAddRequestModel model);
}

class ChatsRepositoryImpl implements ChatsRepository {
  final RestApiClient restApiClient;

  ChatsRepositoryImpl({
    required this.restApiClient,
  });

  @override
  Future<Result<List<ChatGroupResponseModel>>> getChatGroups() async {
    final result = await restApiClient.get<List<ChatGroupResponseModel>>(
      '/api/chat/chat-groups',
      onSuccess: (data) => data.map<ChatGroupResponseModel>((x) => ChatGroupResponseModel.fromJson(x)).toList(),
    );

    return result;
  }

  @override
  Future<Result<ChatMessagesResponseModel>> getChatMessages(ChatMessagesSearchRequestModel searchModel) async {
    final result = await restApiClient.get<ChatMessagesResponseModel>(
      '/api/chat/chat-messages',
      queryParameters: searchModel.toJson(),
      onSuccess: (data) => ChatMessagesResponseModel.fromJson(data),
    );

    return result;
  }

  @override
  Future<Result> addChatMessage(ChatMessageAddRequestModel model) async {
    final result = await restApiClient.post(
      '/api/chat/add',
      data: model.toJson(),
    );

    return result;
  }
}
