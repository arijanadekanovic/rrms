import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum FileInfoType {
  /// The asset is not an image, video, or audio file.
  other,

  /// The asset is an image file.
  image,

  /// The asset is a video file.
  video,

  /// The asset is an audio file.
  audio;

  factory FileInfoType.fromAssetType(AssetType assetType) {
    return switch (assetType) {
      AssetType.other => FileInfoType.other,
      AssetType.image => FileInfoType.image,
      AssetType.video => FileInfoType.video,
      AssetType.audio => FileInfoType.audio,
    };
  }

  RequestType toRequestType() => switch (this) {
        FileInfoType.other => RequestType.all,
        FileInfoType.image => RequestType.image,
        FileInfoType.video => RequestType.video,
        FileInfoType.audio => RequestType.audio,
      };

  factory FileInfoType.fromExtension(String? extension) {
    return switch (extension) {
      '.jpg' => FileInfoType.image,
      '.jpeg' => FileInfoType.image,
      '.png' => FileInfoType.image,
      '.mp3' => FileInfoType.audio,
      '.m4a' => FileInfoType.audio,
      '.wav' => FileInfoType.audio,
      '.mp4' => FileInfoType.video,
      '.mkv' => FileInfoType.video,
      _ => FileInfoType.other,
    };
  }
}
