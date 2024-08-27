import 'package:rrms/_all.dart';

abstract class MediaStorageService {
  Future<Result<String>> upload(FileInfo file);
}

class MediaStorageServiceImpl implements MediaStorageService {
  final RestApiClient restApiClient;

  MediaStorageServiceImpl({
    required this.restApiClient,
  });

  @override
  Future<Result<String>> upload(FileInfo fileInfo) async {
    final result = await restApiClient.post<String>(
      '${appSettings.storageApiUrl}/api/storage/upload',
      data: FormData.fromMap(
        {
          'file': await MultipartFile.fromFile(fileInfo.path),
        },
      ),
      parser: (data) => data['url'],
      options: RestApiClientRequestOptions(
        contentType: Headers.multipartFormDataContentType,
      ),
    );

    return result;
  }
}
