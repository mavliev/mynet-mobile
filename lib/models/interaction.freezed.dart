// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProfileInteraction _$ProfileInteractionFromJson(Map<String, dynamic> json) {
  return _ProfileInteraction.fromJson(json);
}

/// @nodoc
mixin _$ProfileInteraction {
  int get id => throw _privateConstructorUsedError;
  String get profileId => throw _privateConstructorUsedError;
  String get profileType => throw _privateConstructorUsedError;
  InteractionType get interactionType => throw _privateConstructorUsedError;
  DateTime get interactionDate => throw _privateConstructorUsedError;
  int? get durationMinutes => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;
  InteractionOutcome? get outcome => throw _privateConstructorUsedError;
  DateTime? get followUpDate => throw _privateConstructorUsedError;
  bool get followUpCompleted => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get attachmentPaths => throw _privateConstructorUsedError;
  String? get relatedNoteIds => throw _privateConstructorUsedError;
  bool get isImportant => throw _privateConstructorUsedError;
  String? get tags => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  String? get deviceId => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;

  /// Serializes this ProfileInteraction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileInteraction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileInteractionCopyWith<ProfileInteraction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileInteractionCopyWith<$Res> {
  factory $ProfileInteractionCopyWith(
    ProfileInteraction value,
    $Res Function(ProfileInteraction) then,
  ) = _$ProfileInteractionCopyWithImpl<$Res, ProfileInteraction>;
  @useResult
  $Res call({
    int id,
    String profileId,
    String profileType,
    InteractionType interactionType,
    DateTime interactionDate,
    int? durationMinutes,
    String? subject,
    String? summary,
    InteractionOutcome? outcome,
    DateTime? followUpDate,
    bool followUpCompleted,
    String? location,
    String? attachmentPaths,
    String? relatedNoteIds,
    bool isImportant,
    String? tags,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? syncedAt,
    bool isDeleted,
    String? deviceId,
    int version,
  });
}

/// @nodoc
class _$ProfileInteractionCopyWithImpl<$Res, $Val extends ProfileInteraction>
    implements $ProfileInteractionCopyWith<$Res> {
  _$ProfileInteractionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileInteraction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profileId = null,
    Object? profileType = null,
    Object? interactionType = null,
    Object? interactionDate = null,
    Object? durationMinutes = freezed,
    Object? subject = freezed,
    Object? summary = freezed,
    Object? outcome = freezed,
    Object? followUpDate = freezed,
    Object? followUpCompleted = null,
    Object? location = freezed,
    Object? attachmentPaths = freezed,
    Object? relatedNoteIds = freezed,
    Object? isImportant = null,
    Object? tags = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? isDeleted = null,
    Object? deviceId = freezed,
    Object? version = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            profileId: null == profileId
                ? _value.profileId
                : profileId // ignore: cast_nullable_to_non_nullable
                      as String,
            profileType: null == profileType
                ? _value.profileType
                : profileType // ignore: cast_nullable_to_non_nullable
                      as String,
            interactionType: null == interactionType
                ? _value.interactionType
                : interactionType // ignore: cast_nullable_to_non_nullable
                      as InteractionType,
            interactionDate: null == interactionDate
                ? _value.interactionDate
                : interactionDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            durationMinutes: freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            subject: freezed == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String?,
            summary: freezed == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String?,
            outcome: freezed == outcome
                ? _value.outcome
                : outcome // ignore: cast_nullable_to_non_nullable
                      as InteractionOutcome?,
            followUpDate: freezed == followUpDate
                ? _value.followUpDate
                : followUpDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            followUpCompleted: null == followUpCompleted
                ? _value.followUpCompleted
                : followUpCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            attachmentPaths: freezed == attachmentPaths
                ? _value.attachmentPaths
                : attachmentPaths // ignore: cast_nullable_to_non_nullable
                      as String?,
            relatedNoteIds: freezed == relatedNoteIds
                ? _value.relatedNoteIds
                : relatedNoteIds // ignore: cast_nullable_to_non_nullable
                      as String?,
            isImportant: null == isImportant
                ? _value.isImportant
                : isImportant // ignore: cast_nullable_to_non_nullable
                      as bool,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            syncedAt: freezed == syncedAt
                ? _value.syncedAt
                : syncedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isDeleted: null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            deviceId: freezed == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileInteractionImplCopyWith<$Res>
    implements $ProfileInteractionCopyWith<$Res> {
  factory _$$ProfileInteractionImplCopyWith(
    _$ProfileInteractionImpl value,
    $Res Function(_$ProfileInteractionImpl) then,
  ) = __$$ProfileInteractionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String profileId,
    String profileType,
    InteractionType interactionType,
    DateTime interactionDate,
    int? durationMinutes,
    String? subject,
    String? summary,
    InteractionOutcome? outcome,
    DateTime? followUpDate,
    bool followUpCompleted,
    String? location,
    String? attachmentPaths,
    String? relatedNoteIds,
    bool isImportant,
    String? tags,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? syncedAt,
    bool isDeleted,
    String? deviceId,
    int version,
  });
}

/// @nodoc
class __$$ProfileInteractionImplCopyWithImpl<$Res>
    extends _$ProfileInteractionCopyWithImpl<$Res, _$ProfileInteractionImpl>
    implements _$$ProfileInteractionImplCopyWith<$Res> {
  __$$ProfileInteractionImplCopyWithImpl(
    _$ProfileInteractionImpl _value,
    $Res Function(_$ProfileInteractionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileInteraction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profileId = null,
    Object? profileType = null,
    Object? interactionType = null,
    Object? interactionDate = null,
    Object? durationMinutes = freezed,
    Object? subject = freezed,
    Object? summary = freezed,
    Object? outcome = freezed,
    Object? followUpDate = freezed,
    Object? followUpCompleted = null,
    Object? location = freezed,
    Object? attachmentPaths = freezed,
    Object? relatedNoteIds = freezed,
    Object? isImportant = null,
    Object? tags = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? isDeleted = null,
    Object? deviceId = freezed,
    Object? version = null,
  }) {
    return _then(
      _$ProfileInteractionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        profileId: null == profileId
            ? _value.profileId
            : profileId // ignore: cast_nullable_to_non_nullable
                  as String,
        profileType: null == profileType
            ? _value.profileType
            : profileType // ignore: cast_nullable_to_non_nullable
                  as String,
        interactionType: null == interactionType
            ? _value.interactionType
            : interactionType // ignore: cast_nullable_to_non_nullable
                  as InteractionType,
        interactionDate: null == interactionDate
            ? _value.interactionDate
            : interactionDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        durationMinutes: freezed == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        subject: freezed == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String?,
        summary: freezed == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String?,
        outcome: freezed == outcome
            ? _value.outcome
            : outcome // ignore: cast_nullable_to_non_nullable
                  as InteractionOutcome?,
        followUpDate: freezed == followUpDate
            ? _value.followUpDate
            : followUpDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        followUpCompleted: null == followUpCompleted
            ? _value.followUpCompleted
            : followUpCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        attachmentPaths: freezed == attachmentPaths
            ? _value.attachmentPaths
            : attachmentPaths // ignore: cast_nullable_to_non_nullable
                  as String?,
        relatedNoteIds: freezed == relatedNoteIds
            ? _value.relatedNoteIds
            : relatedNoteIds // ignore: cast_nullable_to_non_nullable
                  as String?,
        isImportant: null == isImportant
            ? _value.isImportant
            : isImportant // ignore: cast_nullable_to_non_nullable
                  as bool,
        tags: freezed == tags
            ? _value.tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        syncedAt: freezed == syncedAt
            ? _value.syncedAt
            : syncedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        deviceId: freezed == deviceId
            ? _value.deviceId
            : deviceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileInteractionImpl implements _ProfileInteraction {
  const _$ProfileInteractionImpl({
    required this.id,
    required this.profileId,
    required this.profileType,
    required this.interactionType,
    required this.interactionDate,
    this.durationMinutes,
    this.subject,
    this.summary,
    this.outcome,
    this.followUpDate,
    this.followUpCompleted = false,
    this.location,
    this.attachmentPaths,
    this.relatedNoteIds,
    this.isImportant = false,
    this.tags,
    required this.createdAt,
    required this.updatedAt,
    this.syncedAt,
    this.isDeleted = false,
    this.deviceId,
    this.version = 1,
  });

  factory _$ProfileInteractionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileInteractionImplFromJson(json);

  @override
  final int id;
  @override
  final String profileId;
  @override
  final String profileType;
  @override
  final InteractionType interactionType;
  @override
  final DateTime interactionDate;
  @override
  final int? durationMinutes;
  @override
  final String? subject;
  @override
  final String? summary;
  @override
  final InteractionOutcome? outcome;
  @override
  final DateTime? followUpDate;
  @override
  @JsonKey()
  final bool followUpCompleted;
  @override
  final String? location;
  @override
  final String? attachmentPaths;
  @override
  final String? relatedNoteIds;
  @override
  @JsonKey()
  final bool isImportant;
  @override
  final String? tags;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  final String? deviceId;
  @override
  @JsonKey()
  final int version;

  @override
  String toString() {
    return 'ProfileInteraction(id: $id, profileId: $profileId, profileType: $profileType, interactionType: $interactionType, interactionDate: $interactionDate, durationMinutes: $durationMinutes, subject: $subject, summary: $summary, outcome: $outcome, followUpDate: $followUpDate, followUpCompleted: $followUpCompleted, location: $location, attachmentPaths: $attachmentPaths, relatedNoteIds: $relatedNoteIds, isImportant: $isImportant, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, isDeleted: $isDeleted, deviceId: $deviceId, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileInteractionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.profileType, profileType) ||
                other.profileType == profileType) &&
            (identical(other.interactionType, interactionType) ||
                other.interactionType == interactionType) &&
            (identical(other.interactionDate, interactionDate) ||
                other.interactionDate == interactionDate) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.outcome, outcome) || other.outcome == outcome) &&
            (identical(other.followUpDate, followUpDate) ||
                other.followUpDate == followUpDate) &&
            (identical(other.followUpCompleted, followUpCompleted) ||
                other.followUpCompleted == followUpCompleted) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.attachmentPaths, attachmentPaths) ||
                other.attachmentPaths == attachmentPaths) &&
            (identical(other.relatedNoteIds, relatedNoteIds) ||
                other.relatedNoteIds == relatedNoteIds) &&
            (identical(other.isImportant, isImportant) ||
                other.isImportant == isImportant) &&
            (identical(other.tags, tags) || other.tags == tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    profileId,
    profileType,
    interactionType,
    interactionDate,
    durationMinutes,
    subject,
    summary,
    outcome,
    followUpDate,
    followUpCompleted,
    location,
    attachmentPaths,
    relatedNoteIds,
    isImportant,
    tags,
    createdAt,
    updatedAt,
    syncedAt,
    isDeleted,
    deviceId,
    version,
  ]);

  /// Create a copy of ProfileInteraction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileInteractionImplCopyWith<_$ProfileInteractionImpl> get copyWith =>
      __$$ProfileInteractionImplCopyWithImpl<_$ProfileInteractionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileInteractionImplToJson(this);
  }
}

abstract class _ProfileInteraction implements ProfileInteraction {
  const factory _ProfileInteraction({
    required final int id,
    required final String profileId,
    required final String profileType,
    required final InteractionType interactionType,
    required final DateTime interactionDate,
    final int? durationMinutes,
    final String? subject,
    final String? summary,
    final InteractionOutcome? outcome,
    final DateTime? followUpDate,
    final bool followUpCompleted,
    final String? location,
    final String? attachmentPaths,
    final String? relatedNoteIds,
    final bool isImportant,
    final String? tags,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final DateTime? syncedAt,
    final bool isDeleted,
    final String? deviceId,
    final int version,
  }) = _$ProfileInteractionImpl;

  factory _ProfileInteraction.fromJson(Map<String, dynamic> json) =
      _$ProfileInteractionImpl.fromJson;

  @override
  int get id;
  @override
  String get profileId;
  @override
  String get profileType;
  @override
  InteractionType get interactionType;
  @override
  DateTime get interactionDate;
  @override
  int? get durationMinutes;
  @override
  String? get subject;
  @override
  String? get summary;
  @override
  InteractionOutcome? get outcome;
  @override
  DateTime? get followUpDate;
  @override
  bool get followUpCompleted;
  @override
  String? get location;
  @override
  String? get attachmentPaths;
  @override
  String? get relatedNoteIds;
  @override
  bool get isImportant;
  @override
  String? get tags;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt;
  @override
  bool get isDeleted;
  @override
  String? get deviceId;
  @override
  int get version;

  /// Create a copy of ProfileInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileInteractionImplCopyWith<_$ProfileInteractionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
