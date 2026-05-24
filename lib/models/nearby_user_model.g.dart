// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_user_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNearbyUserModelCollection on Isar {
  IsarCollection<NearbyUserModel> get nearbyUserModels => this.collection();
}

const NearbyUserModelSchema = CollectionSchema(
  name: r'NearbyUserModel',
  id: -7488551062341779348,
  properties: {
    r'avatar': PropertySchema(
      id: 0,
      name: r'avatar',
      type: IsarType.string,
    ),
    r'connectedAt': PropertySchema(
      id: 1,
      name: r'connectedAt',
      type: IsarType.dateTime,
    ),
    r'distance': PropertySchema(
      id: 2,
      name: r'distance',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'signalStrength': PropertySchema(
      id: 4,
      name: r'signalStrength',
      type: IsarType.double,
    )
  },
  estimateSize: _nearbyUserModelEstimateSize,
  serialize: _nearbyUserModelSerialize,
  deserialize: _nearbyUserModelDeserialize,
  deserializeProp: _nearbyUserModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _nearbyUserModelGetId,
  getLinks: _nearbyUserModelGetLinks,
  attach: _nearbyUserModelAttach,
  version: '3.1.0+1',
);

int _nearbyUserModelEstimateSize(
  NearbyUserModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.avatar;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.distance;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _nearbyUserModelSerialize(
  NearbyUserModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.avatar);
  writer.writeDateTime(offsets[1], object.connectedAt);
  writer.writeString(offsets[2], object.distance);
  writer.writeString(offsets[3], object.name);
  writer.writeDouble(offsets[4], object.signalStrength);
}

NearbyUserModel _nearbyUserModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NearbyUserModel();
  object.avatar = reader.readStringOrNull(offsets[0]);
  object.connectedAt = reader.readDateTimeOrNull(offsets[1]);
  object.distance = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.name = reader.readStringOrNull(offsets[3]);
  object.signalStrength = reader.readDoubleOrNull(offsets[4]);
  return object;
}

P _nearbyUserModelDeserializeProp<P>(
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
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _nearbyUserModelGetId(NearbyUserModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _nearbyUserModelGetLinks(NearbyUserModel object) {
  return [];
}

void _nearbyUserModelAttach(
    IsarCollection<dynamic> col, Id id, NearbyUserModel object) {
  object.id = id;
}

extension NearbyUserModelQueryWhereSort
    on QueryBuilder<NearbyUserModel, NearbyUserModel, QWhere> {
  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NearbyUserModelQueryWhere
    on QueryBuilder<NearbyUserModel, NearbyUserModel, QWhereClause> {
  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterWhereClause>
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

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension NearbyUserModelQueryFilter
    on QueryBuilder<NearbyUserModel, NearbyUserModel, QFilterCondition> {
  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      avatarIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatar',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      avatarIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatar',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      avatarEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      avatarGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      avatarLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      avatarBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      avatarStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      avatarEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      avatarContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      avatarMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatar',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      avatarIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatar',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      avatarIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatar',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'connectedAt',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'connectedAt',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'connectedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'connectedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'connectedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'connectedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      distanceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'distance',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      distanceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'distance',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      distanceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      distanceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      distanceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      distanceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      distanceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'distance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      distanceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'distance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      distanceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'distance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      distanceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'distance',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      distanceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distance',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      distanceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'distance',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      signalStrengthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'signalStrength',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      signalStrengthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'signalStrength',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      signalStrengthEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'signalStrength',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      signalStrengthGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'signalStrength',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      signalStrengthLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'signalStrength',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      signalStrengthBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'signalStrength',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension NearbyUserModelQueryObject
    on QueryBuilder<NearbyUserModel, NearbyUserModel, QFilterCondition> {}

extension NearbyUserModelQueryLinks
    on QueryBuilder<NearbyUserModel, NearbyUserModel, QFilterCondition> {}

extension NearbyUserModelQuerySortBy
    on QueryBuilder<NearbyUserModel, NearbyUserModel, QSortBy> {
  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy> sortByAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByAvatarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByConnectedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectedAt', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByConnectedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectedAt', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByDistanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortBySignalStrength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signalStrength', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortBySignalStrengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signalStrength', Sort.desc);
    });
  }
}

extension NearbyUserModelQuerySortThenBy
    on QueryBuilder<NearbyUserModel, NearbyUserModel, QSortThenBy> {
  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy> thenByAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByAvatarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByConnectedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectedAt', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByConnectedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectedAt', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByDistanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenBySignalStrength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signalStrength', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenBySignalStrengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signalStrength', Sort.desc);
    });
  }
}

extension NearbyUserModelQueryWhereDistinct
    on QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct> {
  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct> distinctByAvatar(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatar', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct>
      distinctByConnectedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'connectedAt');
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct> distinctByDistance(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distance', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct>
      distinctBySignalStrength() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'signalStrength');
    });
  }
}

extension NearbyUserModelQueryProperty
    on QueryBuilder<NearbyUserModel, NearbyUserModel, QQueryProperty> {
  QueryBuilder<NearbyUserModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NearbyUserModel, String?, QQueryOperations> avatarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatar');
    });
  }

  QueryBuilder<NearbyUserModel, DateTime?, QQueryOperations>
      connectedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'connectedAt');
    });
  }

  QueryBuilder<NearbyUserModel, String?, QQueryOperations> distanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distance');
    });
  }

  QueryBuilder<NearbyUserModel, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<NearbyUserModel, double?, QQueryOperations>
      signalStrengthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'signalStrength');
    });
  }
}
