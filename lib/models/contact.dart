import 'connection_degree.dart';

/// Represents a professional contact in the network
class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String? headline;
  final String? company;
  final String? location;
  final ConnectionDegree connectionDegree;
  final DateTime? lastInteractionDate;
  final String? avatarUrl;
  final String? email;
  final String? phone;
  final String? linkedinUrl;
  final List<String> tags;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.headline,
    this.company,
    this.location,
    required this.connectionDegree,
    this.lastInteractionDate,
    this.avatarUrl,
    this.email,
    this.phone,
    this.linkedinUrl,
    this.tags = const [],
  });

  /// Get full name of the contact
  String get fullName => '$firstName $lastName';

  /// Get initials for avatar fallback
  String get initials {
    final first = firstName.isNotEmpty ? firstName[0] : '';
    final last = lastName.isNotEmpty ? lastName[0] : '';
    return '$first$last'.toUpperCase();
  }

  /// Get formatted time since last interaction
  String get timeSinceLastInteraction {
    if (lastInteractionDate == null) return 'Never';

    final now = DateTime.now();
    final difference = now.difference(lastInteractionDate!);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}y ago';
    }
  }

  /// Create a copy with modified fields
  Contact copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? headline,
    String? company,
    String? location,
    ConnectionDegree? connectionDegree,
    DateTime? lastInteractionDate,
    String? avatarUrl,
    String? email,
    String? phone,
    String? linkedinUrl,
    List<String>? tags,
  }) {
    return Contact(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      headline: headline ?? this.headline,
      company: company ?? this.company,
      location: location ?? this.location,
      connectionDegree: connectionDegree ?? this.connectionDegree,
      lastInteractionDate: lastInteractionDate ?? this.lastInteractionDate,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      tags: tags ?? this.tags,
    );
  }

  /// Create from JSON
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      headline: json['headline'] as String?,
      company: json['company'] as String?,
      location: json['location'] as String?,
      connectionDegree: ConnectionDegree.fromInt(json['connectionDegree'] as int),
      lastInteractionDate: json['lastInteractionDate'] != null
          ? DateTime.parse(json['lastInteractionDate'] as String)
          : null,
      avatarUrl: json['avatarUrl'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      linkedinUrl: json['linkedinUrl'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'headline': headline,
      'company': company,
      'location': location,
      'connectionDegree': connectionDegree.value,
      'lastInteractionDate': lastInteractionDate?.toIso8601String(),
      'avatarUrl': avatarUrl,
      'email': email,
      'phone': phone,
      'linkedinUrl': linkedinUrl,
      'tags': tags,
    };
  }
}
