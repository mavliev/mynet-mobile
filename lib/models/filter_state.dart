import 'connection_degree.dart';

/// Represents the current filter state for contact search
class FilterState {
  final Set<ConnectionDegree> connectionDegrees;
  final Set<String> companies;
  final Set<String> locations;
  final DateRangeFilter? dateRange;
  final Set<String> tags;

  const FilterState({
    this.connectionDegrees = const {},
    this.companies = const {},
    this.locations = const {},
    this.dateRange,
    this.tags = const {},
  });

  /// Check if any filters are active
  bool get hasActiveFilters =>
      connectionDegrees.isNotEmpty ||
      companies.isNotEmpty ||
      locations.isNotEmpty ||
      dateRange != null ||
      tags.isNotEmpty;

  /// Count of active filters
  int get activeFilterCount {
    int count = 0;
    if (connectionDegrees.isNotEmpty) count++;
    if (companies.isNotEmpty) count += companies.length;
    if (locations.isNotEmpty) count += locations.length;
    if (dateRange != null) count++;
    if (tags.isNotEmpty) count += tags.length;
    return count;
  }

  /// Create a copy with modified fields
  FilterState copyWith({
    Set<ConnectionDegree>? connectionDegrees,
    Set<String>? companies,
    Set<String>? locations,
    DateRangeFilter? dateRange,
    bool clearDateRange = false,
    Set<String>? tags,
  }) {
    return FilterState(
      connectionDegrees: connectionDegrees ?? this.connectionDegrees,
      companies: companies ?? this.companies,
      locations: locations ?? this.locations,
      dateRange: clearDateRange ? null : (dateRange ?? this.dateRange),
      tags: tags ?? this.tags,
    );
  }

  /// Clear all filters
  FilterState clear() {
    return const FilterState();
  }
}

/// Date range filter options
enum DateRangeFilter {
  lastWeek('Last week'),
  lastMonth('Last month'),
  lastThreeMonths('Last 3 months'),
  lastYear('Last year'),
  custom('Custom range');

  const DateRangeFilter(this.label);

  final String label;

  /// Get the date threshold for this filter
  DateTime get threshold {
    final now = DateTime.now();
    switch (this) {
      case DateRangeFilter.lastWeek:
        return now.subtract(const Duration(days: 7));
      case DateRangeFilter.lastMonth:
        return now.subtract(const Duration(days: 30));
      case DateRangeFilter.lastThreeMonths:
        return now.subtract(const Duration(days: 90));
      case DateRangeFilter.lastYear:
        return now.subtract(const Duration(days: 365));
      case DateRangeFilter.custom:
        return now; // Should be handled separately
    }
  }
}
