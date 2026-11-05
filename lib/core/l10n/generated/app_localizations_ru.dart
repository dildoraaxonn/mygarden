// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Мой сад';

  @override
  String get navGarden => 'Сад';

  @override
  String get navTrees => 'Деревья';

  @override
  String get navRecords => 'Учёт';

  @override
  String get navSettings => 'Настройки';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get undo => 'Отменить';

  @override
  String get notSet => 'Не указано';

  @override
  String treeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дерева',
      many: '$count деревьев',
      few: '$count дерева',
      one: '$count дерево',
      zero: 'Нет деревьев',
    );
    return '$_temp0';
  }

  @override
  String plotSize(String width, String length) {
    return '$width × $length м';
  }

  @override
  String get meterUnit => 'м';

  @override
  String kgValue(String value) {
    return '$value кг';
  }

  @override
  String get currency => 'сум';

  @override
  String moneyValue(String value) {
    return '$value сум';
  }

  @override
  String get daysToday => 'сегодня';

  @override
  String get daysYesterday => 'вчера';

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дня назад',
      many: '$days дней назад',
      few: '$days дня назад',
      one: '$days день назад',
    );
    return '$_temp0';
  }

  @override
  String get dashboardGreenhouses => 'Теплицы';

  @override
  String get dashboardUpcoming => 'Скоро плодоношение';

  @override
  String get dashboardUpcomingHint =>
      'Первые плоды ожидаются в течение 6 месяцев';

  @override
  String get dashboardEmptyTitle => 'Расставьте деревья на карте';

  @override
  String get dashboardEmptyBody =>
      'Откройте теплицу, выберите фрукт справа и нажимайте на карту там, где стоит каждое дерево.';

  @override
  String homeFruitingNow(int count) {
    return 'Плодоносят: $count';
  }

  @override
  String get homeLastCare => 'Последний уход';

  @override
  String get homeNever => 'ещё не было';

  @override
  String get homeThisYear => 'В этом году';

  @override
  String get homeRecent => 'Последние записи';

  @override
  String get weatherTitle => 'Ночная температура';

  @override
  String get weatherFrost => 'Будут заморозки!';

  @override
  String get weatherCold => 'Холодные ночи';

  @override
  String get weatherOk => 'Заморозков не ожидается';

  @override
  String get weatherAdvice =>
      'Проверьте отопление теплицы и укройте бананы и папайю.';

  @override
  String get weatherRefresh => 'Обновить';

  @override
  String get weatherOffline =>
      'Прогноза пока нет. Подключитесь к интернету и потяните экран вниз.';

  @override
  String get weatherOld =>
      'Не удалось обновить, показан последний сохранённый прогноз.';

  @override
  String get mapPlant => 'Посадить';

  @override
  String get mapHint =>
      'Нажмите на дерево — действия · удерживайте, чтобы тянуть';

  @override
  String mapPlantingHint(String fruit) {
    return 'Нажимайте, где стоит $fruit';
  }

  @override
  String mapMoveHint(String fruit) {
    return 'Нажмите на новое место для $fruit';
  }

  @override
  String get mapStopPlanting => 'Отмена';

  @override
  String get plotEdit => 'Изменить теплицу';

  @override
  String get plotName => 'Название';

  @override
  String get plotWidth => 'Ширина, м';

  @override
  String get plotLength => 'Длина, м';

  @override
  String plotLogWhole(String name) {
    return 'Вся теплица: $name';
  }

  @override
  String get plotLogWholeShort => 'Вся теплица';

  @override
  String get journalWatered => 'Полив';

  @override
  String get journalFertilized => 'Подкормка';

  @override
  String get journalSprayed => 'Опрыскивание';

  @override
  String get journalPruned => 'Обрезка';

  @override
  String get journalFlowering => 'Цветение';

  @override
  String get journalProblem => 'Проблема';

  @override
  String get journalNote => 'Заметка';

  @override
  String get journalProductHint => 'Чем? (необязательно)';

  @override
  String get journalProblemHint => 'Что случилось? (необязательно)';

  @override
  String get journalNoteHint => 'Напишите заметку';

  @override
  String journalSaved(String what) {
    return 'Записано: $what';
  }

  @override
  String get photoSaved => 'Фото сохранено';

  @override
  String treeTitle(String fruit, int id) {
    return '$fruit №$id';
  }

  @override
  String get treeOpenCard => 'Карточка';

  @override
  String get treeMove => 'Переместить';

  @override
  String get treeLocation => 'Теплица';

  @override
  String get treeStage => 'Стадия';

  @override
  String get stageSeedling => 'Саженец';

  @override
  String get stageGrowing => 'Растёт';

  @override
  String get stageFlowering => 'Цветёт';

  @override
  String get stageFruiting => 'Плодоносит';

  @override
  String get treePlanted => 'Посажено';

  @override
  String get treeExpectedFruit => 'Первые плоды';

  @override
  String get treeTotalHarvest => 'Собрано всего';

  @override
  String get fruitingNow => 'Уже плодоносит';

  @override
  String get fruitingDue => 'Ожидаются в любое время';

  @override
  String fruitingIn(String date, int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months месяца',
      many: '$months месяцев',
      few: '$months месяца',
      one: '$months месяц',
    );
    return '$date (через $_temp0)';
  }

  @override
  String get fruitingNeedsDate => 'Укажите дату посадки';

  @override
  String get treeVariety => 'Сорт';

  @override
  String get treeNotes => 'Заметки';

  @override
  String get treePhotos => 'Фото';

  @override
  String get treeNoPhotos => 'Фото пока нет';

  @override
  String get photoCamera => 'Фото';

  @override
  String get photoGallery => 'Галерея';

  @override
  String get treeDeleteTitle => 'Удалить это дерево?';

  @override
  String get treeDeleteBody =>
      'Дерево, его дневник и фото будут удалены. Записи урожая останутся.';

  @override
  String get photoDeleteTitle => 'Удалить это фото?';

  @override
  String get treesEmpty => 'Деревьев пока нет';

  @override
  String get timelineTitle => 'История дерева';

  @override
  String get timelineHint => 'Удерживайте запись, чтобы удалить её';

  @override
  String get timelineEmpty => 'Пока пусто. Отмечайте уход кнопками вверху.';

  @override
  String get timelineWholePlot => 'вся теплица';

  @override
  String get timelinePhoto => 'Фото';

  @override
  String get timelinePlanted => 'Посажено';

  @override
  String get recordsAdd => 'Добавить';

  @override
  String get recordsIncome => 'Доход';

  @override
  String get recordsSpent => 'Расходы';

  @override
  String get recordsProfit => 'Прибыль';

  @override
  String get recordsByFruit => 'По фруктам';

  @override
  String get recordsByCategory => 'Расходы по статьям';

  @override
  String recordsHarvested(String kg) {
    return 'собрано $kg';
  }

  @override
  String recordsSold(String kg) {
    return 'продано $kg';
  }

  @override
  String get recordsEntries => 'Записи';

  @override
  String get recordsHarvest => 'Урожай';

  @override
  String get recordsSales => 'Продажи';

  @override
  String get recordsExpenses => 'Расходы';

  @override
  String get recordsEmpty => 'За этот период записей нет';

  @override
  String get recordDeleteTitle => 'Удалить эту запись?';

  @override
  String get periodMonth => 'Месяц';

  @override
  String get periodYear => 'Год';

  @override
  String get periodAll => 'Всё время';

  @override
  String get harvestTitle => 'Урожай';

  @override
  String get saleTitle => 'Продажа';

  @override
  String get expenseTitle => 'Расход';

  @override
  String get fieldDate => 'Дата';

  @override
  String get fieldFruit => 'Фрукт';

  @override
  String get fieldKg => 'Вес, кг';

  @override
  String get fieldPricePerKg => 'Цена за кг';

  @override
  String get fieldTotal => 'Сумма';

  @override
  String get fieldAmount => 'Сумма';

  @override
  String get fieldBuyer => 'Покупатель';

  @override
  String get fieldNote => 'Заметка';

  @override
  String get fieldCategory => 'Статья расхода';

  @override
  String get fieldRequired => 'Обязательно';

  @override
  String get expenseFertilizer => 'Удобрения';

  @override
  String get expensePlants => 'Саженцы и семена';

  @override
  String get expenseHeating => 'Отопление (газ, уголь, дрова)';

  @override
  String get expenseUtilities => 'Вода и свет';

  @override
  String get expenseGreenhouse => 'Теплица (плёнка, ремонт)';

  @override
  String get expenseTools => 'Инструменты';

  @override
  String get expensePestControl => 'Защита от вредителей';

  @override
  String get expenseOther => 'Прочее';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsCity => 'Город (для погоды)';

  @override
  String get settingsFruitTypes => 'Виды фруктов';

  @override
  String get settingsFruitTypesHint =>
      'Добавить новые фрукты или изменить данные';

  @override
  String get fruitTypeAdd => 'Добавить вид';

  @override
  String get fruitTypeEdit => 'Изменить вид';

  @override
  String get fruitTypeNameEn => 'Название на английском';

  @override
  String get fruitTypeNameRu => 'Название на русском';

  @override
  String get fruitTypeNameMissing => 'Укажите хотя бы одно название';

  @override
  String get fruitTypeEmoji => 'Значок';

  @override
  String get fruitTypeMonths => 'Месяцев от посадки до первых плодов';

  @override
  String fruitTypeMonthsShort(int months) {
    return 'Первые плоды через ~$months мес.';
  }

  @override
  String get fruitTypeInUse =>
      'Нельзя удалить: этот фрукт используется в деревьях или записях.';

  @override
  String get diagnosisTitle => 'Диагноз';

  @override
  String get diagnosisAction => 'Диагноз';

  @override
  String get diagnosisPhotoTip =>
      'Сфотографируйте крупно больной лист, плод или стебель при дневном свете. Лучше одна проблема на одном фото.';

  @override
  String get diagnosisChangePhoto => 'Переснять';

  @override
  String get diagnosisQuestion => 'Что беспокоит?';

  @override
  String get diagnosisQuestionHint =>
      'например: листья желтеют с краёв (необязательно)';

  @override
  String get diagnosisCheck => 'Проверить';

  @override
  String get diagnosisSending => 'Смотрю фото…';

  @override
  String get diagnosisSendingHint => 'Обычно это занимает до минуты';

  @override
  String get diagnosisRetry => 'Повторить';

  @override
  String get diagnosisSaved => 'Сохранено в историю дерева';

  @override
  String get diagnosisDone => 'Готово';

  @override
  String get diagnosisDemoBanner =>
      'Демо-режим: настоящий ИИ ещё не подключён, ответы — примеры.';

  @override
  String get diagnosisDemoTag => 'ДЕМО';

  @override
  String get diagnosisHealthy => 'Растение выглядит здоровым';

  @override
  String get urgencyLow => 'Не срочно';

  @override
  String get urgencyMedium => 'Стоит заняться в ближайшие дни';

  @override
  String get urgencyHigh => 'Срочно!';

  @override
  String diagnosisConfidence(int percent) {
    return '$percent%';
  }

  @override
  String get diagnosisWhatToDo => 'Что делать';

  @override
  String get diagnosisTips => 'Советы по уходу';

  @override
  String get diagnosisDisclaimer =>
      'Это совет ИИ, он может ошибаться. Если проблема серьёзная или распространяется, покажите растение агроному.';

  @override
  String get errorNoConnection =>
      'Нет интернета. Проверьте подключение и попробуйте снова.';

  @override
  String get errorTimeout => 'Сервер долго не отвечает. Попробуйте ещё раз.';

  @override
  String get errorUnauthorized =>
      'Сервер отказал в доступе. Приложение нужно обновить.';

  @override
  String get errorRateLimited =>
      'Слишком много проверок за сегодня. Попробуйте позже.';

  @override
  String get errorImageUnclear =>
      'Фото нечёткое. Сфотографируйте ближе и при хорошем свете.';

  @override
  String errorServer(String details) {
    return 'Сервис ИИ сейчас недоступен. Попробуйте позже. ($details)';
  }

  @override
  String get errorInvalidResponse =>
      'Сервер прислал ответ, который приложение не понимает.';

  @override
  String get errorUnknown => 'Что-то пошло не так. Попробуйте ещё раз.';
}
