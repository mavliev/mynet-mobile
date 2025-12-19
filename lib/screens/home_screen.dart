import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/connection_degree.dart';
import '../models/contact.dart';
import '../providers/search_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/contact_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/search_bar_widget.dart';

/// Main home screen with search and contact list
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showFilterChips = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Hide filter chips when scrolling down, show when scrolling up
    if (_scrollController.hasClients) {
      final direction = _scrollController.position.userScrollDirection;
      final bool shouldShow = direction == ScrollDirection.forward || direction == ScrollDirection.idle;
      if (_showFilterChips != shouldShow) {
        setState(() {
          _showFilterChips = shouldShow;
        });
      }
    }
  }

  Future<void> _onRefresh() async {
    // Simulate refresh
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Contacts synced'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  void _showSortMenu() {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(1000, 80, 0, 0),
      items: SortOption.values.map((option) {
        return PopupMenuItem(
          value: option,
          child: Text(option.label),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        ref.read(sortOptionProvider.notifier).state = value;
      }
    });
  }

  void _onContactTap(Contact contact) {
    // Navigate to profile detail (placeholder)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening profile for ${contact.fullName}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onContactCall(Contact contact) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calling ${contact.fullName}...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onContactEmail(Contact contact) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Emailing ${contact.fullName}...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onContactLongPress(Contact contact) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.space4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Call'),
              onTap: () {
                Navigator.pop(context);
                _onContactCall(contact);
              },
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              onTap: () {
                Navigator.pop(context);
                _onContactEmail(contact);
              },
            ),
            ListTile(
              leading: const Icon(Icons.note_add),
              title: const Text('Add Note'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add Note (not yet implemented)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onFabPressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add Contact (not yet implemented)'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contacts = ref.watch(filteredContactsProvider);
    final filterState = ref.watch(filterStateProvider);
    final sortOption = ref.watch(sortOptionProvider);
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Navigation drawer (not yet implemented)')),
            );
          },
        ),
        title: const Text('myNET'),
        actions: [
          // Filter badge with count
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: _showFilterBottomSheet,
                tooltip: 'Advanced filters',
              ),
              if (filterState.hasActiveFilters)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppTheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${filterState.activeFilterCount}',
                      style: const TextStyle(
                        color: AppTheme.onSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User profile (not yet implemented)')),
              );
            },
            tooltip: 'User profile',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Column(
          children: [
            // Search bar
            const SearchBarWidget(),
            // Filter chips
            if (_showFilterChips) _buildFilterChips(),
            // Sort bar
            _buildSortBar(sortOption),
            const Divider(height: 1),
            // Contact list
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : contacts.isEmpty
                      ? _buildEmptyState()
                      : _buildContactList(contacts),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        tooltip: 'Add contact',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filterState = ref.watch(filterStateProvider);

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // Connection degree chips
          ...ConnectionDegree.values.map((degree) {
            final isSelected = filterState.connectionDegrees.contains(degree);
            return Padding(
              padding: const EdgeInsets.only(right: AppTheme.space2),
              child: FilterChip(
                label: Text(degree.label),
                selected: isSelected,
                onSelected: (selected) {
                  final degrees = Set<ConnectionDegree>.from(filterState.connectionDegrees);
                  if (selected) {
                    degrees.add(degree);
                  } else {
                    degrees.remove(degree);
                  }
                  ref.read(filterStateProvider.notifier).state =
                      filterState.copyWith(connectionDegrees: degrees);
                },
                avatar: isSelected
                    ? null
                    : CircleAvatar(
                        backgroundColor: degree.color.withOpacity(0.2),
                        radius: 8,
                      ),
                selectedColor: degree.color.withOpacity(0.2),
                checkmarkColor: degree.color,
              ),
            );
          }),
          // Advanced filter chip
          FilterChip(
            label: const Text('+Filter'),
            onSelected: (_) => _showFilterBottomSheet(),
            avatar: const Icon(Icons.add, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSortBar(SortOption sortOption) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: _showSortMenu,
            child: Row(
              children: [
                Text(
                  'Sort: ${sortOption.label}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Icon(Icons.arrow_drop_down, size: 20),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.grid_view, size: 20),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Grid view (not yet implemented)')),
                  );
                },
                tooltip: 'Grid view',
              ),
              IconButton(
                icon: const Icon(Icons.view_list, size: 20),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('List view (active)')),
                  );
                },
                tooltip: 'List view',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactList(List<Contact> contacts) {
    return AnimationLimiter(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 300),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: ContactCard(
                  contact: contact,
                  onTap: () => _onContactTap(contact),
                  onCall: () => _onContactCall(contact),
                  onEmail: () => _onContactEmail(contact),
                  onLongPress: () => _onContactLongPress(contact),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    final searchQuery = ref.watch(searchQueryProvider);
    final filterState = ref.watch(filterStateProvider);

    if (searchQuery.isNotEmpty || filterState.hasActiveFilters) {
      // No search results
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: AppTheme.primary.withOpacity(0.3),
            ),
            const SizedBox(height: AppTheme.space4),
            Text(
              'No contacts match your search',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppTheme.space2),
            Text(
              'Try adjusting your filters or search query',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                  ),
            ),
            const SizedBox(height: AppTheme.space5),
            OutlinedButton(
              onPressed: () {
                ref.read(searchQueryProvider.notifier).state = '';
                ref.read(filterStateProvider.notifier).state = FilterState();
              },
              child: const Text('Clear filters'),
            ),
          ],
        ),
      );
    }

    // No contacts at all
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.contacts,
            size: 64,
            color: AppTheme.primary.withOpacity(0.3),
          ),
          const SizedBox(height: AppTheme.space4),
          Text(
            'No contacts yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppTheme.space2),
          Text(
            'Tap + to add your first contact',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                ),
          ),
        ],
      ),
    );
  }
}
