// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_attachment_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFileAttachmentModelCollection on Isar {
  IsarCollection<FileAttachmentModel> get fileAttachmentModels =>
      this.collection();
}

const FileAttachmentModelSchema = CollectionSchema(
  name: r'FileAttachmentModel',
  id: -8458058535167928130,
  properties: {
    r'chunkCount': PropertySchema(
      id: 0,
      name: r'chunkCount',
      type: IsarType.long,
    ),
    r'fileHash': PropertySchema(
      id: 1,
      name: r'fileHash',
      type: IsarType.string,
    ),
    r'fileName': PropertySchema(
      id: 2,
      name: r'fileName',
      type: IsarType.string,
    ),
    r'fileSize': PropertySchema(
      id: 3,
      name: r'fileSize',
      type: IsarType.long,
    ),
    r'localPath': PropertySchema(
      id: 4,
      name: r'localPath',
      type: IsarType.string,
    ),
    r'mimeType': PropertySchema(
      id: 5,
      name: r'mimeType',
      type: IsarType.string,
    ),
    r'previewHeight': PropertySchema(
      id: 6,
      name: r'previewHeight',
      type: IsarType.long,
    ),
    r'previewWidth': PropertySchema(
      id: 7,
      name: r'previewWidth',
      type: IsarType.long,
    ),
    r'tempPath': PropertySchema(
      id: 8,
      name: r'tempPath',
      type: IsarType.string,
    ),
    r'transferProgress': PropertySchema(
      id: 9,
      name: r'transferProgress',
      type: IsarType.double,
    ),
    r'transferSessionId': PropertySchema(
      id: 10,
      name: r'transferSessionId',
      type: IsarType.string,
    ),
    r'transferStatus': PropertySchema(
      id: 11,
      name: r'transferStatus',
      type: IsarType.byte,
      enumMap: _FileAttachmentModeltransferStatusEnumValueMap,
    ),
    r'transferredChunks': PropertySchema(
      id: 12,
      name: r'transferredChunks',
      type: IsarType.long,
    )
  },
  estimateSize: _fileAttachmentModelEstimateSize,
  serialize: _fileAttachmentModelSerialize,
  deserialize: _fileAttachmentModelDeserialize,
  deserializeProp: _fileAttachmentModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'transferSessionId': IndexSchema(
      id: 3277069028569218594,
      name: r'transferSessionId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'transferSessionId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _fileAttachmentModelGetId,
  getLinks: _fileAttachmentModelGetLinks,
  attach: _fileAttachmentModelAttach,
  version: '3.1.0+1',
);

int _fileAttachmentModelEstimateSize(
  FileAttachmentModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.fileHash.length * 3;
  bytesCount += 3 + object.fileName.length * 3;
  {
    final value = object.localPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.mimeType.length * 3;
  {
    final value = object.tempPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.transferSessionId.length * 3;
  return bytesCount;
}

void _fileAttachmentModelSerialize(
  FileAttachmentModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.chunkCount);
  writer.writeString(offsets[1], object.fileHash);
  writer.writeString(offsets[2], object.fileName);
  writer.writeLong(offsets[3], object.fileSize);
  writer.writeString(offsets[4], object.localPath);
  writer.writeString(offsets[5], object.mimeType);
  writer.writeLong(offsets[6], object.previewHeight);
  writer.writeLong(offsets[7], object.previewWidth);
  writer.writeString(offsets[8], object.tempPath);
  writer.writeDouble(offsets[9], object.transferProgress);
  writer.writeString(offsets[10], object.transferSessionId);
  writer.writeByte(offsets[11], object.transferStatus.index);
  writer.writeLong(offsets[12], object.transferredChunks);
}

FileAttachmentModel _fileAttachmentModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FileAttachmentModel();
  object.chunkCount = reader.readLong(offsets[0]);
  object.fileHash = reader.readString(offsets[1]);
  object.fileName = reader.readString(offsets[2]);
  object.fileSize = reader.readLong(offsets[3]);
  object.id = id;
  object.localPath = reader.readStringOrNull(offsets[4]);
  object.mimeType = reader.readString(offsets[5]);
  object.previewHeight = reader.readLongOrNull(offsets[6]);
  object.previewWidth = reader.readLongOrNull(offsets[7]);
  object.tempPath = reader.readStringOrNull(offsets[8]);
  object.transferProgress = reader.readDouble(offsets[9]);
  object.transferSessionId = reader.readString(offsets[10]);
  object.transferStatus = _FileAttachmentModeltransferStatusValueEnumMap[
          reader.readByteOrNull(offsets[11])] ??
      TransferStatus.preparing;
  object.transferredChunks = reader.readLong(offsets[12]);
  return object;
}

P _fileAttachmentModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (_FileAttachmentModeltransferStatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          TransferStatus.preparing) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FileAttachmentModeltransferStatusEnumValueMap = {
  'preparing': 0,
  'uploading': 1,
  'transferring': 2,
  'completed': 3,
  'failed': 4,
  'cancelled': 5,
};
const _FileAttachmentModeltransferStatusValueEnumMap = {
  0: TransferStatus.preparing,
  1: TransferStatus.uploading,
  2: TransferStatus.transferring,
  3: TransferStatus.completed,
  4: TransferStatus.failed,
  5: TransferStatus.cancelled,
};

Id _fileAttachmentModelGetId(FileAttachmentModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fileAttachmentModelGetLinks(
    FileAttachmentModel object) {
  return [];
}

void _fileAttachmentModelAttach(
    IsarCollection<dynamic> col, Id id, FileAttachmentModel object) {
  object.id = id;
}

extension FileAttachmentModelByIndex on IsarCollection<FileAttachmentModel> {
  Future<FileAttachmentModel?> getByTransferSessionId(
      String transferSessionId) {
    return getByIndex(r'transferSessionId', [transferSessionId]);
  }

  FileAttachmentModel? getByTransferSessionIdSync(String transferSessionId) {
    return getByIndexSync(r'transferSessionId', [transferSessionId]);
  }

  Future<bool> deleteByTransferSessionId(String transferSessionId) {
    return deleteByIndex(r'transferSessionId', [transferSessionId]);
  }

  bool deleteByTransferSessionIdSync(String transferSessionId) {
    return deleteByIndexSync(r'transferSessionId', [transferSessionId]);
  }

  Future<List<FileAttachmentModel?>> getAllByTransferSessionId(
      List<String> transferSessionIdValues) {
    final values = transferSessionIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'transferSessionId', values);
  }

  List<FileAttachmentModel?> getAllByTransferSessionIdSync(
      List<String> transferSessionIdValues) {
    final values = transferSessionIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'transferSessionId', values);
  }

  Future<int> deleteAllByTransferSessionId(
      List<String> transferSessionIdValues) {
    final values = transferSessionIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'transferSessionId', values);
  }

  int deleteAllByTransferSessionIdSync(List<String> transferSessionIdValues) {
    final values = transferSessionIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'transferSessionId', values);
  }

  Future<Id> putByTransferSessionId(FileAttachmentModel object) {
    return putByIndex(r'transferSessionId', object);
  }

  Id putByTransferSessionIdSync(FileAttachmentModel object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'transferSessionId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTransferSessionId(
      List<FileAttachmentModel> objects) {
    return putAllByIndex(r'transferSessionId', objects);
  }

  List<Id> putAllByTransferSessionIdSync(List<FileAttachmentModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'transferSessionId', objects,
        saveLinks: saveLinks);
  }
}

extension FileAttachmentModelQueryWhereSort
    on QueryBuilder<FileAttachmentModel, FileAttachmentModel, QWhere> {
  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FileAttachmentModelQueryWhere
    on QueryBuilder<FileAttachmentModel, FileAttachmentModel, QWhereClause> {
  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterWhereClause>
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

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterWhereClause>
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

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterWhereClause>
      transferSessionIdEqualTo(String transferSessionId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'transferSessionId',
        value: [transferSessionId],
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterWhereClause>
      transferSessionIdNotEqualTo(String transferSessionId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transferSessionId',
              lower: [],
              upper: [transferSessionId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transferSessionId',
              lower: [transferSessionId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transferSessionId',
              lower: [transferSessionId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transferSessionId',
              lower: [],
              upper: [transferSessionId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension FileAttachmentModelQueryFilter on QueryBuilder<FileAttachmentModel,
    FileAttachmentModel, QFilterCondition> {
  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      chunkCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chunkCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      chunkCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chunkCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      chunkCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chunkCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      chunkCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chunkCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileHashEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileHashGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileHashLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileHashBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileHash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileHashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileHashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileHash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileHash',
        value: '',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileHash',
        value: '',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileSizeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileSize',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileSizeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileSize',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileSizeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileSize',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      fileSizeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
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

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
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

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
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

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      localPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localPath',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      localPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localPath',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      localPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      localPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      localPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      localPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      localPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      localPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      localPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      localPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      localPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localPath',
        value: '',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      localPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localPath',
        value: '',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      mimeTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      mimeTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      mimeTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      mimeTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mimeType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      mimeTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      mimeTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      mimeTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mimeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      mimeTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mimeType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      mimeTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mimeType',
        value: '',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      mimeTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mimeType',
        value: '',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      previewHeightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'previewHeight',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      previewHeightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'previewHeight',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      previewHeightEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'previewHeight',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      previewHeightGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'previewHeight',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      previewHeightLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'previewHeight',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      previewHeightBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'previewHeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      previewWidthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'previewWidth',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      previewWidthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'previewWidth',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      previewWidthEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'previewWidth',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      previewWidthGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'previewWidth',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      previewWidthLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'previewWidth',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      previewWidthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'previewWidth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      tempPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tempPath',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      tempPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tempPath',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      tempPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tempPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      tempPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tempPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      tempPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tempPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      tempPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tempPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      tempPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tempPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      tempPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tempPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      tempPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tempPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      tempPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tempPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      tempPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tempPath',
        value: '',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      tempPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tempPath',
        value: '',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferProgressEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transferProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferProgressGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transferProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferProgressLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transferProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferProgressBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transferProgress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferSessionIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transferSessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferSessionIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transferSessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferSessionIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transferSessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferSessionIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transferSessionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferSessionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'transferSessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferSessionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'transferSessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferSessionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'transferSessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferSessionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'transferSessionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferSessionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transferSessionId',
        value: '',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferSessionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'transferSessionId',
        value: '',
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferStatusEqualTo(TransferStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transferStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferStatusGreaterThan(
    TransferStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transferStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferStatusLessThan(
    TransferStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transferStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferStatusBetween(
    TransferStatus lower,
    TransferStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transferStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferredChunksEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transferredChunks',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferredChunksGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transferredChunks',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferredChunksLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transferredChunks',
        value: value,
      ));
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterFilterCondition>
      transferredChunksBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transferredChunks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FileAttachmentModelQueryObject on QueryBuilder<FileAttachmentModel,
    FileAttachmentModel, QFilterCondition> {}

extension FileAttachmentModelQueryLinks on QueryBuilder<FileAttachmentModel,
    FileAttachmentModel, QFilterCondition> {}

extension FileAttachmentModelQuerySortBy
    on QueryBuilder<FileAttachmentModel, FileAttachmentModel, QSortBy> {
  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByChunkCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chunkCount', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByChunkCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chunkCount', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByFileHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileHash', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByFileHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileHash', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByFileSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileSize', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByFileSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileSize', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByLocalPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPath', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByLocalPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPath', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByMimeType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mimeType', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByMimeTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mimeType', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByPreviewHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewHeight', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByPreviewHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewHeight', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByPreviewWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewWidth', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByPreviewWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewWidth', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByTempPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempPath', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByTempPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempPath', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByTransferProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferProgress', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByTransferProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferProgress', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByTransferSessionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferSessionId', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByTransferSessionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferSessionId', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByTransferStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferStatus', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByTransferStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferStatus', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByTransferredChunks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferredChunks', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      sortByTransferredChunksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferredChunks', Sort.desc);
    });
  }
}

extension FileAttachmentModelQuerySortThenBy
    on QueryBuilder<FileAttachmentModel, FileAttachmentModel, QSortThenBy> {
  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByChunkCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chunkCount', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByChunkCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chunkCount', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByFileHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileHash', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByFileHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileHash', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByFileSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileSize', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByFileSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileSize', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByLocalPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPath', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByLocalPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPath', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByMimeType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mimeType', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByMimeTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mimeType', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByPreviewHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewHeight', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByPreviewHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewHeight', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByPreviewWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewWidth', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByPreviewWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewWidth', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByTempPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempPath', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByTempPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempPath', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByTransferProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferProgress', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByTransferProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferProgress', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByTransferSessionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferSessionId', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByTransferSessionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferSessionId', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByTransferStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferStatus', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByTransferStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferStatus', Sort.desc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByTransferredChunks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferredChunks', Sort.asc);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QAfterSortBy>
      thenByTransferredChunksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferredChunks', Sort.desc);
    });
  }
}

extension FileAttachmentModelQueryWhereDistinct
    on QueryBuilder<FileAttachmentModel, FileAttachmentModel, QDistinct> {
  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QDistinct>
      distinctByChunkCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chunkCount');
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QDistinct>
      distinctByFileHash({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileHash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QDistinct>
      distinctByFileName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QDistinct>
      distinctByFileSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileSize');
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QDistinct>
      distinctByLocalPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QDistinct>
      distinctByMimeType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mimeType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QDistinct>
      distinctByPreviewHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'previewHeight');
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QDistinct>
      distinctByPreviewWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'previewWidth');
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QDistinct>
      distinctByTempPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tempPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QDistinct>
      distinctByTransferProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transferProgress');
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QDistinct>
      distinctByTransferSessionId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transferSessionId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QDistinct>
      distinctByTransferStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transferStatus');
    });
  }

  QueryBuilder<FileAttachmentModel, FileAttachmentModel, QDistinct>
      distinctByTransferredChunks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transferredChunks');
    });
  }
}

extension FileAttachmentModelQueryProperty
    on QueryBuilder<FileAttachmentModel, FileAttachmentModel, QQueryProperty> {
  QueryBuilder<FileAttachmentModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FileAttachmentModel, int, QQueryOperations>
      chunkCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chunkCount');
    });
  }

  QueryBuilder<FileAttachmentModel, String, QQueryOperations>
      fileHashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileHash');
    });
  }

  QueryBuilder<FileAttachmentModel, String, QQueryOperations>
      fileNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileName');
    });
  }

  QueryBuilder<FileAttachmentModel, int, QQueryOperations> fileSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileSize');
    });
  }

  QueryBuilder<FileAttachmentModel, String?, QQueryOperations>
      localPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localPath');
    });
  }

  QueryBuilder<FileAttachmentModel, String, QQueryOperations>
      mimeTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mimeType');
    });
  }

  QueryBuilder<FileAttachmentModel, int?, QQueryOperations>
      previewHeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'previewHeight');
    });
  }

  QueryBuilder<FileAttachmentModel, int?, QQueryOperations>
      previewWidthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'previewWidth');
    });
  }

  QueryBuilder<FileAttachmentModel, String?, QQueryOperations>
      tempPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tempPath');
    });
  }

  QueryBuilder<FileAttachmentModel, double, QQueryOperations>
      transferProgressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transferProgress');
    });
  }

  QueryBuilder<FileAttachmentModel, String, QQueryOperations>
      transferSessionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transferSessionId');
    });
  }

  QueryBuilder<FileAttachmentModel, TransferStatus, QQueryOperations>
      transferStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transferStatus');
    });
  }

  QueryBuilder<FileAttachmentModel, int, QQueryOperations>
      transferredChunksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transferredChunks');
    });
  }
}
