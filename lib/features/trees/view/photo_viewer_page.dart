import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/storage/photo_storage.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/dialogs.dart';

/// Full-screen photo with pinch-to-zoom and delete.
class PhotoViewerPage extends StatelessWidget {
  const PhotoViewerPage({
    super.key,
    required this.photo,
    required this.onDelete,
  });

  final TreePhoto photo;
  final Future<void> Function() onDelete;

  static Future<void> open(
    BuildContext context, {
    required TreePhoto photo,
    required Future<void> Function() onDelete,
  }) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => PhotoViewerPage(photo: photo, onDelete: onDelete),
    ),
  );

  Future<void> _delete(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.photoDeleteTitle,
    );
    if (!confirmed || !context.mounted) return;
    Navigator.pop(context);
    await onDelete();
  }

  @override
  Widget build(BuildContext context) {
    final storage = context.read<PhotoStorage>();
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(formatDate(context, photo.takenAt)),
        actions: [
          IconButton(
            tooltip: l10n.delete,
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _delete(context),
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          maxScale: 5,
          child: Image.file(storage.fileFor(photo.fileName)),
        ),
      ),
    );
  }
}
