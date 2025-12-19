import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/contact.dart';
import '../models/connection_degree.dart';

// Search State Management

class SearchState {
  final String query;
  final SearchType type;
  final bool isActive;

  SearchState({
    this.query = '',
    this.type = SearchType.profiles,
    this.isActive = false,
  });

  SearchState copyWith({
    String? query,
    SearchType? type,
    bool? isActive,
  }) {
    return SearchState(
      query: query ?? this.query,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
    );
  }
}

enum SearchType {
  profiles,
  notes,
  tags,
  companies,
}

// Sort Options
enum SortOption {
  nameAsc('Name (A-Z)'),
  nameDesc('Name (Z-A)'),
  recentFirst('Recently Added'),
  companyAsc('Company (A-Z)');

  final String label;
  const SortOption(this.label);
}

// Filter State
class FilterState {
  final String? company;
  final String? location;
  final bool? isRecruiter;
  final List<String> selectedTags;
  final List<ConnectionDegree> connectionDegrees;

  FilterState({
    this.company,
    this.location,
    this.isRecruiter,
    this.selectedTags = const [],
    this.connectionDegrees = const [],
  });

  FilterState copyWith({
    String? company,
    String? location,
    bool? isRecruiter,
    List<String>? selectedTags,
    List<ConnectionDegree>? connectionDegrees,
  }) {
    return FilterState(
      company: company ?? this.company,
      location: location ?? this.location,
      isRecruiter: isRecruiter ?? this.isRecruiter,
      selectedTags: selectedTags ?? this.selectedTags,
      connectionDegrees: connectionDegrees ?? this.connectionDegrees,
    );
  }

  bool get isActive =>
      company != null || location != null || isRecruiter != null ||
      selectedTags.isNotEmpty || connectionDegrees.isNotEmpty;

  bool get hasActiveFilters => isActive;

  int get activeFilterCount {
    int count = 0;
    if (company != null) count++;
    if (location != null) count++;
    if (isRecruiter != null) count++;
    count += selectedTags.length;
    count += connectionDegrees.length;
    return count;
  }
}

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(SearchState());

  void setQuery(String query) {
    state = state.copyWith(query: query, isActive: query.isNotEmpty);
  }

  void setType(SearchType type) {
    state = state.copyWith(type: type);
  }

  void activate() {
    state = state.copyWith(isActive: true);
  }

  void deactivate() {
    state = state.copyWith(isActive: false, query: '');
  }

  void clear() {
    state = SearchState();
  }
}

// Provider
final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier();
});

// Recent Searches Provider
class RecentSearchesNotifier extends StateNotifier<List<String>> {
  RecentSearchesNotifier() : super([]);

  void addSearch(String query) {
    if (query.isEmpty) return;

    // Remove if already exists
    state = state.where((s) => s != query).toList();

    // Add to front
    state = [query, ...state];

    // Keep only last 10
    if (state.length > 10) {
      state = state.sublist(0, 10);
    }
  }

  void removeSearch(String query) {
    state = state.where((s) => s != query).toList();
  }

  void clearAll() {
    state = [];
  }
}

final recentSearchesProvider = StateNotifierProvider<RecentSearchesNotifier, List<String>>((ref) {
  return RecentSearchesNotifier();
});

// ==================== Additional Providers for Home Screen ====================

// Search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Filter state provider
final filterStateProvider = StateProvider<FilterState>((ref) => FilterState());

// Sort option provider
final sortOptionProvider = StateProvider<SortOption>((ref) => SortOption.nameAsc);

// Loading state provider
final isLoadingProvider = StateProvider<bool>((ref) => false);

// Filtered contacts provider
final filteredContactsProvider = Provider<List<Contact>>((ref) {
  // This is a placeholder - in a real app, this would filter contacts from a data source
  // For now, return empty list
  return [];
});

// Available filter options providers
final availableCompaniesProvider = FutureProvider<List<String>>((ref) async {
  // TODO: Fetch from database
  return [];
});

final availableLocationsProvider = FutureProvider<List<String>>((ref) async {
  // TODO: Fetch from database
  return [];
});

final availableTagsProvider = FutureProvider<List<String>>((ref) async {
  // TODO: Fetch from database
  return [];
});
