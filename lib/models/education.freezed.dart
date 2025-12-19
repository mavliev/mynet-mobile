// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'education.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Education _$EducationFromJson(Map<String, dynamic> json) {
  return _Education.fromJson(json);
}

/// @nodoc
mixin _$Education {
  int get educationId => throw _privateConstructorUsedError;
  String get profileId => throw _privateConstructorUsedError;
  String get schoolName => throw _privateConstructorUsedError;
  String? get schoolUrl => throw _privateConstructorUsedError;
  String? get degree => throw _privateConstructorUsedError;
  String? get fieldOfStudy => throw _privateConstructorUsedError;
  int? get startYear => throw _privateConstructorUsedError;
  int? get endYear => throw _privateConstructorUsedError;
  String? get grade => throw _privateConstructorUsedError;
  String? get activities => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get orderIndex => throw _privateConstructorUsedError;
  DateTime? get extractedAt => throw _privateConstructorUsedError;

  /// Serializes this Education to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EducationCopyWith<Education> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EducationCopyWith<$Res> {
  factory $EducationCopyWith(Education value, $Res Function(Education) then) =
      _$EducationCopyWithImpl<$Res, Education>;
  @useResult
  $Res call({
    int educationId,
    String profileId,
    String schoolName,
    String? schoolUrl,
    String? degree,
    String? fieldOfStudy,
    int? startYear,
    int? endYear,
    String? grade,
    String? activities,
    String? description,
    int? orderIndex,
    DateTime? extractedAt,
  });
}

/// @nodoc
class _$EducationCopyWithImpl<$Res, $Val extends Education>
    implements $EducationCopyWith<$Res> {
  _$EducationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? educationId = null,
    Object? profileId = null,
    Object? schoolName = null,
    Object? schoolUrl = freezed,
    Object? degree = freezed,
    Object? fieldOfStudy = freezed,
    Object? startYear = freezed,
    Object? endYear = freezed,
    Object? grade = freezed,
    Object? activities = freezed,
    Object? description = freezed,
    Object? orderIndex = freezed,
    Object? extractedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            educationId: null == educationId
                ? _value.educationId
                : educationId // ignore: cast_nullable_to_non_nullable
                      as int,
            profileId: null == profileId
                ? _value.profileId
                : profileId // ignore: cast_nullable_to_non_nullable
                      as String,
            schoolName: null == schoolName
                ? _value.schoolName
                : schoolName // ignore: cast_nullable_to_non_nullable
                      as String,
            schoolUrl: freezed == schoolUrl
                ? _value.schoolUrl
                : schoolUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            degree: freezed == degree
                ? _value.degree
                : degree // ignore: cast_nullable_to_non_nullable
                      as String?,
            fieldOfStudy: freezed == fieldOfStudy
                ? _value.fieldOfStudy
                : fieldOfStudy // ignore: cast_nullable_to_non_nullable
                      as String?,
            startYear: freezed == startYear
                ? _value.startYear
                : startYear // ignore: cast_nullable_to_non_nullable
                      as int?,
            endYear: freezed == endYear
                ? _value.endYear
                : endYear // ignore: cast_nullable_to_non_nullable
                      as int?,
            grade: freezed == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as String?,
            activities: freezed == activities
                ? _value.activities
                : activities // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$EducationImplCopyWith<$Res>
    implements $EducationCopyWith<$Res> {
  factory _$$EducationImplCopyWith(
    _$EducationImpl value,
    $Res Function(_$EducationImpl) then,
  ) = __$$EducationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int educationId,
    String profileId,
    String schoolName,
    String? schoolUrl,
    String? degree,
    String? fieldOfStudy,
    int? startYear,
    int? endYear,
    String? grade,
    String? activities,
    String? description,
    int? orderIndex,
    DateTime? extractedAt,
  });
}

/// @nodoc
class __$$EducationImplCopyWithImpl<$Res>
    extends _$EducationCopyWithImpl<$Res, _$EducationImpl>
    implements _$$EducationImplCopyWith<$Res> {
  __$$EducationImplCopyWithImpl(
    _$EducationImpl _value,
    $Res Function(_$EducationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? educationId = null,
    Object? profileId = null,
    Object? schoolName = null,
    Object? schoolUrl = freezed,
    Object? degree = freezed,
    Object? fieldOfStudy = freezed,
    Object? startYear = freezed,
    Object? endYear = freezed,
    Object? grade = freezed,
    Object? activities = freezed,
    Object? description = freezed,
    Object? orderIndex = freezed,
    Object? extractedAt = freezed,
  }) {
    return _then(
      _$EducationImpl(
        educationId: null == educationId
            ? _value.educationId
            : educationId // ignore: cast_nullable_to_non_nullable
                  as int,
        profileId: null == profileId
            ? _value.profileId
            : profileId // ignore: cast_nullable_to_non_nullable
                  as String,
        schoolName: null == schoolName
            ? _value.schoolName
            : schoolName // ignore: cast_nullable_to_non_nullable
                  as String,
        schoolUrl: freezed == schoolUrl
            ? _value.schoolUrl
            : schoolUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        degree: freezed == degree
            ? _value.degree
            : degree // ignore: cast_nullable_to_non_nullable
                  as String?,
        fieldOfStudy: freezed == fieldOfStudy
            ? _value.fieldOfStudy
            : fieldOfStudy // ignore: cast_nullable_to_non_nullable
                  as String?,
        startYear: freezed == startYear
            ? _value.startYear
            : startYear // ignore: cast_nullable_to_non_nullable
                  as int?,
        endYear: freezed == endYear
            ? _value.endYear
            : endYear // ignore: cast_nullable_to_non_nullable
                  as int?,
        grade: freezed == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as String?,
        activities: freezed == activities
            ? _value.activities
            : activities // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$EducationImpl implements _Education {
  const _$EducationImpl({
    required this.educationId,
    required this.profileId,
    required this.schoolName,
    this.schoolUrl,
    this.degree,
    this.fieldOfStudy,
    this.startYear,
    this.endYear,
    this.grade,
    this.activities,
    this.description,
    this.orderIndex,
    this.extractedAt,
  });

  factory _$EducationImpl.fromJson(Map<String, dynamic> json) =>
      _$$EducationImplFromJson(json);

  @override
  final int educationId;
  @override
  final String profileId;
  @override
  final String schoolName;
  @override
  final String? schoolUrl;
  @override
  final String? degree;
  @override
  final String? fieldOfStudy;
  @override
  final int? startYear;
  @override
  final int? endYear;
  @override
  final String? grade;
  @override
  final String? activities;
  @override
  final String? description;
  @override
  final int? orderIndex;
  @override
  final DateTime? extractedAt;

  @override
  String toString() {
    return 'Education(educationId: $educationId, profileId: $profileId, schoolName: $schoolName, schoolUrl: $schoolUrl, degree: $degree, fieldOfStudy: $fieldOfStudy, startYear: $startYear, endYear: $endYear, grade: $grade, activities: $activities, description: $description, orderIndex: $orderIndex, extractedAt: $extractedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EducationImpl &&
            (identical(other.educationId, educationId) ||
                other.educationId == educationId) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.schoolUrl, schoolUrl) ||
                other.schoolUrl == schoolUrl) &&
            (identical(other.degree, degree) || other.degree == degree) &&
            (identical(other.fieldOfStudy, fieldOfStudy) ||
                other.fieldOfStudy == fieldOfStudy) &&
            (identical(other.startYear, startYear) ||
                other.startYear == startYear) &&
            (identical(other.endYear, endYear) || other.endYear == endYear) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.activities, activities) ||
                other.activities == activities) &&
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
    educationId,
    profileId,
    schoolName,
    schoolUrl,
    degree,
    fieldOfStudy,
    startYear,
    endYear,
    grade,
    activities,
    description,
    orderIndex,
    extractedAt,
  );

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EducationImplCopyWith<_$EducationImpl> get copyWith =>
      __$$EducationImplCopyWithImpl<_$EducationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EducationImplToJson(this);
  }
}

abstract class _Education implements Education {
  const factory _Education({
    required final int educationId,
    required final String profileId,
    required final String schoolName,
    final String? schoolUrl,
    final String? degree,
    final String? fieldOfStudy,
    final int? startYear,
    final int? endYear,
    final String? grade,
    final String? activities,
    final String? description,
    final int? orderIndex,
    final DateTime? extractedAt,
  }) = _$EducationImpl;

  factory _Education.fromJson(Map<String, dynamic> json) =
      _$EducationImpl.fromJson;

  @override
  int get educationId;
  @override
  String get profileId;
  @override
  String get schoolName;
  @override
  String? get schoolUrl;
  @override
  String? get degree;
  @override
  String? get fieldOfStudy;
  @override
  int? get startYear;
  @override
  int? get endYear;
  @override
  String? get grade;
  @override
  String? get activities;
  @override
  String? get description;
  @override
  int? get orderIndex;
  @override
  DateTime? get extractedAt;

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EducationImplCopyWith<_$EducationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
