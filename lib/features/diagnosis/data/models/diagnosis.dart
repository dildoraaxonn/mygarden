import 'package:equatable/equatable.dart';

import '../../../../core/network/api_exception.dart';

enum Urgency {
  low,
  medium,
  high;

  static Urgency parse(Object? value) => switch (value) {
    'high' => Urgency.high,
    'medium' => Urgency.medium,
    _ => Urgency.low,
  };
}

class DiagnosisProblem extends Equatable {
  const DiagnosisProblem({
    required this.name,
    required this.confidence,
    this.description,
    this.actions = const [],
  });

  factory DiagnosisProblem.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    if (name is! String || name.trim().isEmpty) {
      throw const InvalidResponseException('problem without a name');
    }
    final confidence = json['confidence'];
    return DiagnosisProblem(
      name: name.trim(),
      confidence: confidence is num
          ? confidence.toDouble().clamp(0.0, 1.0)
          : 0.0,
      description: _optionalString(json['description']),
      actions: _stringList(json['actions']),
    );
  }

  final String name;

  /// 0..1 — how sure the AI is.
  final double confidence;
  final String? description;
  final List<String> actions;

  Map<String, dynamic> toJson() => {
    'name': name,
    'confidence': confidence,
    'description': ?description,
    'actions': actions,
  };

  @override
  List<Object?> get props => [name, confidence, description, actions];
}

/// The plant doctor's answer. Same shape whichever AI is behind the server.
/// See docs/diagnosis_api.md.
class Diagnosis extends Equatable {
  const Diagnosis({
    required this.healthy,
    required this.summary,
    required this.urgency,
    this.problems = const [],
    this.careTips = const [],
    this.model,
  });

  /// Parses the server answer. Unknown fields are ignored and missing
  /// optional ones get defaults, so the server can evolve without breaking
  /// older app versions.
  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    final summary = json['summary'];
    if (summary is! String || summary.trim().isEmpty) {
      throw const InvalidResponseException('missing summary');
    }
    final problems = json['problems'];
    return Diagnosis(
      healthy: json['healthy'] == true,
      summary: summary.trim(),
      urgency: Urgency.parse(json['urgency']),
      problems: problems is List
          ? [
              for (final p in problems)
                if (p is Map<String, dynamic>) DiagnosisProblem.fromJson(p),
            ]
          : const [],
      careTips: _stringList(json['care_tips']),
      model: _optionalString(json['model']),
    );
  }

  final bool healthy;
  final String summary;
  final Urgency urgency;

  /// Most likely problem first.
  final List<DiagnosisProblem> problems;
  final List<String> careTips;

  /// Which AI answered (for our own records); "demo" in demo mode.
  final String? model;

  bool get isDemo => model == demoModel;

  static const demoModel = 'demo';

  Map<String, dynamic> toJson() => {
    'healthy': healthy,
    'summary': summary,
    'urgency': urgency.name,
    'problems': [for (final p in problems) p.toJson()],
    'care_tips': careTips,
    'model': ?model,
  };

  @override
  List<Object?> get props => [
    healthy,
    summary,
    urgency,
    problems,
    careTips,
    model,
  ];
}

String? _optionalString(Object? value) =>
    value is String && value.trim().isNotEmpty ? value.trim() : null;

List<String> _stringList(Object? value) => value is List
    ? [
        for (final v in value)
          if (v is String && v.trim().isNotEmpty) v.trim(),
      ]
    : const [];
