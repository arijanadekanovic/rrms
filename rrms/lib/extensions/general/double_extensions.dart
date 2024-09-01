import 'package:intl/intl.dart';
import 'package:rrms/app/shared_features/localization/translations.dart';

extension DoubleExtensions on double? {
  String formatDecimals([int numberOfDecimals = 2]) {
    final formatter = NumberFormat.decimalPattern(translations.localeName);
    formatter.maximumFractionDigits = numberOfDecimals;
    formatter.minimumFractionDigits = numberOfDecimals;

    return (value - value.toInt()) == 0 ? value.toStringAsFixed(0) : formatter.format(value);
  }

  String formatPrice([int numberOfDecimals = 2]) {
    final formatter = NumberFormat.decimalPattern(translations.localeName);
    formatter.maximumFractionDigits = numberOfDecimals;
    formatter.minimumFractionDigits = numberOfDecimals;

    return (value - value.toInt()) == 0 ? value.toStringAsFixed(0) : formatter.format(value);
  }

  String formatPriceWithSign([int numberOfDecimals = 2]) {
    final price = formatPriceWithoutSign(numberOfDecimals);
    final sign = value < 0
        ? '-'
        : (value > 0)
            ? '+'
            : '';

    return '$sign$price';
  }

  String formatPriceWithoutSign([int numberOfDecimals = 2]) => formatPrice(numberOfDecimals).replaceAll('-', '');

  String formatPriceWithCurrency([String currency = '\$']) => '${formatPrice()}$currency';

  double get value => this ?? 0.0;
}
