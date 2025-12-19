// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProfileNote _$ProfileNoteFromJson(Map<String, dynamic> json) {
  return _ProfileNote.fromJson(json);
}

/// @nodoc
mixin _$ProfileNote {
  int get id => throw _privateConstructorUsedError;
  String get profileId => throw _privateConstructorUsedError;
  String get profileType => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  NoteType get noteType => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;
  String? get colorTag => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  String? get deviceId => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  String get conflictResolutionStrategy => throw _privateConstructorUsedError;

  /// Serializes this ProfileNote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileNoteCopyWith<ProfileNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileNoteCopyWith<$Res> {
  factory $ProfileNoteCopyWith(
    ProfileNote value,
    $Res Function(ProfileNote) then,
  ) = _$ProfileNoteCopyWithImpl<$Res, ProfileNote>;
  @useResult
  $Res call({
    int id,
    String profileId,
    String profileType,
    String? title,
    String content,
    NoteType noteType,
    bool isPinned,
    String? colorTag,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? syncedAt,
    bool isDeleted,
    String? deviceId,
    int version,
    String conflictResolutionStrategy,
  });
}

/// @nodoc
class _$ProfileNoteCopyWithImpl<$Res, $Val extends ProfileNote>
    implements $ProfileNoteCopyWith<$Res> {
  _$ProfileNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profileId = null,
    Object? profileType = null,
    Object? title = freezed,
    Object? content = null,
    Object? noteType = null,
    Object? isPinned = null,
    Object? colorTag = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? isDeleted = null,
    Object? deviceId = freezed,
    Object? version = null,
    Object? conflictResolutionStrategy = null,
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
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            noteType: null == noteType
                ? _value.noteType
                : noteType // ignore: cast_nullable_to_non_nullable
                      as NoteType,
            isPinned: null == isPinned
                ? _value.isPinned
                : isPinned // ignore: cast_nullable_to_non_nullable
                      as bool,
            colorTag: freezed == colorTag
                ? _value.colorTag
                : colorTag // ignore: cast_nullable_to_non_nullable
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
            conflictResolutionStrategy: null == conflictResolutionStrategy
                ? _value.conflictResolutionStrategy
                : conflictResolutionStrategy // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileNoteImplCopyWith<$Res>
    implements $ProfileNoteCopyWith<$Res> {
  factory _$$ProfileNoteImplCopyWith(
    _$ProfileNoteImpl value,
    $Res Function(_$ProfileNoteImpl) then,
  ) = __$$ProfileNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String profileId,
    String profileType,
    String? title,
    String content,
    NoteType noteType,
    bool isPinned,
    String? colorTag,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? syncedAt,
    bool isDeleted,
    String? deviceId,
    int version,
    String conflictResolutionStrategy,
  });
}

/// @nodoc
class __$$ProfileNoteImplCopyWithImpl<$Res>
    extends _$ProfileNoteCopyWithImpl<$Res, _$ProfileNoteImpl>
    implements _$$ProfileNoteImplCopyWith<$Res> {
  __$$ProfileNoteImplCopyWithImpl(
    _$ProfileNoteImpl _value,
    $Res Function(_$ProfileNoteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profileId = null,
    Object? profileType = null,
    Object? title = freezed,
    Object? content = null,
    Object? noteType = null,
    Object? isPinned = null,
    Object? colorTag = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? isDeleted = null,
    Object? deviceId = freezed,
    Object? version = null,
    Object? conflictResolutionStrategy = null,
  }) {
    return _then(
      _$ProfileNoteImpl(
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
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        noteType: null == noteType
            ? _value.noteType
            : noteType // ignore: cast_nullable_to_non_nullable
                  as NoteType,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        colorTag: freezed == colorTag
            ? _value.colorTag
            : colorTag // ignore: cast_nullable_to_non_nullable
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
        conflictResolutionStrategy: null == conflictResolutionStrategy
            ? _value.conflictResolutionStrategy
            : conflictResolutionStrategy // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileNoteImpl implements _ProfileNote {
  const _$ProfileNoteImpl({
    required this.id,
    required this.profileId,
    required this.profileType,
    this.title,
    required this.content,
    this.noteType = NoteType.general,
    this.isPinned = false,
    this.colorTag,
    required this.createdAt,
    required this.updatedAt,
    this.syncedAt,
    this.isDeleted = false,
    this.deviceId,
    this.version = 1,
    this.conflictResolutionStrategy = 'last_write_wins',
  });

  factory _$ProfileNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileNoteImplFromJson(json);

  @override
  final int id;
  @override
  final String profileId;
  @override
  final String profileType;
  @override
  final String? title;
  @override
  final String content;
  @override
  @JsonKey()
  final NoteType noteType;
  @override
  @JsonKey()
  final bool isPinned;
  @override
  final String? colorTag;
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
  @JsonKey()
  final String conflictResolutionStrategy;

  @override
  String toString() {
    return 'ProfileNote(id: $id, profileId: $profileId, profileType: $profileType, title: $title, content: $content, noteType: $noteType, isPinned: $isPinned, colorTag: $colorTag, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, isDeleted: $isDeleted, deviceId: $deviceId, version: $version, conflictResolutionStrategy: $conflictResolutionStrategy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileNoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.profileType, profileType) ||
                other.profileType == profileType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.noteType, noteType) ||
                other.noteType == noteType) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.colorTag, colorTag) ||
                other.colorTag == colorTag) &&
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
            (identical(other.version, version) || other.version == version) &&
            (identical(
                  other.conflictResolutionStrategy,
                  conflictResolutionStrategy,
                ) ||
                other.conflictResolutionStrategy ==
                    conflictResolutionStrategy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    profileId,
    profileType,
    title,
    content,
    noteType,
    isPinned,
    colorTag,
    createdAt,
    updatedAt,
    syncedAt,
    isDeleted,
    deviceId,
    version,
    conflictResolutionStrategy,
  );

  /// Create a copy of ProfileNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileNoteImplCopyWith<_$ProfileNoteImpl> get copyWith =>
      __$$ProfileNoteImplCopyWithImpl<_$ProfileNoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileNoteImplToJson(this);
  }
}

abstract class _ProfileNote implements ProfileNote {
  const factory _ProfileNote({
    required final int id,
    required final String profileId,
    required final String profileType,
    final String? title,
    required final String content,
    final NoteType noteType,
    final bool isPinned,
    final String? colorTag,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final DateTime? syncedAt,
    final bool isDeleted,
    final String? deviceId,
    final int version,
    final String conflictResolutionStrategy,
  }) = _$ProfileNoteImpl;

  factory _ProfileNote.fromJson(Map<String, dynamic> json) =
      _$ProfileNoteImpl.fromJson;

  @override
  int get id;
  @override
  String get profileId;
  @override
  String get profileType;
  @override
  String? get title;
  @override
  String get content;
  @override
  NoteType get noteType;
  @override
  bool get isPinned;
  @override
  String? get colorTag;
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
  @override
  String get conflictResolutionStrategy;

  /// Create a copy of ProfileNote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileNoteImplCopyWith<_$ProfileNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
