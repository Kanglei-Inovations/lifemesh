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
    r'connectionStatus': PropertySchema(
      id: 2,
      name: r'connectionStatus',
      type: IsarType.string,
    ),
    r'connectionType': PropertySchema(
      id: 3,
      name: r'connectionType',
      type: IsarType.string,
    ),
    r'deviceName': PropertySchema(
      id: 4,
      name: r'deviceName',
      type: IsarType.string,
    ),
    r'discoverySource': PropertySchema(
      id: 5,
      name: r'discoverySource',
      type: IsarType.string,
    ),
    r'distance': PropertySchema(
      id: 6,
      name: r'distance',
      type: IsarType.string,
    ),
    r'endpointId': PropertySchema(
      id: 7,
      name: r'endpointId',
      type: IsarType.string,
    ),
    r'ipAddress': PropertySchema(
      id: 8,
      name: r'ipAddress',
      type: IsarType.string,
    ),
    r'isOnline': PropertySchema(
      id: 9,
      name: r'isOnline',
      type: IsarType.bool,
    ),
    r'lastHeartbeat': PropertySchema(
      id: 10,
      name: r'lastHeartbeat',
      type: IsarType.dateTime,
    ),
    r'lastSeen': PropertySchema(
      id: 11,
      name: r'lastSeen',
      type: IsarType.dateTime,
    ),
    r'meshId': PropertySchema(
      id: 12,
      name: r'meshId',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 13,
      name: r'name',
      type: IsarType.string,
    ),
    r'port': PropertySchema(
      id: 14,
      name: r'port',
      type: IsarType.long,
    ),
    r'signalStrength': PropertySchema(
      id: 15,
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
    final value = object.connectionStatus;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.connectionType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.deviceName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.discoverySource;
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
    final value = object.endpointId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ipAddress;
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
  writer.writeString(offsets[2], object.connectionStatus);
  writer.writeString(offsets[3], object.connectionType);
  writer.writeString(offsets[4], object.deviceName);
  writer.writeString(offsets[5], object.discoverySource);
  writer.writeString(offsets[6], object.distance);
  writer.writeString(offsets[7], object.endpointId);
  writer.writeString(offsets[8], object.ipAddress);
  writer.writeBool(offsets[9], object.isOnline);
  writer.writeDateTime(offsets[10], object.lastHeartbeat);
  writer.writeDateTime(offsets[11], object.lastSeen);
  writer.writeString(offsets[12], object.meshId);
  writer.writeString(offsets[13], object.name);
  writer.writeLong(offsets[14], object.port);
  writer.writeDouble(offsets[15], object.signalStrength);
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
  object.connectionStatus = reader.readStringOrNull(offsets[2]);
  object.connectionType = reader.readStringOrNull(offsets[3]);
  object.deviceName = reader.readStringOrNull(offsets[4]);
  object.discoverySource = reader.readStringOrNull(offsets[5]);
  object.distance = reader.readStringOrNull(offsets[6]);
  object.endpointId = reader.readStringOrNull(offsets[7]);
  object.id = id;
  object.ipAddress = reader.readStringOrNull(offsets[8]);
  object.isOnline = reader.readBool(offsets[9]);
  object.lastHeartbeat = reader.readDateTimeOrNull(offsets[10]);
  object.lastSeen = reader.readDateTimeOrNull(offsets[11]);
  object.meshId = reader.readStringOrNull(offsets[12]);
  object.name = reader.readStringOrNull(offsets[13]);
  object.port = reader.readLongOrNull(offsets[14]);
  object.signalStrength = reader.readDoubleOrNull(offsets[15]);
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
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 11:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
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
      connectionStatusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'connectionStatus',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionStatusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'connectionStatus',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionStatusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'connectionStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionStatusGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'connectionStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionStatusLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'connectionStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionStatusBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'connectionStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'connectionStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'connectionStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'connectionStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'connectionStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'connectionStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'connectionStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'connectionType',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'connectionType',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'connectionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'connectionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'connectionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'connectionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'connectionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'connectionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'connectionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'connectionType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'connectionType',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      connectionTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'connectionType',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      deviceNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deviceName',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      deviceNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deviceName',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      deviceNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      deviceNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      deviceNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      deviceNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deviceName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      deviceNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      deviceNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      deviceNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      deviceNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deviceName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      deviceNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceName',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      deviceNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deviceName',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      discoverySourceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'discoverySource',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      discoverySourceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'discoverySource',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      discoverySourceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'discoverySource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      discoverySourceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'discoverySource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      discoverySourceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'discoverySource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      discoverySourceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'discoverySource',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      discoverySourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'discoverySource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      discoverySourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'discoverySource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      discoverySourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'discoverySource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      discoverySourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'discoverySource',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      discoverySourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'discoverySource',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      discoverySourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'discoverySource',
        value: '',
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
      endpointIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endpointId',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      endpointIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endpointId',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      endpointIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endpointId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      endpointIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endpointId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      endpointIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endpointId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      endpointIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endpointId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      endpointIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'endpointId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      endpointIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'endpointId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      endpointIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'endpointId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      endpointIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'endpointId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      endpointIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endpointId',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      endpointIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'endpointId',
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
      ipAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ipAddress',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      ipAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ipAddress',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      ipAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ipAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      ipAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ipAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      ipAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ipAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      ipAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ipAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      ipAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ipAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      ipAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ipAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      ipAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ipAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      ipAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ipAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      ipAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ipAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      ipAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ipAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      isOnlineEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOnline',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      lastHeartbeatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastHeartbeat',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      lastHeartbeatIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastHeartbeat',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      lastHeartbeatEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastHeartbeat',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      lastHeartbeatGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastHeartbeat',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      lastHeartbeatLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastHeartbeat',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      lastHeartbeatBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastHeartbeat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      lastSeenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSeen',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      lastSeenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSeen',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      lastSeenEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSeen',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      lastSeenGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSeen',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      lastSeenLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSeen',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      lastSeenBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSeen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      meshIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'meshId',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      meshIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'meshId',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      meshIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      meshIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'meshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      meshIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'meshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      meshIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'meshId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      meshIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'meshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      meshIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'meshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      meshIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'meshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      meshIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'meshId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      meshIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meshId',
        value: '',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      meshIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'meshId',
        value: '',
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
      portIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'port',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      portIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'port',
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      portEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      portGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      portLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterFilterCondition>
      portBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'port',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
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
      sortByConnectionStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionStatus', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByConnectionStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionStatus', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByConnectionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionType', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByConnectionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionType', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByDeviceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceName', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByDeviceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceName', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByDiscoverySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discoverySource', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByDiscoverySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discoverySource', Sort.desc);
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

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByEndpointId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endpointId', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByEndpointIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endpointId', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByIpAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipAddress', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByIpAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipAddress', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByIsOnline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOnline', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByIsOnlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOnline', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByLastHeartbeat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastHeartbeat', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByLastHeartbeatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastHeartbeat', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByLastSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeen', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByLastSeenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeen', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy> sortByMeshId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meshId', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByMeshIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meshId', Sort.desc);
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

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy> sortByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      sortByPortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.desc);
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
      thenByConnectionStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionStatus', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByConnectionStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionStatus', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByConnectionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionType', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByConnectionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionType', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByDeviceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceName', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByDeviceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceName', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByDiscoverySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discoverySource', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByDiscoverySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discoverySource', Sort.desc);
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

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByEndpointId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endpointId', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByEndpointIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endpointId', Sort.desc);
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

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByIpAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipAddress', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByIpAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipAddress', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByIsOnline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOnline', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByIsOnlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOnline', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByLastHeartbeat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastHeartbeat', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByLastHeartbeatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastHeartbeat', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByLastSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeen', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByLastSeenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSeen', Sort.desc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy> thenByMeshId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meshId', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByMeshIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meshId', Sort.desc);
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

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy> thenByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.asc);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QAfterSortBy>
      thenByPortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.desc);
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

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct>
      distinctByConnectionStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'connectionStatus',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct>
      distinctByConnectionType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'connectionType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct>
      distinctByDeviceName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deviceName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct>
      distinctByDiscoverySource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'discoverySource',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct> distinctByDistance(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distance', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct>
      distinctByEndpointId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endpointId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct> distinctByIpAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ipAddress', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct>
      distinctByIsOnline() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOnline');
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct>
      distinctByLastHeartbeat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastHeartbeat');
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct>
      distinctByLastSeen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSeen');
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct> distinctByMeshId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'meshId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NearbyUserModel, NearbyUserModel, QDistinct> distinctByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'port');
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

  QueryBuilder<NearbyUserModel, String?, QQueryOperations>
      connectionStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'connectionStatus');
    });
  }

  QueryBuilder<NearbyUserModel, String?, QQueryOperations>
      connectionTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'connectionType');
    });
  }

  QueryBuilder<NearbyUserModel, String?, QQueryOperations>
      deviceNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviceName');
    });
  }

  QueryBuilder<NearbyUserModel, String?, QQueryOperations>
      discoverySourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'discoverySource');
    });
  }

  QueryBuilder<NearbyUserModel, String?, QQueryOperations> distanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distance');
    });
  }

  QueryBuilder<NearbyUserModel, String?, QQueryOperations>
      endpointIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endpointId');
    });
  }

  QueryBuilder<NearbyUserModel, String?, QQueryOperations> ipAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ipAddress');
    });
  }

  QueryBuilder<NearbyUserModel, bool, QQueryOperations> isOnlineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOnline');
    });
  }

  QueryBuilder<NearbyUserModel, DateTime?, QQueryOperations>
      lastHeartbeatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastHeartbeat');
    });
  }

  QueryBuilder<NearbyUserModel, DateTime?, QQueryOperations>
      lastSeenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSeen');
    });
  }

  QueryBuilder<NearbyUserModel, String?, QQueryOperations> meshIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meshId');
    });
  }

  QueryBuilder<NearbyUserModel, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<NearbyUserModel, int?, QQueryOperations> portProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'port');
    });
  }

  QueryBuilder<NearbyUserModel, double?, QQueryOperations>
      signalStrengthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'signalStrength');
    });
  }
}
