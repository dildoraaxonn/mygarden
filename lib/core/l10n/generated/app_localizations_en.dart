// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My Garden';

  @override
  String get navGarden => 'Garden';

  @override
  String get navTrees => 'Trees';

  @override
  String get navRecords => 'Records';

  @override
  String get navSettings => 'Settings';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get undo => 'Undo';

  @override
  String get notSet => 'Not set';

  @override
  String treeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count trees',
      one: '1 tree',
      zero: 'No trees',
    );
    return '$_temp0';
  }

  @override
  String plotSize(String width, String length) {
    return '$width × $length m';
  }

  @override
  String get meterUnit => 'm';

  @override
  String kgValue(String value) {
    return '$value kg';
  }

  @override
  String get currency => 'UZS';

  @override
  String moneyValue(String value) {
    return '$value UZS';
  }

  @override
  String get daysToday => 'today';

  @override
  String get daysYesterday => 'yesterday';

  @override
  String daysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String get dashboardGreenhouses => 'Greenhouses';

  @override
  String get dashboardUpcoming => 'Fruiting soon';

  @override
  String get dashboardUpcomingHint => 'First fruit expected within 6 months';

  @override
  String get dashboardEmptyTitle => 'Put your trees on the map';

  @override
  String get dashboardEmptyBody =>
      'Open a greenhouse, pick a fruit on the right and tap the map where each tree stands.';

  @override
  String homeFruitingNow(int count) {
    return 'Fruiting: $count';
  }

  @override
  String get homeLastCare => 'Last care';

  @override
  String get homeNever => 'not yet';

  @override
  String get homeThisYear => 'This year';

  @override
  String get homeRecent => 'Recent diary';

  @override
  String get weatherTitle => 'Night temperature';

  @override
  String get weatherFrost => 'Frost ahead!';

  @override
  String get weatherCold => 'Cold nights ahead';

  @override
  String get weatherOk => 'No frost expected';

  @override
  String get weatherAdvice =>
      'Check the greenhouse heating and cover the bananas and papayas.';

  @override
  String get weatherRefresh => 'Refresh';

  @override
  String get weatherOffline =>
      'No forecast yet. Connect to the internet and pull down to refresh.';

  @override
  String get weatherOld => 'Couldn\'t update; showing the last saved forecast.';

  @override
  String get mapPlant => 'Plant';

  @override
  String get mapHint => 'Tap a tree for actions · hold it to drag';

  @override
  String mapPlantingHint(String fruit) {
    return 'Tap where each $fruit stands';
  }

  @override
  String mapMoveHint(String fruit) {
    return 'Tap the new spot for $fruit';
  }

  @override
  String get mapStopPlanting => 'Cancel';

  @override
  String get plotEdit => 'Edit greenhouse';

  @override
  String get plotName => 'Name';

  @override
  String get plotWidth => 'Width, m';

  @override
  String get plotLength => 'Length, m';

  @override
  String plotLogWhole(String name) {
    return 'Whole greenhouse: $name';
  }

  @override
  String get plotLogWholeShort => 'Whole greenhouse';

  @override
  String get journalWatered => 'Watered';

  @override
  String get journalFertilized => 'Fertilized';

  @override
  String get journalSprayed => 'Sprayed';

  @override
  String get journalPruned => 'Pruned';

  @override
  String get journalFlowering => 'Flowering';

  @override
  String get journalProblem => 'Problem';

  @override
  String get journalNote => 'Note';

  @override
  String get journalProductHint => 'What with? (optional)';

  @override
  String get journalProblemHint => 'What\'s wrong? (optional)';

  @override
  String get journalNoteHint => 'Write a note';

  @override
  String journalSaved(String what) {
    return 'Saved: $what';
  }

  @override
  String get photoSaved => 'Photo saved';

  @override
  String treeTitle(String fruit, int id) {
    return '$fruit #$id';
  }

  @override
  String get treeOpenCard => 'Card';

  @override
  String get treeMove => 'Move';

  @override
  String get treeLocation => 'Greenhouse';

  @override
  String get treeStage => 'Stage';

  @override
  String get stageSeedling => 'Seedling';

  @override
  String get stageGrowing => 'Growing';

  @override
  String get stageFlowering => 'Flowering';

  @override
  String get stageFruiting => 'Fruiting';

  @override
  String get treePlanted => 'Planted';

  @override
  String get treeExpectedFruit => 'Expected first fruit';

  @override
  String get treeTotalHarvest => 'Harvested in total';

  @override
  String get fruitingNow => 'Already fruiting';

  @override
  String get fruitingDue => 'Any time now';

  @override
  String fruitingIn(String date, int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months months',
      one: '1 month',
    );
    return '$date (in $_temp0)';
  }

  @override
  String get fruitingNeedsDate => 'Set the planting date to see this';

  @override
  String get treeVariety => 'Variety';

  @override
  String get treeNotes => 'Notes';

  @override
  String get treePhotos => 'Photos';

  @override
  String get treeNoPhotos => 'No photos yet';

  @override
  String get photoCamera => 'Photo';

  @override
  String get photoGallery => 'Gallery';

  @override
  String get treeDeleteTitle => 'Delete this tree?';

  @override
  String get treeDeleteBody =>
      'The tree, its diary and photos will be removed. Harvest records stay.';

  @override
  String get photoDeleteTitle => 'Delete this photo?';

  @override
  String get treesEmpty => 'No trees yet';

  @override
  String get timelineTitle => 'Life story';

  @override
  String get timelineHint => 'Hold an entry to delete it';

  @override
  String get timelineEmpty =>
      'Nothing yet. Use the buttons at the top to log care.';

  @override
  String get timelineWholePlot => 'whole greenhouse';

  @override
  String get timelinePhoto => 'Photo';

  @override
  String get timelinePlanted => 'Planted';

  @override
  String get recordsAdd => 'Add';

  @override
  String get recordsIncome => 'Income';

  @override
  String get recordsSpent => 'Spent';

  @override
  String get recordsProfit => 'Profit';

  @override
  String get recordsByFruit => 'By fruit';

  @override
  String get recordsByCategory => 'Spending by category';

  @override
  String recordsHarvested(String kg) {
    return 'harvested $kg';
  }

  @override
  String recordsSold(String kg) {
    return 'sold $kg';
  }

  @override
  String get recordsEntries => 'Entries';

  @override
  String get recordsHarvest => 'Harvest';

  @override
  String get recordsSales => 'Sales';

  @override
  String get recordsExpenses => 'Expenses';

  @override
  String get recordsEmpty => 'Nothing here for this period';

  @override
  String get recordDeleteTitle => 'Delete this entry?';

  @override
  String get periodMonth => 'Month';

  @override
  String get periodYear => 'Year';

  @override
  String get periodAll => 'All time';

  @override
  String get harvestTitle => 'Harvest';

  @override
  String get saleTitle => 'Sale';

  @override
  String get expenseTitle => 'Expense';

  @override
  String get fieldDate => 'Date';

  @override
  String get fieldFruit => 'Fruit';

  @override
  String get fieldKg => 'Weight, kg';

  @override
  String get fieldPricePerKg => 'Price per kg';

  @override
  String get fieldTotal => 'Total';

  @override
  String get fieldAmount => 'Amount';

  @override
  String get fieldBuyer => 'Buyer';

  @override
  String get fieldNote => 'Note';

  @override
  String get fieldCategory => 'Category';

  @override
  String get fieldRequired => 'Required';

  @override
  String get expenseFertilizer => 'Fertilizer';

  @override
  String get expensePlants => 'Seedlings & seeds';

  @override
  String get expenseHeating => 'Heating (gas, coal, wood)';

  @override
  String get expenseUtilities => 'Water & electricity';

  @override
  String get expenseGreenhouse => 'Greenhouse (film, repairs)';

  @override
  String get expenseTools => 'Tools';

  @override
  String get expensePestControl => 'Pest control';

  @override
  String get expenseOther => 'Other';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsCity => 'City (for weather)';

  @override
  String get settingsFruitTypes => 'Fruit types';

  @override
  String get settingsFruitTypesHint => 'Add new fruits or change their details';

  @override
  String get fruitTypeAdd => 'Add fruit type';

  @override
  String get fruitTypeEdit => 'Edit fruit type';

  @override
  String get fruitTypeNameEn => 'Name in English';

  @override
  String get fruitTypeNameRu => 'Name in Russian';

  @override
  String get fruitTypeNameMissing => 'Fill in at least one name';

  @override
  String get fruitTypeEmoji => 'Icon';

  @override
  String get fruitTypeMonths => 'Months from planting to first fruit';

  @override
  String fruitTypeMonthsShort(int months) {
    return 'First fruit after ~$months mo.';
  }

  @override
  String get fruitTypeInUse =>
      'Can\'t delete: trees or records use this fruit.';

  @override
  String get diagnosisTitle => 'Plant doctor';

  @override
  String get diagnosisAction => 'Check health';

  @override
  String get diagnosisPhotoTip =>
      'Take a close photo of the sick leaf, fruit or stem in daylight. One problem per photo works best.';

  @override
  String get diagnosisChangePhoto => 'Retake photo';

  @override
  String get diagnosisQuestion => 'What worries you?';

  @override
  String get diagnosisQuestionHint =>
      'e.g. leaves turn yellow from the edges (optional)';

  @override
  String get diagnosisCheck => 'Check';

  @override
  String get diagnosisSending => 'Looking at the photo…';

  @override
  String get diagnosisSendingHint => 'This usually takes up to a minute';

  @override
  String get diagnosisRetry => 'Try again';

  @override
  String get diagnosisSaved => 'Saved to the tree\'s life story';

  @override
  String get diagnosisDone => 'Done';

  @override
  String get diagnosisDemoBanner =>
      'Demo mode: the real AI is not connected yet, so answers are examples.';

  @override
  String get diagnosisDemoTag => 'DEMO';

  @override
  String get diagnosisHealthy => 'The plant looks healthy';

  @override
  String get urgencyLow => 'Not urgent';

  @override
  String get urgencyMedium => 'Deal with it in the next few days';

  @override
  String get urgencyHigh => 'Urgent!';

  @override
  String diagnosisConfidence(int percent) {
    return '$percent%';
  }

  @override
  String get diagnosisWhatToDo => 'What to do';

  @override
  String get diagnosisTips => 'Care tips';

  @override
  String get diagnosisDisclaimer =>
      'This is AI advice and can be wrong. If the problem is serious or spreading, show the plant to an agronomist.';

  @override
  String get errorNoConnection =>
      'No internet. Check the connection and try again.';

  @override
  String get errorTimeout => 'The server is taking too long. Please try again.';

  @override
  String get errorUnauthorized =>
      'The server refused access. The app needs to be updated.';

  @override
  String get errorRateLimited =>
      'Too many checks today. Please try again later.';

  @override
  String get errorImageUnclear =>
      'The photo isn\'t clear enough. Take it closer and in good light.';

  @override
  String errorServer(String details) {
    return 'The AI service isn\'t available right now. Please try again later. ($details)';
  }

  @override
  String get errorInvalidResponse =>
      'The server sent an answer the app doesn\'t understand.';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';
}
