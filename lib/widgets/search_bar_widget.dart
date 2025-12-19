import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/search_provider.dart';
import '../theme/app_theme.dart';

/// A search bar with debounced input and recent searches
class SearchBarWidget extends ConsumerStatefulWidget {
  final bool showRecentSearches;

  const SearchBarWidget({
    super.key,
    this.showRecentSearches = true,
  });

  @override
  ConsumerState<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends ConsumerState<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounceTimer;
  bool _showRecentSearches = false;

  static const _debounceDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && _controller.text.isEmpty && widget.showRecentSearches) {
      setState(() {
        _showRecentSearches = true;
      });
    } else {
      setState(() {
        _showRecentSearches = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    // Cancel previous timer
    _debounceTimer?.cancel();

    // Set new timer
    _debounceTimer = Timer(_debounceDuration, () {
      ref.read(searchQueryProvider.notifier).state = query;
    });
  }

  void _onSearchSubmitted(String query) {
    _debounceTimer?.cancel();
    ref.read(searchQueryProvider.notifier).state = query;

    // Add to recent searches
    if (query.isNotEmpty) {
      ref.read(recentSearchesProvider.notifier).addSearch(query);
    }

    _focusNode.unfocus();
  }

  void _clearSearch() {
    _controller.clear();
    ref.read(searchQueryProvider.notifier).state = '';
    _focusNode.unfocus();
  }

  void _selectRecentSearch(String query) {
    _controller.text = query;
    _onSearchSubmitted(query);
  }

  @override
  Widget build(BuildContext context) {
    final recentSearches = ref.watch(recentSearchesProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 56,
          margin: const EdgeInsets.symmetric(
            horizontal: AppTheme.space4,
            vertical: AppTheme.space2,
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: _onSearchChanged,
            onSubmitted: _onSearchSubmitted,
            decoration: InputDecoration(
              hintText: 'Search contacts...',
              prefixIcon: const Icon(Icons.search, size: AppTheme.iconSize),
              suffixIcon: _controller.text.isNotEmpty
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.clear, size: AppTheme.iconSize),
                          onPressed: _clearSearch,
                          tooltip: 'Clear search',
                        ),
                        IconButton(
                          icon: const Icon(Icons.mic, size: AppTheme.iconSize),
                          onPressed: () {
                            // Voice search placeholder
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Voice search not yet implemented'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          tooltip: 'Voice search',
                        ),
                      ],
                    )
                  : IconButton(
                      icon: const Icon(Icons.mic, size: AppTheme.iconSize),
                      onPressed: () {
                        // Voice search placeholder
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Voice search not yet implemented'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      tooltip: 'Voice search',
                    ),
            ),
            textInputAction: TextInputAction.search,
          ),
        ),
        // Recent searches dropdown
        if (_showRecentSearches && recentSearches.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppTheme.space4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppTheme.space3),
                  child: Text(
                    'Recent searches',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.color
                              ?.withValues(alpha: 0.6),
                        ),
                  ),
                ),
                ...recentSearches.take(5).map((search) {
                  return ListTile(
                    dense: true,
                    leading: const Icon(Icons.history, size: 20),
                    title: Text(search),
                    onTap: () => _selectRecentSearch(search),
                    trailing: IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () {
                        ref.read(recentSearchesProvider.notifier).removeSearch(search);
                      },
                      tooltip: 'Remove',
                    ),
                  );
                }),
                if (recentSearches.length > 5)
                  TextButton(
                    onPressed: () {
                      ref.read(recentSearchesProvider.notifier).clearAll();
                    },
                    child: const Text('Clear all'),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
