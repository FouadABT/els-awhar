/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class SearchLog implements _i1.SerializableModel {
  SearchLog._({
    this.id,
    this.userId,
    required this.searchText,
    this.cityId,
    this.categoryId,
    int? resultsCount,
    this.clickedDriverId,
    this.sessionId,
    this.deviceType,
    DateTime? createdAt,
  }) : resultsCount = resultsCount ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory SearchLog({
    int? id,
    int? userId,
    required String searchText,
    int? cityId,
    int? categoryId,
    int? resultsCount,
    int? clickedDriverId,
    String? sessionId,
    String? deviceType,
    DateTime? createdAt,
  }) = _SearchLogImpl;

  factory SearchLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return SearchLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int?,
      searchText: jsonSerialization['searchText'] as String,
      cityId: jsonSerialization['cityId'] as int?,
      categoryId: jsonSerialization['categoryId'] as int?,
      resultsCount: jsonSerialization['resultsCount'] as int,
      clickedDriverId: jsonSerialization['clickedDriverId'] as int?,
      sessionId: jsonSerialization['sessionId'] as String?,
      deviceType: jsonSerialization['deviceType'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? userId;

  String searchText;

  int? cityId;

  int? categoryId;

  int resultsCount;

  int? clickedDriverId;

  String? sessionId;

  String? deviceType;

  DateTime createdAt;

  /// Returns a shallow copy of this [SearchLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SearchLog copyWith({
    int? id,
    int? userId,
    String? searchText,
    int? cityId,
    int? categoryId,
    int? resultsCount,
    int? clickedDriverId,
    String? sessionId,
    String? deviceType,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SearchLog',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      'searchText': searchText,
      if (cityId != null) 'cityId': cityId,
      if (categoryId != null) 'categoryId': categoryId,
      'resultsCount': resultsCount,
      if (clickedDriverId != null) 'clickedDriverId': clickedDriverId,
      if (sessionId != null) 'sessionId': sessionId,
      if (deviceType != null) 'deviceType': deviceType,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SearchLogImpl extends SearchLog {
  _SearchLogImpl({
    int? id,
    int? userId,
    required String searchText,
    int? cityId,
    int? categoryId,
    int? resultsCount,
    int? clickedDriverId,
    String? sessionId,
    String? deviceType,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         searchText: searchText,
         cityId: cityId,
         categoryId: categoryId,
         resultsCount: resultsCount,
         clickedDriverId: clickedDriverId,
         sessionId: sessionId,
         deviceType: deviceType,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SearchLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SearchLog copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    String? searchText,
    Object? cityId = _Undefined,
    Object? categoryId = _Undefined,
    int? resultsCount,
    Object? clickedDriverId = _Undefined,
    Object? sessionId = _Undefined,
    Object? deviceType = _Undefined,
    DateTime? createdAt,
  }) {
    return SearchLog(
      id: id is int? ? id : this.id,
      userId: userId is int? ? userId : this.userId,
      searchText: searchText ?? this.searchText,
      cityId: cityId is int? ? cityId : this.cityId,
      categoryId: categoryId is int? ? categoryId : this.categoryId,
      resultsCount: resultsCount ?? this.resultsCount,
      clickedDriverId: clickedDriverId is int?
          ? clickedDriverId
          : this.clickedDriverId,
      sessionId: sessionId is String? ? sessionId : this.sessionId,
      deviceType: deviceType is String? ? deviceType : this.deviceType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
