import 'package:intl/intl.dart';

/// One recent care event, sent as context ("fertilized 9 days ago").
class CareEvent {
  const CareEvent({required this.kind, required this.date, this.note});

  final String kind;
  final DateTime date;
  final String? note;

  Map<String, dynamic> toJson() => {
    'kind': kind,
    'date': _day.format(date),
    'note': ?note,
  };
}

final _day = DateFormat('yyyy-MM-dd');

/// Everything sent with a photo. Context helps the AI a lot: a yellow
/// banana leaf means something different in a cold greenhouse in December.
class DiagnosisRequest {
  const DiagnosisRequest({
    required this.imagePath,
    required this.language,
    required this.fruit,
    this.fruitLocal,
    this.variety,
    this.stage,
    this.plantedOn,
    this.location,
    this.outsideMinTempC,
    this.question,
    this.recentCare = const [],
  });

  final String imagePath;

  /// Language for the answer: "ru" or "en".
  final String language;

  /// Fruit name in English, e.g. "Banana" (models know English names best).
  final String fruit;

  /// Fruit name as the family calls it, e.g. "Банан".
  final String? fruitLocal;
  final String? variety;

  /// seedling | growing | flowering | fruiting
  final String? stage;
  final DateTime? plantedOn;

  /// e.g. "Tashkent, Uzbekistan".
  final String? location;

  /// Coldest night in the forecast, outside the greenhouse.
  final double? outsideMinTempC;

  /// What the user noticed, in their words.
  final String? question;
  final List<CareEvent> recentCare;

  Map<String, dynamic> contextJson() => {
    'language': language,
    'plant': {
      'fruit': fruit,
      'fruit_local': ?fruitLocal,
      'variety': ?variety,
      'stage': ?stage,
      if (plantedOn != null) 'planted_on': _day.format(plantedOn!),
    },
    'growing': {
      'setting': 'homemade greenhouse',
      'location': ?location,
      'outside_min_temp_c': ?outsideMinTempC,
    },
    'question': ?question,
    'recent_care': [for (final c in recentCare) c.toJson()],
  };
}
