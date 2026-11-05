import 'dart:convert';

import '../models/diagnosis_request.dart';

/// What we tell Gemini, and the exact JSON shape we want back.
/// (Same text as server/src/prompt.ts, for when the app calls Gemini directly.)

const _languageNames = {'ru': 'Russian', 'en': 'English', 'uz': 'Uzbek'};

String geminiSystemInstruction(String language) {
  final name = _languageNames[language] ?? 'Russian';
  return '''You are an experienced plant doctor helping a family that grows tropical and subtropical fruit trees (banana, papaya, mandarin, lemon and similar) in homemade greenhouses in Uzbekistan. Winters there are cold, so low temperatures, poor light and humidity in the greenhouse are common causes of problems.

You get one photo and some context about the tree. Decide what is wrong, if anything.

Rules:
- Write every text field in $name, in simple words a non-expert can follow.
- Base the diagnosis on what is visible in the photo, then use the context (fruit, stage, outside temperature, recent care) to choose between likely causes.
- List at most 3 problems, most likely first. "confidence" is your honest probability from 0 to 1; when unsure, say so with a low value instead of guessing.
- Give concrete, practical actions the family can do this week. Name product types (e.g. "copper-based fungicide", "potassium fertilizer") rather than brands. Never give dangerous doses; say "follow the label".
- If a problem is serious or spreading fast, include an action to show the plant to a local agronomist.
- If the plant looks healthy, set healthy=true, urgency="low", problems=[] and give a short reassurance plus 1-2 care tips.
- If the photo is too blurry, dark, far away, or does not show a plant, set image_ok=false and use "summary" to say how to retake it.
- "summary" is one or two sentences: the main conclusion.''';
}

String geminiUserText(DiagnosisRequest request) {
  final context = request.contextJson()..remove('question');
  final question = request.question?.trim();
  return [
    'Context about this tree (JSON):',
    const JsonEncoder.withIndent('  ').convert(context),
    question != null && question.isNotEmpty
        ? 'The gardener says: "$question"'
        : 'The gardener did not describe the problem; look for anything wrong.',
  ].join('\n\n');
}

/// JSON Schema for Gemini's structured output.
const geminiResponseSchema = {
  'type': 'object',
  'properties': {
    'image_ok': {
      'type': 'boolean',
      'description': 'false if the photo cannot be used for a diagnosis',
    },
    'healthy': {'type': 'boolean'},
    'summary': {'type': 'string'},
    'urgency': {
      'type': 'string',
      'enum': ['low', 'medium', 'high'],
    },
    'problems': {
      'type': 'array',
      'maxItems': 3,
      'items': {
        'type': 'object',
        'properties': {
          'name': {'type': 'string'},
          'confidence': {'type': 'number', 'minimum': 0, 'maximum': 1},
          'description': {'type': 'string'},
          'actions': {
            'type': 'array',
            'items': {'type': 'string'},
          },
        },
        'required': ['name', 'confidence', 'actions'],
      },
    },
    'care_tips': {
      'type': 'array',
      'items': {'type': 'string'},
    },
  },
  'required': [
    'image_ok',
    'healthy',
    'summary',
    'urgency',
    'problems',
    'care_tips',
  ],
};
