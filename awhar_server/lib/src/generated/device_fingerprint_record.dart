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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class DeviceFingerprintRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DeviceFingerprintRecord._({
    this.id,
    required this.fingerprintHash,
    this.deviceId,
    this.deviceModel,
    this.deviceBrand,
    this.screenWidth,
    this.screenHeight,
    this.screenDensity,
    this.cpuCores,
    this.isPhysicalDevice,
    this.osVersion,
    this.timezone,
    this.language,
    this.appVersion,
    this.lastIpAddress,
    required this.userIds,
    required this.riskScore,
    this.riskFactors,
    required this.isBlocked,
    this.notes,
    required this.firstSeenAt,
    required this.lastSeenAt,
  });

  factory DeviceFingerprintRecord({
    int? id,
    required String fingerprintHash,
    String? deviceId,
    String? deviceModel,
    String? deviceBrand,
    int? screenWidth,
    int? screenHeight,
    double? screenDensity,
    int? cpuCores,
    bool? isPhysicalDevice,
    String? osVersion,
    String? timezone,
    String? language,
    String? appVersion,
    String? lastIpAddress,
    required String userIds,
    required double riskScore,
    String? riskFactors,
    required bool isBlocked,
    String? notes,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
  }) = _DeviceFingerprintRecordImpl;

  factory DeviceFingerprintRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DeviceFingerprintRecord(
      id: jsonSerialization['id'] as int?,
      fingerprintHash: jsonSerialization['fingerprintHash'] as String,
      deviceId: jsonSerialization['deviceId'] as String?,
      deviceModel: jsonSerialization['deviceModel'] as String?,
      deviceBrand: jsonSerialization['deviceBrand'] as String?,
      screenWidth: jsonSerialization['screenWidth'] as int?,
      screenHeight: jsonSerialization['screenHeight'] as int?,
      screenDensity: (jsonSerialization['screenDensity'] as num?)?.toDouble(),
      cpuCores: jsonSerialization['cpuCores'] as int?,
      isPhysicalDevice: jsonSerialization['isPhysicalDevice'] as bool?,
      osVersion: jsonSerialization['osVersion'] as String?,
      timezone: jsonSerialization['timezone'] as String?,
      language: jsonSerialization['language'] as String?,
      appVersion: jsonSerialization['appVersion'] as String?,
      lastIpAddress: jsonSerialization['lastIpAddress'] as String?,
      userIds: jsonSerialization['userIds'] as String,
      riskScore: (jsonSerialization['riskScore'] as num).toDouble(),
      riskFactors: jsonSerialization['riskFactors'] as String?,
      isBlocked: jsonSerialization['isBlocked'] as bool,
      notes: jsonSerialization['notes'] as String?,
      firstSeenAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstSeenAt'],
      ),
      lastSeenAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeenAt'],
      ),
    );
  }

  static final t = DeviceFingerprintRecordTable();

  static const db = DeviceFingerprintRecordRepository._();

  @override
  int? id;

  /// Fingerprint identification
  String fingerprintHash;

  /// Device identifiers (can be multiple per fingerprint due to reinstalls)
  String? deviceId;

  /// Device identifiers (can be multiple per fingerprint due to reinstalls)
  String? deviceModel;

  /// Device identifiers (can be multiple per fingerprint due to reinstalls)
  String? deviceBrand;

  /// Screen info
  int? screenWidth;

  int? screenHeight;

  double? screenDensity;

  /// Hardware specs
  int? cpuCores;

  bool? isPhysicalDevice;

  /// OS info
  String? osVersion;

  /// Locale info
  String? timezone;

  /// Locale info
  String? language;

  /// App info
  String? appVersion;

  /// Network info (captured on each check)
  String? lastIpAddress;

  /// User associations (multi-value - stored as JSON array)
  /// These are the user IDs that have used this device
  String userIds;

  /// Risk assessment
  double riskScore;

  /// Risk assessment
  String? riskFactors;

  /// Risk assessment
  bool isBlocked;

  /// Admin notes
  String? notes;

  /// Timestamps
  DateTime firstSeenAt;

  DateTime lastSeenAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DeviceFingerprintRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceFingerprintRecord copyWith({
    int? id,
    String? fingerprintHash,
    String? deviceId,
    String? deviceModel,
    String? deviceBrand,
    int? screenWidth,
    int? screenHeight,
    double? screenDensity,
    int? cpuCores,
    bool? isPhysicalDevice,
    String? osVersion,
    String? timezone,
    String? language,
    String? appVersion,
    String? lastIpAddress,
    String? userIds,
    double? riskScore,
    String? riskFactors,
    bool? isBlocked,
    String? notes,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceFingerprintRecord',
      if (id != null) 'id': id,
      'fingerprintHash': fingerprintHash,
      if (deviceId != null) 'deviceId': deviceId,
      if (deviceModel != null) 'deviceModel': deviceModel,
      if (deviceBrand != null) 'deviceBrand': deviceBrand,
      if (screenWidth != null) 'screenWidth': screenWidth,
      if (screenHeight != null) 'screenHeight': screenHeight,
      if (screenDensity != null) 'screenDensity': screenDensity,
      if (cpuCores != null) 'cpuCores': cpuCores,
      if (isPhysicalDevice != null) 'isPhysicalDevice': isPhysicalDevice,
      if (osVersion != null) 'osVersion': osVersion,
      if (timezone != null) 'timezone': timezone,
      if (language != null) 'language': language,
      if (appVersion != null) 'appVersion': appVersion,
      if (lastIpAddress != null) 'lastIpAddress': lastIpAddress,
      'userIds': userIds,
      'riskScore': riskScore,
      if (riskFactors != null) 'riskFactors': riskFactors,
      'isBlocked': isBlocked,
      if (notes != null) 'notes': notes,
      'firstSeenAt': firstSeenAt.toJson(),
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DeviceFingerprintRecord',
      if (id != null) 'id': id,
      'fingerprintHash': fingerprintHash,
      if (deviceId != null) 'deviceId': deviceId,
      if (deviceModel != null) 'deviceModel': deviceModel,
      if (deviceBrand != null) 'deviceBrand': deviceBrand,
      if (screenWidth != null) 'screenWidth': screenWidth,
      if (screenHeight != null) 'screenHeight': screenHeight,
      if (screenDensity != null) 'screenDensity': screenDensity,
      if (cpuCores != null) 'cpuCores': cpuCores,
      if (isPhysicalDevice != null) 'isPhysicalDevice': isPhysicalDevice,
      if (osVersion != null) 'osVersion': osVersion,
      if (timezone != null) 'timezone': timezone,
      if (language != null) 'language': language,
      if (appVersion != null) 'appVersion': appVersion,
      if (lastIpAddress != null) 'lastIpAddress': lastIpAddress,
      'userIds': userIds,
      'riskScore': riskScore,
      if (riskFactors != null) 'riskFactors': riskFactors,
      'isBlocked': isBlocked,
      if (notes != null) 'notes': notes,
      'firstSeenAt': firstSeenAt.toJson(),
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  static DeviceFingerprintRecordInclude include() {
    return DeviceFingerprintRecordInclude._();
  }

  static DeviceFingerprintRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<DeviceFingerprintRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceFingerprintRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceFingerprintRecordTable>? orderByList,
    DeviceFingerprintRecordInclude? include,
  }) {
    return DeviceFingerprintRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeviceFingerprintRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DeviceFingerprintRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceFingerprintRecordImpl extends DeviceFingerprintRecord {
  _DeviceFingerprintRecordImpl({
    int? id,
    required String fingerprintHash,
    String? deviceId,
    String? deviceModel,
    String? deviceBrand,
    int? screenWidth,
    int? screenHeight,
    double? screenDensity,
    int? cpuCores,
    bool? isPhysicalDevice,
    String? osVersion,
    String? timezone,
    String? language,
    String? appVersion,
    String? lastIpAddress,
    required String userIds,
    required double riskScore,
    String? riskFactors,
    required bool isBlocked,
    String? notes,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
  }) : super._(
         id: id,
         fingerprintHash: fingerprintHash,
         deviceId: deviceId,
         deviceModel: deviceModel,
         deviceBrand: deviceBrand,
         screenWidth: screenWidth,
         screenHeight: screenHeight,
         screenDensity: screenDensity,
         cpuCores: cpuCores,
         isPhysicalDevice: isPhysicalDevice,
         osVersion: osVersion,
         timezone: timezone,
         language: language,
         appVersion: appVersion,
         lastIpAddress: lastIpAddress,
         userIds: userIds,
         riskScore: riskScore,
         riskFactors: riskFactors,
         isBlocked: isBlocked,
         notes: notes,
         firstSeenAt: firstSeenAt,
         lastSeenAt: lastSeenAt,
       );

  /// Returns a shallow copy of this [DeviceFingerprintRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceFingerprintRecord copyWith({
    Object? id = _Undefined,
    String? fingerprintHash,
    Object? deviceId = _Undefined,
    Object? deviceModel = _Undefined,
    Object? deviceBrand = _Undefined,
    Object? screenWidth = _Undefined,
    Object? screenHeight = _Undefined,
    Object? screenDensity = _Undefined,
    Object? cpuCores = _Undefined,
    Object? isPhysicalDevice = _Undefined,
    Object? osVersion = _Undefined,
    Object? timezone = _Undefined,
    Object? language = _Undefined,
    Object? appVersion = _Undefined,
    Object? lastIpAddress = _Undefined,
    String? userIds,
    double? riskScore,
    Object? riskFactors = _Undefined,
    bool? isBlocked,
    Object? notes = _Undefined,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
  }) {
    return DeviceFingerprintRecord(
      id: id is int? ? id : this.id,
      fingerprintHash: fingerprintHash ?? this.fingerprintHash,
      deviceId: deviceId is String? ? deviceId : this.deviceId,
      deviceModel: deviceModel is String? ? deviceModel : this.deviceModel,
      deviceBrand: deviceBrand is String? ? deviceBrand : this.deviceBrand,
      screenWidth: screenWidth is int? ? screenWidth : this.screenWidth,
      screenHeight: screenHeight is int? ? screenHeight : this.screenHeight,
      screenDensity: screenDensity is double?
          ? screenDensity
          : this.screenDensity,
      cpuCores: cpuCores is int? ? cpuCores : this.cpuCores,
      isPhysicalDevice: isPhysicalDevice is bool?
          ? isPhysicalDevice
          : this.isPhysicalDevice,
      osVersion: osVersion is String? ? osVersion : this.osVersion,
      timezone: timezone is String? ? timezone : this.timezone,
      language: language is String? ? language : this.language,
      appVersion: appVersion is String? ? appVersion : this.appVersion,
      lastIpAddress: lastIpAddress is String?
          ? lastIpAddress
          : this.lastIpAddress,
      userIds: userIds ?? this.userIds,
      riskScore: riskScore ?? this.riskScore,
      riskFactors: riskFactors is String? ? riskFactors : this.riskFactors,
      isBlocked: isBlocked ?? this.isBlocked,
      notes: notes is String? ? notes : this.notes,
      firstSeenAt: firstSeenAt ?? this.firstSeenAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }
}

class DeviceFingerprintRecordUpdateTable
    extends _i1.UpdateTable<DeviceFingerprintRecordTable> {
  DeviceFingerprintRecordUpdateTable(super.table);

  _i1.ColumnValue<String, String> fingerprintHash(String value) =>
      _i1.ColumnValue(
        table.fingerprintHash,
        value,
      );

  _i1.ColumnValue<String, String> deviceId(String? value) => _i1.ColumnValue(
    table.deviceId,
    value,
  );

  _i1.ColumnValue<String, String> deviceModel(String? value) => _i1.ColumnValue(
    table.deviceModel,
    value,
  );

  _i1.ColumnValue<String, String> deviceBrand(String? value) => _i1.ColumnValue(
    table.deviceBrand,
    value,
  );

  _i1.ColumnValue<int, int> screenWidth(int? value) => _i1.ColumnValue(
    table.screenWidth,
    value,
  );

  _i1.ColumnValue<int, int> screenHeight(int? value) => _i1.ColumnValue(
    table.screenHeight,
    value,
  );

  _i1.ColumnValue<double, double> screenDensity(double? value) =>
      _i1.ColumnValue(
        table.screenDensity,
        value,
      );

  _i1.ColumnValue<int, int> cpuCores(int? value) => _i1.ColumnValue(
    table.cpuCores,
    value,
  );

  _i1.ColumnValue<bool, bool> isPhysicalDevice(bool? value) => _i1.ColumnValue(
    table.isPhysicalDevice,
    value,
  );

  _i1.ColumnValue<String, String> osVersion(String? value) => _i1.ColumnValue(
    table.osVersion,
    value,
  );

  _i1.ColumnValue<String, String> timezone(String? value) => _i1.ColumnValue(
    table.timezone,
    value,
  );

  _i1.ColumnValue<String, String> language(String? value) => _i1.ColumnValue(
    table.language,
    value,
  );

  _i1.ColumnValue<String, String> appVersion(String? value) => _i1.ColumnValue(
    table.appVersion,
    value,
  );

  _i1.ColumnValue<String, String> lastIpAddress(String? value) =>
      _i1.ColumnValue(
        table.lastIpAddress,
        value,
      );

  _i1.ColumnValue<String, String> userIds(String value) => _i1.ColumnValue(
    table.userIds,
    value,
  );

  _i1.ColumnValue<double, double> riskScore(double value) => _i1.ColumnValue(
    table.riskScore,
    value,
  );

  _i1.ColumnValue<String, String> riskFactors(String? value) => _i1.ColumnValue(
    table.riskFactors,
    value,
  );

  _i1.ColumnValue<bool, bool> isBlocked(bool value) => _i1.ColumnValue(
    table.isBlocked,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> firstSeenAt(DateTime value) =>
      _i1.ColumnValue(
        table.firstSeenAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastSeenAt(DateTime value) =>
      _i1.ColumnValue(
        table.lastSeenAt,
        value,
      );
}

class DeviceFingerprintRecordTable extends _i1.Table<int?> {
  DeviceFingerprintRecordTable({super.tableRelation})
    : super(tableName: 'device_fingerprint_records') {
    updateTable = DeviceFingerprintRecordUpdateTable(this);
    fingerprintHash = _i1.ColumnString(
      'fingerprintHash',
      this,
    );
    deviceId = _i1.ColumnString(
      'deviceId',
      this,
    );
    deviceModel = _i1.ColumnString(
      'deviceModel',
      this,
    );
    deviceBrand = _i1.ColumnString(
      'deviceBrand',
      this,
    );
    screenWidth = _i1.ColumnInt(
      'screenWidth',
      this,
    );
    screenHeight = _i1.ColumnInt(
      'screenHeight',
      this,
    );
    screenDensity = _i1.ColumnDouble(
      'screenDensity',
      this,
    );
    cpuCores = _i1.ColumnInt(
      'cpuCores',
      this,
    );
    isPhysicalDevice = _i1.ColumnBool(
      'isPhysicalDevice',
      this,
    );
    osVersion = _i1.ColumnString(
      'osVersion',
      this,
    );
    timezone = _i1.ColumnString(
      'timezone',
      this,
    );
    language = _i1.ColumnString(
      'language',
      this,
    );
    appVersion = _i1.ColumnString(
      'appVersion',
      this,
    );
    lastIpAddress = _i1.ColumnString(
      'lastIpAddress',
      this,
    );
    userIds = _i1.ColumnString(
      'userIds',
      this,
    );
    riskScore = _i1.ColumnDouble(
      'riskScore',
      this,
    );
    riskFactors = _i1.ColumnString(
      'riskFactors',
      this,
    );
    isBlocked = _i1.ColumnBool(
      'isBlocked',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    firstSeenAt = _i1.ColumnDateTime(
      'firstSeenAt',
      this,
    );
    lastSeenAt = _i1.ColumnDateTime(
      'lastSeenAt',
      this,
    );
  }

  late final DeviceFingerprintRecordUpdateTable updateTable;

  /// Fingerprint identification
  late final _i1.ColumnString fingerprintHash;

  /// Device identifiers (can be multiple per fingerprint due to reinstalls)
  late final _i1.ColumnString deviceId;

  /// Device identifiers (can be multiple per fingerprint due to reinstalls)
  late final _i1.ColumnString deviceModel;

  /// Device identifiers (can be multiple per fingerprint due to reinstalls)
  late final _i1.ColumnString deviceBrand;

  /// Screen info
  late final _i1.ColumnInt screenWidth;

  late final _i1.ColumnInt screenHeight;

  late final _i1.ColumnDouble screenDensity;

  /// Hardware specs
  late final _i1.ColumnInt cpuCores;

  late final _i1.ColumnBool isPhysicalDevice;

  /// OS info
  late final _i1.ColumnString osVersion;

  /// Locale info
  late final _i1.ColumnString timezone;

  /// Locale info
  late final _i1.ColumnString language;

  /// App info
  late final _i1.ColumnString appVersion;

  /// Network info (captured on each check)
  late final _i1.ColumnString lastIpAddress;

  /// User associations (multi-value - stored as JSON array)
  /// These are the user IDs that have used this device
  late final _i1.ColumnString userIds;

  /// Risk assessment
  late final _i1.ColumnDouble riskScore;

  /// Risk assessment
  late final _i1.ColumnString riskFactors;

  /// Risk assessment
  late final _i1.ColumnBool isBlocked;

  /// Admin notes
  late final _i1.ColumnString notes;

  /// Timestamps
  late final _i1.ColumnDateTime firstSeenAt;

  late final _i1.ColumnDateTime lastSeenAt;

  @override
  List<_i1.Column> get columns => [
    id,
    fingerprintHash,
    deviceId,
    deviceModel,
    deviceBrand,
    screenWidth,
    screenHeight,
    screenDensity,
    cpuCores,
    isPhysicalDevice,
    osVersion,
    timezone,
    language,
    appVersion,
    lastIpAddress,
    userIds,
    riskScore,
    riskFactors,
    isBlocked,
    notes,
    firstSeenAt,
    lastSeenAt,
  ];
}

class DeviceFingerprintRecordInclude extends _i1.IncludeObject {
  DeviceFingerprintRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DeviceFingerprintRecord.t;
}

class DeviceFingerprintRecordIncludeList extends _i1.IncludeList {
  DeviceFingerprintRecordIncludeList._({
    _i1.WhereExpressionBuilder<DeviceFingerprintRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DeviceFingerprintRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DeviceFingerprintRecord.t;
}

class DeviceFingerprintRecordRepository {
  const DeviceFingerprintRecordRepository._();

  /// Returns a list of [DeviceFingerprintRecord]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<DeviceFingerprintRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DeviceFingerprintRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceFingerprintRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceFingerprintRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DeviceFingerprintRecord>(
      where: where?.call(DeviceFingerprintRecord.t),
      orderBy: orderBy?.call(DeviceFingerprintRecord.t),
      orderByList: orderByList?.call(DeviceFingerprintRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [DeviceFingerprintRecord] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<DeviceFingerprintRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DeviceFingerprintRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<DeviceFingerprintRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceFingerprintRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DeviceFingerprintRecord>(
      where: where?.call(DeviceFingerprintRecord.t),
      orderBy: orderBy?.call(DeviceFingerprintRecord.t),
      orderByList: orderByList?.call(DeviceFingerprintRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [DeviceFingerprintRecord] by its [id] or null if no such row exists.
  Future<DeviceFingerprintRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DeviceFingerprintRecord>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [DeviceFingerprintRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [DeviceFingerprintRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DeviceFingerprintRecord>> insert(
    _i1.Session session,
    List<DeviceFingerprintRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DeviceFingerprintRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DeviceFingerprintRecord] and returns the inserted row.
  ///
  /// The returned [DeviceFingerprintRecord] will have its `id` field set.
  Future<DeviceFingerprintRecord> insertRow(
    _i1.Session session,
    DeviceFingerprintRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DeviceFingerprintRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DeviceFingerprintRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DeviceFingerprintRecord>> update(
    _i1.Session session,
    List<DeviceFingerprintRecord> rows, {
    _i1.ColumnSelections<DeviceFingerprintRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DeviceFingerprintRecord>(
      rows,
      columns: columns?.call(DeviceFingerprintRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeviceFingerprintRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DeviceFingerprintRecord> updateRow(
    _i1.Session session,
    DeviceFingerprintRecord row, {
    _i1.ColumnSelections<DeviceFingerprintRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DeviceFingerprintRecord>(
      row,
      columns: columns?.call(DeviceFingerprintRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeviceFingerprintRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DeviceFingerprintRecord?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DeviceFingerprintRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DeviceFingerprintRecord>(
      id,
      columnValues: columnValues(DeviceFingerprintRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DeviceFingerprintRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DeviceFingerprintRecord>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DeviceFingerprintRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DeviceFingerprintRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceFingerprintRecordTable>? orderBy,
    _i1.OrderByListBuilder<DeviceFingerprintRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DeviceFingerprintRecord>(
      columnValues: columnValues(DeviceFingerprintRecord.t.updateTable),
      where: where(DeviceFingerprintRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeviceFingerprintRecord.t),
      orderByList: orderByList?.call(DeviceFingerprintRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DeviceFingerprintRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DeviceFingerprintRecord>> delete(
    _i1.Session session,
    List<DeviceFingerprintRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DeviceFingerprintRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DeviceFingerprintRecord].
  Future<DeviceFingerprintRecord> deleteRow(
    _i1.Session session,
    DeviceFingerprintRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DeviceFingerprintRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DeviceFingerprintRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DeviceFingerprintRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DeviceFingerprintRecord>(
      where: where(DeviceFingerprintRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DeviceFingerprintRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DeviceFingerprintRecord>(
      where: where?.call(DeviceFingerprintRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
