// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAnimeCollection on Isar {
  IsarCollection<Anime> get animes => this.collection();
}

const AnimeSchema = CollectionSchema(
  name: r'Anime',
  id: -2255851914829551581,
  properties: {
    r'ambientColorValue': PropertySchema(
      id: 0,
      name: r'ambientColorValue',
      type: IsarType.long,
    ),
    r'coverUrl': PropertySchema(
      id: 1,
      name: r'coverUrl',
      type: IsarType.string,
    ),
    r'customCollections': PropertySchema(
      id: 2,
      name: r'customCollections',
      type: IsarType.stringList,
    ),
    r'dateAdded': PropertySchema(
      id: 3,
      name: r'dateAdded',
      type: IsarType.dateTime,
    ),
    r'descripion': PropertySchema(
      id: 4,
      name: r'descripion',
      type: IsarType.string,
    ),
    r'episodePaths': PropertySchema(
      id: 5,
      name: r'episodePaths',
      type: IsarType.stringList,
    ),
    r'folderPath': PropertySchema(
      id: 6,
      name: r'folderPath',
      type: IsarType.string,
    ),
    r'isHidden': PropertySchema(
      id: 7,
      name: r'isHidden',
      type: IsarType.bool,
    ),
    r'nextEpisodeToPlay': PropertySchema(
      id: 8,
      name: r'nextEpisodeToPlay',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 9,
      name: r'notes',
      type: IsarType.objectList,
      target: r'EpisodeNote',
    ),
    r'playbackPositions': PropertySchema(
      id: 10,
      name: r'playbackPositions',
      type: IsarType.objectList,
      target: r'PlaybackEntry',
    ),
    r'progressFraction': PropertySchema(
      id: 11,
      name: r'progressFraction',
      type: IsarType.string,
    ),
    r'progressPercentage': PropertySchema(
      id: 12,
      name: r'progressPercentage',
      type: IsarType.string,
    ),
    r'shikimoriId': PropertySchema(
      id: 13,
      name: r'shikimoriId',
      type: IsarType.long,
    ),
    r'skipData': PropertySchema(
      id: 14,
      name: r'skipData',
      type: IsarType.objectList,
      target: r'EpisodeSkipData',
    ),
    r'sortedEpisodes': PropertySchema(
      id: 15,
      name: r'sortedEpisodes',
      type: IsarType.stringList,
    ),
    r'status': PropertySchema(
      id: 16,
      name: r'status',
      type: IsarType.byte,
      enumMap: _AnimestatusEnumValueMap,
    ),
    r'title': PropertySchema(
      id: 17,
      name: r'title',
      type: IsarType.string,
    ),
    r'watchProgress': PropertySchema(
      id: 18,
      name: r'watchProgress',
      type: IsarType.double,
    ),
    r'watchedEpisodes': PropertySchema(
      id: 19,
      name: r'watchedEpisodes',
      type: IsarType.stringList,
    )
  },
  estimateSize: _animeEstimateSize,
  serialize: _animeSerialize,
  deserialize: _animeDeserialize,
  deserializeProp: _animeDeserializeProp,
  idName: r'id',
  indexes: {
    r'title': IndexSchema(
      id: -7636685945352118059,
      name: r'title',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'title',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'EpisodeNote': EpisodeNoteSchema,
    r'PlaybackEntry': PlaybackEntrySchema,
    r'EpisodeSkipData': EpisodeSkipDataSchema,
    r'SkipIntervalDb': SkipIntervalDbSchema
  },
  getId: _animeGetId,
  getLinks: _animeGetLinks,
  attach: _animeAttach,
  version: '3.1.0+1',
);

int _animeEstimateSize(
  Anime object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.coverUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.customCollections.length * 3;
  {
    for (var i = 0; i < object.customCollections.length; i++) {
      final value = object.customCollections[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.descripion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.episodePaths.length * 3;
  {
    for (var i = 0; i < object.episodePaths.length; i++) {
      final value = object.episodePaths[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.folderPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nextEpisodeToPlay;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.notes.length * 3;
  {
    final offsets = allOffsets[EpisodeNote]!;
    for (var i = 0; i < object.notes.length; i++) {
      final value = object.notes[i];
      bytesCount += EpisodeNoteSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.playbackPositions.length * 3;
  {
    final offsets = allOffsets[PlaybackEntry]!;
    for (var i = 0; i < object.playbackPositions.length; i++) {
      final value = object.playbackPositions[i];
      bytesCount +=
          PlaybackEntrySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.progressFraction.length * 3;
  bytesCount += 3 + object.progressPercentage.length * 3;
  bytesCount += 3 + object.skipData.length * 3;
  {
    final offsets = allOffsets[EpisodeSkipData]!;
    for (var i = 0; i < object.skipData.length; i++) {
      final value = object.skipData[i];
      bytesCount +=
          EpisodeSkipDataSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.sortedEpisodes.length * 3;
  {
    for (var i = 0; i < object.sortedEpisodes.length; i++) {
      final value = object.sortedEpisodes[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.watchedEpisodes.length * 3;
  {
    for (var i = 0; i < object.watchedEpisodes.length; i++) {
      final value = object.watchedEpisodes[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _animeSerialize(
  Anime object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.ambientColorValue);
  writer.writeString(offsets[1], object.coverUrl);
  writer.writeStringList(offsets[2], object.customCollections);
  writer.writeDateTime(offsets[3], object.dateAdded);
  writer.writeString(offsets[4], object.descripion);
  writer.writeStringList(offsets[5], object.episodePaths);
  writer.writeString(offsets[6], object.folderPath);
  writer.writeBool(offsets[7], object.isHidden);
  writer.writeString(offsets[8], object.nextEpisodeToPlay);
  writer.writeObjectList<EpisodeNote>(
    offsets[9],
    allOffsets,
    EpisodeNoteSchema.serialize,
    object.notes,
  );
  writer.writeObjectList<PlaybackEntry>(
    offsets[10],
    allOffsets,
    PlaybackEntrySchema.serialize,
    object.playbackPositions,
  );
  writer.writeString(offsets[11], object.progressFraction);
  writer.writeString(offsets[12], object.progressPercentage);
  writer.writeLong(offsets[13], object.shikimoriId);
  writer.writeObjectList<EpisodeSkipData>(
    offsets[14],
    allOffsets,
    EpisodeSkipDataSchema.serialize,
    object.skipData,
  );
  writer.writeStringList(offsets[15], object.sortedEpisodes);
  writer.writeByte(offsets[16], object.status.index);
  writer.writeString(offsets[17], object.title);
  writer.writeDouble(offsets[18], object.watchProgress);
  writer.writeStringList(offsets[19], object.watchedEpisodes);
}

Anime _animeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Anime();
  object.ambientColorValue = reader.readLongOrNull(offsets[0]);
  object.coverUrl = reader.readStringOrNull(offsets[1]);
  object.customCollections = reader.readStringList(offsets[2]) ?? [];
  object.dateAdded = reader.readDateTime(offsets[3]);
  object.descripion = reader.readStringOrNull(offsets[4]);
  object.episodePaths = reader.readStringList(offsets[5]) ?? [];
  object.folderPath = reader.readStringOrNull(offsets[6]);
  object.id = id;
  object.isHidden = reader.readBool(offsets[7]);
  object.notes = reader.readObjectList<EpisodeNote>(
        offsets[9],
        EpisodeNoteSchema.deserialize,
        allOffsets,
        EpisodeNote(),
      ) ??
      [];
  object.playbackPositions = reader.readObjectList<PlaybackEntry>(
        offsets[10],
        PlaybackEntrySchema.deserialize,
        allOffsets,
        PlaybackEntry(),
      ) ??
      [];
  object.shikimoriId = reader.readLongOrNull(offsets[13]);
  object.skipData = reader.readObjectList<EpisodeSkipData>(
        offsets[14],
        EpisodeSkipDataSchema.deserialize,
        allOffsets,
        EpisodeSkipData(),
      ) ??
      [];
  object.status =
      _AnimestatusValueEnumMap[reader.readByteOrNull(offsets[16])] ??
          AnimeStatus.planned;
  object.title = reader.readString(offsets[17]);
  object.watchedEpisodes = reader.readStringList(offsets[19]) ?? [];
  return object;
}

P _animeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readObjectList<EpisodeNote>(
            offset,
            EpisodeNoteSchema.deserialize,
            allOffsets,
            EpisodeNote(),
          ) ??
          []) as P;
    case 10:
      return (reader.readObjectList<PlaybackEntry>(
            offset,
            PlaybackEntrySchema.deserialize,
            allOffsets,
            PlaybackEntry(),
          ) ??
          []) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readObjectList<EpisodeSkipData>(
            offset,
            EpisodeSkipDataSchema.deserialize,
            allOffsets,
            EpisodeSkipData(),
          ) ??
          []) as P;
    case 15:
      return (reader.readStringList(offset) ?? []) as P;
    case 16:
      return (_AnimestatusValueEnumMap[reader.readByteOrNull(offset)] ??
          AnimeStatus.planned) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readDouble(offset)) as P;
    case 19:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AnimestatusEnumValueMap = {
  'planned': 0,
  'watching': 1,
  'completed': 2,
  'dropped': 3,
};
const _AnimestatusValueEnumMap = {
  0: AnimeStatus.planned,
  1: AnimeStatus.watching,
  2: AnimeStatus.completed,
  3: AnimeStatus.dropped,
};

Id _animeGetId(Anime object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _animeGetLinks(Anime object) {
  return [];
}

void _animeAttach(IsarCollection<dynamic> col, Id id, Anime object) {
  object.id = id;
}

extension AnimeByIndex on IsarCollection<Anime> {
  Future<Anime?> getByTitle(String title) {
    return getByIndex(r'title', [title]);
  }

  Anime? getByTitleSync(String title) {
    return getByIndexSync(r'title', [title]);
  }

  Future<bool> deleteByTitle(String title) {
    return deleteByIndex(r'title', [title]);
  }

  bool deleteByTitleSync(String title) {
    return deleteByIndexSync(r'title', [title]);
  }

  Future<List<Anime?>> getAllByTitle(List<String> titleValues) {
    final values = titleValues.map((e) => [e]).toList();
    return getAllByIndex(r'title', values);
  }

  List<Anime?> getAllByTitleSync(List<String> titleValues) {
    final values = titleValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'title', values);
  }

  Future<int> deleteAllByTitle(List<String> titleValues) {
    final values = titleValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'title', values);
  }

  int deleteAllByTitleSync(List<String> titleValues) {
    final values = titleValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'title', values);
  }

  Future<Id> putByTitle(Anime object) {
    return putByIndex(r'title', object);
  }

  Id putByTitleSync(Anime object, {bool saveLinks = true}) {
    return putByIndexSync(r'title', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTitle(List<Anime> objects) {
    return putAllByIndex(r'title', objects);
  }

  List<Id> putAllByTitleSync(List<Anime> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'title', objects, saveLinks: saveLinks);
  }
}

extension AnimeQueryWhereSort on QueryBuilder<Anime, Anime, QWhere> {
  QueryBuilder<Anime, Anime, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AnimeQueryWhere on QueryBuilder<Anime, Anime, QWhereClause> {
  QueryBuilder<Anime, Anime, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Anime, Anime, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> idBetween(
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

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [title],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleNotEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AnimeQueryFilter on QueryBuilder<Anime, Anime, QFilterCondition> {
  QueryBuilder<Anime, Anime, QAfterFilterCondition> ambientColorValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ambientColorValue',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      ambientColorValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ambientColorValue',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> ambientColorValueEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ambientColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      ambientColorValueGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ambientColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> ambientColorValueLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ambientColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> ambientColorValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ambientColorValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> coverUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coverUrl',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> coverUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coverUrl',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> coverUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> coverUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coverUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> coverUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coverUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> coverUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coverUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> coverUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'coverUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> coverUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'coverUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> coverUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'coverUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> coverUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'coverUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> coverUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> coverUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'coverUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customCollections',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customCollections',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customCollections',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customCollections',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customCollections',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customCollections',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customCollections',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customCollections',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customCollections',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customCollections',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'customCollections',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> customCollectionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'customCollections',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'customCollections',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'customCollections',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'customCollections',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      customCollectionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'customCollections',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> dateAddedEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateAdded',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> dateAddedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateAdded',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> dateAddedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateAdded',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> dateAddedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateAdded',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> descripionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'descripion',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> descripionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'descripion',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> descripionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descripion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> descripionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descripion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> descripionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descripion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> descripionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descripion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> descripionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'descripion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> descripionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'descripion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> descripionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descripion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> descripionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descripion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> descripionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descripion',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> descripionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descripion',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodePathsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'episodePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      episodePathsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'episodePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodePathsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'episodePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodePathsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'episodePaths',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      episodePathsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'episodePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodePathsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'episodePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodePathsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'episodePaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodePathsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'episodePaths',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      episodePathsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'episodePaths',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      episodePathsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'episodePaths',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodePathsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'episodePaths',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodePathsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'episodePaths',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodePathsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'episodePaths',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodePathsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'episodePaths',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      episodePathsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'episodePaths',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodePathsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'episodePaths',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> folderPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'folderPath',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> folderPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'folderPath',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> folderPathEqualTo(
    String? value, {
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> folderPathGreaterThan(
    String? value, {
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> folderPathLessThan(
    String? value, {
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> folderPathBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> folderPathStartsWith(
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> folderPathEndsWith(
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> folderPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'folderPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> folderPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'folderPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> folderPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'folderPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> folderPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'folderPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> isHiddenEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHidden',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> nextEpisodeToPlayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextEpisodeToPlay',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      nextEpisodeToPlayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextEpisodeToPlay',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> nextEpisodeToPlayEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextEpisodeToPlay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      nextEpisodeToPlayGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextEpisodeToPlay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> nextEpisodeToPlayLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextEpisodeToPlay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> nextEpisodeToPlayBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextEpisodeToPlay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> nextEpisodeToPlayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nextEpisodeToPlay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> nextEpisodeToPlayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nextEpisodeToPlay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> nextEpisodeToPlayContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nextEpisodeToPlay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> nextEpisodeToPlayMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nextEpisodeToPlay',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> nextEpisodeToPlayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextEpisodeToPlay',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      nextEpisodeToPlayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nextEpisodeToPlay',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> notesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> notesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> notesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> notesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      playbackPositionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playbackPositions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> playbackPositionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playbackPositions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      playbackPositionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playbackPositions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      playbackPositionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playbackPositions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      playbackPositionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playbackPositions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      playbackPositionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playbackPositions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressFractionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progressFraction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressFractionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progressFraction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressFractionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progressFraction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressFractionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progressFraction',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressFractionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'progressFraction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressFractionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'progressFraction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressFractionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'progressFraction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressFractionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'progressFraction',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressFractionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progressFraction',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      progressFractionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'progressFraction',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressPercentageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progressPercentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      progressPercentageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progressPercentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressPercentageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progressPercentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressPercentageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progressPercentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      progressPercentageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'progressPercentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressPercentageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'progressPercentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressPercentageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'progressPercentage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> progressPercentageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'progressPercentage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      progressPercentageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progressPercentage',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      progressPercentageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'progressPercentage',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> shikimoriIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shikimoriId',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> shikimoriIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shikimoriId',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> shikimoriIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shikimoriId',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> shikimoriIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shikimoriId',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> shikimoriIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shikimoriId',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> shikimoriIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shikimoriId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> skipDataLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skipData',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> skipDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skipData',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> skipDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skipData',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> skipDataLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skipData',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> skipDataLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skipData',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> skipDataLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skipData',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      sortedEpisodesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sortedEpisodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      sortedEpisodesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sortedEpisodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      sortedEpisodesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sortedEpisodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      sortedEpisodesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sortedEpisodes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      sortedEpisodesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sortedEpisodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      sortedEpisodesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sortedEpisodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      sortedEpisodesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sortedEpisodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      sortedEpisodesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sortedEpisodes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      sortedEpisodesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sortedEpisodes',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      sortedEpisodesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sortedEpisodes',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> sortedEpisodesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sortedEpisodes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> sortedEpisodesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sortedEpisodes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> sortedEpisodesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sortedEpisodes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      sortedEpisodesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sortedEpisodes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      sortedEpisodesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sortedEpisodes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> sortedEpisodesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sortedEpisodes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> statusEqualTo(
      AnimeStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> statusGreaterThan(
    AnimeStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> statusLessThan(
    AnimeStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> statusBetween(
    AnimeStatus lower,
    AnimeStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleEqualTo(
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleGreaterThan(
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleLessThan(
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleBetween(
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleStartsWith(
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleEndsWith(
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

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> watchProgressEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'watchProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> watchProgressGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'watchProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> watchProgressLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'watchProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> watchProgressBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'watchProgress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'watchedEpisodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'watchedEpisodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'watchedEpisodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'watchedEpisodes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'watchedEpisodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'watchedEpisodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'watchedEpisodes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'watchedEpisodes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'watchedEpisodes',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'watchedEpisodes',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchedEpisodes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> watchedEpisodesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchedEpisodes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchedEpisodes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchedEpisodes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchedEpisodes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition>
      watchedEpisodesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'watchedEpisodes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension AnimeQueryObject on QueryBuilder<Anime, Anime, QFilterCondition> {
  QueryBuilder<Anime, Anime, QAfterFilterCondition> notesElement(
      FilterQuery<EpisodeNote> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'notes');
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> playbackPositionsElement(
      FilterQuery<PlaybackEntry> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'playbackPositions');
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> skipDataElement(
      FilterQuery<EpisodeSkipData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'skipData');
    });
  }
}

extension AnimeQueryLinks on QueryBuilder<Anime, Anime, QFilterCondition> {}

extension AnimeQuerySortBy on QueryBuilder<Anime, Anime, QSortBy> {
  QueryBuilder<Anime, Anime, QAfterSortBy> sortByAmbientColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ambientColorValue', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByAmbientColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ambientColorValue', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByCoverUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverUrl', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByCoverUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverUrl', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByDateAdded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateAdded', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByDateAddedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateAdded', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByDescripion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripion', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByDescripionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripion', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByFolderPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderPath', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByFolderPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderPath', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByNextEpisodeToPlay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextEpisodeToPlay', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByNextEpisodeToPlayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextEpisodeToPlay', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByProgressFraction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressFraction', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByProgressFractionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressFraction', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByProgressPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressPercentage', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByProgressPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressPercentage', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByShikimoriId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shikimoriId', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByShikimoriIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shikimoriId', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByWatchProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'watchProgress', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByWatchProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'watchProgress', Sort.desc);
    });
  }
}

extension AnimeQuerySortThenBy on QueryBuilder<Anime, Anime, QSortThenBy> {
  QueryBuilder<Anime, Anime, QAfterSortBy> thenByAmbientColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ambientColorValue', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByAmbientColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ambientColorValue', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByCoverUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverUrl', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByCoverUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverUrl', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByDateAdded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateAdded', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByDateAddedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateAdded', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByDescripion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripion', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByDescripionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripion', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByFolderPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderPath', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByFolderPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'folderPath', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByIsHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHidden', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByNextEpisodeToPlay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextEpisodeToPlay', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByNextEpisodeToPlayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextEpisodeToPlay', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByProgressFraction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressFraction', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByProgressFractionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressFraction', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByProgressPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressPercentage', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByProgressPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progressPercentage', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByShikimoriId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shikimoriId', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByShikimoriIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shikimoriId', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByWatchProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'watchProgress', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByWatchProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'watchProgress', Sort.desc);
    });
  }
}

extension AnimeQueryWhereDistinct on QueryBuilder<Anime, Anime, QDistinct> {
  QueryBuilder<Anime, Anime, QDistinct> distinctByAmbientColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ambientColorValue');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByCoverUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coverUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByCustomCollections() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customCollections');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByDateAdded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateAdded');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByDescripion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descripion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByEpisodePaths() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'episodePaths');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByFolderPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'folderPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByIsHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isHidden');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByNextEpisodeToPlay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextEpisodeToPlay',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByProgressFraction(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progressFraction',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByProgressPercentage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progressPercentage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByShikimoriId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shikimoriId');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctBySortedEpisodes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sortedEpisodes');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByWatchProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'watchProgress');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByWatchedEpisodes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'watchedEpisodes');
    });
  }
}

extension AnimeQueryProperty on QueryBuilder<Anime, Anime, QQueryProperty> {
  QueryBuilder<Anime, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Anime, int?, QQueryOperations> ambientColorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ambientColorValue');
    });
  }

  QueryBuilder<Anime, String?, QQueryOperations> coverUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coverUrl');
    });
  }

  QueryBuilder<Anime, List<String>, QQueryOperations>
      customCollectionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customCollections');
    });
  }

  QueryBuilder<Anime, DateTime, QQueryOperations> dateAddedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateAdded');
    });
  }

  QueryBuilder<Anime, String?, QQueryOperations> descripionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descripion');
    });
  }

  QueryBuilder<Anime, List<String>, QQueryOperations> episodePathsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'episodePaths');
    });
  }

  QueryBuilder<Anime, String?, QQueryOperations> folderPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'folderPath');
    });
  }

  QueryBuilder<Anime, bool, QQueryOperations> isHiddenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isHidden');
    });
  }

  QueryBuilder<Anime, String?, QQueryOperations> nextEpisodeToPlayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextEpisodeToPlay');
    });
  }

  QueryBuilder<Anime, List<EpisodeNote>, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<Anime, List<PlaybackEntry>, QQueryOperations>
      playbackPositionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playbackPositions');
    });
  }

  QueryBuilder<Anime, String, QQueryOperations> progressFractionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progressFraction');
    });
  }

  QueryBuilder<Anime, String, QQueryOperations> progressPercentageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progressPercentage');
    });
  }

  QueryBuilder<Anime, int?, QQueryOperations> shikimoriIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shikimoriId');
    });
  }

  QueryBuilder<Anime, List<EpisodeSkipData>, QQueryOperations>
      skipDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'skipData');
    });
  }

  QueryBuilder<Anime, List<String>, QQueryOperations> sortedEpisodesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sortedEpisodes');
    });
  }

  QueryBuilder<Anime, AnimeStatus, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<Anime, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<Anime, double, QQueryOperations> watchProgressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'watchProgress');
    });
  }

  QueryBuilder<Anime, List<String>, QQueryOperations>
      watchedEpisodesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'watchedEpisodes');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const EpisodeNoteSchema = Schema(
  name: r'EpisodeNote',
  id: -6975040030378353113,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'episodePath': PropertySchema(
      id: 1,
      name: r'episodePath',
      type: IsarType.string,
    ),
    r'text': PropertySchema(
      id: 2,
      name: r'text',
      type: IsarType.string,
    ),
    r'timestampSeconds': PropertySchema(
      id: 3,
      name: r'timestampSeconds',
      type: IsarType.long,
    )
  },
  estimateSize: _episodeNoteEstimateSize,
  serialize: _episodeNoteSerialize,
  deserialize: _episodeNoteDeserialize,
  deserializeProp: _episodeNoteDeserializeProp,
);

int _episodeNoteEstimateSize(
  EpisodeNote object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.episodePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.text;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _episodeNoteSerialize(
  EpisodeNote object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.episodePath);
  writer.writeString(offsets[2], object.text);
  writer.writeLong(offsets[3], object.timestampSeconds);
}

EpisodeNote _episodeNoteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EpisodeNote();
  object.createdAt = reader.readDateTimeOrNull(offsets[0]);
  object.episodePath = reader.readStringOrNull(offsets[1]);
  object.text = reader.readStringOrNull(offsets[2]);
  object.timestampSeconds = reader.readLongOrNull(offsets[3]);
  return object;
}

P _episodeNoteDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension EpisodeNoteQueryFilter
    on QueryBuilder<EpisodeNote, EpisodeNote, QFilterCondition> {
  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
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

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value, {
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

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
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

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      episodePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'episodePath',
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      episodePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'episodePath',
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      episodePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'episodePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      episodePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'episodePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      episodePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'episodePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      episodePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'episodePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      episodePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'episodePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      episodePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'episodePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      episodePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'episodePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      episodePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'episodePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      episodePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'episodePath',
        value: '',
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      episodePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'episodePath',
        value: '',
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition> textIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'text',
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      textIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'text',
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition> textEqualTo(
    String? value, {
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

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition> textGreaterThan(
    String? value, {
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

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition> textLessThan(
    String? value, {
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

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition> textBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition> textStartsWith(
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

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition> textEndsWith(
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

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      timestampSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timestampSeconds',
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      timestampSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timestampSeconds',
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      timestampSecondsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestampSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      timestampSecondsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestampSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      timestampSecondsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestampSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<EpisodeNote, EpisodeNote, QAfterFilterCondition>
      timestampSecondsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestampSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EpisodeNoteQueryObject
    on QueryBuilder<EpisodeNote, EpisodeNote, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PlaybackEntrySchema = Schema(
  name: r'PlaybackEntry',
  id: 4370651259175256439,
  properties: {
    r'path': PropertySchema(
      id: 0,
      name: r'path',
      type: IsarType.string,
    ),
    r'position': PropertySchema(
      id: 1,
      name: r'position',
      type: IsarType.long,
    )
  },
  estimateSize: _playbackEntryEstimateSize,
  serialize: _playbackEntrySerialize,
  deserialize: _playbackEntryDeserialize,
  deserializeProp: _playbackEntryDeserializeProp,
);

int _playbackEntryEstimateSize(
  PlaybackEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.path;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _playbackEntrySerialize(
  PlaybackEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.path);
  writer.writeLong(offsets[1], object.position);
}

PlaybackEntry _playbackEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlaybackEntry();
  object.path = reader.readStringOrNull(offsets[0]);
  object.position = reader.readLongOrNull(offsets[1]);
  return object;
}

P _playbackEntryDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PlaybackEntryQueryFilter
    on QueryBuilder<PlaybackEntry, PlaybackEntry, QFilterCondition> {
  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
      pathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'path',
      ));
    });
  }

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
      pathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'path',
      ));
    });
  }

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition> pathEqualTo(
    String? value, {
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

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
      pathGreaterThan(
    String? value, {
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

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
      pathLessThan(
    String? value, {
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

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition> pathBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
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

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
      pathEndsWith(
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

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
      pathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition> pathMatches(
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

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
      pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
      pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
      positionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'position',
      ));
    });
  }

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
      positionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'position',
      ));
    });
  }

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
      positionEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
      positionGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
      positionLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaybackEntry, PlaybackEntry, QAfterFilterCondition>
      positionBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'position',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PlaybackEntryQueryObject
    on QueryBuilder<PlaybackEntry, PlaybackEntry, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const EpisodeSkipDataSchema = Schema(
  name: r'EpisodeSkipData',
  id: -5631851334927123711,
  properties: {
    r'episodePath': PropertySchema(
      id: 0,
      name: r'episodePath',
      type: IsarType.string,
    ),
    r'intervals': PropertySchema(
      id: 1,
      name: r'intervals',
      type: IsarType.objectList,
      target: r'SkipIntervalDb',
    )
  },
  estimateSize: _episodeSkipDataEstimateSize,
  serialize: _episodeSkipDataSerialize,
  deserialize: _episodeSkipDataDeserialize,
  deserializeProp: _episodeSkipDataDeserializeProp,
);

int _episodeSkipDataEstimateSize(
  EpisodeSkipData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.episodePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.intervals.length * 3;
  {
    final offsets = allOffsets[SkipIntervalDb]!;
    for (var i = 0; i < object.intervals.length; i++) {
      final value = object.intervals[i];
      bytesCount +=
          SkipIntervalDbSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _episodeSkipDataSerialize(
  EpisodeSkipData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.episodePath);
  writer.writeObjectList<SkipIntervalDb>(
    offsets[1],
    allOffsets,
    SkipIntervalDbSchema.serialize,
    object.intervals,
  );
}

EpisodeSkipData _episodeSkipDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EpisodeSkipData();
  object.episodePath = reader.readStringOrNull(offsets[0]);
  object.intervals = reader.readObjectList<SkipIntervalDb>(
        offsets[1],
        SkipIntervalDbSchema.deserialize,
        allOffsets,
        SkipIntervalDb(),
      ) ??
      [];
  return object;
}

P _episodeSkipDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readObjectList<SkipIntervalDb>(
            offset,
            SkipIntervalDbSchema.deserialize,
            allOffsets,
            SkipIntervalDb(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension EpisodeSkipDataQueryFilter
    on QueryBuilder<EpisodeSkipData, EpisodeSkipData, QFilterCondition> {
  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      episodePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'episodePath',
      ));
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      episodePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'episodePath',
      ));
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      episodePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'episodePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      episodePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'episodePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      episodePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'episodePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      episodePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'episodePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      episodePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'episodePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      episodePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'episodePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      episodePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'episodePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      episodePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'episodePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      episodePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'episodePath',
        value: '',
      ));
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      episodePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'episodePath',
        value: '',
      ));
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      intervalsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'intervals',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      intervalsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'intervals',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      intervalsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'intervals',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      intervalsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'intervals',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      intervalsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'intervals',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      intervalsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'intervals',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension EpisodeSkipDataQueryObject
    on QueryBuilder<EpisodeSkipData, EpisodeSkipData, QFilterCondition> {
  QueryBuilder<EpisodeSkipData, EpisodeSkipData, QAfterFilterCondition>
      intervalsElement(FilterQuery<SkipIntervalDb> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'intervals');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SkipIntervalDbSchema = Schema(
  name: r'SkipIntervalDb',
  id: -6299560242180249208,
  properties: {
    r'endTime': PropertySchema(
      id: 0,
      name: r'endTime',
      type: IsarType.double,
    ),
    r'startTime': PropertySchema(
      id: 1,
      name: r'startTime',
      type: IsarType.double,
    ),
    r'type': PropertySchema(
      id: 2,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _skipIntervalDbEstimateSize,
  serialize: _skipIntervalDbSerialize,
  deserialize: _skipIntervalDbDeserialize,
  deserializeProp: _skipIntervalDbDeserializeProp,
);

int _skipIntervalDbEstimateSize(
  SkipIntervalDb object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _skipIntervalDbSerialize(
  SkipIntervalDb object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.endTime);
  writer.writeDouble(offsets[1], object.startTime);
  writer.writeString(offsets[2], object.type);
}

SkipIntervalDb _skipIntervalDbDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SkipIntervalDb();
  object.endTime = reader.readDoubleOrNull(offsets[0]);
  object.startTime = reader.readDoubleOrNull(offsets[1]);
  object.type = reader.readStringOrNull(offsets[2]);
  return object;
}

P _skipIntervalDbDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SkipIntervalDbQueryFilter
    on QueryBuilder<SkipIntervalDb, SkipIntervalDb, QFilterCondition> {
  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      endTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endTime',
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      endTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endTime',
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      endTimeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      endTimeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      endTimeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      endTimeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      startTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'startTime',
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      startTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'startTime',
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      startTimeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      startTimeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      startTimeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      startTimeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      typeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      typeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      typeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      typeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<SkipIntervalDb, SkipIntervalDb, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension SkipIntervalDbQueryObject
    on QueryBuilder<SkipIntervalDb, SkipIntervalDb, QFilterCondition> {}
