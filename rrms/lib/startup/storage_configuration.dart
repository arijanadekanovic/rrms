import 'package:rrms/_all.dart';

class StorageConfiguration {
  static Future configure() async {
    final storageRepository = StorageRepositoryImpl();
    await storageRepository.init();

    if (appSettings.resetStorage) {
      await storageRepository.clear();
    }
    if (appSettings.loggingOptions.logStorage) {
      await storageRepository.log();
    }

    services.registerSingleton<StorageRepository>(storageRepository);
  }
}
