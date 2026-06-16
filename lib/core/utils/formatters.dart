import 'package:intl/intl.dart';

/// Centralized formatting for currency, area and dates so no widget builds
/// these strings by hand.
class Formatters {
  const Formatters._();

  /// Compact price, e.g. `$1,850` or `$1.2M`. Rentals get a `/mo` suffix.
  static String price(num value, {String currency = 'USD', bool rental = false}) {
    final symbol = NumberFormat.simpleCurrency(name: currency).currencySymbol;
    final String formatted;
    if (value >= 1000000) {
      formatted = '$symbol${(value / 1000000).toStringAsFixed(value % 1000000 == 0 ? 0 : 1)}M';
    } else {
      formatted = NumberFormat.currency(symbol: symbol, decimalDigits: 0).format(value);
    }
    return rental ? '$formatted/mo' : formatted;
  }

  /// Full currency with grouping, e.g. `$1,850,000`.
  static String currency(num value, {String currency = 'USD'}) {
    final symbol = NumberFormat.simpleCurrency(name: currency).currencySymbol;
    return NumberFormat.currency(symbol: symbol, decimalDigits: 0).format(value);
  }

  static String area(num sqm) => '${NumberFormat.decimalPattern().format(sqm)} m²';

  /// Relative-ish listing date, e.g. `Jun 1, 2026`.
  static String date(String? iso) {
    if (iso == null) return '';
    final parsed = DateTime.tryParse(iso);
    if (parsed == null) return '';
    return DateFormat.yMMMd().format(parsed.toLocal());
  }

  /// Short time, e.g. `10:15 AM`.
  static String time(String? iso) {
    if (iso == null) return '';
    final parsed = DateTime.tryParse(iso);
    if (parsed == null) return '';
    return DateFormat.jm().format(parsed.toLocal());
  }

  static String dateTime(String? iso) {
    if (iso == null) return '';
    final parsed = DateTime.tryParse(iso);
    if (parsed == null) return '';
    return DateFormat.yMMMd().add_jm().format(parsed.toLocal());
  }
}
