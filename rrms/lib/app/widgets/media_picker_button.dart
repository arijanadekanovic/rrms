import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:rrms/_all.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class MediaPickerButtonCropAspectRatio {
  final CropAspectRatio value;

  MediaPickerButtonCropAspectRatio(double x, double y) : value = CropAspectRatio(ratioX: x, ratioY: y);

  factory MediaPickerButtonCropAspectRatio.square() => MediaPickerButtonCropAspectRatio(1, 1);
  factory MediaPickerButtonCropAspectRatio.ratio3x2() => MediaPickerButtonCropAspectRatio(3, 2);
  factory MediaPickerButtonCropAspectRatio.ratio5x3() => MediaPickerButtonCropAspectRatio(5, 3);
  factory MediaPickerButtonCropAspectRatio.ratio4x3() => MediaPickerButtonCropAspectRatio(4, 3);
  factory MediaPickerButtonCropAspectRatio.ratio5x4() => MediaPickerButtonCropAspectRatio(5, 4);
  factory MediaPickerButtonCropAspectRatio.ratio7x5() => MediaPickerButtonCropAspectRatio(7, 5);
  factory MediaPickerButtonCropAspectRatio.ratio16x9() => MediaPickerButtonCropAspectRatio(16, 9);
}

class MediaPickerButton extends StatelessWidget {
  final MediaPickerButtonType type;
  final MediaPickerImageConfig? imageConfig;
  final MediaPickerFileConfig? fileConfig;
  final Widget child;
  final bool disabled;
  final void Function(List<FileInfo> items)? onMediaTaken;
  final void Function(List<FileInfo> items)? onMediaCropped;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final bool allowMultiple;

  const MediaPickerButton({
    super.key,
    this.type = MediaPickerButtonType.gallery,
    this.imageConfig,
    this.fileConfig,
    required this.child,
    this.disabled = false,
    this.onMediaTaken,
    this.onMediaCropped,
    this.padding,
    this.borderRadius,
    this.allowMultiple = true,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onTap: () => _handleSelectionType(context),
      padding: padding ?? EdgeInsets.zero,
      borderRadius: borderRadius,
      child: child,
    );
  }

  Future<void> _handleSelectionType(BuildContext context) async {
    if (disabled) {
      return;
    }

    switch (type) {
      case MediaPickerButtonType.gallery:
        await _handleGallery(imageConfig?.context ?? context);
      case MediaPickerButtonType.file:
        await _handleFile(imageConfig?.context ?? context);
    }
  }

  Future<void> _handleGallery(BuildContext context) async {
    if (imageConfig == null) {
      return;
    }

    if (Platform.isAndroid || Platform.isIOS) {
      await _handleGalleryMobile(context);
    }

    if (Platform.isWindows) {
      await _handleGalleryWindows(context);
    }
  }

  Future<void> _handleGalleryMobile(BuildContext context) async {    
    final List<String> selectedAssetIds = [];

    final assets = await AssetPicker.pickAssets(
          context,
          pickerConfig: AssetPickerConfig(
            maxAssets: imageConfig!.maxAssets,
            themeColor: context.theme.primaryColor,
            requestType: imageConfig!.fileInfoType?.toRequestType() ?? RequestType.common,
            textDelegate: () {
              return switch (context.read<LocalizationCubit>().state.language.locale.languageCode) {
                'en' => const EnglishAssetPickerTextDelegate(),
                'de' => const GermanAssetPickerTextDelegate(),
                _ => const EnglishAssetPickerTextDelegate(),
              };
            }(),
            selectPredicate: imageConfig!.onlyOneAssetType
                ? (_, asset, isSelected) {
                    if (isSelected) {
                      selectedAssetIds.remove(asset.id);
                    } else {
                      selectedAssetIds.add(asset.id);
                    }

                    return true;
                  }
                : null,
          ),
        ) ??
        [];

    if (assets.isNotNullOrEmpty) {
      final List<FileInfo> assetInfos = [];

      for (final asset in assets) {
        final file = await asset.file;

        if (file != null) {
          assetInfos.add(FileInfo.fromPath(file.path));
        }
      }

      if (assetInfos.isNotNullOrEmpty) {
        onMediaTaken?.call(assetInfos);
      }

      if (imageConfig!.useCropper) {
        final List<FileInfo> croppedImages = [];

        for (final asset in assets.where((x) => x.type == AssetType.image)) {
          final file = await asset.file;

          if (file != null) {
            final croppedImage = await _cropImage(context, file.path.value);

            if (croppedImage != null) {
              croppedImages.add(FileInfo.fromPath(croppedImage.path.value));
            }
          }
        }

        if (croppedImages.isNotNullOrEmpty) {
          onMediaCropped?.call(croppedImages);
        }
      }
    }
  }

  Future<void> _handleGalleryWindows(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      final fileInfo = FileInfo.fromPath(result.files.single.path!);

      onMediaTaken?.call([fileInfo]);
      onMediaCropped?.call([fileInfo]);
    }
  }

  Future<void> _handleFile(BuildContext context) async {
    if (fileConfig == null) {
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: fileConfig!.fileType ?? FileType.custom,
      allowMultiple: allowMultiple,
      allowedExtensions: fileConfig!.allowedExtensions,
    );

    if (result != null) {
      final assetInfos = result.paths.map((path) => FileInfo.fromPath(path.value)).toList();

      onMediaTaken?.call(assetInfos);
    }
  }

  Future<File?> _cropImage(BuildContext context, String path) async {
    if (imageConfig == null) {
      return null;
    }

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: imageConfig!.cropAspectRatio?.value,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: translations.cropper,
          toolbarColor: context.theme.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: imageConfig!.lockCropAspectRatio,
        ),
        IOSUiSettings(title: translations.cropper),
        WebUiSettings(context: context),
      ],
    );

    if (onMediaCropped != null && croppedFile != null) {
      return File(croppedFile.path);
    }

    return null;
  }
}

enum MediaPickerButtonType {
  gallery,
  file,
}

class MediaPickerImageConfig {
  final FileInfoType? fileInfoType;
  final bool useCropper;
  final bool onlyOneAssetType;
  final bool? lockCropAspectRatio;
  final int imageQualityPercentage;
  final int maxAssets;
  final MediaPickerButtonCropAspectRatio? cropAspectRatio;
  final BuildContext context;

  const MediaPickerImageConfig({
    this.fileInfoType,
    this.useCropper = false,
    this.onlyOneAssetType = false,
    this.lockCropAspectRatio = false,
    this.imageQualityPercentage = 100,
    this.maxAssets = 1,
    this.cropAspectRatio,
    required this.context,
  });
}

class MediaPickerFileConfig {
  final FileType? fileType;
  final List<String>? allowedExtensions;

  const MediaPickerFileConfig({
    this.fileType,
    this.allowedExtensions,
  });
}
