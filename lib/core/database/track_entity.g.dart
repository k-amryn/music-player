// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTrackEntityCollection on Isar {
  IsarCollection<TrackEntity> get trackEntitys => this.collection();
}

const TrackEntitySchema = CollectionSchema(
  name: r'TrackEntity',
  id: 3277857790110460924,
  properties: {
    r'album': PropertySchema(
      id: 0,
      name: r'album',
      type: IsarType.string,
    ),
    r'albumArtist': PropertySchema(
      id: 1,
      name: r'albumArtist',
      type: IsarType.string,
    ),
    r'albumArtistLower': PropertySchema(
      id: 2,
      name: r'albumArtistLower',
      type: IsarType.string,
    ),
    r'albumLower': PropertySchema(
      id: 3,
      name: r'albumLower',
      type: IsarType.string,
    ),
    r'artist': PropertySchema(
      id: 4,
      name: r'artist',
      type: IsarType.string,
    ),
    r'artistLower': PropertySchema(
      id: 5,
      name: r'artistLower',
      type: IsarType.string,
    ),
    r'bitrate': PropertySchema(
      id: 6,
      name: r'bitrate',
      type: IsarType.long,
    ),
    r'channels': PropertySchema(
      id: 7,
      name: r'channels',
      type: IsarType.long,
    ),
    r'codec': PropertySchema(
      id: 8,
      name: r'codec',
      type: IsarType.string,
    ),
    r'comment': PropertySchema(
      id: 9,
      name: r'comment',
      type: IsarType.string,
    ),
    r'composer': PropertySchema(
      id: 10,
      name: r'composer',
      type: IsarType.string,
    ),
    r'conductor': PropertySchema(
      id: 11,
      name: r'conductor',
      type: IsarType.string,
    ),
    r'coverArtPath': PropertySchema(
      id: 12,
      name: r'coverArtPath',
      type: IsarType.string,
    ),
    r'discNumber': PropertySchema(
      id: 13,
      name: r'discNumber',
      type: IsarType.long,
    ),
    r'durationMs': PropertySchema(
      id: 14,
      name: r'durationMs',
      type: IsarType.long,
    ),
    r'fileName': PropertySchema(
      id: 15,
      name: r'fileName',
      type: IsarType.string,
    ),
    r'fileNameLower': PropertySchema(
      id: 16,
      name: r'fileNameLower',
      type: IsarType.string,
    ),
    r'fileSize': PropertySchema(
      id: 17,
      name: r'fileSize',
      type: IsarType.long,
    ),
    r'folderPath': PropertySchema(
      id: 18,
      name: r'folderPath',
      type: IsarType.string,
    ),
    r'genre': PropertySchema(
      id: 19,
      name: r'genre',
      type: IsarType.string,
    ),
    r'genreLower': PropertySchema(
      id: 20,
      name: r'genreLower',
      type: IsarType.string,
    ),
    r'lastModifiedMs': PropertySchema(
      id: 21,
      name: r'lastModifiedMs',
      type: IsarType.long,
    ),
    r'lastScannedMs': PropertySchema(
      id: 22,
      name: r'lastScannedMs',
      type: IsarType.long,
    ),
    r'lyrics': PropertySchema(
      id: 23,
      name: r'lyrics',
      type: IsarType.string,
    ),
    r'path': PropertySchema(
      id: 24,
      name: r'path',
      type: IsarType.string,
    ),
    r'sampleRate': PropertySchema(
      id: 25,
      name: r'sampleRate',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 26,
      name: r'title',
      type: IsarType.string,
    ),
    r'titleLower': PropertySchema(
      id: 27,
      name: r'titleLower',
      type: IsarType.string,
    ),
    r'totalDiscs': PropertySchema(
      id: 28,
      name: r'totalDiscs',
      type: IsarType.long,
    ),
    r'totalTracks': PropertySchema(
      id: 29,
      name: r'totalTracks',
      type: IsarType.long,
    ),
    r'trackNumber': PropertySchema(
      id: 30,
      name: r'trackNumber',
      type: IsarType.long,
    ),
    r'year': PropertySchema(
      id: 31,
      name: r'year',
      type: IsarType.long,
    )
  },
  estimateSize: _trackEntityEstimateSize,
  serialize: _trackEntitySerialize,
  deserialize: _trackEntityDeserialize,
  deserializeProp: _trackEntityDeserializeProp,
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
    r'folderPath': IndexSchema(
      id: -8832620910772372211,
      name: r'folderPath',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'folderPath',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'artistLower': IndexSchema(
      id: 1745870720956327737,
      name: r'artistLower',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'artistLower',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'albumLower': IndexSchema(
      id: -7410670508268661822,
      name: r'albumLower',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'albumLower',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'titleLower': IndexSchema(
      id: -2652193349673264940,
      name: r'titleLower',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'titleLower',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'genreLower': IndexSchema(
      id: 5537698933446640448,
      name: r'genreLower',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'genreLower',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'albumArtistLower': IndexSchema(
      id: 5589483017503091561,
      name: r'albumArtistLower',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'albumArtistLower',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'fileNameLower': IndexSchema(
      id: -8058593816343492087,
      name: r'fileNameLower',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fileNameLower',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _trackEntityGetId,
  getLinks: _trackEntityGetLinks,
  attach: _trackEntityAttach,
  version: '3.1.0+1',
);

int _trackEntityEstimateSize(
  TrackEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.album.length * 3;
  {
    final value = object.albumArtist;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.albumArtistLower;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.albumLower.length * 3;
  bytesCount += 3 + object.artist.length * 3;
  bytesCount += 3 + object.artistLower.length * 3;
  {
    final value = object.codec;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.comment;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.composer;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.conductor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.coverArtPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.fileName.length * 3;
  bytesCount += 3 + object.fileNameLower.length * 3;
  bytesCount += 3 + object.folderPath.length * 3;
  {
    final value = object.genre;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.genreLower;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lyrics;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.path.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.titleLower.length * 3;
  return bytesCount;
}

void _trackEntitySerialize(
  TrackEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.album);
  writer.writeString(offsets[1], object.albumArtist);
  writer.writeString(offsets[2], object.albumArtistLower);
  writer.writeString(offsets[3], object.albumLower);
  writer.writeString(offsets[4], object.artist);
  writer.writeString(offsets[5], object.artistLower);
  writer.writeLong(offsets[6], object.bitrate);
  writer.writeLong(offsets[7], object.channels);
  writer.writeString(offsets[8], object.codec);
  writer.writeString(offsets[9], object.comment);
  writer.writeString(offsets[10], object.composer);
  writer.writeString(offsets[11], object.conductor);
  writer.writeString(offsets[12], object.coverArtPath);
  writer.writeLong(offsets[13], object.discNumber);
  writer.writeLong(offsets[14], object.durationMs);
  writer.writeString(offsets[15], object.fileName);
  writer.writeString(offsets[16], object.fileNameLower);
  writer.writeLong(offsets[17], object.fileSize);
  writer.writeString(offsets[18], object.folderPath);
  writer.writeString(offsets[19], object.genre);
  writer.writeString(offsets[20], object.genreLower);
  writer.writeLong(offsets[21], object.lastModifiedMs);
  writer.writeLong(offsets[22], object.lastScannedMs);
  writer.writeString(offsets[23], object.lyrics);
  writer.writeString(offsets[24], object.path);
  writer.writeLong(offsets[25], object.sampleRate);
  writer.writeString(offsets[26], object.title);
  writer.writeString(offsets[27], object.titleLower);
  writer.writeLong(offsets[28], object.totalDiscs);
  writer.writeLong(offsets[29], object.totalTracks);
  writer.writeLong(offsets[30], object.trackNumber);
  writer.writeLong(offsets[31], object.year);
}

TrackEntity _trackEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TrackEntity();
  object.album = reader.readString(offsets[0]);
  object.albumArtist = reader.readStringOrNull(offsets[1]);
  object.albumArtistLower = reader.readStringOrNull(offsets[2]);
  object.albumLower = reader.readString(offsets[3]);
  object.artist = reader.readString(offsets[4]);
  object.artistLower = reader.readString(offsets[5]);
  object.bitrate = reader.readLongOrNull(offsets[6]);
  object.channels = reader.readLongOrNull(offsets[7]);
  object.codec = reader.readStringOrNull(offsets[8]);
  object.comment = reader.readStringOrNull(offsets[9]);
  object.composer = reader.readStringOrNull(offsets[10]);
  object.conductor = reader.readStringOrNull(offsets[11]);
  object.coverArtPath = reader.readStringOrNull(offsets[12]);
  object.discNumber = reader.readLongOrNull(offsets[13]);
  object.durationMs = reader.readLongOrNull(offsets[14]);
  object.fileName = reader.readString(offsets[15]);
  object.fileNameLower = reader.readString(offsets[16]);
  object.fileSize = reader.readLongOrNull(offsets[17]);
  object.folderPath = reader.readString(offsets[18]);
  object.genre = reader.readStringOrNull(offsets[19]);
  object.genreLower = reader.readStringOrNull(offsets[20]);
  object.id = id;
  object.lastModifiedMs = reader.readLongOrNull(offsets[21]);
  object.lastScannedMs = reader.readLongOrNull(offsets[22]);
  object.lyrics = reader.readStringOrNull(offsets[23]);
  object.path = reader.readString(offsets[24]);
  object.sampleRate = reader.readLongOrNull(offsets[25]);
  object.title = reader.readString(offsets[26]);
  object.titleLower = reader.readString(offsets[27]);
  object.totalDiscs = reader.readLongOrNull(offsets[28]);
  object.totalTracks = reader.readLongOrNull(offsets[29]);
  object.trackNumber = reader.readLongOrNull(offsets[30]);
  object.year = reader.readLongOrNull(offsets[31]);
  return object;
}

P _trackEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readLongOrNull(offset)) as P;
    case 18:
      return (reader.readString(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readLongOrNull(offset)) as P;
    case 22:
      return (reader.readLongOrNull(offset)) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    case 24:
      return (reader.readString(offset)) as P;
    case 25:
      return (reader.readLongOrNull(offset)) as P;
    case 26:
      return (reader.readString(offset)) as P;
    case 27:
      return (reader.readString(offset)) as P;
    case 28:
      return (reader.readLongOrNull(offset)) as P;
    case 29:
      return (reader.readLongOrNull(offset)) as P;
    case 30:
      return (reader.readLongOrNull(offset)) as P;
    case 31:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _trackEntityGetId(TrackEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _trackEntityGetLinks(TrackEntity object) {
  return [];
}

void _trackEntityAttach(
    IsarCollection<dynamic> col, Id id, TrackEntity object) {
  object.id = id;
}

extension TrackEntityByIndex on IsarCollection<TrackEntity> {
  Future<TrackEntity?> getByPath(String path) {
    return getByIndex(r'path', [path]);
  }

  TrackEntity? getByPathSync(String path) {
    return getByIndexSync(r'path', [path]);
  }

  Future<bool> deleteByPath(String path) {
    return deleteByIndex(r'path', [path]);
  }

  bool deleteByPathSync(String path) {
    return deleteByIndexSync(r'path', [path]);
  }

  Future<List<TrackEntity?>> getAllByPath(List<String> pathValues) {
    final values = pathValues.map((e) => [e]).toList();
    return getAllByIndex(r'path', values);
  }

  List<TrackEntity?> getAllByPathSync(List<String> pathValues) {
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

  Future<Id> putByPath(TrackEntity object) {
    return putByIndex(r'path', object);
  }

  Id putByPathSync(TrackEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'path', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPath(List<TrackEntity> objects) {
    return putAllByIndex(r'path', objects);
  }

  List<Id> putAllByPathSync(List<TrackEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'path', objects, saveLinks: saveLinks);
  }
}

extension TrackEntityQueryWhereSort
    on QueryBuilder<TrackEntity, TrackEntity, QWhere> {
  QueryBuilder<TrackEntity, TrackEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TrackEntityQueryWhere
    on QueryBuilder<TrackEntity, TrackEntity, QWhereClause> {
  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause> idBetween(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause> pathEqualTo(
      String path) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'path',
        value: [path],
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause> pathNotEqualTo(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause> folderPathEqualTo(
      String folderPath) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'folderPath',
        value: [folderPath],
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause>
      folderPathNotEqualTo(String folderPath) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'folderPath',
              lower: [],
              upper: [folderPath],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'folderPath',
              lower: [folderPath],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'folderPath',
              lower: [folderPath],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'folderPath',
              lower: [],
              upper: [folderPath],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause> artistLowerEqualTo(
      String artistLower) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'artistLower',
        value: [artistLower],
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause>
      artistLowerNotEqualTo(String artistLower) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'artistLower',
              lower: [],
              upper: [artistLower],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'artistLower',
              lower: [artistLower],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'artistLower',
              lower: [artistLower],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'artistLower',
              lower: [],
              upper: [artistLower],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause> albumLowerEqualTo(
      String albumLower) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'albumLower',
        value: [albumLower],
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause>
      albumLowerNotEqualTo(String albumLower) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'albumLower',
              lower: [],
              upper: [albumLower],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'albumLower',
              lower: [albumLower],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'albumLower',
              lower: [albumLower],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'albumLower',
              lower: [],
              upper: [albumLower],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause> titleLowerEqualTo(
      String titleLower) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'titleLower',
        value: [titleLower],
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause>
      titleLowerNotEqualTo(String titleLower) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titleLower',
              lower: [],
              upper: [titleLower],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titleLower',
              lower: [titleLower],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titleLower',
              lower: [titleLower],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titleLower',
              lower: [],
              upper: [titleLower],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause> genreLowerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'genreLower',
        value: [null],
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause>
      genreLowerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'genreLower',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause> genreLowerEqualTo(
      String? genreLower) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'genreLower',
        value: [genreLower],
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause>
      genreLowerNotEqualTo(String? genreLower) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'genreLower',
              lower: [],
              upper: [genreLower],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'genreLower',
              lower: [genreLower],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'genreLower',
              lower: [genreLower],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'genreLower',
              lower: [],
              upper: [genreLower],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause>
      albumArtistLowerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'albumArtistLower',
        value: [null],
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause>
      albumArtistLowerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'albumArtistLower',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause>
      albumArtistLowerEqualTo(String? albumArtistLower) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'albumArtistLower',
        value: [albumArtistLower],
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause>
      albumArtistLowerNotEqualTo(String? albumArtistLower) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'albumArtistLower',
              lower: [],
              upper: [albumArtistLower],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'albumArtistLower',
              lower: [albumArtistLower],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'albumArtistLower',
              lower: [albumArtistLower],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'albumArtistLower',
              lower: [],
              upper: [albumArtistLower],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause>
      fileNameLowerEqualTo(String fileNameLower) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fileNameLower',
        value: [fileNameLower],
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterWhereClause>
      fileNameLowerNotEqualTo(String fileNameLower) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileNameLower',
              lower: [],
              upper: [fileNameLower],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileNameLower',
              lower: [fileNameLower],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileNameLower',
              lower: [fileNameLower],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fileNameLower',
              lower: [],
              upper: [fileNameLower],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TrackEntityQueryFilter
    on QueryBuilder<TrackEntity, TrackEntity, QFilterCondition> {
  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> albumEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'album',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'album',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> albumLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'album',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> albumBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'album',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> albumStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'album',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> albumEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'album',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> albumContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'album',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> albumMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'album',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> albumIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'album',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'album',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumArtist',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumArtist',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumArtist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'albumArtist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'albumArtist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'albumArtist',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'albumArtist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'albumArtist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'albumArtist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'albumArtist',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumArtist',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'albumArtist',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistLowerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumArtistLower',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistLowerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumArtistLower',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistLowerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumArtistLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistLowerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'albumArtistLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistLowerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'albumArtistLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistLowerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'albumArtistLower',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistLowerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'albumArtistLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistLowerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'albumArtistLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistLowerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'albumArtistLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistLowerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'albumArtistLower',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistLowerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumArtistLower',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumArtistLowerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'albumArtistLower',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumLowerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumLowerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'albumLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumLowerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'albumLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumLowerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'albumLower',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumLowerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'albumLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumLowerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'albumLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumLowerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'albumLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumLowerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'albumLower',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumLowerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumLower',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      albumLowerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'albumLower',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> artistEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      artistGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> artistLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> artistBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'artist',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      artistStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> artistEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> artistContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> artistMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'artist',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      artistIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artist',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      artistIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'artist',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      artistLowerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artistLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      artistLowerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'artistLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      artistLowerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'artistLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      artistLowerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'artistLower',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      artistLowerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'artistLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      artistLowerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'artistLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      artistLowerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'artistLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      artistLowerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'artistLower',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      artistLowerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artistLower',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      artistLowerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'artistLower',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      bitrateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bitrate',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      bitrateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bitrate',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> bitrateEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bitrate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      bitrateGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bitrate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> bitrateLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bitrate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> bitrateBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bitrate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      channelsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'channels',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      channelsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'channels',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> channelsEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channels',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      channelsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'channels',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      channelsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'channels',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> channelsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'channels',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> codecIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'codec',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      codecIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'codec',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> codecEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'codec',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      codecGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'codec',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> codecLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'codec',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> codecBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'codec',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> codecStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'codec',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> codecEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'codec',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> codecContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'codec',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> codecMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'codec',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> codecIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'codec',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      codecIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'codec',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      commentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comment',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      commentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comment',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> commentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      commentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> commentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> commentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comment',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      commentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> commentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> commentContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> commentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comment',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      commentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comment',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      commentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comment',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      composerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'composer',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      composerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'composer',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> composerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'composer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      composerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'composer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      composerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'composer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> composerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'composer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      composerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'composer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      composerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'composer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      composerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'composer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> composerMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'composer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      composerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'composer',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      composerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'composer',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      conductorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'conductor',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      conductorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'conductor',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      conductorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conductor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      conductorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'conductor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      conductorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'conductor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      conductorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'conductor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      conductorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'conductor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      conductorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'conductor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      conductorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'conductor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      conductorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'conductor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      conductorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conductor',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      conductorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'conductor',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      coverArtPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coverArtPath',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      coverArtPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coverArtPath',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      coverArtPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'coverArtPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      coverArtPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'coverArtPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      coverArtPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverArtPath',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      coverArtPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'coverArtPath',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      discNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'discNumber',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      discNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'discNumber',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      discNumberEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'discNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      discNumberGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'discNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      discNumberLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'discNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      discNumberBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'discNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      durationMsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'durationMs',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      durationMsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'durationMs',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      durationMsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationMs',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      durationMsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationMs',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      durationMsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationMs',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      durationMsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> fileNameEqualTo(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> fileNameBetween(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> fileNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileNameLowerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileNameLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileNameLowerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileNameLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileNameLowerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileNameLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileNameLowerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileNameLower',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileNameLowerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileNameLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileNameLowerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileNameLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileNameLowerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileNameLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileNameLowerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileNameLower',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileNameLowerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileNameLower',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileNameLowerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileNameLower',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileSizeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileSize',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileSizeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileSize',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> fileSizeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileSize',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileSizeGreaterThan(
    int? value, {
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      fileSizeLessThan(
    int? value, {
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> fileSizeBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      folderPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'folderPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      folderPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'folderPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      folderPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'folderPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      folderPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'folderPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      folderPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'folderPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      folderPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'folderPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      folderPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'folderPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      folderPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'folderPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      folderPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'folderPath',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      folderPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'folderPath',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> genreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'genre',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'genre',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> genreEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'genre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'genre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> genreLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'genre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> genreBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'genre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> genreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'genre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> genreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'genre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> genreContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'genre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> genreMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'genre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> genreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'genre',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'genre',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreLowerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'genreLower',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreLowerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'genreLower',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreLowerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'genreLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreLowerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'genreLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreLowerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'genreLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreLowerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'genreLower',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreLowerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'genreLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreLowerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'genreLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreLowerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'genreLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreLowerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'genreLower',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreLowerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'genreLower',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      genreLowerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'genreLower',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      lastModifiedMsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastModifiedMs',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      lastModifiedMsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastModifiedMs',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      lastModifiedMsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastModifiedMs',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      lastModifiedMsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastModifiedMs',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      lastModifiedMsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastModifiedMs',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      lastModifiedMsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastModifiedMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      lastScannedMsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastScannedMs',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      lastScannedMsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastScannedMs',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      lastScannedMsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastScannedMs',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> lyricsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lyrics',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      lyricsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lyrics',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> lyricsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      lyricsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> lyricsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> lyricsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lyrics',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      lyricsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> lyricsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> lyricsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> lyricsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lyrics',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      lyricsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lyrics',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      lyricsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lyrics',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> pathEqualTo(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> pathGreaterThan(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> pathLessThan(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> pathBetween(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> pathStartsWith(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> pathEndsWith(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> pathContains(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> pathMatches(
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

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      sampleRateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sampleRate',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      sampleRateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sampleRate',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      sampleRateEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sampleRate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      sampleRateGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sampleRate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      sampleRateLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sampleRate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      sampleRateBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sampleRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      titleLowerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      titleLowerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titleLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      titleLowerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titleLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      titleLowerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titleLower',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      titleLowerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titleLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      titleLowerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titleLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      titleLowerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titleLower',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      titleLowerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titleLower',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      titleLowerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleLower',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      titleLowerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titleLower',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      totalDiscsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalDiscs',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      totalDiscsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalDiscs',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      totalDiscsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalDiscs',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      totalDiscsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalDiscs',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      totalDiscsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalDiscs',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      totalDiscsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalDiscs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      totalTracksIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalTracks',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      totalTracksIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalTracks',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      totalTracksEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalTracks',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      totalTracksGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalTracks',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      totalTracksLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalTracks',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      totalTracksBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalTracks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      trackNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trackNumber',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      trackNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trackNumber',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      trackNumberEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      trackNumberGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trackNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      trackNumberLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trackNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      trackNumberBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trackNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> yearIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'year',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition>
      yearIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'year',
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> yearEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> yearGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> yearLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterFilterCondition> yearBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'year',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TrackEntityQueryObject
    on QueryBuilder<TrackEntity, TrackEntity, QFilterCondition> {}

extension TrackEntityQueryLinks
    on QueryBuilder<TrackEntity, TrackEntity, QFilterCondition> {}

extension TrackEntityQuerySortBy
    on QueryBuilder<TrackEntity, TrackEntity, QSortBy> {
  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByAlbum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'album', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByAlbumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'album', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByAlbumArtist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArtist', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByAlbumArtistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArtist', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy>
      sortByAlbumArtistLower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArtistLower', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy>
      sortByAlbumArtistLowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArtistLower', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByAlbumLower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumLower', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByAlbumLowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumLower', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByArtist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByArtistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByArtistLower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistLower', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByArtistLowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistLower', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByBitrate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bitrate', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByBitrateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bitrate', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByChannels() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channels', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByChannelsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channels', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByCodec() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codec', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByCodecDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codec', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByComment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByCommentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByComposer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composer', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByComposerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composer', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByConductor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conductor', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByConductorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conductor', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByCoverArtPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverArtPath', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy>
      sortByCoverArtPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverArtPath', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByDiscNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discNumber', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByDiscNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discNumber', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByDurationMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByFileNameLower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileNameLower', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy>
      sortByFileNameLowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileNameLower', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByFileSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileSize', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByFileSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileSize', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByFolderPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderPath', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByFolderPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderPath', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByGenre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genre', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByGenreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genre', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByGenreLower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genreLower', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByGenreLowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genreLower', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByLastModifiedMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModifiedMs', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy>
      sortByLastModifiedMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModifiedMs', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByLastScannedMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastScannedMs', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy>
      sortByLastScannedMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastScannedMs', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByLyrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lyrics', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByLyricsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lyrics', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortBySampleRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sampleRate', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortBySampleRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sampleRate', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByTitleLower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleLower', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByTitleLowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleLower', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByTotalDiscs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDiscs', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByTotalDiscsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDiscs', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByTotalTracks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTracks', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByTotalTracksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTracks', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByTrackNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackNumber', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByTrackNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackNumber', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> sortByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension TrackEntityQuerySortThenBy
    on QueryBuilder<TrackEntity, TrackEntity, QSortThenBy> {
  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByAlbum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'album', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByAlbumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'album', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByAlbumArtist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArtist', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByAlbumArtistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArtist', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy>
      thenByAlbumArtistLower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArtistLower', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy>
      thenByAlbumArtistLowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArtistLower', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByAlbumLower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumLower', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByAlbumLowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumLower', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByArtist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByArtistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByArtistLower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistLower', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByArtistLowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistLower', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByBitrate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bitrate', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByBitrateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bitrate', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByChannels() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channels', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByChannelsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channels', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByCodec() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codec', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByCodecDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'codec', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByComment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByCommentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByComposer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composer', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByComposerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composer', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByConductor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conductor', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByConductorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conductor', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByCoverArtPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverArtPath', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy>
      thenByCoverArtPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverArtPath', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByDiscNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discNumber', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByDiscNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discNumber', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByDurationMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByFileNameLower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileNameLower', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy>
      thenByFileNameLowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileNameLower', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByFileSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileSize', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByFileSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileSize', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByFolderPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderPath', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByFolderPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderPath', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByGenre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genre', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByGenreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genre', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByGenreLower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genreLower', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByGenreLowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genreLower', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByLastModifiedMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModifiedMs', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy>
      thenByLastModifiedMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModifiedMs', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByLastScannedMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastScannedMs', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy>
      thenByLastScannedMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastScannedMs', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByLyrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lyrics', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByLyricsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lyrics', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenBySampleRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sampleRate', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenBySampleRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sampleRate', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByTitleLower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleLower', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByTitleLowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleLower', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByTotalDiscs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDiscs', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByTotalDiscsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDiscs', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByTotalTracks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTracks', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByTotalTracksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTracks', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByTrackNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackNumber', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByTrackNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackNumber', Sort.desc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QAfterSortBy> thenByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension TrackEntityQueryWhereDistinct
    on QueryBuilder<TrackEntity, TrackEntity, QDistinct> {
  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByAlbum(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'album', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByAlbumArtist(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'albumArtist', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByAlbumArtistLower(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'albumArtistLower',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByAlbumLower(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'albumLower', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByArtist(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'artist', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByArtistLower(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'artistLower', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByBitrate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bitrate');
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByChannels() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channels');
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByCodec(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'codec', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByComment(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comment', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByComposer(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'composer', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByConductor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conductor', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByCoverArtPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coverArtPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByDiscNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'discNumber');
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationMs');
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByFileName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByFileNameLower(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileNameLower',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByFileSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileSize');
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByFolderPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'folderPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByGenre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'genre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByGenreLower(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'genreLower', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByLastModifiedMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastModifiedMs');
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByLastScannedMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastScannedMs');
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByLyrics(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lyrics', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctBySampleRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sampleRate');
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByTitleLower(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titleLower', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByTotalDiscs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalDiscs');
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByTotalTracks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalTracks');
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByTrackNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackNumber');
    });
  }

  QueryBuilder<TrackEntity, TrackEntity, QDistinct> distinctByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'year');
    });
  }
}

extension TrackEntityQueryProperty
    on QueryBuilder<TrackEntity, TrackEntity, QQueryProperty> {
  QueryBuilder<TrackEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TrackEntity, String, QQueryOperations> albumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'album');
    });
  }

  QueryBuilder<TrackEntity, String?, QQueryOperations> albumArtistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'albumArtist');
    });
  }

  QueryBuilder<TrackEntity, String?, QQueryOperations>
      albumArtistLowerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'albumArtistLower');
    });
  }

  QueryBuilder<TrackEntity, String, QQueryOperations> albumLowerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'albumLower');
    });
  }

  QueryBuilder<TrackEntity, String, QQueryOperations> artistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artist');
    });
  }

  QueryBuilder<TrackEntity, String, QQueryOperations> artistLowerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artistLower');
    });
  }

  QueryBuilder<TrackEntity, int?, QQueryOperations> bitrateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bitrate');
    });
  }

  QueryBuilder<TrackEntity, int?, QQueryOperations> channelsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channels');
    });
  }

  QueryBuilder<TrackEntity, String?, QQueryOperations> codecProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'codec');
    });
  }

  QueryBuilder<TrackEntity, String?, QQueryOperations> commentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comment');
    });
  }

  QueryBuilder<TrackEntity, String?, QQueryOperations> composerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'composer');
    });
  }

  QueryBuilder<TrackEntity, String?, QQueryOperations> conductorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conductor');
    });
  }

  QueryBuilder<TrackEntity, String?, QQueryOperations> coverArtPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coverArtPath');
    });
  }

  QueryBuilder<TrackEntity, int?, QQueryOperations> discNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'discNumber');
    });
  }

  QueryBuilder<TrackEntity, int?, QQueryOperations> durationMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationMs');
    });
  }

  QueryBuilder<TrackEntity, String, QQueryOperations> fileNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileName');
    });
  }

  QueryBuilder<TrackEntity, String, QQueryOperations> fileNameLowerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileNameLower');
    });
  }

  QueryBuilder<TrackEntity, int?, QQueryOperations> fileSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileSize');
    });
  }

  QueryBuilder<TrackEntity, String, QQueryOperations> folderPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'folderPath');
    });
  }

  QueryBuilder<TrackEntity, String?, QQueryOperations> genreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'genre');
    });
  }

  QueryBuilder<TrackEntity, String?, QQueryOperations> genreLowerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'genreLower');
    });
  }

  QueryBuilder<TrackEntity, int?, QQueryOperations> lastModifiedMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastModifiedMs');
    });
  }

  QueryBuilder<TrackEntity, int?, QQueryOperations> lastScannedMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastScannedMs');
    });
  }

  QueryBuilder<TrackEntity, String?, QQueryOperations> lyricsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lyrics');
    });
  }

  QueryBuilder<TrackEntity, String, QQueryOperations> pathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'path');
    });
  }

  QueryBuilder<TrackEntity, int?, QQueryOperations> sampleRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sampleRate');
    });
  }

  QueryBuilder<TrackEntity, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<TrackEntity, String, QQueryOperations> titleLowerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titleLower');
    });
  }

  QueryBuilder<TrackEntity, int?, QQueryOperations> totalDiscsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalDiscs');
    });
  }

  QueryBuilder<TrackEntity, int?, QQueryOperations> totalTracksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalTracks');
    });
  }

  QueryBuilder<TrackEntity, int?, QQueryOperations> trackNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackNumber');
    });
  }

  QueryBuilder<TrackEntity, int?, QQueryOperations> yearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'year');
    });
  }
}
