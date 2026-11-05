import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/network/api_exception.dart';
import '../../data/models/diagnosis.dart';

/// The answer: overall verdict, likely problems with what to do, and tips.
class DiagnosisResultView extends StatelessWidget {
  const DiagnosisResultView({super.key, required this.diagnosis});

  final Diagnosis diagnosis;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final (emoji, verdict, color) = diagnosis.healthy
        ? ('✅', l10n.diagnosisHealthy, Colors.green.shade100)
        : switch (diagnosis.urgency) {
            Urgency.high => (
              '🚨',
              l10n.urgencyHigh,
              theme.colorScheme.errorContainer,
            ),
            Urgency.medium => (
              '⚠️',
              l10n.urgencyMedium,
              Colors.orange.shade100,
            ),
            Urgency.low => ('ℹ️', l10n.urgencyLow, Colors.blue.shade50),
          };
    final onColor = Colors.black87;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (diagnosis.isDemo)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Chip(
              avatar: const Icon(Icons.science_outlined, size: 18),
              label: Text(l10n.diagnosisDemoTag),
            ),
          ),
        Card(
          margin: EdgeInsets.zero,
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(emoji, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        verdict,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: onColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  diagnosis.summary,
                  style: theme.textTheme.bodyLarge?.copyWith(color: onColor),
                ),
              ],
            ),
          ),
        ),
        for (final problem in diagnosis.problems) ...[
          const SizedBox(height: 12),
          _ProblemCard(problem: problem),
        ],
        if (diagnosis.careTips.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(l10n.diagnosisTips, style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          for (final tip in diagnosis.careTips)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text('• $tip'),
            ),
        ],
        const SizedBox(height: 16),
        Text(
          l10n.diagnosisDisclaimer,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _ProblemCard extends StatelessWidget {
  const _ProblemCard({required this.problem});

  final DiagnosisProblem problem;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final percent = (problem.confidence * 100).round();
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(problem.name, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: problem.confidence,
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(l10n.diagnosisConfidence(percent)),
              ],
            ),
            if (problem.description != null) ...[
              const SizedBox(height: 8),
              Text(problem.description!),
            ],
            if (problem.actions.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(l10n.diagnosisWhatToDo, style: theme.textTheme.titleSmall),
              const SizedBox(height: 4),
              for (final (i, action) in problem.actions.indexed)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text('${i + 1}. $action'),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A message the family can act on, for each kind of network failure.
String diagnosisErrorMessage(AppLocalizations l10n, ApiException error) =>
    switch (error) {
      NoConnectionException() => l10n.errorNoConnection,
      ApiTimeoutException() => l10n.errorTimeout,
      UnauthorizedException() => l10n.errorUnauthorized,
      RateLimitedException() => l10n.errorRateLimited,
      // The server's message here is the AI's own advice on how to retake
      // the photo, already in the user's language.
      ServerException(code: 'image_unclear', :final message) =>
        message ?? l10n.errorImageUnclear,
      ServerException(:final code, :final statusCode) => l10n.errorServer(
        code ?? 'HTTP $statusCode',
      ),
      InvalidResponseException() => l10n.errorInvalidResponse,
      RequestCancelledException() || UnknownApiException() => l10n.errorUnknown,
    };
