import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/database_service.dart';
import '../repositories/profile_repository.dart';
import '../repositories/note_repository.dart';
import '../repositories/interaction_repository.dart';
import '../repositories/tag_repository.dart';

// Database Service Provider
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService.instance;
});

// Repository Providers
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  return NoteRepository();
});

final interactionRepositoryProvider = Provider<InteractionRepository>((ref) {
  return InteractionRepository();
});

final tagRepositoryProvider = Provider<TagRepository>((ref) {
  return TagRepository();
});

// Database Stats Provider
final databaseStatsProvider = FutureProvider<Map<String, int>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  return await db.getStats();
});

// Database Size Provider
final databaseSizeProvider = FutureProvider<int>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  return await db.getDatabaseSize();
});
