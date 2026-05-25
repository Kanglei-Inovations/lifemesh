// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChatMessageModelCollection on Isar {
  IsarCollection<ChatMessageModel> get chatMessageModels => this.collection();
}

const ChatMessageModelSchema = CollectionSchema(
  name: r'ChatMessageModel',
  id: 3821037901158827866,
  properties: {
    r'deliveryStatus': PropertySchema(
      id: 0,
      name: r'deliveryStatus',
      type: IsarType.byte,
      enumMap: _ChatMessageModeldeliveryStatusEnumValueMap,
    ),
    r'endpointId': PropertySchema(
      id: 1,
      name: r'endpointId',
      type: IsarType.string,
    ),
    r'isDelivered': PropertySchema(
      id: 2,
      name: r'isDelivered',
      type: IsarType.bool,
    ),
    r'isMine': PropertySchema(
      id: 3,
      name: r'isMine',
      type: IsarType.bool,
    ),
    r'isRead': PropertySchema(
      id: 4,
      name: r'isRead',
      type: IsarType.bool,
    ),
    r'messageId': PropertySchema(
      id: 5,
      name: r'messageId',
      type: IsarType.string,
    ),
    r'messageType': PropertySchema(
      id: 6,
      name: r'messageType',
      type: IsarType.byte,
      enumMap: _ChatMessageModelmessageTypeEnumValueMap,
    ),
    r'receiverMeshId': PropertySchema(
      id: 7,
      name: r'receiverMeshId',
      type: IsarType.string,
    ),
    r'roomId': PropertySchema(
      id: 8,
      name: r'roomId',
      type: IsarType.string,
    ),
    r'senderMeshId': PropertySchema(
      id: 9,
      name: r'senderMeshId',
      type: IsarType.string,
    ),
    r'text': PropertySchema(
      id: 10,
      name: r'text',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 11,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _chatMessageModelEstimateSize,
  serialize: _chatMessageModelSerialize,
  deserialize: _chatMessageModelDeserialize,
  deserializeProp: _chatMessageModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'messageId': IndexSchema(
      id: -635287409172016016,
      name: r'messageId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'messageId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'roomId': IndexSchema(
      id: -3609232324653216207,
      name: r'roomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'senderMeshId': IndexSchema(
      id: 3996909178101424917,
      name: r'senderMeshId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'senderMeshId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'receiverMeshId': IndexSchema(
      id: -6837057682452886930,
      name: r'receiverMeshId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'receiverMeshId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'timestamp': IndexSchema(
      id: 1852253767416892198,
      name: r'timestamp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'timestamp',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _chatMessageModelGetId,
  getLinks: _chatMessageModelGetLinks,
  attach: _chatMessageModelAttach,
  version: '3.1.0+1',
);

int _chatMessageModelEstimateSize(
  ChatMessageModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.endpointId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.messageId.length * 3;
  bytesCount += 3 + object.receiverMeshId.length * 3;
  bytesCount += 3 + object.roomId.length * 3;
  bytesCount += 3 + object.senderMeshId.length * 3;
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _chatMessageModelSerialize(
  ChatMessageModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.deliveryStatus.index);
  writer.writeString(offsets[1], object.endpointId);
  writer.writeBool(offsets[2], object.isDelivered);
  writer.writeBool(offsets[3], object.isMine);
  writer.writeBool(offsets[4], object.isRead);
  writer.writeString(offsets[5], object.messageId);
  writer.writeByte(offsets[6], object.messageType.index);
  writer.writeString(offsets[7], object.receiverMeshId);
  writer.writeString(offsets[8], object.roomId);
  writer.writeString(offsets[9], object.senderMeshId);
  writer.writeString(offsets[10], object.text);
  writer.writeDateTime(offsets[11], object.timestamp);
}

ChatMessageModel _chatMessageModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChatMessageModel();
  object.deliveryStatus = _ChatMessageModeldeliveryStatusValueEnumMap[
          reader.readByteOrNull(offsets[0])] ??
      DeliveryStatus.sending;
  object.endpointId = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.isDelivered = reader.readBool(offsets[2]);
  object.isMine = reader.readBool(offsets[3]);
  object.isRead = reader.readBool(offsets[4]);
  object.messageId = reader.readString(offsets[5]);
  object.messageType = _ChatMessageModelmessageTypeValueEnumMap[
          reader.readByteOrNull(offsets[6])] ??
      MessageType.text;
  object.receiverMeshId = reader.readString(offsets[7]);
  object.roomId = reader.readString(offsets[8]);
  object.senderMeshId = reader.readString(offsets[9]);
  object.text = reader.readString(offsets[10]);
  object.timestamp = reader.readDateTime(offsets[11]);
  return object;
}

P _chatMessageModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_ChatMessageModeldeliveryStatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          DeliveryStatus.sending) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (_ChatMessageModelmessageTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MessageType.text) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ChatMessageModeldeliveryStatusEnumValueMap = {
  'sending': 0,
  'sent': 1,
  'delivered': 2,
  'read': 3,
  'failed': 4,
};
const _ChatMessageModeldeliveryStatusValueEnumMap = {
  0: DeliveryStatus.sending,
  1: DeliveryStatus.sent,
  2: DeliveryStatus.delivered,
  3: DeliveryStatus.read,
  4: DeliveryStatus.failed,
};
const _ChatMessageModelmessageTypeEnumValueMap = {
  'text': 0,
  'voice': 1,
  'location': 2,
  'image': 3,
  'file': 4,
};
const _ChatMessageModelmessageTypeValueEnumMap = {
  0: MessageType.text,
  1: MessageType.voice,
  2: MessageType.location,
  3: MessageType.image,
  4: MessageType.file,
};

Id _chatMessageModelGetId(ChatMessageModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _chatMessageModelGetLinks(ChatMessageModel object) {
  return [];
}

void _chatMessageModelAttach(
    IsarCollection<dynamic> col, Id id, ChatMessageModel object) {
  object.id = id;
}

extension ChatMessageModelByIndex on IsarCollection<ChatMessageModel> {
  Future<ChatMessageModel?> getByMessageId(String messageId) {
    return getByIndex(r'messageId', [messageId]);
  }

  ChatMessageModel? getByMessageIdSync(String messageId) {
    return getByIndexSync(r'messageId', [messageId]);
  }

  Future<bool> deleteByMessageId(String messageId) {
    return deleteByIndex(r'messageId', [messageId]);
  }

  bool deleteByMessageIdSync(String messageId) {
    return deleteByIndexSync(r'messageId', [messageId]);
  }

  Future<List<ChatMessageModel?>> getAllByMessageId(
      List<String> messageIdValues) {
    final values = messageIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'messageId', values);
  }

  List<ChatMessageModel?> getAllByMessageIdSync(List<String> messageIdValues) {
    final values = messageIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'messageId', values);
  }

  Future<int> deleteAllByMessageId(List<String> messageIdValues) {
    final values = messageIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'messageId', values);
  }

  int deleteAllByMessageIdSync(List<String> messageIdValues) {
    final values = messageIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'messageId', values);
  }

  Future<Id> putByMessageId(ChatMessageModel object) {
    return putByIndex(r'messageId', object);
  }

  Id putByMessageIdSync(ChatMessageModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'messageId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMessageId(List<ChatMessageModel> objects) {
    return putAllByIndex(r'messageId', objects);
  }

  List<Id> putAllByMessageIdSync(List<ChatMessageModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'messageId', objects, saveLinks: saveLinks);
  }
}

extension ChatMessageModelQueryWhereSort
    on QueryBuilder<ChatMessageModel, ChatMessageModel, QWhere> {
  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhere> anyTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'timestamp'),
      );
    });
  }
}

extension ChatMessageModelQueryWhere
    on QueryBuilder<ChatMessageModel, ChatMessageModel, QWhereClause> {
  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
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

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      messageIdEqualTo(String messageId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageId',
        value: [messageId],
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      messageIdNotEqualTo(String messageId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [],
              upper: [messageId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [messageId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [messageId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [],
              upper: [messageId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      roomIdEqualTo(String roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      roomIdNotEqualTo(String roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [],
              upper: [roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [roomId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [roomId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [],
              upper: [roomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      senderMeshIdEqualTo(String senderMeshId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'senderMeshId',
        value: [senderMeshId],
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      senderMeshIdNotEqualTo(String senderMeshId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'senderMeshId',
              lower: [],
              upper: [senderMeshId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'senderMeshId',
              lower: [senderMeshId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'senderMeshId',
              lower: [senderMeshId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'senderMeshId',
              lower: [],
              upper: [senderMeshId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      receiverMeshIdEqualTo(String receiverMeshId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'receiverMeshId',
        value: [receiverMeshId],
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      receiverMeshIdNotEqualTo(String receiverMeshId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'receiverMeshId',
              lower: [],
              upper: [receiverMeshId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'receiverMeshId',
              lower: [receiverMeshId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'receiverMeshId',
              lower: [receiverMeshId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'receiverMeshId',
              lower: [],
              upper: [receiverMeshId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      timestampEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'timestamp',
        value: [timestamp],
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      timestampNotEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [],
              upper: [timestamp],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [timestamp],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [timestamp],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [],
              upper: [timestamp],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      timestampGreaterThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [timestamp],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      timestampLessThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [],
        upper: [timestamp],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterWhereClause>
      timestampBetween(
    DateTime lowerTimestamp,
    DateTime upperTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [lowerTimestamp],
        includeLower: includeLower,
        upper: [upperTimestamp],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ChatMessageModelQueryFilter
    on QueryBuilder<ChatMessageModel, ChatMessageModel, QFilterCondition> {
  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      deliveryStatusEqualTo(DeliveryStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      deliveryStatusGreaterThan(
    DeliveryStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deliveryStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      deliveryStatusLessThan(
    DeliveryStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deliveryStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      deliveryStatusBetween(
    DeliveryStatus lower,
    DeliveryStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deliveryStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      endpointIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endpointId',
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      endpointIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endpointId',
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
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

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
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

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
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

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
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

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
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

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
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

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      endpointIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'endpointId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      endpointIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'endpointId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      endpointIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endpointId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      endpointIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'endpointId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
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

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
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

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
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

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      isDeliveredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDelivered',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      isMineEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMine',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      isReadEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRead',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      messageIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      messageIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      messageIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      messageIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      messageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      messageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      messageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      messageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'messageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      messageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      messageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'messageId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      messageTypeEqualTo(MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageType',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      messageTypeGreaterThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageType',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      messageTypeLessThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageType',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      messageTypeBetween(
    MessageType lower,
    MessageType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      receiverMeshIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receiverMeshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      receiverMeshIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'receiverMeshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      receiverMeshIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'receiverMeshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      receiverMeshIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'receiverMeshId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      receiverMeshIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'receiverMeshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      receiverMeshIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'receiverMeshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      receiverMeshIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'receiverMeshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      receiverMeshIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'receiverMeshId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      receiverMeshIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receiverMeshId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      receiverMeshIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'receiverMeshId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      roomIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      roomIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      roomIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      roomIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      roomIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      roomIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      roomIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      roomIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      senderMeshIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderMeshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      senderMeshIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderMeshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      senderMeshIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderMeshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      senderMeshIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderMeshId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      senderMeshIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'senderMeshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      senderMeshIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'senderMeshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      senderMeshIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'senderMeshId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      senderMeshIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'senderMeshId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      senderMeshIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderMeshId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      senderMeshIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'senderMeshId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      textContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      textMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ChatMessageModelQueryObject
    on QueryBuilder<ChatMessageModel, ChatMessageModel, QFilterCondition> {}

extension ChatMessageModelQueryLinks
    on QueryBuilder<ChatMessageModel, ChatMessageModel, QFilterCondition> {}

extension ChatMessageModelQuerySortBy
    on QueryBuilder<ChatMessageModel, ChatMessageModel, QSortBy> {
  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByDeliveryStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryStatus', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByDeliveryStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryStatus', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByEndpointId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endpointId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByEndpointIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endpointId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByIsDelivered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDelivered', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByIsDeliveredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDelivered', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByIsMine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMine', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByIsMineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMine', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByIsReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByReceiverMeshId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiverMeshId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByReceiverMeshIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiverMeshId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortBySenderMeshId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderMeshId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortBySenderMeshIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderMeshId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension ChatMessageModelQuerySortThenBy
    on QueryBuilder<ChatMessageModel, ChatMessageModel, QSortThenBy> {
  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByDeliveryStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryStatus', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByDeliveryStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryStatus', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByEndpointId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endpointId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByEndpointIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endpointId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByIsDelivered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDelivered', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByIsDeliveredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDelivered', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByIsMine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMine', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByIsMineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMine', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByIsReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByReceiverMeshId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiverMeshId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByReceiverMeshIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiverMeshId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenBySenderMeshId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderMeshId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenBySenderMeshIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderMeshId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension ChatMessageModelQueryWhereDistinct
    on QueryBuilder<ChatMessageModel, ChatMessageModel, QDistinct> {
  QueryBuilder<ChatMessageModel, ChatMessageModel, QDistinct>
      distinctByDeliveryStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deliveryStatus');
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QDistinct>
      distinctByEndpointId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endpointId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QDistinct>
      distinctByIsDelivered() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDelivered');
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QDistinct>
      distinctByIsMine() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMine');
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QDistinct>
      distinctByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRead');
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QDistinct>
      distinctByMessageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QDistinct>
      distinctByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageType');
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QDistinct>
      distinctByReceiverMeshId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'receiverMeshId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QDistinct> distinctByRoomId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QDistinct>
      distinctBySenderMeshId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderMeshId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatMessageModel, ChatMessageModel, QDistinct>
      distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension ChatMessageModelQueryProperty
    on QueryBuilder<ChatMessageModel, ChatMessageModel, QQueryProperty> {
  QueryBuilder<ChatMessageModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ChatMessageModel, DeliveryStatus, QQueryOperations>
      deliveryStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deliveryStatus');
    });
  }

  QueryBuilder<ChatMessageModel, String?, QQueryOperations>
      endpointIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endpointId');
    });
  }

  QueryBuilder<ChatMessageModel, bool, QQueryOperations> isDeliveredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDelivered');
    });
  }

  QueryBuilder<ChatMessageModel, bool, QQueryOperations> isMineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMine');
    });
  }

  QueryBuilder<ChatMessageModel, bool, QQueryOperations> isReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRead');
    });
  }

  QueryBuilder<ChatMessageModel, String, QQueryOperations> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageId');
    });
  }

  QueryBuilder<ChatMessageModel, MessageType, QQueryOperations>
      messageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageType');
    });
  }

  QueryBuilder<ChatMessageModel, String, QQueryOperations>
      receiverMeshIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'receiverMeshId');
    });
  }

  QueryBuilder<ChatMessageModel, String, QQueryOperations> roomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomId');
    });
  }

  QueryBuilder<ChatMessageModel, String, QQueryOperations>
      senderMeshIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderMeshId');
    });
  }

  QueryBuilder<ChatMessageModel, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }

  QueryBuilder<ChatMessageModel, DateTime, QQueryOperations>
      timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}
