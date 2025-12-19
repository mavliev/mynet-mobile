// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'experience.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorkExperience _$WorkExperienceFromJson(Map<String, dynamic> json) {
  return _WorkExperience.fromJson(json);
}

/// @nodoc
mixin _$WorkExperience {
  int get experienceId => throw _privateConstructorUsedError;
  String get profileId => throw _privateConstructorUsedError;
  String get positionTitle => throw _privateConstructorUsedError;
  String? get companyName => throw _privateConstructorUsedError;
  String? get companyUrl => throw _privateConstructorUsedError;
  String? get employmentType => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  String? get durationText => throw _privateConstructorUsedError;
  bool get isCurrent => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get orderIndex => throw _privateConstructorUsedError;
  DateTime? get extractedAt => throw _privateConstructorUsedError;

  /// Serializes this WorkExperience to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkExperience
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkExperienceCopyWith<WorkExperience> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkExperienceCopyWith<$Res> {
  factory $WorkExperienceCopyWith(
    WorkExperience value,
    $Res Function(WorkExperience) then,
  ) = _$WorkExperienceCopyWithImpl<$Res, WorkExperience>;
  @useResult
  $Res call({
    int experienceId,
    String profileId,
    String positionTitle,
    String? companyName,
    String? companyUrl,
    String? employmentType,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    String? durationText,
    bool isCurrent,
    String? description,
    int? orderIndex,
    DateTime? extractedAt,
  });
}

/// @nodoc
class _$WorkExperienceCopyWithImpl<$Res, $Val extends WorkExperience>
    implements $WorkExperienceCopyWith<$Res> {
  _$WorkExperienceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkExperience
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? experienceId = null,
    Object? profileId = null,
    Object? positionTitle = null,
    Object? companyName = freezed,
    Object? companyUrl = freezed,
    Object? employmentType = freezed,
    Object? location = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? durationText = freezed,
    Object? isCurrent = null,
    Object? description = freezed,
    Object? orderIndex = freezed,
    Object? extractedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            experienceId: null == experienceId
                ? _value.experienceId
                : experienceId // ignore: cast_nullable_to_non_nullable
                      as int,
            profileId: null == profileId
                ? _value.profileId
                : profileId // ignore: cast_nullable_to_non_nullable
                      as String,
            positionTitle: null == positionTitle
                ? _value.positionTitle
                : positionTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            companyName: freezed == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String?,
            companyUrl: freezed == companyUrl
                ? _value.companyUrl
                : companyUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            employmentType: freezed == employmentType
                ? _value.employmentType
                : employmentType // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            durationText: freezed == durationText
                ? _value.durationText
                : durationText // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCurrent: null == isCurrent
                ? _value.isCurrent
                : isCurrent // ignore: cast_nullable_to_non_nullable
                      as bool,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$WorkExperienceImplCopyWith<$Res>
    implements $WorkExperienceCopyWith<$Res> {
  factory _$$WorkExperienceImplCopyWith(
    _$WorkExperienceImpl value,
    $Res Function(_$WorkExperienceImpl) then,
  ) = __$$WorkExperienceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int experienceId,
    String profileId,
    String positionTitle,
    String? companyName,
    String? companyUrl,
    String? employmentType,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    String? durationText,
    bool isCurrent,
    String? description,
    int? orderIndex,
    DateTime? extractedAt,
  });
}

/// @nodoc
class __$$WorkExperienceImplCopyWithImpl<$Res>
    extends _$WorkExperienceCopyWithImpl<$Res, _$WorkExperienceImpl>
    implements _$$WorkExperienceImplCopyWith<$Res> {
  __$$WorkExperienceImplCopyWithImpl(
    _$WorkExperienceImpl _value,
    $Res Function(_$WorkExperienceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkExperience
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? experienceId = null,
    Object? profileId = null,
    Object? positionTitle = null,
    Object? companyName = freezed,
    Object? companyUrl = freezed,
    Object? employmentType = freezed,
    Object? location = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? durationText = freezed,
    Object? isCurrent = null,
    Object? description = freezed,
    Object? orderIndex = freezed,
    Object? extractedAt = freezed,
  }) {
    return _then(
      _$WorkExperienceImpl(
        experienceId: null == experienceId
            ? _value.experienceId
            : experienceId // ignore: cast_nullable_to_non_nullable
                  as int,
        profileId: null == profileId
            ? _value.profileId
            : profileId // ignore: cast_nullable_to_non_nullable
                  as String,
        positionTitle: null == positionTitle
            ? _value.positionTitle
            : positionTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        companyName: freezed == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String?,
        companyUrl: freezed == companyUrl
            ? _value.companyUrl
            : companyUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        employmentType: freezed == employmentType
            ? _value.employmentType
            : employmentType // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        durationText: freezed == durationText
            ? _value.durationText
            : durationText // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCurrent: null == isCurrent
            ? _value.isCurrent
            : isCurrent // ignore: cast_nullable_to_non_nullable
                  as bool,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$WorkExperienceImpl implements _WorkExperience {
  const _$WorkExperienceImpl({
    required this.experienceId,
    required this.profileId,
    required this.positionTitle,
    this.companyName,
    this.companyUrl,
    this.employmentType,
    this.location,
    this.startDate,
    this.endDate,
    this.durationText,
    this.isCurrent = false,
    this.description,
    this.orderIndex,
    this.extractedAt,
  });

  factory _$WorkExperienceImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkExperienceImplFromJson(json);

  @override
  final int experienceId;
  @override
  final String profileId;
  @override
  final String positionTitle;
  @override
  final String? companyName;
  @override
  final String? companyUrl;
  @override
  final String? employmentType;
  @override
  final String? location;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final String? durationText;
  @override
  @JsonKey()
  final bool isCurrent;
  @override
  final String? description;
  @override
  final int? orderIndex;
  @override
  final DateTime? extractedAt;

  @override
  String toString() {
    return 'WorkExperience(experienceId: $experienceId, profileId: $profileId, positionTitle: $positionTitle, companyName: $companyName, companyUrl: $companyUrl, employmentType: $employmentType, location: $location, startDate: $startDate, endDate: $endDate, durationText: $durationText, isCurrent: $isCurrent, description: $description, orderIndex: $orderIndex, extractedAt: $extractedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkExperienceImpl &&
            (identical(other.experienceId, experienceId) ||
                other.experienceId == experienceId) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.positionTitle, positionTitle) ||
                other.positionTitle == positionTitle) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.companyUrl, companyUrl) ||
                other.companyUrl == companyUrl) &&
            (identical(other.employmentType, employmentType) ||
                other.employmentType == employmentType) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.durationText, durationText) ||
                other.durationText == durationText) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            (identical(other.extractedAt, extractedAt) ||
                other.extractedAt == extractedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    experienceId,
    profileId,
    positionTitle,
    companyName,
    companyUrl,
    employmentType,
    location,
    startDate,
    endDate,
    durationText,
    isCurrent,
    description,
    orderIndex,
    extractedAt,
  );

  /// Create a copy of WorkExperience
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkExperienceImplCopyWith<_$WorkExperienceImpl> get copyWith =>
      __$$WorkExperienceImplCopyWithImpl<_$WorkExperienceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkExperienceImplToJson(this);
  }
}

abstract class _WorkExperience implements WorkExperience {
  const factory _WorkExperience({
    required final int experienceId,
    required final String profileId,
    required final String positionTitle,
    final String? companyName,
    final String? companyUrl,
    final String? employmentType,
    final String? location,
    final DateTime? startDate,
    final DateTime? endDate,
    final String? durationText,
    final bool isCurrent,
    final String? description,
    final int? orderIndex,
    final DateTime? extractedAt,
  }) = _$WorkExperienceImpl;

  factory _WorkExperience.fromJson(Map<String, dynamic> json) =
      _$WorkExperienceImpl.fromJson;

  @override
  int get experienceId;
  @override
  String get profileId;
  @override
  String get positionTitle;
  @override
  String? get companyName;
  @override
  String? get companyUrl;
  @override
  String? get employmentType;
  @override
  String? get location;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  String? get durationText;
  @override
  bool get isCurrent;
  @override
  String? get description;
  @override
  int? get orderIndex;
  @override
  DateTime? get extractedAt;

  /// Create a copy of WorkExperience
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkExperienceImplCopyWith<_$WorkExperienceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
