// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stat_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDashboardStatModelCollection on Isar {
  IsarCollection<DashboardStatModel> get dashboardStatModels =>
      this.collection();
}

const DashboardStatModelSchema = CollectionSchema(
  name: r'DashboardStatModel',
  id: 7856497679147310329,
  properties: {
    r'connectedNodes': PropertySchema(
      id: 0,
      name: r'connectedNodes',
      type: IsarType.long,
    ),
    r'isMeshActive': PropertySchema(
      id: 1,
      name: r'isMeshActive',
      type: IsarType.bool,
    ),
    r'lastUpdated': PropertySchema(
      id: 2,
      name: r'lastUpdated',
      type: IsarType.dateTime,
    ),
    r'signalStrength': PropertySchema(
      id: 3,
      name: r'signalStrength',
      type: IsarType.long,
    ),
  },
  estimateSize: _dashboardStatModelEstimateSize,
  serialize: _dashboardStatModelSerialize,
  deserialize: _dashboardStatModelDeserialize,
  deserializeProp: _dashboardStatModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _dashboardStatModelGetId,
  getLinks: _dashboardStatModelGetLinks,
  attach: _dashboardStatModelAttach,
  version: '3.1.0+1',
);

int _dashboardStatModelEstimateSize(
  DashboardStatModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _dashboardStatModelSerialize(
  DashboardStatModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.connectedNodes);
  writer.writeBool(offsets[1], object.isMeshActive);
  writer.writeDateTime(offsets[2], object.lastUpdated);
  writer.writeLong(offsets[3], object.signalStrength);
}

DashboardStatModel _dashboardStatModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DashboardStatModel();
  object.connectedNodes = reader.readLong(offsets[0]);
  object.id = id;
  object.isMeshActive = reader.readBool(offsets[1]);
  object.lastUpdated = reader.readDateTimeOrNull(offsets[2]);
  object.signalStrength = reader.readLong(offsets[3]);
  return object;
}

P _dashboardStatModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dashboardStatModelGetId(DashboardStatModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dashboardStatModelGetLinks(
  DashboardStatModel object,
) {
  return [];
}

void _dashboardStatModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  DashboardStatModel object,
) {
  object.id = id;
}

extension DashboardStatModelQueryWhereSort
    on QueryBuilder<DashboardStatModel, DashboardStatModel, QWhere> {
  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DashboardStatModelQueryWhere
    on QueryBuilder<DashboardStatModel, DashboardStatModel, QWhereClause> {
  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterWhereClause>
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

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterWhereClause>
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

extension DashboardStatModelQueryFilter
    on QueryBuilder<DashboardStatModel, DashboardStatModel, QFilterCondition> {
  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  connectedNodesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'connectedNodes', value: value),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  connectedNodesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'connectedNodes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  connectedNodesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'connectedNodes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  connectedNodesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'connectedNodes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
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

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
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

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
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

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  isMeshActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isMeshActive', value: value),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  lastUpdatedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastUpdated'),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  lastUpdatedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastUpdated'),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  lastUpdatedEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastUpdated', value: value),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  lastUpdatedGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastUpdated',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  lastUpdatedLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastUpdated',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  lastUpdatedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastUpdated',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  signalStrengthEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'signalStrength', value: value),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  signalStrengthGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'signalStrength',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  signalStrengthLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'signalStrength',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterFilterCondition>
  signalStrengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'signalStrength',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension DashboardStatModelQueryObject
    on QueryBuilder<DashboardStatModel, DashboardStatModel, QFilterCondition> {}

extension DashboardStatModelQueryLinks
    on QueryBuilder<DashboardStatModel, DashboardStatModel, QFilterCondition> {}

extension DashboardStatModelQuerySortBy
    on QueryBuilder<DashboardStatModel, DashboardStatModel, QSortBy> {
  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  sortByConnectedNodes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectedNodes', Sort.asc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  sortByConnectedNodesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectedNodes', Sort.desc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  sortByIsMeshActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMeshActive', Sort.asc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  sortByIsMeshActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMeshActive', Sort.desc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  sortBySignalStrength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signalStrength', Sort.asc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  sortBySignalStrengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signalStrength', Sort.desc);
    });
  }
}

extension DashboardStatModelQuerySortThenBy
    on QueryBuilder<DashboardStatModel, DashboardStatModel, QSortThenBy> {
  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  thenByConnectedNodes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectedNodes', Sort.asc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  thenByConnectedNodesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectedNodes', Sort.desc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  thenByIsMeshActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMeshActive', Sort.asc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  thenByIsMeshActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMeshActive', Sort.desc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  thenBySignalStrength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signalStrength', Sort.asc);
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QAfterSortBy>
  thenBySignalStrengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signalStrength', Sort.desc);
    });
  }
}

extension DashboardStatModelQueryWhereDistinct
    on QueryBuilder<DashboardStatModel, DashboardStatModel, QDistinct> {
  QueryBuilder<DashboardStatModel, DashboardStatModel, QDistinct>
  distinctByConnectedNodes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'connectedNodes');
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QDistinct>
  distinctByIsMeshActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMeshActive');
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QDistinct>
  distinctByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated');
    });
  }

  QueryBuilder<DashboardStatModel, DashboardStatModel, QDistinct>
  distinctBySignalStrength() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'signalStrength');
    });
  }
}

extension DashboardStatModelQueryProperty
    on QueryBuilder<DashboardStatModel, DashboardStatModel, QQueryProperty> {
  QueryBuilder<DashboardStatModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DashboardStatModel, int, QQueryOperations>
  connectedNodesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'connectedNodes');
    });
  }

  QueryBuilder<DashboardStatModel, bool, QQueryOperations>
  isMeshActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMeshActive');
    });
  }

  QueryBuilder<DashboardStatModel, DateTime?, QQueryOperations>
  lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<DashboardStatModel, int, QQueryOperations>
  signalStrengthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'signalStrength');
    });
  }
}
