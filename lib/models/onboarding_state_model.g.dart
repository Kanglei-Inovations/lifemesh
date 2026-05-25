// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_state_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOnboardingStateModelCollection on Isar {
  IsarCollection<OnboardingStateModel> get onboardingStateModels =>
      this.collection();
}

const OnboardingStateModelSchema = CollectionSchema(
  name: r'OnboardingStateModel',
  id: -5063268767869231713,
  properties: {
    r'currentStep': PropertySchema(
      id: 0,
      name: r'currentStep',
      type: IsarType.long,
    ),
    r'lastUpdated': PropertySchema(
      id: 1,
      name: r'lastUpdated',
      type: IsarType.dateTime,
    ),
    r'onboardingCompleted': PropertySchema(
      id: 2,
      name: r'onboardingCompleted',
      type: IsarType.bool,
    )
  },
  estimateSize: _onboardingStateModelEstimateSize,
  serialize: _onboardingStateModelSerialize,
  deserialize: _onboardingStateModelDeserialize,
  deserializeProp: _onboardingStateModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _onboardingStateModelGetId,
  getLinks: _onboardingStateModelGetLinks,
  attach: _onboardingStateModelAttach,
  version: '3.1.0+1',
);

int _onboardingStateModelEstimateSize(
  OnboardingStateModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _onboardingStateModelSerialize(
  OnboardingStateModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.currentStep);
  writer.writeDateTime(offsets[1], object.lastUpdated);
  writer.writeBool(offsets[2], object.onboardingCompleted);
}

OnboardingStateModel _onboardingStateModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OnboardingStateModel();
  object.currentStep = reader.readLong(offsets[0]);
  object.id = id;
  object.lastUpdated = reader.readDateTimeOrNull(offsets[1]);
  object.onboardingCompleted = reader.readBool(offsets[2]);
  return object;
}

P _onboardingStateModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _onboardingStateModelGetId(OnboardingStateModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _onboardingStateModelGetLinks(
    OnboardingStateModel object) {
  return [];
}

void _onboardingStateModelAttach(
    IsarCollection<dynamic> col, Id id, OnboardingStateModel object) {
  object.id = id;
}

extension OnboardingStateModelQueryWhereSort
    on QueryBuilder<OnboardingStateModel, OnboardingStateModel, QWhere> {
  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OnboardingStateModelQueryWhere
    on QueryBuilder<OnboardingStateModel, OnboardingStateModel, QWhereClause> {
  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterWhereClause>
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

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterWhereClause>
      idBetween(
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

extension OnboardingStateModelQueryFilter on QueryBuilder<OnboardingStateModel,
    OnboardingStateModel, QFilterCondition> {
  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> currentStepEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStep',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> currentStepGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentStep',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> currentStepLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentStep',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> currentStepBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentStep',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> lastUpdatedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastUpdated',
      ));
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> lastUpdatedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastUpdated',
      ));
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> lastUpdatedEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> lastUpdatedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> lastUpdatedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> lastUpdatedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel,
      QAfterFilterCondition> onboardingCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onboardingCompleted',
        value: value,
      ));
    });
  }
}

extension OnboardingStateModelQueryObject on QueryBuilder<OnboardingStateModel,
    OnboardingStateModel, QFilterCondition> {}

extension OnboardingStateModelQueryLinks on QueryBuilder<OnboardingStateModel,
    OnboardingStateModel, QFilterCondition> {}

extension OnboardingStateModelQuerySortBy
    on QueryBuilder<OnboardingStateModel, OnboardingStateModel, QSortBy> {
  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterSortBy>
      sortByCurrentStep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStep', Sort.asc);
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterSortBy>
      sortByCurrentStepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStep', Sort.desc);
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterSortBy>
      sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterSortBy>
      sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterSortBy>
      sortByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterSortBy>
      sortByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }
}

extension OnboardingStateModelQuerySortThenBy
    on QueryBuilder<OnboardingStateModel, OnboardingStateModel, QSortThenBy> {
  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterSortBy>
      thenByCurrentStep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStep', Sort.asc);
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterSortBy>
      thenByCurrentStepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStep', Sort.desc);
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterSortBy>
      thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterSortBy>
      thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterSortBy>
      thenByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QAfterSortBy>
      thenByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }
}

extension OnboardingStateModelQueryWhereDistinct
    on QueryBuilder<OnboardingStateModel, OnboardingStateModel, QDistinct> {
  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QDistinct>
      distinctByCurrentStep() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentStep');
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QDistinct>
      distinctByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated');
    });
  }

  QueryBuilder<OnboardingStateModel, OnboardingStateModel, QDistinct>
      distinctByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onboardingCompleted');
    });
  }
}

extension OnboardingStateModelQueryProperty on QueryBuilder<
    OnboardingStateModel, OnboardingStateModel, QQueryProperty> {
  QueryBuilder<OnboardingStateModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OnboardingStateModel, int, QQueryOperations>
      currentStepProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentStep');
    });
  }

  QueryBuilder<OnboardingStateModel, DateTime?, QQueryOperations>
      lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<OnboardingStateModel, bool, QQueryOperations>
      onboardingCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onboardingCompleted');
    });
  }
}
