// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_user_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOnboardingUserModelCollection on Isar {
  IsarCollection<OnboardingUserModel> get onboardingUserModels =>
      this.collection();
}

const OnboardingUserModelSchema = CollectionSchema(
  name: r'OnboardingUserModel',
  id: -234646597519286312,
  properties: {
    r'bio': PropertySchema(id: 0, name: r'bio', type: IsarType.string),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'displayName': PropertySchema(
      id: 2,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'dob': PropertySchema(id: 3, name: r'dob', type: IsarType.string),
    r'email': PropertySchema(id: 4, name: r'email', type: IsarType.string),
    r'fullName': PropertySchema(
      id: 5,
      name: r'fullName',
      type: IsarType.string,
    ),
    r'gender': PropertySchema(id: 6, name: r'gender', type: IsarType.string),
    r'isPrivate': PropertySchema(
      id: 7,
      name: r'isPrivate',
      type: IsarType.bool,
    ),
    r'latitude': PropertySchema(
      id: 8,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'locationName': PropertySchema(
      id: 9,
      name: r'locationName',
      type: IsarType.string,
    ),
    r'longitude': PropertySchema(
      id: 10,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'meshId': PropertySchema(id: 11, name: r'meshId', type: IsarType.string),
    r'occupation': PropertySchema(
      id: 12,
      name: r'occupation',
      type: IsarType.string,
    ),
    r'onboardingCompleted': PropertySchema(
      id: 13,
      name: r'onboardingCompleted',
      type: IsarType.bool,
    ),
    r'phone': PropertySchema(id: 14, name: r'phone', type: IsarType.string),
    r'profileImage': PropertySchema(
      id: 15,
      name: r'profileImage',
      type: IsarType.string,
    ),
    r'username': PropertySchema(
      id: 16,
      name: r'username',
      type: IsarType.string,
    ),
  },
  estimateSize: _onboardingUserModelEstimateSize,
  serialize: _onboardingUserModelSerialize,
  deserialize: _onboardingUserModelDeserialize,
  deserializeProp: _onboardingUserModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _onboardingUserModelGetId,
  getLinks: _onboardingUserModelGetLinks,
  attach: _onboardingUserModelAttach,
  version: '3.1.0+1',
);

int _onboardingUserModelEstimateSize(
  OnboardingUserModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.bio;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.displayName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.dob;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fullName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.gender;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.locationName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.meshId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.occupation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.phone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.profileImage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.username;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _onboardingUserModelSerialize(
  OnboardingUserModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bio);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.displayName);
  writer.writeString(offsets[3], object.dob);
  writer.writeString(offsets[4], object.email);
  writer.writeString(offsets[5], object.fullName);
  writer.writeString(offsets[6], object.gender);
  writer.writeBool(offsets[7], object.isPrivate);
  writer.writeDouble(offsets[8], object.latitude);
  writer.writeString(offsets[9], object.locationName);
  writer.writeDouble(offsets[10], object.longitude);
  writer.writeString(offsets[11], object.meshId);
  writer.writeString(offsets[12], object.occupation);
  writer.writeBool(offsets[13], object.onboardingCompleted);
  writer.writeString(offsets[14], object.phone);
  writer.writeString(offsets[15], object.profileImage);
  writer.writeString(offsets[16], object.username);
}

OnboardingUserModel _onboardingUserModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OnboardingUserModel();
  object.bio = reader.readStringOrNull(offsets[0]);
  object.createdAt = reader.readDateTimeOrNull(offsets[1]);
  object.displayName = reader.readStringOrNull(offsets[2]);
  object.dob = reader.readStringOrNull(offsets[3]);
  object.email = reader.readStringOrNull(offsets[4]);
  object.fullName = reader.readStringOrNull(offsets[5]);
  object.gender = reader.readStringOrNull(offsets[6]);
  object.id = id;
  object.isPrivate = reader.readBool(offsets[7]);
  object.latitude = reader.readDoubleOrNull(offsets[8]);
  object.locationName = reader.readStringOrNull(offsets[9]);
  object.longitude = reader.readDoubleOrNull(offsets[10]);
  object.meshId = reader.readStringOrNull(offsets[11]);
  object.occupation = reader.readStringOrNull(offsets[12]);
  object.onboardingCompleted = reader.readBool(offsets[13]);
  object.phone = reader.readStringOrNull(offsets[14]);
  object.profileImage = reader.readStringOrNull(offsets[15]);
  object.username = reader.readStringOrNull(offsets[16]);
  return object;
}

P _onboardingUserModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _onboardingUserModelGetId(OnboardingUserModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _onboardingUserModelGetLinks(
  OnboardingUserModel object,
) {
  return [];
}

void _onboardingUserModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  OnboardingUserModel object,
) {
  object.id = id;
}

extension OnboardingUserModelQueryWhereSort
    on QueryBuilder<OnboardingUserModel, OnboardingUserModel, QWhere> {
  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OnboardingUserModelQueryWhere
    on QueryBuilder<OnboardingUserModel, OnboardingUserModel, QWhereClause> {
  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterWhereClause>
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension OnboardingUserModelQueryFilter
    on
        QueryBuilder<
          OnboardingUserModel,
          OnboardingUserModel,
          QFilterCondition
        > {
  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  bioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'bio'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  bioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'bio'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  bioEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'bio',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  bioGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bio',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  bioLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bio',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  bioBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bio',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  bioStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'bio',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  bioEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'bio',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  bioContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'bio',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  bioMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'bio',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  bioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bio', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  bioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'bio', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  createdAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  createdAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  displayNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'displayName'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  displayNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'displayName'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  displayNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  displayNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  displayNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  displayNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'displayName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  displayNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  displayNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  displayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'displayName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  displayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'displayName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'displayName', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'displayName', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  dobIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'dob'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  dobIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'dob'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  dobEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dob',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  dobGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dob',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  dobLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dob',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  dobBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dob',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  dobStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'dob',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  dobEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'dob',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  dobContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'dob',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  dobMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'dob',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  dobIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dob', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  dobIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'dob', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'email'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'email'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  emailEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'email',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'email',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'email',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'email',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  emailStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'email',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  emailEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'email',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  emailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'email',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  emailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'email',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'email', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'email', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  fullNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'fullName'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  fullNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'fullName'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  fullNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fullName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  fullNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fullName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  fullNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fullName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  fullNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fullName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  fullNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fullName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  fullNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fullName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  fullNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fullName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  fullNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fullName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  fullNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fullName', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  fullNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fullName', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  genderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'gender'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  genderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'gender'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  genderEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'gender',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  genderGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'gender',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  genderLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'gender',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  genderBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'gender',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  genderStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'gender',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  genderEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'gender',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  genderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'gender',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  genderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'gender',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  genderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'gender', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  genderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'gender', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  isPrivateEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isPrivate', value: value),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  latitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'latitude'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  latitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'latitude'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  latitudeEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'latitude',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  latitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'latitude',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  latitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'latitude',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  latitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'latitude',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  locationNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'locationName'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  locationNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'locationName'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  locationNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'locationName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  locationNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'locationName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  locationNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'locationName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  locationNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'locationName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  locationNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'locationName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  locationNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'locationName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  locationNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'locationName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  locationNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'locationName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  locationNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'locationName', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  locationNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'locationName', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  longitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'longitude'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  longitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'longitude'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  longitudeEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'longitude',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  longitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'longitude',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  longitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'longitude',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  longitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'longitude',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  meshIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'meshId'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  meshIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'meshId'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  meshIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'meshId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  meshIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'meshId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  meshIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'meshId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  meshIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'meshId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  meshIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'meshId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  meshIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'meshId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  meshIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'meshId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  meshIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'meshId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  meshIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'meshId', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  meshIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'meshId', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  occupationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'occupation'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  occupationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'occupation'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  occupationEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'occupation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  occupationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'occupation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  occupationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'occupation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  occupationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'occupation',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  occupationStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'occupation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  occupationEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'occupation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  occupationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'occupation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  occupationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'occupation',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  occupationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'occupation', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  occupationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'occupation', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  onboardingCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'onboardingCompleted', value: value),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  phoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'phone'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  phoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'phone'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  phoneEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'phone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  phoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'phone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  phoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'phone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  phoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'phone',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  phoneStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'phone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  phoneEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'phone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  phoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'phone',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  phoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'phone',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  phoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'phone', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  phoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'phone', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  profileImageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'profileImage'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  profileImageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'profileImage'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  profileImageEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'profileImage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  profileImageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'profileImage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  profileImageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'profileImage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  profileImageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'profileImage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  profileImageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'profileImage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  profileImageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'profileImage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  profileImageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'profileImage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  profileImageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'profileImage',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  profileImageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'profileImage', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  profileImageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'profileImage', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  usernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'username'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  usernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'username'),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  usernameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  usernameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  usernameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  usernameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'username',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  usernameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  usernameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  usernameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  usernameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'username',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'username', value: ''),
      );
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterFilterCondition>
  usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'username', value: ''),
      );
    });
  }
}

extension OnboardingUserModelQueryObject
    on
        QueryBuilder<
          OnboardingUserModel,
          OnboardingUserModel,
          QFilterCondition
        > {}

extension OnboardingUserModelQueryLinks
    on
        QueryBuilder<
          OnboardingUserModel,
          OnboardingUserModel,
          QFilterCondition
        > {}

extension OnboardingUserModelQuerySortBy
    on QueryBuilder<OnboardingUserModel, OnboardingUserModel, QSortBy> {
  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByBio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByBioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByDob() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dob', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByDobDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dob', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByFullName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByFullNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByIsPrivate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrivate', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByIsPrivateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrivate', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByLocationName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationName', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByLocationNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationName', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByMeshId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meshId', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByMeshIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meshId', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByOccupation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occupation', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByOccupationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occupation', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByProfileImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileImage', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByProfileImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileImage', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension OnboardingUserModelQuerySortThenBy
    on QueryBuilder<OnboardingUserModel, OnboardingUserModel, QSortThenBy> {
  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByBio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByBioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByDob() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dob', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByDobDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dob', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByFullName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByFullNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByIsPrivate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrivate', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByIsPrivateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrivate', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByLocationName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationName', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByLocationNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationName', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByMeshId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meshId', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByMeshIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meshId', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByOccupation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occupation', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByOccupationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occupation', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByProfileImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileImage', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByProfileImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileImage', Sort.desc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QAfterSortBy>
  thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension OnboardingUserModelQueryWhereDistinct
    on QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct> {
  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByBio({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bio', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByDisplayName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByDob({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dob', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByFullName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByGender({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gender', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByIsPrivate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPrivate');
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByLocationName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locationName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByMeshId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'meshId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByOccupation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'occupation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onboardingCompleted');
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByPhone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByProfileImage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileImage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OnboardingUserModel, OnboardingUserModel, QDistinct>
  distinctByUsername({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }
}

extension OnboardingUserModelQueryProperty
    on QueryBuilder<OnboardingUserModel, OnboardingUserModel, QQueryProperty> {
  QueryBuilder<OnboardingUserModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OnboardingUserModel, String?, QQueryOperations> bioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bio');
    });
  }

  QueryBuilder<OnboardingUserModel, DateTime?, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<OnboardingUserModel, String?, QQueryOperations>
  displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<OnboardingUserModel, String?, QQueryOperations> dobProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dob');
    });
  }

  QueryBuilder<OnboardingUserModel, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<OnboardingUserModel, String?, QQueryOperations>
  fullNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullName');
    });
  }

  QueryBuilder<OnboardingUserModel, String?, QQueryOperations>
  genderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gender');
    });
  }

  QueryBuilder<OnboardingUserModel, bool, QQueryOperations>
  isPrivateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPrivate');
    });
  }

  QueryBuilder<OnboardingUserModel, double?, QQueryOperations>
  latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<OnboardingUserModel, String?, QQueryOperations>
  locationNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locationName');
    });
  }

  QueryBuilder<OnboardingUserModel, double?, QQueryOperations>
  longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<OnboardingUserModel, String?, QQueryOperations>
  meshIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meshId');
    });
  }

  QueryBuilder<OnboardingUserModel, String?, QQueryOperations>
  occupationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'occupation');
    });
  }

  QueryBuilder<OnboardingUserModel, bool, QQueryOperations>
  onboardingCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onboardingCompleted');
    });
  }

  QueryBuilder<OnboardingUserModel, String?, QQueryOperations> phoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phone');
    });
  }

  QueryBuilder<OnboardingUserModel, String?, QQueryOperations>
  profileImageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileImage');
    });
  }

  QueryBuilder<OnboardingUserModel, String?, QQueryOperations>
  usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }
}
