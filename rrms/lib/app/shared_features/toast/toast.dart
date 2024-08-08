import 'package:rrms/_all.dart';

Toast get toast => services.get<Toast>();

abstract class Toast {
  void info(String? message);
  void success(String? message);
  void error(String? message);
  void warning(String? message);
  void validation(String? message);
  void showExceptionMessage(BaseException exception);
}

class ToastImpl implements Toast {
  @override
  void info(String? message) {
    _showMessage(
      ToastContainer(
        color: const Color(0xFFF6C000),
        bgColor: const Color(0xFFFFF8DD),
        message: message,
      ),
    );
  }

  @override
  void success(String? message) {
    _showMessage(
      ToastContainer(
        color: const Color(0xFF50CD89),
        bgColor: const Color(0xFFE8FFF3),
        title: translations.success,
        message: message,
      ),
    );
  }

  @override
  void error(String? message) {
    _showMessage(
      ToastContainer(
        color: const Color(0xFFF1416C),
        bgColor: const Color(0xFFFFF5F8),
        title: translations.error,
        message: message,
      ),
    );
  }

  @override
  void warning(String? message) {
    _showMessage(
      ToastContainer(
        color: const Color(0xFFFFC700),
        bgColor: const Color(0xFFFFF8DD),
        title: translations.warning,
        message: message,
      ),
    );
  }

  @override
  void validation(String? message) => error(message);

  @override
  void showExceptionMessage(BaseException exception) {
    final messages = List<String>.from(exception.messages);

    if (messages.isEmpty) {
      messages.add(_getDefaultErrorMessageForException(exception));
    }

    final message = messages.join('\n');

    if (exception is ValidationException) {
      logger.debug('::::::::: ValidationException :::::::::');
      validation(message);
    } else if (exception is ServerErrorException) {
      logger.debug('::::::::: ServerErrorException :::::::::');
      error(message);
    } else if (exception is NetworkErrorException) {
      logger.debug('::::::::: NetworkErrorException :::::::::');
      error(message);
    } else if (exception is ForbiddenException) {
      logger.debug('::::::::: ForbiddenException :::::::::');
      error(message);
    } else if (exception is UnauthorizedException) {
      logger.debug('::::::::: UnauthorizedException :::::::::');
    } else {
      error(message);
    }
  }

  String _getDefaultErrorMessageForException(BaseException exception) {
    if (exception is ServerErrorException) {
      return translations.there_was_a_server_error_please_try_again_later;
    }
    if (exception is NetworkErrorException) {
      return translations.there_was_a_network_error_please_try_again_later;
    }
    if (exception is ValidationException) {
      return translations.there_was_a_validation_error_please_fix_and_try_again;
    }

    return translations.there_was_an_error;
  }

  void _showMessage(ToastContainer toastContainer) {
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();

    scaffoldMessengerKey.currentState?.showSnackBar(toastContainer);
  }
}

class ToastContainer extends SnackBar {
  final Color? color;
  final Color? bgColor;
  final String? title;
  final String? message;

  ToastContainer({
    super.key,
    this.color,
    this.bgColor,
    this.title,
    this.message,
  }) : super(
          content: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: bgColor ?? const Color(0xFF323232),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title.isNotNullOrEmpty) ...{
                          Text(
                            title.value,
                            style: TextStyle(color: color ?? Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          const Gap(5),
                        },
                        Text(
                          message.value,
                          style: const TextStyle(color: Color(0xFF4B5675), fontSize: 12, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: () => scaffoldMessengerKey.currentState?.removeCurrentSnackBar(),
                    child: Icon(Icons.close, color: color ?? Colors.white, size: 18),
                  ),
                ],
              ),
            ),
          ),
          padding: const EdgeInsets.all(10),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
}
