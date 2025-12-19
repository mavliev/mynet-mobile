// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProfileTag _$ProfileTagFromJson(Map<String, dynamic> json) {
  return _ProfileTag.fromJson(json);
}

/// @nodoc
mixin _$ProfileTag {
  int get id => throw _privateConstructorUsedError;
  String get tagName => throw _privateConstructorUsedError;
  String? get tagCategory => throw _privateConstructorUsedError;
  String? get tagColor => throw _privateConstructorUsedError;
  int get usageCount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  bool get isSystemTag => throw _privateConstructorUsedError;

  /// Serializes this ProfileTag to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileTagCopyWith<ProfileTag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileTagCopyWith<$Res> {
  factory $ProfileTagCopyWith(
    ProfileTag value,
    $Res Function(ProfileTag) then,
  ) = _$ProfileTagCopyWithImpl<$Res, ProfileTag>;
  @useResult
  $Res call({
    int id,
    String tagName,
    String? tagCategory,
    String? tagColor,
    int usageCount,
    DateTime createdAt,
    DateTime updatedAt,
    bool isSystemTag,
  });
}

/// @nodoc
class _$ProfileTagCopyWithImpl<$Res, $Val extends ProfileTag>
    implements $ProfileTagCopyWith<$Res> {
  _$ProfileTagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tagName = null,
    Object? tagCategory = freezed,
    Object? tagColor = freezed,
    Object? usageCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isSystemTag = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            tagName: null == tagName
                ? _value.tagName
                : tagName // ignore: cast_nullable_to_non_nullable
                      as String,
            tagCategory: freezed == tagCategory
                ? _value.tagCategory
                : tagCategory // ignore: cast_nullable_to_non_nullable
                      as String?,
            tagColor: freezed == tagColor
                ? _value.tagColor
                : tagColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            usageCount: null == usageCount
                ? _value.usageCount
                : usageCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isSystemTag: null == isSystemTag
                ? _value.isSystemTag
                : isSystemTag // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileTagImplCopyWith<$Res>
    implements $ProfileTagCopyWith<$Res> {
  factory _$$ProfileTagImplCopyWith(
    _$ProfileTagImpl value,
    $Res Function(_$ProfileTagImpl) then,
  ) = __$$ProfileTagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String tagName,
    String? tagCategory,
    String? tagColor,
    int usageCount,
    DateTime createdAt,
    DateTime updatedAt,
    bool isSystemTag,
  });
}

/// @nodoc
class __$$ProfileTagImplCopyWithImpl<$Res>
    extends _$ProfileTagCopyWithImpl<$Res, _$ProfileTagImpl>
    implements _$$ProfileTagImplCopyWith<$Res> {
  __$$ProfileTagImplCopyWithImpl(
    _$ProfileTagImpl _value,
    $Res Function(_$ProfileTagImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tagName = null,
    Object? tagCategory = freezed,
    Object? tagColor = freezed,
    Object? usageCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isSystemTag = null,
  }) {
    return _then(
      _$ProfileTagImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        tagName: null == tagName
            ? _value.tagName
            : tagName // ignore: cast_nullable_to_non_nullable
                  as String,
        tagCategory: freezed == tagCategory
            ? _value.tagCategory
            : tagCategory // ignore: cast_nullable_to_non_nullable
                  as String?,
        tagColor: freezed == tagColor
            ? _value.tagColor
            : tagColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        usageCount: null == usageCount
            ? _value.usageCount
            : usageCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isSystemTag: null == isSystemTag
            ? _value.isSystemTag
            : isSystemTag // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileTagImpl implements _ProfileTag {
  const _$ProfileTagImpl({
    required this.id,
    required this.tagName,
    this.tagCategory,
    this.tagColor,
    this.usageCount = 0,
    required this.createdAt,
    required this.updatedAt,
    this.isSystemTag = false,
  });

  factory _$ProfileTagImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileTagImplFromJson(json);

  @override
  final int id;
  @override
  final String tagName;
  @override
  final String? tagCategory;
  @override
  final String? tagColor;
  @override
  @JsonKey()
  final int usageCount;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final bool isSystemTag;

  @override
  String toString() {
    return 'ProfileTag(id: $id, tagName: $tagName, tagCategory: $tagCategory, tagColor: $tagColor, usageCount: $usageCount, createdAt: $createdAt, updatedAt: $updatedAt, isSystemTag: $isSystemTag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileTagImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tagName, tagName) || other.tagName == tagName) &&
            (identical(other.tagCategory, tagCategory) ||
                other.tagCategory == tagCategory) &&
            (identical(other.tagColor, tagColor) ||
                other.tagColor == tagColor) &&
            (identical(other.usageCount, usageCount) ||
                other.usageCount == usageCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isSystemTag, isSystemTag) ||
                other.isSystemTag == isSystemTag));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    tagName,
    tagCategory,
    tagColor,
    usageCount,
    createdAt,
    updatedAt,
    isSystemTag,
  );

  /// Create a copy of ProfileTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileTagImplCopyWith<_$ProfileTagImpl> get copyWith =>
      __$$ProfileTagImplCopyWithImpl<_$ProfileTagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileTagImplToJson(this);
  }
}

abstract class _ProfileTag implements ProfileTag {
  const factory _ProfileTag({
    required final int id,
    required final String tagName,
    final String? tagCategory,
    final String? tagColor,
    final int usageCount,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final bool isSystemTag,
  }) = _$ProfileTagImpl;

  factory _ProfileTag.fromJson(Map<String, dynamic> json) =
      _$ProfileTagImpl.fromJson;

  @override
  int get id;
  @override
  String get tagName;
  @override
  String? get tagCategory;
  @override
  String? get tagColor;
  @override
  int get usageCount;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  bool get isSystemTag;

  /// Create a copy of ProfileTag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileTagImplCopyWith<_$ProfileTagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileTagAssociation _$ProfileTagAssociationFromJson(
  Map<String, dynamic> json,
) {
  return _ProfileTagAssociation.fromJson(json);
}

/// @nodoc
mixin _$ProfileTagAssociation {
  int get id => throw _privateConstructorUsedError;
  String get profileId => throw _privateConstructorUsedError;
  String get profileType => throw _privateConstructorUsedError;
  int get tagId => throw _privateConstructorUsedError;
  String? get taggedBy => throw _privateConstructorUsedError;
  DateTime get taggedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this ProfileTagAssociation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileTagAssociation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileTagAssociationCopyWith<ProfileTagAssociation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileTagAssociationCopyWith<$Res> {
  factory $ProfileTagAssociationCopyWith(
    ProfileTagAssociation value,
    $Res Function(ProfileTagAssociation) then,
  ) = _$ProfileTagAssociationCopyWithImpl<$Res, ProfileTagAssociation>;
  @useResult
  $Res call({
    int id,
    String profileId,
    String profileType,
    int tagId,
    String? taggedBy,
    DateTime taggedAt,
    DateTime? syncedAt,
    bool isDeleted,
  });
}

/// @nodoc
class _$ProfileTagAssociationCopyWithImpl<
  $Res,
  $Val extends ProfileTagAssociation
>
    implements $ProfileTagAssociationCopyWith<$Res> {
  _$ProfileTagAssociationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileTagAssociation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profileId = null,
    Object? profileType = null,
    Object? tagId = null,
    Object? taggedBy = freezed,
    Object? taggedAt = null,
    Object? syncedAt = freezed,
    Object? isDeleted = null,
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
            tagId: null == tagId
                ? _value.tagId
                : tagId // ignore: cast_nullable_to_non_nullable
                      as int,
            taggedBy: freezed == taggedBy
                ? _value.taggedBy
                : taggedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            taggedAt: null == taggedAt
                ? _value.taggedAt
                : taggedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            syncedAt: freezed == syncedAt
                ? _value.syncedAt
                : syncedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isDeleted: null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileTagAssociationImplCopyWith<$Res>
    implements $ProfileTagAssociationCopyWith<$Res> {
  factory _$$ProfileTagAssociationImplCopyWith(
    _$ProfileTagAssociationImpl value,
    $Res Function(_$ProfileTagAssociationImpl) then,
  ) = __$$ProfileTagAssociationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String profileId,
    String profileType,
    int tagId,
    String? taggedBy,
    DateTime taggedAt,
    DateTime? syncedAt,
    bool isDeleted,
  });
}

/// @nodoc
class __$$ProfileTagAssociationImplCopyWithImpl<$Res>
    extends
        _$ProfileTagAssociationCopyWithImpl<$Res, _$ProfileTagAssociationImpl>
    implements _$$ProfileTagAssociationImplCopyWith<$Res> {
  __$$ProfileTagAssociationImplCopyWithImpl(
    _$ProfileTagAssociationImpl _value,
    $Res Function(_$ProfileTagAssociationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileTagAssociation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profileId = null,
    Object? profileType = null,
    Object? tagId = null,
    Object? taggedBy = freezed,
    Object? taggedAt = null,
    Object? syncedAt = freezed,
    Object? isDeleted = null,
  }) {
    return _then(
      _$ProfileTagAssociationImpl(
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
        tagId: null == tagId
            ? _value.tagId
            : tagId // ignore: cast_nullable_to_non_nullable
                  as int,
        taggedBy: freezed == taggedBy
            ? _value.taggedBy
            : taggedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        taggedAt: null == taggedAt
            ? _value.taggedAt
            : taggedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        syncedAt: freezed == syncedAt
            ? _value.syncedAt
            : syncedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileTagAssociationImpl implements _ProfileTagAssociation {
  const _$ProfileTagAssociationImpl({
    required this.id,
    required this.profileId,
    required this.profileType,
    required this.tagId,
    this.taggedBy,
    required this.taggedAt,
    this.syncedAt,
    this.isDeleted = false,
  });

  factory _$ProfileTagAssociationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileTagAssociationImplFromJson(json);

  @override
  final int id;
  @override
  final String profileId;
  @override
  final String profileType;
  @override
  final int tagId;
  @override
  final String? taggedBy;
  @override
  final DateTime taggedAt;
  @override
  final DateTime? syncedAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'ProfileTagAssociation(id: $id, profileId: $profileId, profileType: $profileType, tagId: $tagId, taggedBy: $taggedBy, taggedAt: $taggedAt, syncedAt: $syncedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileTagAssociationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.profileType, profileType) ||
                other.profileType == profileType) &&
            (identical(other.tagId, tagId) || other.tagId == tagId) &&
            (identical(other.taggedBy, taggedBy) ||
                other.taggedBy == taggedBy) &&
            (identical(other.taggedAt, taggedAt) ||
                other.taggedAt == taggedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    profileId,
    profileType,
    tagId,
    taggedBy,
    taggedAt,
    syncedAt,
    isDeleted,
  );

  /// Create a copy of ProfileTagAssociation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileTagAssociationImplCopyWith<_$ProfileTagAssociationImpl>
  get copyWith =>
      __$$ProfileTagAssociationImplCopyWithImpl<_$ProfileTagAssociationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileTagAssociationImplToJson(this);
  }
}

abstract class _ProfileTagAssociation implements ProfileTagAssociation {
  const factory _ProfileTagAssociation({
    required final int id,
    required final String profileId,
    required final String profileType,
    required final int tagId,
    final String? taggedBy,
    required final DateTime taggedAt,
    final DateTime? syncedAt,
    final bool isDeleted,
  }) = _$ProfileTagAssociationImpl;

  factory _ProfileTagAssociation.fromJson(Map<String, dynamic> json) =
      _$ProfileTagAssociationImpl.fromJson;

  @override
  int get id;
  @override
  String get profileId;
  @override
  String get profileType;
  @override
  int get tagId;
  @override
  String? get taggedBy;
  @override
  DateTime get taggedAt;
  @override
  DateTime? get syncedAt;
  @override
  bool get isDeleted;

  /// Create a copy of ProfileTagAssociation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileTagAssociationImplCopyWith<_$ProfileTagAssociationImpl>
  get copyWith => throw _privateConstructorUsedError;
}
