import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/note.dart';
import '../providers/profile_provider.dart';

/// Notes tab with timeline and CRUD actions
class NotesTab extends StatelessWidget {
  const NotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingNotes) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.notes.isEmpty) {
          return _buildEmptyState(context);
        }

        return Column(
          children: [
            // Header with search/filter
            _buildHeader(context),

            // Notes list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Pinned notes
                  if (provider.pinnedNotes.isNotEmpty) ...[
                    _buildSectionHeader(context, 'Pinned'),
                    const SizedBox(height: 8),
                    ...provider.pinnedNotes.map(
                      (note) => _buildNoteCard(context, note),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Regular notes
                  if (provider.unpinnedNotes.isNotEmpty) ...[
                    if (provider.pinnedNotes.isNotEmpty)
                      _buildSectionHeader(context, 'All Notes'),
                    if (provider.pinnedNotes.isNotEmpty)
                      const SizedBox(height: 8),
                    ...provider.unpinnedNotes.map(
                      (note) => _buildNoteCard(context, note),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_add_outlined,
            size: 64,
            color: Theme.of(context).primaryColor.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No notes yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first note to track this relationship',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _addNote(context),
            icon: const Icon(Icons.add),
            label: const Text('Add Note'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _addNote(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Note'),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _searchNotes(context),
            tooltip: 'Search notes',
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _filterNotes(context),
            tooltip: 'Filter notes',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildNoteCard(BuildContext context, Note note) {
    return Dismissible(
      key: Key(note.id),
      background: _buildSwipeBackground(context, Alignment.centerLeft,
          Colors.blue, Icons.edit, 'Edit'),
      secondaryBackground: _buildSwipeBackground(context, Alignment.centerRight,
          Colors.red, Icons.delete, 'Delete'),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Edit
          _editNote(context, note);
          return false;
        } else {
          // Delete
          return await _confirmDelete(context, note);
        }
      },
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: note.colorTag != null
              ? BorderSide(
                  color: Color(int.parse('0xFF${note.colorTag}')),
                  width: 2,
                )
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: () => _viewNote(context, note),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with icon and metadata
                Row(
                  children: [
                    Text(
                      note.typeIcon,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                timeago.format(note.createdAt),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                              const Text(' • '),
                              Text(
                                note.typeLabel,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Pin icon
                    if (note.isPinned)
                      const Icon(
                        Icons.push_pin,
                        size: 18,
                        color: Colors.amber,
                      ),
                    // More menu
                    PopupMenuButton<String>(
                      onSelected: (value) =>
                          _handleNoteAction(context, value, note),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'pin',
                          child: Row(
                            children: [
                              Icon(
                                note.isPinned
                                    ? Icons.push_pin_outlined
                                    : Icons.push_pin,
                              ),
                              const SizedBox(width: 8),
                              Text(note.isPinned ? 'Unpin' : 'Pin'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Delete',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Note content
                Text(
                  note.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                // Location
                if (note.location != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        note.location!,
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[600],
                                ),
                      ),
                    ],
                  ),
                ],

                // Tags
                if (note.tags.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: note.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '#$tag',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeBackground(
    BuildContext context,
    Alignment alignment,
    Color color,
    IconData icon,
    String label,
  ) {
    return Container(
      color: color,
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _handleNoteAction(BuildContext context, String action, Note note) {
    switch (action) {
      case 'pin':
        context.read<ProfileProvider>().toggleNotePinned(note.id);
        break;
      case 'edit':
        _editNote(context, note);
        break;
      case 'delete':
        _deleteNote(context, note);
        break;
    }
  }

  void _addNote(BuildContext context) {
    // TODO: Navigate to Add Note screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add Note screen coming soon')),
    );
  }

  void _editNote(BuildContext context, Note note) {
    // TODO: Navigate to Edit Note screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit note: ${note.title}')),
    );
  }

  void _viewNote(BuildContext context, Note note) {
    // TODO: Navigate to Note Detail screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('View note: ${note.title}')),
    );
  }

  Future<bool> _confirmDelete(BuildContext context, Note note) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete note?'),
            content: const Text('This action cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _deleteNote(BuildContext context, Note note) async {
    final confirmed = await _confirmDelete(context, note);
    if (confirmed && context.mounted) {
      final success =
          await context.read<ProfileProvider>().deleteNote(note.id);
      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Note deleted')),
        );
      }
    }
  }

  void _searchNotes(BuildContext context) {
    // TODO: Implement search functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Search notes - Coming soon')),
    );
  }

  void _filterNotes(BuildContext context) {
    // TODO: Implement filter functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Filter notes - Coming soon')),
    );
  }
}
