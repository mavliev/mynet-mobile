// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return _Skill.fromJson(json);
}

/// @nodoc
mixin _$Skill {
  int get skillId => throw _privateConstructorUsedError;
  String get profileId => throw _privateConstructorUsedError;
  String get skillName => throw _privateConstructorUsedError;
  int get endorsementCount => throw _privateConstructorUsedError;
  bool get isTopSkill => throw _privateConstructorUsedError;
  int? get orderIndex => throw _privateConstructorUsedError;
  DateTime? get extractedAt => throw _privateConstructorUsedError;

  /// Serializes this Skill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SkillCopyWith<Skill> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillCopyWith<$Res> {
  factory $SkillCopyWith(Skill value, $Res Function(Skill) then) =
      _$SkillCopyWithImpl<$Res, Skill>;
  @useResult
  $Res call({
    int skillId,
    String profileId,
    String skillName,
    int endorsementCount,
    bool isTopSkill,
    int? orderIndex,
    DateTime? extractedAt,
  });
}

/// @nodoc
class _$SkillCopyWithImpl<$Res, $Val extends Skill>
    implements $SkillCopyWith<$Res> {
  _$SkillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillId = null,
    Object? profileId = null,
    Object? skillName = null,
    Object? endorsementCount = null,
    Object? isTopSkill = null,
    Object? orderIndex = freezed,
    Object? extractedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            skillId: null == skillId
                ? _value.skillId
                : skillId // ignore: cast_nullable_to_non_nullable
                      as int,
            profileId: null == profileId
                ? _value.profileId
                : profileId // ignore: cast_nullable_to_non_nullable
                      as String,
            skillName: null == skillName
                ? _value.skillName
                : skillName // ignore: cast_nullable_to_non_nullable
                      as String,
            endorsementCount: null == endorsementCount
                ? _value.endorsementCount
                : endorsementCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isTopSkill: null == isTopSkill
                ? _value.isTopSkill
                : isTopSkill // ignore: cast_nullable_to_non_nullable
                      as bool,
            orderIndex: freezed == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int?,
            extractedAt: freezed == extractedAt
                ? _value.extractedAt
                : extractedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SkillImplCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory _$$SkillImplCopyWith(
    _$SkillImpl value,
    $Res Function(_$SkillImpl) then,
  ) = __$$SkillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int skillId,
    String profileId,
    String skillName,
    int endorsementCount,
    bool isTopSkill,
    int? orderIndex,
    DateTime? extractedAt,
  });
}

/// @nodoc
class __$$SkillImplCopyWithImpl<$Res>
    extends _$SkillCopyWithImpl<$Res, _$SkillImpl>
    implements _$$SkillImplCopyWith<$Res> {
  __$$SkillImplCopyWithImpl(
    _$SkillImpl _value,
    $Res Function(_$SkillImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillId = null,
    Object? profileId = null,
    Object? skillName = null,
    Object? endorsementCount = null,
    Object? isTopSkill = null,
    Object? orderIndex = freezed,
    Object? extractedAt = freezed,
  }) {
    return _then(
      _$SkillImpl(
        skillId: null == skillId
            ? _value.skillId
            : skillId // ignore: cast_nullable_to_non_nullable
                  as int,
        profileId: null == profileId
            ? _value.profileId
            : profileId // ignore: cast_nullable_to_non_nullable
                  as String,
        skillName: null == skillName
            ? _value.skillName
            : skillName // ignore: cast_nullable_to_non_nullable
                  as String,
        endorsementCount: null == endorsementCount
            ? _value.endorsementCount
            : endorsementCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isTopSkill: null == isTopSkill
            ? _value.isTopSkill
            : isTopSkill // ignore: cast_nullable_to_non_nullable
                  as bool,
        orderIndex: freezed == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int?,
        extractedAt: freezed == extractedAt
            ? _value.extractedAt
            : extractedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillImpl implements _Skill {
  const _$SkillImpl({
    required this.skillId,
    required this.profileId,
    required this.skillName,
    this.endorsementCount = 0,
    this.isTopSkill = false,
    this.orderIndex,
    this.extractedAt,
  });

  factory _$SkillImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillImplFromJson(json);

  @override
  final int skillId;
  @override
  final String profileId;
  @override
  final String skillName;
  @override
  @JsonKey()
  final int endorsementCount;
  @override
  @JsonKey()
  final bool isTopSkill;
  @override
  final int? orderIndex;
  @override
  final DateTime? extractedAt;

  @override
  String toString() {
    return 'Skill(skillId: $skillId, profileId: $profileId, skillName: $skillName, endorsementCount: $endorsementCount, isTopSkill: $isTopSkill, orderIndex: $orderIndex, extractedAt: $extractedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkillImpl &&
            (identical(other.skillId, skillId) || other.skillId == skillId) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.skillName, skillName) ||
                other.skillName == skillName) &&
            (identical(other.endorsementCount, endorsementCount) ||
                other.endorsementCount == endorsementCount) &&
            (identical(other.isTopSkill, isTopSkill) ||
                other.isTopSkill == isTopSkill) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            (identical(other.extractedAt, extractedAt) ||
                other.extractedAt == extractedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    skillId,
    profileId,
    skillName,
    endorsementCount,
    isTopSkill,
    orderIndex,
    extractedAt,
  );

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      __$$SkillImplCopyWithImpl<_$SkillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillImplToJson(this);
  }
}

abstract class _Skill implements Skill {
  const factory _Skill({
    required final int skillId,
    required final String profileId,
    required final String skillName,
    final int endorsementCount,
    final bool isTopSkill,
    final int? orderIndex,
    final DateTime? extractedAt,
  }) = _$SkillImpl;

  factory _Skill.fromJson(Map<String, dynamic> json) = _$SkillImpl.fromJson;

  @override
  int get skillId;
  @override
  String get profileId;
  @override
  String get skillName;
  @override
  int get endorsementCount;
  @override
  bool get isTopSkill;
  @override
  int? get orderIndex;
  @override
  DateTime? get extractedAt;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
