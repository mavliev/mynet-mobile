import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/profile.dart';
import '../models/experience.dart';
import '../models/education.dart';
import '../models/skill.dart';
import '../models/connection.dart';
import '../models/note.dart';
import '../models/interaction.dart';
import '../models/tag.dart';
import '../repositories/profile_repository.dart';
import '../repositories/note_repository.dart';
import '../repositories/interaction_repository.dart';
import '../repositories/tag_repository.dart';
import 'database_provider.dart';

// ==================== LinkedIn Profiles ====================

// Get LinkedIn profiles with pagination
final linkedInProfilesProvider = FutureProvider.family<List<LinkedInProfile>, ProfileFilters>(
  (ref, filters) async {
    final repo = ref.watch(profileRepositoryProvider);
    return await repo.getLinkedInProfiles(
      limit: filters.limit,
      offset: filters.offset,
      search: filters.search,
      company: filters.company,
      location: filters.location,
    );
  },
);

// Get specific LinkedIn profile
final linkedInProfileProvider = FutureProvider.family<LinkedInProfile?, String>(
  (ref, profileId) async {
    final repo = ref.watch(profileRepositoryProvider);
    return await repo.getLinkedInProfile(profileId);
  },
);

// Search LinkedIn profiles
final searchLinkedInProfilesProvider = FutureProvider.family<List<LinkedInProfile>, String>(
  (ref, query) async {
    final repo = ref.watch(profileRepositoryProvider);
    return await repo.searchLinkedInProfiles(query);
  },
);

// ==================== Work Experience ====================

final profileExperiencesProvider = FutureProvider.family<List<WorkExperience>, String>(
  (ref, profileId) async {
    final repo = ref.watch(profileRepositoryProvider);
    return await repo.getExperiences(profileId);
  },
);

// ==================== Education ====================

final profileEducationProvider = FutureProvider.family<List<Education>, String>(
  (ref, profileId) async {
    final repo = ref.watch(profileRepositoryProvider);
    return await repo.getEducation(profileId);
  },
);

// ==================== Skills ====================

final profileSkillsProvider = FutureProvider.family<List<Skill>, String>(
  (ref, profileId) async {
    final repo = ref.watch(profileRepositoryProvider);
    return await repo.getSkills(profileId);
  },
);

// ==================== Connections ====================

final connectionsProvider = FutureProvider.family<List<Connection>, ConnectionFilters>(
  (ref, filters) async {
    final repo = ref.watch(profileRepositoryProvider);
    return await repo.getConnections(
      limit: filters.limit,
      offset: filters.offset,
      search: filters.search,
      company: filters.company,
      isRecruiter: filters.isRecruiter,
    );
  },
);

final connectionProvider = FutureProvider.family<Connection?, int>(
  (ref, id) async {
    final repo = ref.watch(profileRepositoryProvider);
    return await repo.getConnection(id);
  },
);

// ==================== Profile Summary ====================

final profileSummariesProvider = FutureProvider.family<List<Map<String, dynamic>>, ProfileSummaryFilters>(
  (ref, filters) async {
    final repo = ref.watch(profileRepositoryProvider);
    return await repo.getProfileSummaries(
      limit: filters.limit,
      offset: filters.offset,
      search: filters.search,
      hasNotes: filters.hasNotes,
      hasInteractions: filters.hasInteractions,
      hasPendingFollowUp: filters.hasPendingFollowUp,
    );
  },
);

final profileSummaryProvider = FutureProvider.family<Map<String, dynamic>?, ProfileIdentifier>(
  (ref, identifier) async {
    final repo = ref.watch(profileRepositoryProvider);
    return await repo.getProfileSummary(identifier.profileId, identifier.profileType);
  },
);

// ==================== Notes ====================

final profileNotesProvider = FutureProvider.family<List<ProfileNote>, ProfileIdentifier>(
  (ref, identifier) async {
    final repo = ref.watch(noteRepositoryProvider);
    return await repo.getNotesForProfile(identifier.profileId, identifier.profileType);
  },
);

final noteProvider = FutureProvider.family<ProfileNote?, int>(
  (ref, id) async {
    final repo = ref.watch(noteRepositoryProvider);
    return await repo.getNote(id);
  },
);

final recentNotesProvider = FutureProvider.family<List<Map<String, dynamic>>, int>(
  (ref, limit) async {
    final repo = ref.watch(noteRepositoryProvider);
    return await repo.getRecentNotes(limit: limit);
  },
);

final pinnedNotesProvider = FutureProvider<List<ProfileNote>>((ref) async {
  final repo = ref.watch(noteRepositoryProvider);
  return await repo.getPinnedNotes();
});

final searchNotesProvider = FutureProvider.family<List<ProfileNote>, String>(
  (ref, query) async {
    final repo = ref.watch(noteRepositoryProvider);
    return await repo.searchNotes(query);
  },
);

// ==================== Interactions ====================

final profileInteractionsProvider = FutureProvider.family<List<ProfileInteraction>, ProfileIdentifier>(
  (ref, identifier) async {
    final repo = ref.watch(interactionRepositoryProvider);
    return await repo.getInteractionsForProfile(identifier.profileId, identifier.profileType);
  },
);

final interactionProvider = FutureProvider.family<ProfileInteraction?, int>(
  (ref, id) async {
    final repo = ref.watch(interactionRepositoryProvider);
    return await repo.getInteraction(id);
  },
);

final recentInteractionsProvider = FutureProvider.family<List<Map<String, dynamic>>, int>(
  (ref, limit) async {
    final repo = ref.watch(interactionRepositoryProvider);
    return await repo.getRecentInteractions(limit: limit);
  },
);

final pendingFollowUpsProvider = FutureProvider.family<List<Map<String, dynamic>>, bool>(
  (ref, overdueOnly) async {
    final repo = ref.watch(interactionRepositoryProvider);
    return await repo.getPendingFollowUps(overdueOnly: overdueOnly);
  },
);

final importantInteractionsProvider = FutureProvider.family<List<ProfileInteraction>, int>(
  (ref, limit) async {
    final repo = ref.watch(interactionRepositoryProvider);
    return await repo.getImportantInteractions(limit: limit);
  },
);

// ==================== Tags ====================

final allTagsProvider = FutureProvider.family<List<ProfileTag>, TagFilters>(
  (ref, filters) async {
    final repo = ref.watch(tagRepositoryProvider);
    return await repo.getAllTags(
      category: filters.category,
      minUsage: filters.minUsage,
    );
  },
);

final tagProvider = FutureProvider.family<ProfileTag?, int>(
  (ref, id) async {
    final repo = ref.watch(tagRepositoryProvider);
    return await repo.getTag(id);
  },
);

final profileTagsProvider = FutureProvider.family<List<ProfileTag>, ProfileIdentifier>(
  (ref, identifier) async {
    final repo = ref.watch(tagRepositoryProvider);
    return await repo.getTagsForProfile(identifier.profileId, identifier.profileType);
  },
);

final tagCloudProvider = FutureProvider.family<List<Map<String, dynamic>>, TagCloudFilters>(
  (ref, filters) async {
    final repo = ref.watch(tagRepositoryProvider);
    return await repo.getTagCloud(
      minUsage: filters.minUsage,
      limit: filters.limit,
    );
  },
);

final searchTagsProvider = FutureProvider.family<List<ProfileTag>, String>(
  (ref, query) async {
    final repo = ref.watch(tagRepositoryProvider);
    return await repo.searchTags(query);
  },
);

final popularTagsProvider = FutureProvider.family<List<ProfileTag>, int>(
  (ref, limit) async {
    final repo = ref.watch(tagRepositoryProvider);
    return await repo.getPopularTags(limit: limit);
  },
);

final tagCategoriesProvider = FutureProvider<List<String>>((ref) async {
  final repo = ref.watch(tagRepositoryProvider);
  return await repo.getTagCategories();
});

// ==================== Company Analysis ====================

final profilesByCompanyProvider = FutureProvider.family<List<LinkedInProfile>, String>(
  (ref, company) async {
    final repo = ref.watch(profileRepositoryProvider);
    return await repo.getProfilesByCompany(company);
  },
);

final topCompaniesProvider = FutureProvider.family<List<Map<String, dynamic>>, int>(
  (ref, limit) async {
    final repo = ref.watch(profileRepositoryProvider);
    return await repo.getTopCompaniesByProfileCount(limit: limit);
  },
);

// ==================== Filter Classes ====================

class ProfileFilters {
  final int? limit;
  final int? offset;
  final String? search;
  final String? company;
  final String? location;

  ProfileFilters({
    this.limit = 50,
    this.offset = 0,
    this.search,
    this.company,
    this.location,
  });
}

class ConnectionFilters {
  final int? limit;
  final int? offset;
  final String? search;
  final String? company;
  final bool? isRecruiter;

  ConnectionFilters({
    this.limit = 50,
    this.offset = 0,
    this.search,
    this.company,
    this.isRecruiter,
  });
}

class ProfileSummaryFilters {
  final int? limit;
  final int? offset;
  final String? search;
  final bool? hasNotes;
  final bool? hasInteractions;
  final bool? hasPendingFollowUp;

  ProfileSummaryFilters({
    this.limit = 50,
    this.offset = 0,
    this.search,
    this.hasNotes,
    this.hasInteractions,
    this.hasPendingFollowUp,
  });
}

class ProfileIdentifier {
  final String profileId;
  final String profileType;

  ProfileIdentifier({
    required this.profileId,
    required this.profileType,
  });
}

class TagFilters {
  final String? category;
  final int? minUsage;

  TagFilters({
    this.category,
    this.minUsage,
  });
}

class TagCloudFilters {
  final int? minUsage;
  final int? limit;

  TagCloudFilters({
    this.minUsage = 1,
    this.limit = 50,
  });
}
