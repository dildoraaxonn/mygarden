import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../l10n/generated/app_localizations.dart';

String _locale(BuildContext context) =>
    Localizations.localeOf(context).toLanguageTag();

/// 10.0 -> "10", 12.5 -> "12.5"
String formatMeters(double value) =>
    value == value.roundToDouble() ? value.toInt().toString() : '$value';

/// 12.0 -> "12 kg", 2.35 -> "2.4 kg" (comma decimal in Russian).
String formatKg(BuildContext context, double kg) {
  final number = NumberFormat('#,##0.#', _locale(context)).format(kg);
  return AppLocalizations.of(context).kgValue(number);
}

/// 1250000 -> "1 250 000 сум"
String formatMoney(BuildContext context, int amount) {
  final number = NumberFormat.decimalPattern(_locale(context)).format(amount);
  return AppLocalizations.of(context).moneyValue(number);
}

String formatDate(BuildContext context, DateTime date) =>
    DateFormat.yMMMd(_locale(context)).format(date);

/// "today", "yesterday", "5 days ago"
String formatDaysAgo(BuildContext context, DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(date.year, date.month, date.day);
  final days = today.difference(day).inDays;
  final l10n = AppLocalizations.of(context);
  return switch (days) {
    <= 0 => l10n.daysToday,
    1 => l10n.daysYesterday,
    _ => l10n.daysAgo(days),
  };
}

/// Parses "12,5" or "12.5". Returns null for empty or invalid text.
double? parseDecimal(String text) =>
    double.tryParse(text.trim().replaceAll(' ', '').replaceAll(',', '.'));

/// Parses "1 250 000" or "1250000".
int? parseAmount(String text) =>
    int.tryParse(text.replaceAll(RegExp(r'[\s  .,]'), ''));
