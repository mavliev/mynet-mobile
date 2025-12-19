import 'package:flutter_riverpod/flutter_riverpod.dart';

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
