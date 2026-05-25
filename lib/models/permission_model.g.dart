// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPermissionModelCollection on Isar {
  IsarCollection<PermissionModel> get permissionModels => this.collection();
}

const PermissionModelSchema = CollectionSchema(
  name: r'PermissionModel',
  id: -8324915577367980571,
  properties: {
    r'bluetoothGranted': PropertySchema(
      id: 0,
      name: r'bluetoothGranted',
      type: IsarType.bool,
    ),
    r'cameraGranted': PropertySchema(
      id: 1,
      name: r'cameraGranted',
      type: IsarType.bool,
    ),
    r'gpsGranted': PropertySchema(
      id: 2,
      name: r'gpsGranted',
      type: IsarType.bool,
    ),
    r'locationGranted': PropertySchema(
      id: 3,
      name: r'locationGranted',
      type: IsarType.bool,
    ),
    r'microphoneGranted': PropertySchema(
      id: 4,
      name: r'microphoneGranted',
      type: IsarType.bool,
    ),
    r'nearbyDevicesGranted': PropertySchema(
      id: 5,
      name: r'nearbyDevicesGranted',
      type: IsarType.bool,
    ),
    r'notificationGranted': PropertySchema(
      id: 6,
      name: r'notificationGranted',
      type: IsarType.bool,
    ),
    r'storageGranted': PropertySchema(
      id: 7,
      name: r'storageGranted',
      type: IsarType.bool,
    )
  },
  estimateSize: _permissionModelEstimateSize,
  serialize: _permissionModelSerialize,
  deserialize: _permissionModelDeserialize,
  deserializeProp: _permissionModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _permissionModelGetId,
  getLinks: _permissionModelGetLinks,
  attach: _permissionModelAttach,
  version: '3.1.0+1',
);

int _permissionModelEstimateSize(
  PermissionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _permissionModelSerialize(
  PermissionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.bluetoothGranted);
  writer.writeBool(offsets[1], object.cameraGranted);
  writer.writeBool(offsets[2], object.gpsGranted);
  writer.writeBool(offsets[3], object.locationGranted);
  writer.writeBool(offsets[4], object.microphoneGranted);
  writer.writeBool(offsets[5], object.nearbyDevicesGranted);
  writer.writeBool(offsets[6], object.notificationGranted);
  writer.writeBool(offsets[7], object.storageGranted);
}

PermissionModel _permissionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PermissionModel();
  object.bluetoothGranted = reader.readBool(offsets[0]);
  object.cameraGranted = reader.readBool(offsets[1]);
  object.gpsGranted = reader.readBool(offsets[2]);
  object.id = id;
  object.locationGranted = reader.readBool(offsets[3]);
  object.microphoneGranted = reader.readBool(offsets[4]);
  object.nearbyDevicesGranted = reader.readBool(offsets[5]);
  object.notificationGranted = reader.readBool(offsets[6]);
  object.storageGranted = reader.readBool(offsets[7]);
  return object;
}

P _permissionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _permissionModelGetId(PermissionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _permissionModelGetLinks(PermissionModel object) {
  return [];
}

void _permissionModelAttach(
    IsarCollection<dynamic> col, Id id, PermissionModel object) {
  object.id = id;
}

extension PermissionModelQueryWhereSort
    on QueryBuilder<PermissionModel, PermissionModel, QWhere> {
  QueryBuilder<PermissionModel, PermissionModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PermissionModelQueryWhere
    on QueryBuilder<PermissionModel, PermissionModel, QWhereClause> {
  QueryBuilder<PermissionModel, PermissionModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterWhereClause>
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

  QueryBuilder<PermissionModel, PermissionModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterWhereClause> idBetween(
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

extension PermissionModelQueryFilter
    on QueryBuilder<PermissionModel, PermissionModel, QFilterCondition> {
  QueryBuilder<PermissionModel, PermissionModel, QAfterFilterCondition>
      bluetoothGrantedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bluetoothGranted',
        value: value,
      ));
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterFilterCondition>
      cameraGrantedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cameraGranted',
        value: value,
      ));
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterFilterCondition>
      gpsGrantedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gpsGranted',
        value: value,
      ));
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterFilterCondition>
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

  QueryBuilder<PermissionModel, PermissionModel, QAfterFilterCondition>
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

  QueryBuilder<PermissionModel, PermissionModel, QAfterFilterCondition>
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

  QueryBuilder<PermissionModel, PermissionModel, QAfterFilterCondition>
      locationGrantedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationGranted',
        value: value,
      ));
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterFilterCondition>
      microphoneGrantedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'microphoneGranted',
        value: value,
      ));
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterFilterCondition>
      nearbyDevicesGrantedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nearbyDevicesGranted',
        value: value,
      ));
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterFilterCondition>
      notificationGrantedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationGranted',
        value: value,
      ));
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterFilterCondition>
      storageGrantedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'storageGranted',
        value: value,
      ));
    });
  }
}

extension PermissionModelQueryObject
    on QueryBuilder<PermissionModel, PermissionModel, QFilterCondition> {}

extension PermissionModelQueryLinks
    on QueryBuilder<PermissionModel, PermissionModel, QFilterCondition> {}

extension PermissionModelQuerySortBy
    on QueryBuilder<PermissionModel, PermissionModel, QSortBy> {
  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByBluetoothGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bluetoothGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByBluetoothGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bluetoothGranted', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByCameraGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cameraGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByCameraGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cameraGranted', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByGpsGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByGpsGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsGranted', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByLocationGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByLocationGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationGranted', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByMicrophoneGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'microphoneGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByMicrophoneGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'microphoneGranted', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByNearbyDevicesGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nearbyDevicesGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByNearbyDevicesGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nearbyDevicesGranted', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByNotificationGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByNotificationGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationGranted', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByStorageGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      sortByStorageGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageGranted', Sort.desc);
    });
  }
}

extension PermissionModelQuerySortThenBy
    on QueryBuilder<PermissionModel, PermissionModel, QSortThenBy> {
  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByBluetoothGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bluetoothGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByBluetoothGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bluetoothGranted', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByCameraGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cameraGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByCameraGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cameraGranted', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByGpsGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByGpsGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsGranted', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByLocationGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByLocationGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationGranted', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByMicrophoneGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'microphoneGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByMicrophoneGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'microphoneGranted', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByNearbyDevicesGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nearbyDevicesGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByNearbyDevicesGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nearbyDevicesGranted', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByNotificationGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByNotificationGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationGranted', Sort.desc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByStorageGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageGranted', Sort.asc);
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QAfterSortBy>
      thenByStorageGrantedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageGranted', Sort.desc);
    });
  }
}

extension PermissionModelQueryWhereDistinct
    on QueryBuilder<PermissionModel, PermissionModel, QDistinct> {
  QueryBuilder<PermissionModel, PermissionModel, QDistinct>
      distinctByBluetoothGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bluetoothGranted');
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QDistinct>
      distinctByCameraGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cameraGranted');
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QDistinct>
      distinctByGpsGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gpsGranted');
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QDistinct>
      distinctByLocationGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locationGranted');
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QDistinct>
      distinctByMicrophoneGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'microphoneGranted');
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QDistinct>
      distinctByNearbyDevicesGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nearbyDevicesGranted');
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QDistinct>
      distinctByNotificationGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationGranted');
    });
  }

  QueryBuilder<PermissionModel, PermissionModel, QDistinct>
      distinctByStorageGranted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'storageGranted');
    });
  }
}

extension PermissionModelQueryProperty
    on QueryBuilder<PermissionModel, PermissionModel, QQueryProperty> {
  QueryBuilder<PermissionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PermissionModel, bool, QQueryOperations>
      bluetoothGrantedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bluetoothGranted');
    });
  }

  QueryBuilder<PermissionModel, bool, QQueryOperations>
      cameraGrantedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cameraGranted');
    });
  }

  QueryBuilder<PermissionModel, bool, QQueryOperations> gpsGrantedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gpsGranted');
    });
  }

  QueryBuilder<PermissionModel, bool, QQueryOperations>
      locationGrantedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locationGranted');
    });
  }

  QueryBuilder<PermissionModel, bool, QQueryOperations>
      microphoneGrantedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'microphoneGranted');
    });
  }

  QueryBuilder<PermissionModel, bool, QQueryOperations>
      nearbyDevicesGrantedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nearbyDevicesGranted');
    });
  }

  QueryBuilder<PermissionModel, bool, QQueryOperations>
      notificationGrantedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationGranted');
    });
  }

  QueryBuilder<PermissionModel, bool, QQueryOperations>
      storageGrantedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'storageGranted');
    });
  }
}
