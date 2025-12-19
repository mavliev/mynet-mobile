import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/connection_degree.dart';
import '../models/filter_state.dart';
import '../providers/search_provider.dart';
import '../theme/app_theme.dart';

/// Bottom sheet for advanced filtering options
class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  ConsumerState<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<FilterBottomSheet> {
  late FilterState _currentFilter;
  final TextEditingController _companySearchController = TextEditingController();
  final TextEditingController _locationSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentFilter = ref.read(filterStateProvider);
  }

  @override
  void dispose() {
    _companySearchController.dispose();
    _locationSearchController.dispose();
    super.dispose();
  }

  void _toggleConnectionDegree(ConnectionDegree degree) {
    setState(() {
      final degrees = Set<ConnectionDegree>.from(_currentFilter.connectionDegrees);
      if (degrees.contains(degree)) {
        degrees.remove(degree);
      } else {
        degrees.add(degree);
      }
      _currentFilter = _currentFilter.copyWith(connectionDegrees: degrees);
    });
  }

  void _toggleCompany(String company) {
    setState(() {
      final companies = Set<String>.from(_currentFilter.companies);
      if (companies.contains(company)) {
        companies.remove(company);
      } else {
        companies.add(company);
      }
      _currentFilter = _currentFilter.copyWith(companies: companies);
    });
  }

  void _toggleLocation(String location) {
    setState(() {
      final locations = Set<String>.from(_currentFilter.locations);
      if (locations.contains(location)) {
        locations.remove(location);
      } else {
        locations.add(location);
      }
      _currentFilter = _currentFilter.copyWith(locations: locations);
    });
  }

  void _setDateRange(DateRangeFilter? dateRange) {
    setState(() {
      _currentFilter = _currentFilter.copyWith(
        dateRange: dateRange,
        clearDateRange: dateRange == null,
      );
    });
  }

  void _toggleTag(String tag) {
    setState(() {
      final tags = Set<String>.from(_currentFilter.tags);
      if (tags.contains(tag)) {
        tags.remove(tag);
      } else {
        tags.add(tag);
      }
      _currentFilter = _currentFilter.copyWith(tags: tags);
    });
  }

  void _applyFilters() {
    ref.read(filterStateProvider.notifier).state = _currentFilter;
    Navigator.of(context).pop();
  }

  void _clearAllFilters() {
    setState(() {
      _currentFilter = const FilterState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableCompanies = ref.watch(availableCompaniesProvider);
    final availableLocations = ref.watch(availableLocationsProvider);
    final availableTags = ref.watch(availableTagsProvider);

    final filteredCompanies = _companySearchController.text.isEmpty
        ? availableCompanies
        : availableCompanies
            .where((c) => c.toLowerCase().contains(_companySearchController.text.toLowerCase()))
            .toList();

    final filteredLocations = _locationSearchController.text.isEmpty
        ? availableLocations
        : availableLocations
            .where((l) => l.toLowerCase().contains(_locationSearchController.text.toLowerCase()))
            .toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppTheme.radiusLarge),
            ),
          ),
          child: Column(
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: AppTheme.space2),
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(AppTheme.space4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filters',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Filter content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(AppTheme.space4),
                  children: [
                    // Connection Degree
                    _buildSectionHeader(context, 'Connection Degree'),
                    Wrap(
                      spacing: AppTheme.space2,
                      children: ConnectionDegree.values.map((degree) {
                        final isSelected = _currentFilter.connectionDegrees.contains(degree);
                        return FilterChip(
                          label: Text(degree.label),
                          selected: isSelected,
                          onSelected: (_) => _toggleConnectionDegree(degree),
                          avatar: isSelected
                              ? null
                              : CircleAvatar(
                                  backgroundColor: degree.color.withValues(alpha: 0.2),
                                  radius: 8,
                                ),
                          selectedColor: degree.color.withValues(alpha: 0.2),
                          checkmarkColor: degree.color,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppTheme.space5),

                    // Company
                    _buildSectionHeader(context, 'Company'),
                    TextField(
                      controller: _companySearchController,
                      decoration: const InputDecoration(
                        hintText: 'Search companies...',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: AppTheme.space2),
                    ...filteredCompanies.take(5).map((company) {
                      return CheckboxListTile(
                        dense: true,
                        title: Text(company),
                        value: _currentFilter.companies.contains(company),
                        onChanged: (_) => _toggleCompany(company),
                      );
                    }),
                    if (filteredCompanies.length > 5)
                      TextButton(
                        onPressed: () {
                          // Show all companies dialog
                          showDialog(
                            context: context,
                            builder: (context) => _buildFullListDialog(
                              context,
                              'All Companies',
                              filteredCompanies,
                              _currentFilter.companies,
                              _toggleCompany,
                            ),
                          );
                        },
                        child: const Text('Show all companies'),
                      ),
                    const SizedBox(height: AppTheme.space5),

                    // Location
                    _buildSectionHeader(context, 'Location'),
                    TextField(
                      controller: _locationSearchController,
                      decoration: const InputDecoration(
                        hintText: 'Search locations...',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: AppTheme.space2),
                    ...filteredLocations.take(5).map((location) {
                      return CheckboxListTile(
                        dense: true,
                        title: Text(location),
                        value: _currentFilter.locations.contains(location),
                        onChanged: (_) => _toggleLocation(location),
                      );
                    }),
                    if (filteredLocations.length > 5)
                      TextButton(
                        onPressed: () {
                          // Show all locations dialog
                          showDialog(
                            context: context,
                            builder: (context) => _buildFullListDialog(
                              context,
                              'All Locations',
                              filteredLocations,
                              _currentFilter.locations,
                              _toggleLocation,
                            ),
                          );
                        },
                        child: const Text('Show all locations'),
                      ),
                    const SizedBox(height: AppTheme.space5),

                    // Last Contact
                    _buildSectionHeader(context, 'Last Contact'),
                    Column(
                      children: [
                        RadioListTile<DateRangeFilter?>(
                          dense: true,
                          title: const Text('Any time'),
                          value: null,
                          groupValue: _currentFilter.dateRange,
                          onChanged: _setDateRange,
                        ),
                        ...DateRangeFilter.values.where((d) => d != DateRangeFilter.custom).map(
                          (range) => RadioListTile<DateRangeFilter>(
                            dense: true,
                            title: Text(range.label),
                            value: range,
                            groupValue: _currentFilter.dateRange,
                            onChanged: _setDateRange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.space5),

                    // Tags
                    _buildSectionHeader(context, 'Tags'),
                    Wrap(
                      spacing: AppTheme.space2,
                      runSpacing: AppTheme.space2,
                      children: availableTags.map((tag) {
                        final isSelected = _currentFilter.tags.contains(tag);
                        return FilterChip(
                          label: Text(tag),
                          selected: isSelected,
                          onSelected: (_) => _toggleTag(tag),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppTheme.space8),
                  ],
                ),
              ),
              // Action buttons
              Container(
                padding: const EdgeInsets.all(AppTheme.space4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _clearAllFilters,
                        child: const Text('Clear All'),
                      ),
                    ),
                    const SizedBox(width: AppTheme.space3),
                    Expanded(
                      child: FilledButton(
                        onPressed: _applyFilters,
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.space2),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _buildFullListDialog(
    BuildContext context,
    String title,
    List<String> items,
    Set<String> selected,
    void Function(String) onToggle,
  ) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return CheckboxListTile(
              dense: true,
              title: Text(item),
              value: selected.contains(item),
              onChanged: (_) {
                onToggle(item);
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
