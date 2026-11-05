import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/database/app_database.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/storage/photo_storage.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/dialogs.dart';
import '../../../core/widgets/section_header.dart';
import '../../diagnosis/data/diagnosis_repository.dart';
import '../../diagnosis/view/diagnosis_page.dart';
import '../../diagnosis/view/diagnosis_record_page.dart';
import '../../fruit_types/cubit/fruit_types_cubit.dart';
import '../../fruit_types/fruit_type_name.dart';
import '../../journal/data/journal_repository.dart';
import '../../journal/view/journal_labels.dart';
import '../../plots/data/plot_repository.dart';
import '../../records/data/records_repository.dart';
import '../../records/view/harvest_form_page.dart';
import '../cubit/tree_detail_cubit.dart';
import '../data/tree_repository.dart';
import '../domain/fruiting.dart';
import 'photo_viewer_page.dart';
import 'tree_labels.dart';

/// The card for one tree: stage, quick diary actions, and its life story.
class TreePage extends StatelessWidget {
  const TreePage({super.key, required this.treeId});

  final int treeId;

  static Future<void> open(BuildContext context, int treeId) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => TreePage(treeId: treeId)),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TreeDetailCubit(
        treeId: treeId,
        trees: context.read<TreeRepository>(),
        plots: context.read<PlotRepository>(),
        journal: context.read<JournalRepository>(),
        records: context.read<RecordsRepository>(),
        diagnoses: context.read<DiagnosisRepository>(),
      ),
      child: const TreeView(),
    );
  }
}

class TreeView extends StatelessWidget {
  const TreeView({super.key});

  Future<void> _delete(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<TreeDetailCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.treeDeleteTitle,
      body: l10n.treeDeleteBody,
    );
    if (!confirmed || !context.mounted) return;
    Navigator.pop(context);
    await cubit.deleteTree();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<TreeDetailCubit, TreeDetailState>(
      builder: (context, state) {
        final tree = state.tree;
        if (tree == null) {
          return Scaffold(
            appBar: AppBar(),
            body: state.loaded
                ? const SizedBox.shrink()
                : const Center(child: CircularProgressIndicator()),
          );
        }
        final type = context.select(
          (FruitTypesCubit c) => c.state.byId(tree.fruitTypeId),
        );
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.treeTitle(type?.label(context) ?? '🌳', tree.id)),
            actions: [
              IconButton(
                tooltip: l10n.delete,
                icon: const Icon(Icons.delete_outline),
                onPressed: () => _delete(context),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              _QuickActions(tree: tree),
              _StageSelector(tree: tree),
              _InfoTiles(state: state, type: type),
              _PhotosSection(photos: state.photos),
              _Timeline(state: state),
            ],
          ),
        );
      },
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.tree});

  final Tree tree;

  Future<void> _log(BuildContext context, JournalKind kind) async {
    final l10n = AppLocalizations.of(context);
    final journal = context.read<JournalRepository>();
    final answer = await askJournalNote(context, kind);
    if (answer == null) return;
    await journal.logForTree(tree, kind, note: answer.note);
    if (context.mounted) {
      showSnack(
        context,
        l10n.journalSaved('${kind.emoji} ${kind.label(l10n)}'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: JournalActionChips(
        kinds: JournalKind.values,
        onSelected: (kind) => _log(context, kind),
        extra: [
          ActionChip(
            avatar: const Text('🧺'),
            label: Text(l10n.harvestTitle),
            onPressed: () => HarvestFormPage.open(context, tree: tree),
          ),
          ActionChip(
            avatar: const Text('🩺'),
            label: Text(l10n.diagnosisAction),
            onPressed: () => DiagnosisPage.open(context, tree.id),
          ),
        ],
      ),
    );
  }
}

class _StageSelector extends StatelessWidget {
  const _StageSelector({required this.tree});

  final Tree tree;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l10n.treeStage),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final stage in TreeStage.values)
                ChoiceChip(
                  label: Text(stage.label(l10n)),
                  selected: tree.stage == stage,
                  selectedColor: stage.color(scheme),
                  onSelected: (_) =>
                      context.read<TreeDetailCubit>().setStage(stage),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoTiles extends StatelessWidget {
  const _InfoTiles({required this.state, required this.type});

  final TreeDetailState state;
  final FruitType? type;

  Future<void> _pickPlantedDate(BuildContext context, Tree tree) async {
    final cubit = context.read<TreeDetailCubit>();
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: tree.plantedOn ?? now,
      firstDate: DateTime(now.year - 40),
      lastDate: now,
    );
    if (picked != null) await cubit.setPlantedOn(picked);
  }

  Future<void> _editText(
    BuildContext context, {
    required String title,
    required String? value,
    required Future<void> Function(String) onSave,
    bool multiline = false,
  }) async {
    final text = await showTextInputDialog(
      context,
      title: title,
      initialValue: value,
      multiline: multiline,
    );
    if (text != null) await onSave(text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<TreeDetailCubit>();
    final tree = state.tree!;
    final type = this.type;
    final planted = tree.plantedOn;
    return Column(
      children: [
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.place_outlined),
          title: Text(l10n.treeLocation),
          subtitle: Text(state.plot?.name ?? '…'),
        ),
        ListTile(
          leading: const Icon(Icons.event_outlined),
          title: Text(l10n.treePlanted),
          subtitle: Text(
            planted == null ? l10n.notSet : formatDate(context, planted),
          ),
          trailing: const Icon(Icons.edit_outlined),
          onTap: () => _pickPlantedDate(context, tree),
        ),
        if (type != null)
          ListTile(
            leading: const Icon(Icons.eco_outlined),
            title: Text(l10n.treeExpectedFruit),
            subtitle: Text(
              forecastLabel(
                context,
                forecastFruiting(tree, type, DateTime.now()),
              ),
            ),
          ),
        if (state.harvests.isNotEmpty)
          ListTile(
            leading: const Text('🧺', style: TextStyle(fontSize: 22)),
            title: Text(l10n.treeTotalHarvest),
            subtitle: Text(formatKg(context, state.totalHarvestKg)),
          ),
        ListTile(
          leading: const Icon(Icons.label_outline),
          title: Text(l10n.treeVariety),
          subtitle: Text(tree.variety ?? l10n.notSet),
          trailing: const Icon(Icons.edit_outlined),
          onTap: () => _editText(
            context,
            title: l10n.treeVariety,
            value: tree.variety,
            onSave: cubit.setVariety,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.notes),
          title: Text(l10n.treeNotes),
          subtitle: Text(tree.notes ?? l10n.notSet),
          trailing: const Icon(Icons.edit_outlined),
          onTap: () => _editText(
            context,
            title: l10n.treeNotes,
            value: tree.notes,
            onSave: cubit.setNotes,
            multiline: true,
          ),
        ),
      ],
    );
  }
}

class _PhotosSection extends StatelessWidget {
  const _PhotosSection({required this.photos});

  final List<TreePhoto> photos;

  Future<void> _addPhoto(BuildContext context, ImageSource source) async {
    final cubit = context.read<TreeDetailCubit>();
    final picked = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1600,
      imageQuality: 80,
    );
    if (picked != null) await cubit.addPhoto(picked.path);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final storage = context.read<PhotoStorage>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l10n.treePhotos),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: () => _addPhoto(context, ImageSource.camera),
                  icon: const Icon(Icons.photo_camera_outlined),
                  label: Text(l10n.photoCamera),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: () => _addPhoto(context, ImageSource.gallery),
                  icon: const Icon(Icons.photo_library_outlined),
                  label: Text(l10n.photoGallery),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (photos.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(l10n.treeNoPhotos),
          )
        else
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: photos.length,
              separatorBuilder: (_, _) => const SizedBox(width: 6),
              itemBuilder: (context, i) {
                final photo = photos[i];
                return GestureDetector(
                  onTap: () => PhotoViewerPage.open(
                    context,
                    photo: photo,
                    onDelete: () =>
                        context.read<TreeDetailCubit>().deletePhoto(photo),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      storage.fileFor(photo.fileName),
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      cacheWidth: 330,
                      errorBuilder: (_, _, _) => const SizedBox(
                        width: 110,
                        child: Icon(Icons.broken_image_outlined),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

/// The tree's life story: planted, diary, harvests and photos by date.
class _Timeline extends StatelessWidget {
  const _Timeline({required this.state});

  final TreeDetailState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tree = state.tree!;
    final events = <_Event>[
      for (final j in state.journal)
        _Event(
          date: j.date,
          emoji: j.kind.emoji,
          title: j.treeId == null
              ? '${j.kind.label(l10n)} · ${l10n.timelineWholePlot}'
              : j.kind.label(l10n),
          subtitle: j.note,
          onLongPress: () async {
            final cubit = context.read<TreeDetailCubit>();
            if (await showConfirmDialog(
              context,
              title: l10n.recordDeleteTitle,
            )) {
              await cubit.deleteJournalEntry(j.id);
            }
          },
        ),
      for (final h in state.harvests)
        _Event(
          date: h.date,
          emoji: '🧺',
          title: '${l10n.harvestTitle} · ${formatKg(context, h.kg)}',
          subtitle: h.note,
          onTap: () => HarvestFormPage.open(context, existing: h, tree: tree),
        ),
      for (final d in state.diagnoses)
        _Event(
          date: d.date,
          emoji: '🩺',
          title: '${l10n.diagnosisTitle}: ${d.summary}',
          subtitle: d.question,
          onTap: () => DiagnosisRecordPage.open(context, d),
        ),
      for (final p in state.photos)
        _Event(date: p.takenAt, emoji: '📷', title: l10n.timelinePhoto),
      if (tree.plantedOn != null)
        _Event(date: tree.plantedOn!, emoji: '🌱', title: l10n.timelinePlanted),
    ]..sort((a, b) => b.date.compareTo(a.date));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l10n.timelineTitle, subtitle: l10n.timelineHint),
        if (events.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(l10n.timelineEmpty),
          ),
        for (final e in events)
          ListTile(
            leading: Text(e.emoji, style: const TextStyle(fontSize: 24)),
            title: Text(e.title),
            subtitle: Text(
              [formatDate(context, e.date), ?e.subtitle].join(' · '),
            ),
            onTap: e.onTap,
            onLongPress: e.onLongPress,
          ),
      ],
    );
  }
}

class _Event {
  const _Event({
    required this.date,
    required this.emoji,
    required this.title,
    this.subtitle,
    this.onTap,
    this.onLongPress,
  });

  final DateTime date;
  final String emoji;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
}
