import 'package:rrms/_all.dart';

abstract class ChatsRepository {
  Future<Result<List<ChatGroupResponseModel>>> getChatGroups();
  Future<Result<ChatMessagesResponseModel>> getChatMessages(ChatMessagesSearchRequestModel searchModel);
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
      parser: (data) => data.map<ChatGroupResponseModel>((x) => ChatGroupResponseModel.fromJson(x)).toList(),
    );

    return result;
  }

  @override
  Future<Result<ChatMessagesResponseModel>> getChatMessages(ChatMessagesSearchRequestModel searchModel) async {
    final result = await restApiClient.get<ChatMessagesResponseModel>(
      '/api/chat/chat-messages',
      queryParameters: searchModel.toJson(),
      parser: (data) => ChatMessagesResponseModel.fromJson(data),
    );

    return result;
  }
}
