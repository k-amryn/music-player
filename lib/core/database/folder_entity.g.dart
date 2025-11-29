// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFolderEntityCollection on Isar {
  IsarCollection<FolderEntity> get folderEntitys => this.collection();
}

const FolderEntitySchema = CollectionSchema(
  name: r'FolderEntity',
  id: 1865616643271602644,
  properties: {
    r'coverArtPath': PropertySchema(
      id: 0,
      name: r'coverArtPath',
      type: IsarType.string,
    ),
    r'lastScannedMs': PropertySchema(
      id: 1,
      name: r'lastScannedMs',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'nameLower': PropertySchema(
      id: 3,
      name: r'nameLower',
      type: IsarType.string,
    ),
    r'parentPath': PropertySchema(
      id: 4,
      name: r'parentPath',
      type: IsarType.string,
    ),
    r'path': PropertySchema(
      id: 5,
      name: r'path',
      type: IsarType.string,
    ),
    r'primaryAlbum': PropertySchema(
      id: 6,
      name: r'primaryAlbum',
      type: IsarType.string,
    ),
    r'primaryArtist': PropertySchema(
      id: 7,
      name: r'primaryArtist',
      type: IsarType.string,
    ),
    r'primaryYear': PropertySchema(
      id: 8,
      name: r'primaryYear',
      type: IsarType.long,
    ),
    r'subfolderCount': PropertySchema(
      id: 9,
      name: r'subfolderCount',
      type: IsarType.long,
    ),
    r'trackCount': PropertySchema(
      id: 10,
      name: r'trackCount',
      type: IsarType.long,
    )
  },
  estimateSize: _folderEntityEstimateSize,
  serialize: _folderEntitySerialize,
  deserialize: _folderEntityDeserialize,
  deserializeProp: _folderEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'path': IndexSchema(
      id: 8756705481922369689,
      name: r'path',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'path',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'nameLower': IndexSchema(
      id: 3656088067429520345,
      name: r'nameLower',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nameLower',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _folderEntityGetId,
  getLinks: _folderEntityGetLinks,
  attach: _folderEntityAttach,
  version: '3.1.0+1',
);

int _folderEntityEstimateSize(
  FolderEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.coverArtPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.nameLower.length * 3;
  {
    final value = object.parentPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.path.length * 3;
  {
    final value = object.primaryAlbum;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.primaryArtist;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _folderEntitySerialize(
  FolderEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.coverArtPath);
  writer.writeLong(offsets[1], object.lastScannedMs);
  writer.writeString(offsets[2], object.name);
  writer.writeString(offsets[3], object.nameLower);
  writer.writeString(offsets[4], object.parentPath);
  writer.writeString(offsets[5], object.path);
  writer.writeString(offsets[6], object.primaryAlbum);
  writer.writeString(offsets[7], object.primaryArtist);
  writer.writeLong(offsets[8], object.primaryYear);
  writer.writeLong(offsets[9], object.subfolderCount);
  writer.writeLong(offsets[10], object.trackCount);
}

FolderEntity _folderEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FolderEntity();
  object.coverArtPath = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.lastScannedMs = reader.readLongOrNull(offsets[1]);
  object.name = reader.readString(offsets[2]);
  object.nameLower = reader.readString(offsets[3]);
  object.parentPath = reader.readStringOrNull(offsets[4]);
  object.path = reader.readString(offsets[5]);
  object.primaryAlbum = reader.readStringOrNull(offsets[6]);
  object.primaryArtist = reader.readStringOrNull(offsets[7]);
  object.primaryYear = reader.readLongOrNull(offsets[8]);
  object.subfolderCount = reader.readLongOrNull(offsets[9]);
  object.trackCount = reader.readLongOrNull(offsets[10]);
  return object;
}

P _folderEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _folderEntityGetId(FolderEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _folderEntityGetLinks(FolderEntity object) {
  return [];
}

void _folderEntityAttach(
    IsarCollection<dynamic> col, Id id, FolderEntity object) {
  object.id = id;
}

extension FolderEntityByIndex on IsarCollection<FolderEntity> {
  Future<FolderEntity?> getByPath(String path) {
    return getByIndex(r'path', [path]);
  }

  FolderEntity? getByPathSync(String path) {
    return getByIndexSync(r'path', [path]);
  }

  Future<bool> deleteByPath(String path) {
    return deleteByIndex(r'path', [path]);
  }

  bool deleteByPathSync(String path) {
    return deleteByIndexSync(r'path', [path]);
  }

  Future<List<FolderEntity?>> getAllByPath(List<String> pathValues) {
    final values = pathValues.map((e) => [e]).toList();
    return getAllByIndex(r'path', values);
  }

  List<FolderEntity?> getAllByPathSync(List<String> pathValues) {
    final values = pathValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'path', values);
  }

  Future<int> deleteAllByPath(List<String> pathValues) {
    final values = pathValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'path', values);
  }

  int deleteAllByPathSync(List<String> pathValues) {
    final values = pathValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'path', values);
  }

  Future<Id> putByPath(FolderEntity object) {
    return putByIndex(r'path', object);
  }

  Id putByPathSync(FolderEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'path', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPath(List<FolderEntity> objects) {
    return putAllByIndex(r'path', objects);
  }

  List<Id> putAllByPathSync(List<FolderEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'path', objects, saveLinks: saveLinks);
  }
}

extension FolderEntityQueryWhereSort
    on QueryBuilder<FolderEntity, FolderEntity, QWhere> {
  QueryBuilder<FolderEntity, FolderEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FolderEntityQueryWhere
    on QueryBuilder<FolderEntity, FolderEntity, QWhereClause> {
  QueryBuilder<FolderEntity, FolderEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<FolderEntity, FolderEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterWhereClause> idBetween(
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

  QueryBuilder<FolderEntity, FolderEntity, QAfterWhereClause> pathEqualTo(
      String path) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'path',
        value: [path],
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterWhereClause> pathNotEqualTo(
      String path) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'path',
              lower: [],
              upper: [path],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'path',
              lower: [path],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'path',
              lower: [path],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'path',
              lower: [],
              upper: [path],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterWhereClause> nameLowerEqualTo(
      String nameLower) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nameLower',
        value: [nameLower],
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterWhereClause>
      nameLowerNotEqualTo(String nameLower) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameLower',
              lower: [],
              upper: [nameLower],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameLower',
              lower: [nameLower],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameLower',
              lower: [nameLower],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameLower',
              lower: [],
              upper: [nameLower],
              includeUpper: false,
            ));
      }
    });
  }
}

extension FolderEntityQueryFilter
    on QueryBuilder<FolderEntity, FolderEntity, QFilterCondition> {
  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      coverArtPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coverArtPath',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      coverArtPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coverArtPath',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      coverArtPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverArtPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      coverArtPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coverArtPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      coverArtPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coverArtPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      coverArtPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coverArtPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      coverArtPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'coverArtPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      coverArtPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'coverArtPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      coverArtPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'coverArtPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      coverArtPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'coverArtPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      coverArtPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverArtPath',
        value: '',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      coverArtPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'coverArtPath',
        value: '',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      lastScannedMsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastScannedMs',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      lastScannedMsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastScannedMs',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      lastScannedMsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastScannedMs',
        value: value,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      lastScannedMsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastScannedMs',
        value: value,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      lastScannedMsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastScannedMs',
        value: value,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      lastScannedMsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastScannedMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> nameEqualTo(
    String value, {
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

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
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

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> nameLessThan(
    String value, {
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

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
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

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
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

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      nameLowerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      nameLowerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      nameLowerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      nameLowerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameLower',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      nameLowerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      nameLowerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      nameLowerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      nameLowerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameLower',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      nameLowerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameLower',
        value: '',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      nameLowerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameLower',
        value: '',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      parentPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentPath',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      parentPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentPath',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      parentPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      parentPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      parentPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      parentPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      parentPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      parentPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      parentPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      parentPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      parentPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentPath',
        value: '',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      parentPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentPath',
        value: '',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> pathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      pathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> pathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> pathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      pathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> pathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> pathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition> pathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryAlbumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'primaryAlbum',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryAlbumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'primaryAlbum',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryAlbumEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primaryAlbum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryAlbumGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'primaryAlbum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryAlbumLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'primaryAlbum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryAlbumBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'primaryAlbum',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryAlbumStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'primaryAlbum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryAlbumEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'primaryAlbum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryAlbumContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'primaryAlbum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryAlbumMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'primaryAlbum',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryAlbumIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primaryAlbum',
        value: '',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryAlbumIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'primaryAlbum',
        value: '',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryArtistIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'primaryArtist',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryArtistIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'primaryArtist',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryArtistEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primaryArtist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryArtistGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'primaryArtist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryArtistLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'primaryArtist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryArtistBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'primaryArtist',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryArtistStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'primaryArtist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryArtistEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'primaryArtist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryArtistContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'primaryArtist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryArtistMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'primaryArtist',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryArtistIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primaryArtist',
        value: '',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryArtistIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'primaryArtist',
        value: '',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryYearIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'primaryYear',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryYearIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'primaryYear',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryYearEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primaryYear',
        value: value,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryYearGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'primaryYear',
        value: value,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryYearLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'primaryYear',
        value: value,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      primaryYearBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'primaryYear',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      subfolderCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subfolderCount',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      subfolderCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subfolderCount',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      subfolderCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subfolderCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      subfolderCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subfolderCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      subfolderCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subfolderCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      subfolderCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subfolderCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      trackCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trackCount',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      trackCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trackCount',
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      trackCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      trackCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trackCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      trackCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trackCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterFilterCondition>
      trackCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trackCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FolderEntityQueryObject
    on QueryBuilder<FolderEntity, FolderEntity, QFilterCondition> {}

extension FolderEntityQueryLinks
    on QueryBuilder<FolderEntity, FolderEntity, QFilterCondition> {}

extension FolderEntityQuerySortBy
    on QueryBuilder<FolderEntity, FolderEntity, QSortBy> {
  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> sortByCoverArtPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverArtPath', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      sortByCoverArtPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverArtPath', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> sortByLastScannedMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastScannedMs', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      sortByLastScannedMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastScannedMs', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> sortByNameLower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLower', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> sortByNameLowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLower', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> sortByParentPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentPath', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      sortByParentPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentPath', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> sortByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> sortByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> sortByPrimaryAlbum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryAlbum', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      sortByPrimaryAlbumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryAlbum', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> sortByPrimaryArtist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryArtist', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      sortByPrimaryArtistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryArtist', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> sortByPrimaryYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryYear', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      sortByPrimaryYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryYear', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      sortBySubfolderCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subfolderCount', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      sortBySubfolderCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subfolderCount', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> sortByTrackCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackCount', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      sortByTrackCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackCount', Sort.desc);
    });
  }
}

extension FolderEntityQuerySortThenBy
    on QueryBuilder<FolderEntity, FolderEntity, QSortThenBy> {
  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenByCoverArtPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverArtPath', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      thenByCoverArtPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverArtPath', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenByLastScannedMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastScannedMs', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      thenByLastScannedMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastScannedMs', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenByNameLower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLower', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenByNameLowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameLower', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenByParentPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentPath', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      thenByParentPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentPath', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenByPrimaryAlbum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryAlbum', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      thenByPrimaryAlbumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryAlbum', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenByPrimaryArtist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryArtist', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      thenByPrimaryArtistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryArtist', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenByPrimaryYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryYear', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      thenByPrimaryYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryYear', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      thenBySubfolderCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subfolderCount', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      thenBySubfolderCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subfolderCount', Sort.desc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy> thenByTrackCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackCount', Sort.asc);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QAfterSortBy>
      thenByTrackCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackCount', Sort.desc);
    });
  }
}

extension FolderEntityQueryWhereDistinct
    on QueryBuilder<FolderEntity, FolderEntity, QDistinct> {
  QueryBuilder<FolderEntity, FolderEntity, QDistinct> distinctByCoverArtPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coverArtPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QDistinct>
      distinctByLastScannedMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastScannedMs');
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QDistinct> distinctByNameLower(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameLower', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QDistinct> distinctByParentPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QDistinct> distinctByPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QDistinct> distinctByPrimaryAlbum(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'primaryAlbum', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QDistinct> distinctByPrimaryArtist(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'primaryArtist',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QDistinct> distinctByPrimaryYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'primaryYear');
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QDistinct>
      distinctBySubfolderCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subfolderCount');
    });
  }

  QueryBuilder<FolderEntity, FolderEntity, QDistinct> distinctByTrackCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackCount');
    });
  }
}

extension FolderEntityQueryProperty
    on QueryBuilder<FolderEntity, FolderEntity, QQueryProperty> {
  QueryBuilder<FolderEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FolderEntity, String?, QQueryOperations> coverArtPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coverArtPath');
    });
  }

  QueryBuilder<FolderEntity, int?, QQueryOperations> lastScannedMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastScannedMs');
    });
  }

  QueryBuilder<FolderEntity, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<FolderEntity, String, QQueryOperations> nameLowerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameLower');
    });
  }

  QueryBuilder<FolderEntity, String?, QQueryOperations> parentPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentPath');
    });
  }

  QueryBuilder<FolderEntity, String, QQueryOperations> pathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'path');
    });
  }

  QueryBuilder<FolderEntity, String?, QQueryOperations> primaryAlbumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'primaryAlbum');
    });
  }

  QueryBuilder<FolderEntity, String?, QQueryOperations>
      primaryArtistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'primaryArtist');
    });
  }

  QueryBuilder<FolderEntity, int?, QQueryOperations> primaryYearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'primaryYear');
    });
  }

  QueryBuilder<FolderEntity, int?, QQueryOperations> subfolderCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subfolderCount');
    });
  }

  QueryBuilder<FolderEntity, int?, QQueryOperations> trackCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackCount');
    });
  }
}
