import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'My Garden'**
  String get appTitle;

  /// No description provided for @navGarden.
  ///
  /// In en, this message translates to:
  /// **'Garden'**
  String get navGarden;

  /// No description provided for @navTrees.
  ///
  /// In en, this message translates to:
  /// **'Trees'**
  String get navTrees;

  /// No description provided for @navRecords.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get navRecords;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @treeCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No trees} =1{1 tree} other{{count} trees}}'**
  String treeCount(int count);

  /// No description provided for @plotSize.
  ///
  /// In en, this message translates to:
  /// **'{width} × {length} m'**
  String plotSize(String width, String length);

  /// No description provided for @meterUnit.
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get meterUnit;

  /// No description provided for @kgValue.
  ///
  /// In en, this message translates to:
  /// **'{value} kg'**
  String kgValue(String value);

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'UZS'**
  String get currency;

  /// No description provided for @moneyValue.
  ///
  /// In en, this message translates to:
  /// **'{value} UZS'**
  String moneyValue(String value);

  /// No description provided for @daysToday.
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get daysToday;

  /// No description provided for @daysYesterday.
  ///
  /// In en, this message translates to:
  /// **'yesterday'**
  String get daysYesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{1 day ago} other{{days} days ago}}'**
  String daysAgo(int days);

  /// No description provided for @dashboardGreenhouses.
  ///
  /// In en, this message translates to:
  /// **'Greenhouses'**
  String get dashboardGreenhouses;

  /// No description provided for @dashboardUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Fruiting soon'**
  String get dashboardUpcoming;

  /// No description provided for @dashboardUpcomingHint.
  ///
  /// In en, this message translates to:
  /// **'First fruit expected within 6 months'**
  String get dashboardUpcomingHint;

  /// No description provided for @dashboardEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Put your trees on the map'**
  String get dashboardEmptyTitle;

  /// No description provided for @dashboardEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Open a greenhouse, pick a fruit on the right and tap the map where each tree stands.'**
  String get dashboardEmptyBody;

  /// No description provided for @homeFruitingNow.
  ///
  /// In en, this message translates to:
  /// **'Fruiting: {count}'**
  String homeFruitingNow(int count);

  /// No description provided for @homeLastCare.
  ///
  /// In en, this message translates to:
  /// **'Last care'**
  String get homeLastCare;

  /// No description provided for @homeNever.
  ///
  /// In en, this message translates to:
  /// **'not yet'**
  String get homeNever;

  /// No description provided for @homeThisYear.
  ///
  /// In en, this message translates to:
  /// **'This year'**
  String get homeThisYear;

  /// No description provided for @homeRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent diary'**
  String get homeRecent;

  /// No description provided for @weatherTitle.
  ///
  /// In en, this message translates to:
  /// **'Night temperature'**
  String get weatherTitle;

  /// No description provided for @weatherFrost.
  ///
  /// In en, this message translates to:
  /// **'Frost ahead!'**
  String get weatherFrost;

  /// No description provided for @weatherCold.
  ///
  /// In en, this message translates to:
  /// **'Cold nights ahead'**
  String get weatherCold;

  /// No description provided for @weatherOk.
  ///
  /// In en, this message translates to:
  /// **'No frost expected'**
  String get weatherOk;

  /// No description provided for @weatherAdvice.
  ///
  /// In en, this message translates to:
  /// **'Check the greenhouse heating and cover the bananas and papayas.'**
  String get weatherAdvice;

  /// No description provided for @weatherRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get weatherRefresh;

  /// No description provided for @weatherOffline.
  ///
  /// In en, this message translates to:
  /// **'No forecast yet. Connect to the internet and pull down to refresh.'**
  String get weatherOffline;

  /// No description provided for @weatherOld.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update; showing the last saved forecast.'**
  String get weatherOld;

  /// No description provided for @mapPlant.
  ///
  /// In en, this message translates to:
  /// **'Plant'**
  String get mapPlant;

  /// No description provided for @mapHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a tree for actions · hold it to drag'**
  String get mapHint;

  /// No description provided for @mapPlantingHint.
  ///
  /// In en, this message translates to:
  /// **'Tap where each {fruit} stands'**
  String mapPlantingHint(String fruit);

  /// No description provided for @mapMoveHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the new spot for {fruit}'**
  String mapMoveHint(String fruit);

  /// No description provided for @mapStopPlanting.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get mapStopPlanting;

  /// No description provided for @plotEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit greenhouse'**
  String get plotEdit;

  /// No description provided for @plotName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get plotName;

  /// No description provided for @plotWidth.
  ///
  /// In en, this message translates to:
  /// **'Width, m'**
  String get plotWidth;

  /// No description provided for @plotLength.
  ///
  /// In en, this message translates to:
  /// **'Length, m'**
  String get plotLength;

  /// No description provided for @plotLogWhole.
  ///
  /// In en, this message translates to:
  /// **'Whole greenhouse: {name}'**
  String plotLogWhole(String name);

  /// No description provided for @plotLogWholeShort.
  ///
  /// In en, this message translates to:
  /// **'Whole greenhouse'**
  String get plotLogWholeShort;

  /// No description provided for @journalWatered.
  ///
  /// In en, this message translates to:
  /// **'Watered'**
  String get journalWatered;

  /// No description provided for @journalFertilized.
  ///
  /// In en, this message translates to:
  /// **'Fertilized'**
  String get journalFertilized;

  /// No description provided for @journalSprayed.
  ///
  /// In en, this message translates to:
  /// **'Sprayed'**
  String get journalSprayed;

  /// No description provided for @journalPruned.
  ///
  /// In en, this message translates to:
  /// **'Pruned'**
  String get journalPruned;

  /// No description provided for @journalFlowering.
  ///
  /// In en, this message translates to:
  /// **'Flowering'**
  String get journalFlowering;

  /// No description provided for @journalProblem.
  ///
  /// In en, this message translates to:
  /// **'Problem'**
  String get journalProblem;

  /// No description provided for @journalNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get journalNote;

  /// No description provided for @journalProductHint.
  ///
  /// In en, this message translates to:
  /// **'What with? (optional)'**
  String get journalProductHint;

  /// No description provided for @journalProblemHint.
  ///
  /// In en, this message translates to:
  /// **'What\'s wrong? (optional)'**
  String get journalProblemHint;

  /// No description provided for @journalNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Write a note'**
  String get journalNoteHint;

  /// No description provided for @journalSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved: {what}'**
  String journalSaved(String what);

  /// No description provided for @photoSaved.
  ///
  /// In en, this message translates to:
  /// **'Photo saved'**
  String get photoSaved;

  /// No description provided for @treeTitle.
  ///
  /// In en, this message translates to:
  /// **'{fruit} #{id}'**
  String treeTitle(String fruit, int id);

  /// No description provided for @treeOpenCard.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get treeOpenCard;

  /// No description provided for @treeMove.
  ///
  /// In en, this message translates to:
  /// **'Move'**
  String get treeMove;

  /// No description provided for @treeLocation.
  ///
  /// In en, this message translates to:
  /// **'Greenhouse'**
  String get treeLocation;

  /// No description provided for @treeStage.
  ///
  /// In en, this message translates to:
  /// **'Stage'**
  String get treeStage;

  /// No description provided for @stageSeedling.
  ///
  /// In en, this message translates to:
  /// **'Seedling'**
  String get stageSeedling;

  /// No description provided for @stageGrowing.
  ///
  /// In en, this message translates to:
  /// **'Growing'**
  String get stageGrowing;

  /// No description provided for @stageFlowering.
  ///
  /// In en, this message translates to:
  /// **'Flowering'**
  String get stageFlowering;

  /// No description provided for @stageFruiting.
  ///
  /// In en, this message translates to:
  /// **'Fruiting'**
  String get stageFruiting;

  /// No description provided for @treePlanted.
  ///
  /// In en, this message translates to:
  /// **'Planted'**
  String get treePlanted;

  /// No description provided for @treeExpectedFruit.
  ///
  /// In en, this message translates to:
  /// **'Expected first fruit'**
  String get treeExpectedFruit;

  /// No description provided for @treeTotalHarvest.
  ///
  /// In en, this message translates to:
  /// **'Harvested in total'**
  String get treeTotalHarvest;

  /// No description provided for @fruitingNow.
  ///
  /// In en, this message translates to:
  /// **'Already fruiting'**
  String get fruitingNow;

  /// No description provided for @fruitingDue.
  ///
  /// In en, this message translates to:
  /// **'Any time now'**
  String get fruitingDue;

  /// No description provided for @fruitingIn.
  ///
  /// In en, this message translates to:
  /// **'{date} (in {months, plural, =1{1 month} other{{months} months}})'**
  String fruitingIn(String date, int months);

  /// No description provided for @fruitingNeedsDate.
  ///
  /// In en, this message translates to:
  /// **'Set the planting date to see this'**
  String get fruitingNeedsDate;

  /// No description provided for @treeVariety.
  ///
  /// In en, this message translates to:
  /// **'Variety'**
  String get treeVariety;

  /// No description provided for @treeNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get treeNotes;

  /// No description provided for @treePhotos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get treePhotos;

  /// No description provided for @treeNoPhotos.
  ///
  /// In en, this message translates to:
  /// **'No photos yet'**
  String get treeNoPhotos;

  /// No description provided for @photoCamera.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photoCamera;

  /// No description provided for @photoGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get photoGallery;

  /// No description provided for @treeDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this tree?'**
  String get treeDeleteTitle;

  /// No description provided for @treeDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'The tree, its diary and photos will be removed. Harvest records stay.'**
  String get treeDeleteBody;

  /// No description provided for @photoDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this photo?'**
  String get photoDeleteTitle;

  /// No description provided for @treesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No trees yet'**
  String get treesEmpty;

  /// No description provided for @timelineTitle.
  ///
  /// In en, this message translates to:
  /// **'Life story'**
  String get timelineTitle;

  /// No description provided for @timelineHint.
  ///
  /// In en, this message translates to:
  /// **'Hold an entry to delete it'**
  String get timelineHint;

  /// No description provided for @timelineEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing yet. Use the buttons at the top to log care.'**
  String get timelineEmpty;

  /// No description provided for @timelineWholePlot.
  ///
  /// In en, this message translates to:
  /// **'whole greenhouse'**
  String get timelineWholePlot;

  /// No description provided for @timelinePhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get timelinePhoto;

  /// No description provided for @timelinePlanted.
  ///
  /// In en, this message translates to:
  /// **'Planted'**
  String get timelinePlanted;

  /// No description provided for @recordsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get recordsAdd;

  /// No description provided for @recordsIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get recordsIncome;

  /// No description provided for @recordsSpent.
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get recordsSpent;

  /// No description provided for @recordsProfit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get recordsProfit;

  /// No description provided for @recordsByFruit.
  ///
  /// In en, this message translates to:
  /// **'By fruit'**
  String get recordsByFruit;

  /// No description provided for @recordsByCategory.
  ///
  /// In en, this message translates to:
  /// **'Spending by category'**
  String get recordsByCategory;

  /// No description provided for @recordsHarvested.
  ///
  /// In en, this message translates to:
  /// **'harvested {kg}'**
  String recordsHarvested(String kg);

  /// No description provided for @recordsSold.
  ///
  /// In en, this message translates to:
  /// **'sold {kg}'**
  String recordsSold(String kg);

  /// No description provided for @recordsEntries.
  ///
  /// In en, this message translates to:
  /// **'Entries'**
  String get recordsEntries;

  /// No description provided for @recordsHarvest.
  ///
  /// In en, this message translates to:
  /// **'Harvest'**
  String get recordsHarvest;

  /// No description provided for @recordsSales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get recordsSales;

  /// No description provided for @recordsExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get recordsExpenses;

  /// No description provided for @recordsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing here for this period'**
  String get recordsEmpty;

  /// No description provided for @recordDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this entry?'**
  String get recordDeleteTitle;

  /// No description provided for @periodMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get periodMonth;

  /// No description provided for @periodYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get periodYear;

  /// No description provided for @periodAll.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get periodAll;

  /// No description provided for @harvestTitle.
  ///
  /// In en, this message translates to:
  /// **'Harvest'**
  String get harvestTitle;

  /// No description provided for @saleTitle.
  ///
  /// In en, this message translates to:
  /// **'Sale'**
  String get saleTitle;

  /// No description provided for @expenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expenseTitle;

  /// No description provided for @fieldDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get fieldDate;

  /// No description provided for @fieldFruit.
  ///
  /// In en, this message translates to:
  /// **'Fruit'**
  String get fieldFruit;

  /// No description provided for @fieldKg.
  ///
  /// In en, this message translates to:
  /// **'Weight, kg'**
  String get fieldKg;

  /// No description provided for @fieldPricePerKg.
  ///
  /// In en, this message translates to:
  /// **'Price per kg'**
  String get fieldPricePerKg;

  /// No description provided for @fieldTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get fieldTotal;

  /// No description provided for @fieldAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get fieldAmount;

  /// No description provided for @fieldBuyer.
  ///
  /// In en, this message translates to:
  /// **'Buyer'**
  String get fieldBuyer;

  /// No description provided for @fieldNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get fieldNote;

  /// No description provided for @fieldCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get fieldCategory;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get fieldRequired;

  /// No description provided for @expenseFertilizer.
  ///
  /// In en, this message translates to:
  /// **'Fertilizer'**
  String get expenseFertilizer;

  /// No description provided for @expensePlants.
  ///
  /// In en, this message translates to:
  /// **'Seedlings & seeds'**
  String get expensePlants;

  /// No description provided for @expenseHeating.
  ///
  /// In en, this message translates to:
  /// **'Heating (gas, coal, wood)'**
  String get expenseHeating;

  /// No description provided for @expenseUtilities.
  ///
  /// In en, this message translates to:
  /// **'Water & electricity'**
  String get expenseUtilities;

  /// No description provided for @expenseGreenhouse.
  ///
  /// In en, this message translates to:
  /// **'Greenhouse (film, repairs)'**
  String get expenseGreenhouse;

  /// No description provided for @expenseTools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get expenseTools;

  /// No description provided for @expensePestControl.
  ///
  /// In en, this message translates to:
  /// **'Pest control'**
  String get expensePestControl;

  /// No description provided for @expenseOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get expenseOther;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsCity.
  ///
  /// In en, this message translates to:
  /// **'City (for weather)'**
  String get settingsCity;

  /// No description provided for @settingsFruitTypes.
  ///
  /// In en, this message translates to:
  /// **'Fruit types'**
  String get settingsFruitTypes;

  /// No description provided for @settingsFruitTypesHint.
  ///
  /// In en, this message translates to:
  /// **'Add new fruits or change their details'**
  String get settingsFruitTypesHint;

  /// No description provided for @fruitTypeAdd.
  ///
  /// In en, this message translates to:
  /// **'Add fruit type'**
  String get fruitTypeAdd;

  /// No description provided for @fruitTypeEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit fruit type'**
  String get fruitTypeEdit;

  /// No description provided for @fruitTypeNameEn.
  ///
  /// In en, this message translates to:
  /// **'Name in English'**
  String get fruitTypeNameEn;

  /// No description provided for @fruitTypeNameRu.
  ///
  /// In en, this message translates to:
  /// **'Name in Russian'**
  String get fruitTypeNameRu;

  /// No description provided for @fruitTypeNameMissing.
  ///
  /// In en, this message translates to:
  /// **'Fill in at least one name'**
  String get fruitTypeNameMissing;

  /// No description provided for @fruitTypeEmoji.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get fruitTypeEmoji;

  /// No description provided for @fruitTypeMonths.
  ///
  /// In en, this message translates to:
  /// **'Months from planting to first fruit'**
  String get fruitTypeMonths;

  /// No description provided for @fruitTypeMonthsShort.
  ///
  /// In en, this message translates to:
  /// **'First fruit after ~{months} mo.'**
  String fruitTypeMonthsShort(int months);

  /// No description provided for @fruitTypeInUse.
  ///
  /// In en, this message translates to:
  /// **'Can\'t delete: trees or records use this fruit.'**
  String get fruitTypeInUse;

  /// No description provided for @diagnosisTitle.
  ///
  /// In en, this message translates to:
  /// **'Plant doctor'**
  String get diagnosisTitle;

  /// No description provided for @diagnosisAction.
  ///
  /// In en, this message translates to:
  /// **'Check health'**
  String get diagnosisAction;

  /// No description provided for @diagnosisPhotoTip.
  ///
  /// In en, this message translates to:
  /// **'Take a close photo of the sick leaf, fruit or stem in daylight. One problem per photo works best.'**
  String get diagnosisPhotoTip;

  /// No description provided for @diagnosisChangePhoto.
  ///
  /// In en, this message translates to:
  /// **'Retake photo'**
  String get diagnosisChangePhoto;

  /// No description provided for @diagnosisQuestion.
  ///
  /// In en, this message translates to:
  /// **'What worries you?'**
  String get diagnosisQuestion;

  /// No description provided for @diagnosisQuestionHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. leaves turn yellow from the edges (optional)'**
  String get diagnosisQuestionHint;

  /// No description provided for @diagnosisCheck.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get diagnosisCheck;

  /// No description provided for @diagnosisSending.
  ///
  /// In en, this message translates to:
  /// **'Looking at the photo…'**
  String get diagnosisSending;

  /// No description provided for @diagnosisSendingHint.
  ///
  /// In en, this message translates to:
  /// **'This usually takes up to a minute'**
  String get diagnosisSendingHint;

  /// No description provided for @diagnosisRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get diagnosisRetry;

  /// No description provided for @diagnosisSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved to the tree\'s life story'**
  String get diagnosisSaved;

  /// No description provided for @diagnosisDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get diagnosisDone;

  /// No description provided for @diagnosisDemoBanner.
  ///
  /// In en, this message translates to:
  /// **'Demo mode: the real AI is not connected yet, so answers are examples.'**
  String get diagnosisDemoBanner;

  /// No description provided for @diagnosisDemoTag.
  ///
  /// In en, this message translates to:
  /// **'DEMO'**
  String get diagnosisDemoTag;

  /// No description provided for @diagnosisHealthy.
  ///
  /// In en, this message translates to:
  /// **'The plant looks healthy'**
  String get diagnosisHealthy;

  /// No description provided for @urgencyLow.
  ///
  /// In en, this message translates to:
  /// **'Not urgent'**
  String get urgencyLow;

  /// No description provided for @urgencyMedium.
  ///
  /// In en, this message translates to:
  /// **'Deal with it in the next few days'**
  String get urgencyMedium;

  /// No description provided for @urgencyHigh.
  ///
  /// In en, this message translates to:
  /// **'Urgent!'**
  String get urgencyHigh;

  /// No description provided for @diagnosisConfidence.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String diagnosisConfidence(int percent);

  /// No description provided for @diagnosisWhatToDo.
  ///
  /// In en, this message translates to:
  /// **'What to do'**
  String get diagnosisWhatToDo;

  /// No description provided for @diagnosisTips.
  ///
  /// In en, this message translates to:
  /// **'Care tips'**
  String get diagnosisTips;

  /// No description provided for @diagnosisDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This is AI advice and can be wrong. If the problem is serious or spreading, show the plant to an agronomist.'**
  String get diagnosisDisclaimer;

  /// No description provided for @errorNoConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet. Check the connection and try again.'**
  String get errorNoConnection;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'The server is taking too long. Please try again.'**
  String get errorTimeout;

  /// No description provided for @errorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'The server refused access. The app needs to be updated.'**
  String get errorUnauthorized;

  /// No description provided for @errorRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many checks today. Please try again later.'**
  String get errorRateLimited;

  /// No description provided for @errorImageUnclear.
  ///
  /// In en, this message translates to:
  /// **'The photo isn\'t clear enough. Take it closer and in good light.'**
  String get errorImageUnclear;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'The AI service isn\'t available right now. Please try again later. ({details})'**
  String errorServer(String details);

  /// No description provided for @errorInvalidResponse.
  ///
  /// In en, this message translates to:
  /// **'The server sent an answer the app doesn\'t understand.'**
  String get errorInvalidResponse;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorUnknown;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
