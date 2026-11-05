import '../../../core/database/app_database.dart';
import '../../../core/l10n/generated/app_localizations.dart';

extension ExpenseCategoryLabel on ExpenseCategory {
  String get emoji => switch (this) {
    ExpenseCategory.fertilizer => '🌿',
    ExpenseCategory.plants => '🌱',
    ExpenseCategory.heating => '🔥',
    ExpenseCategory.utilities => '💡',
    ExpenseCategory.greenhouse => '🏠',
    ExpenseCategory.tools => '🛠️',
    ExpenseCategory.pestControl => '🧴',
    ExpenseCategory.other => '📦',
  };

  String label(AppLocalizations l10n) => switch (this) {
    ExpenseCategory.fertilizer => l10n.expenseFertilizer,
    ExpenseCategory.plants => l10n.expensePlants,
    ExpenseCategory.heating => l10n.expenseHeating,
    ExpenseCategory.utilities => l10n.expenseUtilities,
    ExpenseCategory.greenhouse => l10n.expenseGreenhouse,
    ExpenseCategory.tools => l10n.expenseTools,
    ExpenseCategory.pestControl => l10n.expensePestControl,
    ExpenseCategory.other => l10n.expenseOther,
  };
}
