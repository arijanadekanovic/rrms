import 'package:rrms/_all.dart';

abstract class Launcher {
  final String path;

  Launcher(this.path);

  void launch();
}

abstract class BaseUrlLauncher extends Launcher {
  final String? scheme;

  BaseUrlLauncher(super.path, [this.scheme]);

  @override
  void launch() => launchUrl(Uri(scheme: scheme, path: path));
}

class UrlLauncher extends BaseUrlLauncher {
  LaunchMode launchMode;

  UrlLauncher(
    String url, [
    this.launchMode = LaunchMode.platformDefault,
  ]) : super(_formatUrl(url));

  @override
  void launch() {
    if (super.path.isNotNullOrEmpty) {
      launchUrl(
        Uri.parse(path.trim()),
        mode: launchMode,
      );
    }
  }

  static String _formatUrl(String url) {
    if (url.startsWith('www.')) {
      return 'https://$url';
    }

    return url;
  }
}

class WhatsAppLauncher extends UrlLauncher {
  WhatsAppLauncher(String phoneNumber)
      : super(
          Platform.isIOS ? 'https://wa.me/$phoneNumber' : 'whatsapp://send?phone=$phoneNumber',
        );

  @override
  void launch() => launchUrl(
        Uri.parse(path),
        mode: launchMode,
      );
}

class SmsLauncher extends BaseUrlLauncher {
  SmsLauncher(String path) : super(path, 'sms');
}

class PhoneLauncher extends BaseUrlLauncher {
  PhoneLauncher(String path) : super(path, 'tel');
}

class EmailLauncher extends BaseUrlLauncher {
  EmailLauncher(String path) : super(path, 'mailto');
}
