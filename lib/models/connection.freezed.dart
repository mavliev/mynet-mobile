// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Connection _$ConnectionFromJson(Map<String, dynamic> json) {
  return _Connection.fromJson(json);
}

/// @nodoc
mixin _$Connection {
  int get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get linkedinUrl => throw _privateConstructorUsedError;
  String? get emailAddress => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;
  String? get position => throw _privateConstructorUsedError;
  String get connectedOn => throw _privateConstructorUsedError;
  int get connectionStrength => throw _privateConstructorUsedError;
  String? get lastInteractionDate => throw _privateConstructorUsedError;
  int get totalInteractions => throw _privateConstructorUsedError;
  String? get connectionSource => throw _privateConstructorUsedError;
  String? get tags => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  bool get canProvideIntro => throw _privateConstructorUsedError;
  bool get worksAtTargetCompany => throw _privateConstructorUsedError;
  bool get isHiringManager => throw _privateConstructorUsedError;
  bool get isRecruiter => throw _privateConstructorUsedError;
  String get importedFrom => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Connection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionCopyWith<Connection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionCopyWith<$Res> {
  factory $ConnectionCopyWith(
    Connection value,
    $Res Function(Connection) then,
  ) = _$ConnectionCopyWithImpl<$Res, Connection>;
  @useResult
  $Res call({
    int id,
    String firstName,
    String lastName,
    String linkedinUrl,
    String? emailAddress,
    String? company,
    String? position,
    String connectedOn,
    int connectionStrength,
    String? lastInteractionDate,
    int totalInteractions,
    String? connectionSource,
    String? tags,
    String? notes,
    bool canProvideIntro,
    bool worksAtTargetCompany,
    bool isHiringManager,
    bool isRecruiter,
    String importedFrom,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ConnectionCopyWithImpl<$Res, $Val extends Connection>
    implements $ConnectionCopyWith<$Res> {
  _$ConnectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? linkedinUrl = null,
    Object? emailAddress = freezed,
    Object? company = freezed,
    Object? position = freezed,
    Object? connectedOn = null,
    Object? connectionStrength = null,
    Object? lastInteractionDate = freezed,
    Object? totalInteractions = null,
    Object? connectionSource = freezed,
    Object? tags = freezed,
    Object? notes = freezed,
    Object? canProvideIntro = null,
    Object? worksAtTargetCompany = null,
    Object? isHiringManager = null,
    Object? isRecruiter = null,
    Object? importedFrom = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            linkedinUrl: null == linkedinUrl
                ? _value.linkedinUrl
                : linkedinUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            emailAddress: freezed == emailAddress
                ? _value.emailAddress
                : emailAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            company: freezed == company
                ? _value.company
                : company // ignore: cast_nullable_to_non_nullable
                      as String?,
            position: freezed == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as String?,
            connectedOn: null == connectedOn
                ? _value.connectedOn
                : connectedOn // ignore: cast_nullable_to_non_nullable
                      as String,
            connectionStrength: null == connectionStrength
                ? _value.connectionStrength
                : connectionStrength // ignore: cast_nullable_to_non_nullable
                      as int,
            lastInteractionDate: freezed == lastInteractionDate
                ? _value.lastInteractionDate
                : lastInteractionDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalInteractions: null == totalInteractions
                ? _value.totalInteractions
                : totalInteractions // ignore: cast_nullable_to_non_nullable
                      as int,
            connectionSource: freezed == connectionSource
                ? _value.connectionSource
                : connectionSource // ignore: cast_nullable_to_non_nullable
                      as String?,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            canProvideIntro: null == canProvideIntro
                ? _value.canProvideIntro
                : canProvideIntro // ignore: cast_nullable_to_non_nullable
                      as bool,
            worksAtTargetCompany: null == worksAtTargetCompany
                ? _value.worksAtTargetCompany
                : worksAtTargetCompany // ignore: cast_nullable_to_non_nullable
                      as bool,
            isHiringManager: null == isHiringManager
                ? _value.isHiringManager
                : isHiringManager // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRecruiter: null == isRecruiter
                ? _value.isRecruiter
                : isRecruiter // ignore: cast_nullable_to_non_nullable
                      as bool,
            importedFrom: null == importedFrom
                ? _value.importedFrom
                : importedFrom // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectionImplCopyWith<$Res>
    implements $ConnectionCopyWith<$Res> {
  factory _$$ConnectionImplCopyWith(
    _$ConnectionImpl value,
    $Res Function(_$ConnectionImpl) then,
  ) = __$$ConnectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String firstName,
    String lastName,
    String linkedinUrl,
    String? emailAddress,
    String? company,
    String? position,
    String connectedOn,
    int connectionStrength,
    String? lastInteractionDate,
    int totalInteractions,
    String? connectionSource,
    String? tags,
    String? notes,
    bool canProvideIntro,
    bool worksAtTargetCompany,
    bool isHiringManager,
    bool isRecruiter,
    String importedFrom,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ConnectionImplCopyWithImpl<$Res>
    extends _$ConnectionCopyWithImpl<$Res, _$ConnectionImpl>
    implements _$$ConnectionImplCopyWith<$Res> {
  __$$ConnectionImplCopyWithImpl(
    _$ConnectionImpl _value,
    $Res Function(_$ConnectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? linkedinUrl = null,
    Object? emailAddress = freezed,
    Object? company = freezed,
    Object? position = freezed,
    Object? connectedOn = null,
    Object? connectionStrength = null,
    Object? lastInteractionDate = freezed,
    Object? totalInteractions = null,
    Object? connectionSource = freezed,
    Object? tags = freezed,
    Object? notes = freezed,
    Object? canProvideIntro = null,
    Object? worksAtTargetCompany = null,
    Object? isHiringManager = null,
    Object? isRecruiter = null,
    Object? importedFrom = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ConnectionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        linkedinUrl: null == linkedinUrl
            ? _value.linkedinUrl
            : linkedinUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        emailAddress: freezed == emailAddress
            ? _value.emailAddress
            : emailAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        company: freezed == company
            ? _value.company
            : company // ignore: cast_nullable_to_non_nullable
                  as String?,
        position: freezed == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as String?,
        connectedOn: null == connectedOn
            ? _value.connectedOn
            : connectedOn // ignore: cast_nullable_to_non_nullable
                  as String,
        connectionStrength: null == connectionStrength
            ? _value.connectionStrength
            : connectionStrength // ignore: cast_nullable_to_non_nullable
                  as int,
        lastInteractionDate: freezed == lastInteractionDate
            ? _value.lastInteractionDate
            : lastInteractionDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalInteractions: null == totalInteractions
            ? _value.totalInteractions
            : totalInteractions // ignore: cast_nullable_to_non_nullable
                  as int,
        connectionSource: freezed == connectionSource
            ? _value.connectionSource
            : connectionSource // ignore: cast_nullable_to_non_nullable
                  as String?,
        tags: freezed == tags
            ? _value.tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        canProvideIntro: null == canProvideIntro
            ? _value.canProvideIntro
            : canProvideIntro // ignore: cast_nullable_to_non_nullable
                  as bool,
        worksAtTargetCompany: null == worksAtTargetCompany
            ? _value.worksAtTargetCompany
            : worksAtTargetCompany // ignore: cast_nullable_to_non_nullable
                  as bool,
        isHiringManager: null == isHiringManager
            ? _value.isHiringManager
            : isHiringManager // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRecruiter: null == isRecruiter
            ? _value.isRecruiter
            : isRecruiter // ignore: cast_nullable_to_non_nullable
                  as bool,
        importedFrom: null == importedFrom
            ? _value.importedFrom
            : importedFrom // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionImpl implements _Connection {
  const _$ConnectionImpl({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.linkedinUrl,
    this.emailAddress,
    this.company,
    this.position,
    required this.connectedOn,
    this.connectionStrength = 1,
    this.lastInteractionDate,
    this.totalInteractions = 0,
    this.connectionSource,
    this.tags,
    this.notes,
    this.canProvideIntro = false,
    this.worksAtTargetCompany = false,
    this.isHiringManager = false,
    this.isRecruiter = false,
    this.importedFrom = 'linkedin_export',
    this.createdAt,
    this.updatedAt,
  });

  factory _$ConnectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionImplFromJson(json);

  @override
  final int id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String linkedinUrl;
  @override
  final String? emailAddress;
  @override
  final String? company;
  @override
  final String? position;
  @override
  final String connectedOn;
  @override
  @JsonKey()
  final int connectionStrength;
  @override
  final String? lastInteractionDate;
  @override
  @JsonKey()
  final int totalInteractions;
  @override
  final String? connectionSource;
  @override
  final String? tags;
  @override
  final String? notes;
  @override
  @JsonKey()
  final bool canProvideIntro;
  @override
  @JsonKey()
  final bool worksAtTargetCompany;
  @override
  @JsonKey()
  final bool isHiringManager;
  @override
  @JsonKey()
  final bool isRecruiter;
  @override
  @JsonKey()
  final String importedFrom;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Connection(id: $id, firstName: $firstName, lastName: $lastName, linkedinUrl: $linkedinUrl, emailAddress: $emailAddress, company: $company, position: $position, connectedOn: $connectedOn, connectionStrength: $connectionStrength, lastInteractionDate: $lastInteractionDate, totalInteractions: $totalInteractions, connectionSource: $connectionSource, tags: $tags, notes: $notes, canProvideIntro: $canProvideIntro, worksAtTargetCompany: $worksAtTargetCompany, isHiringManager: $isHiringManager, isRecruiter: $isRecruiter, importedFrom: $importedFrom, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.linkedinUrl, linkedinUrl) ||
                other.linkedinUrl == linkedinUrl) &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.connectedOn, connectedOn) ||
                other.connectedOn == connectedOn) &&
            (identical(other.connectionStrength, connectionStrength) ||
                other.connectionStrength == connectionStrength) &&
            (identical(other.lastInteractionDate, lastInteractionDate) ||
                other.lastInteractionDate == lastInteractionDate) &&
            (identical(other.totalInteractions, totalInteractions) ||
                other.totalInteractions == totalInteractions) &&
            (identical(other.connectionSource, connectionSource) ||
                other.connectionSource == connectionSource) &&
            (identical(other.tags, tags) || other.tags == tags) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.canProvideIntro, canProvideIntro) ||
                other.canProvideIntro == canProvideIntro) &&
            (identical(other.worksAtTargetCompany, worksAtTargetCompany) ||
                other.worksAtTargetCompany == worksAtTargetCompany) &&
            (identical(other.isHiringManager, isHiringManager) ||
                other.isHiringManager == isHiringManager) &&
            (identical(other.isRecruiter, isRecruiter) ||
                other.isRecruiter == isRecruiter) &&
            (identical(other.importedFrom, importedFrom) ||
                other.importedFrom == importedFrom) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    firstName,
    lastName,
    linkedinUrl,
    emailAddress,
    company,
    position,
    connectedOn,
    connectionStrength,
    lastInteractionDate,
    totalInteractions,
    connectionSource,
    tags,
    notes,
    canProvideIntro,
    worksAtTargetCompany,
    isHiringManager,
    isRecruiter,
    importedFrom,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionImplCopyWith<_$ConnectionImpl> get copyWith =>
      __$$ConnectionImplCopyWithImpl<_$ConnectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionImplToJson(this);
  }
}

abstract class _Connection implements Connection {
  const factory _Connection({
    required final int id,
    required final String firstName,
    required final String lastName,
    required final String linkedinUrl,
    final String? emailAddress,
    final String? company,
    final String? position,
    required final String connectedOn,
    final int connectionStrength,
    final String? lastInteractionDate,
    final int totalInteractions,
    final String? connectionSource,
    final String? tags,
    final String? notes,
    final bool canProvideIntro,
    final bool worksAtTargetCompany,
    final bool isHiringManager,
    final bool isRecruiter,
    final String importedFrom,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$ConnectionImpl;

  factory _Connection.fromJson(Map<String, dynamic> json) =
      _$ConnectionImpl.fromJson;

  @override
  int get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get linkedinUrl;
  @override
  String? get emailAddress;
  @override
  String? get company;
  @override
  String? get position;
  @override
  String get connectedOn;
  @override
  int get connectionStrength;
  @override
  String? get lastInteractionDate;
  @override
  int get totalInteractions;
  @override
  String? get connectionSource;
  @override
  String? get tags;
  @override
  String? get notes;
  @override
  bool get canProvideIntro;
  @override
  bool get worksAtTargetCompany;
  @override
  bool get isHiringManager;
  @override
  bool get isRecruiter;
  @override
  String get importedFrom;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionImplCopyWith<_$ConnectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
