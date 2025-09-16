// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beacon_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBeaconDataCollection on Isar {
  IsarCollection<BeaconData> get beaconDatas => this.collection();
}

const BeaconDataSchema = CollectionSchema(
  name: r'BeaconData',
  id: -1638125556886993069,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'distance': PropertySchema(
      id: 1,
      name: r'distance',
      type: IsarType.string,
    ),
    r'major': PropertySchema(
      id: 2,
      name: r'major',
      type: IsarType.string,
    ),
    r'minor': PropertySchema(
      id: 3,
      name: r'minor',
      type: IsarType.string,
    ),
    r'monitorState': PropertySchema(
      id: 4,
      name: r'monitorState',
      type: IsarType.string,
    ),
    r'proximity': PropertySchema(
      id: 5,
      name: r'proximity',
      type: IsarType.string,
    ),
    r'rssi': PropertySchema(
      id: 6,
      name: r'rssi',
      type: IsarType.string,
    ),
    r'txpower': PropertySchema(
      id: 7,
      name: r'txpower',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 8,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _beaconDataEstimateSize,
  serialize: _beaconDataSerialize,
  deserialize: _beaconDataDeserialize,
  deserializeProp: _beaconDataDeserializeProp,
  idName: r'id',
  indexes: {
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _beaconDataGetId,
  getLinks: _beaconDataGetLinks,
  attach: _beaconDataAttach,
  version: '3.1.0',
);

int _beaconDataEstimateSize(
  BeaconData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.distance;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.major;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.minor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.monitorState;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.proximity;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.rssi;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.txpower;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.uuid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _beaconDataSerialize(
  BeaconData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.distance);
  writer.writeString(offsets[2], object.major);
  writer.writeString(offsets[3], object.minor);
  writer.writeString(offsets[4], object.monitorState);
  writer.writeString(offsets[5], object.proximity);
  writer.writeString(offsets[6], object.rssi);
  writer.writeString(offsets[7], object.txpower);
  writer.writeString(offsets[8], object.uuid);
}

BeaconData _beaconDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BeaconData();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.distance = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.major = reader.readStringOrNull(offsets[2]);
  object.minor = reader.readStringOrNull(offsets[3]);
  object.monitorState = reader.readStringOrNull(offsets[4]);
  object.proximity = reader.readStringOrNull(offsets[5]);
  object.rssi = reader.readStringOrNull(offsets[6]);
  object.txpower = reader.readStringOrNull(offsets[7]);
  object.uuid = reader.readStringOrNull(offsets[8]);
  return object;
}

P _beaconDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _beaconDataGetId(BeaconData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _beaconDataGetLinks(BeaconData object) {
  return [];
}

void _beaconDataAttach(IsarCollection<dynamic> col, Id id, BeaconData object) {
  object.id = id;
}

extension BeaconDataQueryWhereSort
    on QueryBuilder<BeaconData, BeaconData, QWhere> {
  QueryBuilder<BeaconData, BeaconData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension BeaconDataQueryWhere
    on QueryBuilder<BeaconData, BeaconData, QWhereClause> {
  QueryBuilder<BeaconData, BeaconData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<BeaconData, BeaconData, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterWhereClause> idBetween(
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

  QueryBuilder<BeaconData, BeaconData, QAfterWhereClause> createdAtEqualTo(
      DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterWhereClause> createdAtNotEqualTo(
      DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterWhereClause> createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterWhereClause> createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterWhereClause> createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BeaconDataQueryFilter
    on QueryBuilder<BeaconData, BeaconData, QFilterCondition> {
  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> distanceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'distance',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      distanceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'distance',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> distanceEqualTo(
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

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
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

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> distanceLessThan(
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

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> distanceBetween(
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

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
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

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> distanceEndsWith(
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

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> distanceContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'distance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> distanceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'distance',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      distanceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distance',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      distanceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'distance',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> idBetween(
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

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> majorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'major',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> majorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'major',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> majorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'major',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> majorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'major',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> majorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'major',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> majorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'major',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> majorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'major',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> majorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'major',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> majorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'major',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> majorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'major',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> majorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'major',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      majorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'major',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> minorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minor',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> minorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minor',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> minorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> minorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> minorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> minorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> minorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'minor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> minorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'minor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> minorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'minor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> minorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'minor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> minorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minor',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      minorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'minor',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      monitorStateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'monitorState',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      monitorStateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'monitorState',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      monitorStateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monitorState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      monitorStateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monitorState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      monitorStateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monitorState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      monitorStateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monitorState',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      monitorStateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'monitorState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      monitorStateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'monitorState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      monitorStateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'monitorState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      monitorStateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'monitorState',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      monitorStateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monitorState',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      monitorStateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'monitorState',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      proximityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'proximity',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      proximityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'proximity',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> proximityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proximity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      proximityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proximity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> proximityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proximity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> proximityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proximity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      proximityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'proximity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> proximityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'proximity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> proximityContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'proximity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> proximityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'proximity',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      proximityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proximity',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      proximityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'proximity',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> rssiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rssi',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> rssiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rssi',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> rssiEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rssi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> rssiGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rssi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> rssiLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rssi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> rssiBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rssi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> rssiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rssi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> rssiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rssi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> rssiContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rssi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> rssiMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rssi',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> rssiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rssi',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> rssiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rssi',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> txpowerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'txpower',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      txpowerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'txpower',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> txpowerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'txpower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      txpowerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'txpower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> txpowerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'txpower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> txpowerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'txpower',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> txpowerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'txpower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> txpowerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'txpower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> txpowerContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'txpower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> txpowerMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'txpower',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> txpowerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'txpower',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition>
      txpowerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'txpower',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> uuidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'uuid',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> uuidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'uuid',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> uuidEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> uuidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> uuidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> uuidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> uuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension BeaconDataQueryObject
    on QueryBuilder<BeaconData, BeaconData, QFilterCondition> {}

extension BeaconDataQueryLinks
    on QueryBuilder<BeaconData, BeaconData, QFilterCondition> {}

extension BeaconDataQuerySortBy
    on QueryBuilder<BeaconData, BeaconData, QSortBy> {
  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByDistanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByMajor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'major', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByMajorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'major', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByMinor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minor', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByMinorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minor', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByMonitorState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monitorState', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByMonitorStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monitorState', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByProximity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximity', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByProximityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximity', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByRssi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rssi', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByRssiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rssi', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByTxpower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txpower', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByTxpowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txpower', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension BeaconDataQuerySortThenBy
    on QueryBuilder<BeaconData, BeaconData, QSortThenBy> {
  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByDistanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByMajor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'major', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByMajorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'major', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByMinor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minor', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByMinorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minor', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByMonitorState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monitorState', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByMonitorStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monitorState', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByProximity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximity', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByProximityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximity', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByRssi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rssi', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByRssiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rssi', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByTxpower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txpower', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByTxpowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txpower', Sort.desc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension BeaconDataQueryWhereDistinct
    on QueryBuilder<BeaconData, BeaconData, QDistinct> {
  QueryBuilder<BeaconData, BeaconData, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<BeaconData, BeaconData, QDistinct> distinctByDistance(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distance', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QDistinct> distinctByMajor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'major', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QDistinct> distinctByMinor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minor', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QDistinct> distinctByMonitorState(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monitorState', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QDistinct> distinctByProximity(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proximity', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QDistinct> distinctByRssi(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rssi', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QDistinct> distinctByTxpower(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'txpower', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BeaconData, BeaconData, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension BeaconDataQueryProperty
    on QueryBuilder<BeaconData, BeaconData, QQueryProperty> {
  QueryBuilder<BeaconData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BeaconData, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<BeaconData, String?, QQueryOperations> distanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distance');
    });
  }

  QueryBuilder<BeaconData, String?, QQueryOperations> majorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'major');
    });
  }

  QueryBuilder<BeaconData, String?, QQueryOperations> minorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minor');
    });
  }

  QueryBuilder<BeaconData, String?, QQueryOperations> monitorStateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monitorState');
    });
  }

  QueryBuilder<BeaconData, String?, QQueryOperations> proximityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proximity');
    });
  }

  QueryBuilder<BeaconData, String?, QQueryOperations> rssiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rssi');
    });
  }

  QueryBuilder<BeaconData, String?, QQueryOperations> txpowerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'txpower');
    });
  }

  QueryBuilder<BeaconData, String?, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
