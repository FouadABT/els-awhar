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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'address.dart' as _i5;
import 'admin_action.dart' as _i6;
import 'admin_action_type_enum.dart' as _i7;
import 'admin_login_response.dart' as _i8;
import 'admin_user.dart' as _i9;
import 'agent_builder_converse_response.dart' as _i10;
import 'agent_builder_step.dart' as _i11;
import 'agent_stream_event.dart' as _i12;
import 'agent_stream_status.dart' as _i13;
import 'ai_agent_status.dart' as _i14;
import 'ai_agent_status_response.dart' as _i15;
import 'ai_agent_type_enum.dart' as _i16;
import 'ai_confidence_level_enum.dart' as _i17;
import 'ai_demand_hotspot.dart' as _i18;
import 'ai_demand_prediction_response.dart' as _i19;
import 'ai_driver_matching_response.dart' as _i20;
import 'ai_driver_recommendation.dart' as _i21;
import 'ai_full_request_response.dart' as _i22;
import 'ai_help_article.dart' as _i23;
import 'ai_help_search_response.dart' as _i24;
import 'ai_parsed_service_request.dart' as _i25;
import 'ai_request_concierge_response.dart' as _i26;
import 'ai_response_status_enum.dart' as _i27;
import 'app_configuration.dart' as _i28;
import 'auth_response.dart' as _i29;
import 'blocked_user.dart' as _i30;
import 'canceller_type_enum.dart' as _i31;
import 'category.dart' as _i32;
import 'chat_message.dart' as _i33;
import 'chat_participants_info.dart' as _i34;
import 'city.dart' as _i35;
import 'client_review.dart' as _i36;
import 'country.dart' as _i37;
import 'dashboard_stats.dart' as _i38;
import 'device_fingerprint_check_result.dart' as _i39;
import 'device_fingerprint_input.dart' as _i40;
import 'device_fingerprint_record.dart' as _i41;
import 'dispute.dart' as _i42;
import 'dispute_status_enum.dart' as _i43;
import 'dispute_type_enum.dart' as _i44;
import 'driver_availability_status_enum.dart' as _i45;
import 'driver_earnings_response.dart' as _i46;
import 'driver_location.dart' as _i47;
import 'driver_offer.dart' as _i48;
import 'driver_profile.dart' as _i49;
import 'driver_proposal.dart' as _i50;
import 'driver_service.dart' as _i51;
import 'driver_statistics.dart' as _i52;
import 'driver_zone.dart' as _i53;
import 'es_category_count.dart' as _i54;
import 'es_driver_hit.dart' as _i55;
import 'es_driver_search_result.dart' as _i56;
import 'es_driver_service_hit.dart' as _i57;
import 'es_driver_service_search_result.dart' as _i58;
import 'es_popular_search_term.dart' as _i59;
import 'es_popular_searches_result.dart' as _i60;
import 'es_popular_service.dart' as _i61;
import 'es_popular_services_result.dart' as _i62;
import 'es_price_stats.dart' as _i63;
import 'es_price_stats_result.dart' as _i64;
import 'es_product_hit.dart' as _i65;
import 'es_product_search_result.dart' as _i66;
import 'es_search_result.dart' as _i67;
import 'es_service_category_counts_result.dart' as _i68;
import 'es_service_hit.dart' as _i69;
import 'es_service_search_result.dart' as _i70;
import 'es_store_hit.dart' as _i71;
import 'es_store_search_result.dart' as _i72;
import 'favorite.dart' as _i73;
import 'greetings/greeting.dart' as _i74;
import 'language_enum.dart' as _i75;
import 'location.dart' as _i76;
import 'media_metadata.dart' as _i77;
import 'message_type_enum.dart' as _i78;
import 'nearby_driver.dart' as _i79;
import 'notification_type.dart' as _i80;
import 'offer_status_enum.dart' as _i81;
import 'order.dart' as _i82;
import 'order_item.dart' as _i83;
import 'order_status_enum.dart' as _i84;
import 'order_status_history.dart' as _i85;
import 'order_tracking.dart' as _i86;
import 'payment.dart' as _i87;
import 'payment_method_enum.dart' as _i88;
import 'payment_status_enum.dart' as _i89;
import 'platform_statistics.dart' as _i90;
import 'price_negotiation_status_enum.dart' as _i91;
import 'price_type_enum.dart' as _i92;
import 'product_category.dart' as _i93;
import 'promo.dart' as _i94;
import 'promo_action_type_enum.dart' as _i95;
import 'proposal_status.dart' as _i96;
import 'rating.dart' as _i97;
import 'rating_stats.dart' as _i98;
import 'rating_type_enum.dart' as _i99;
import 'recent_activity.dart' as _i100;
import 'report.dart' as _i101;
import 'report_reason_enum.dart' as _i102;
import 'report_resolution_enum.dart' as _i103;
import 'report_status_enum.dart' as _i104;
import 'reporter_type_enum.dart' as _i105;
import 'request_status.dart' as _i106;
import 'review.dart' as _i107;
import 'review_with_reviewer.dart' as _i108;
import 'search_log.dart' as _i109;
import 'service.dart' as _i110;
import 'service_analytics.dart' as _i111;
import 'service_category.dart' as _i112;
import 'service_image.dart' as _i113;
import 'service_request.dart' as _i114;
import 'service_type.dart' as _i115;
import 'shopping_item.dart' as _i116;
import 'store.dart' as _i117;
import 'store_category.dart' as _i118;
import 'store_delivery_request.dart' as _i119;
import 'store_order.dart' as _i120;
import 'store_order_chat.dart' as _i121;
import 'store_order_chat_message.dart' as _i122;
import 'store_order_item.dart' as _i123;
import 'store_order_status_enum.dart' as _i124;
import 'store_product.dart' as _i125;
import 'store_report.dart' as _i126;
import 'store_review.dart' as _i127;
import 'subscription.dart' as _i128;
import 'subscription_plan.dart' as _i129;
import 'subscription_status_enum.dart' as _i130;
import 'system_setting.dart' as _i131;
import 'transaction.dart' as _i132;
import 'transaction_status.dart' as _i133;
import 'transaction_type.dart' as _i134;
import 'trust_score_result.dart' as _i135;
import 'user.dart' as _i136;
import 'user_client.dart' as _i137;
import 'user_notification.dart' as _i138;
import 'user_response.dart' as _i139;
import 'user_role_enum.dart' as _i140;
import 'user_status_enum.dart' as _i141;
import 'vehicle_type_enum.dart' as _i142;
import 'wallet.dart' as _i143;
import 'package:awhar_server/src/generated/admin_user.dart' as _i144;
import 'package:awhar_server/src/generated/user.dart' as _i145;
import 'package:awhar_server/src/generated/driver_profile.dart' as _i146;
import 'package:awhar_server/src/generated/store.dart' as _i147;
import 'package:awhar_server/src/generated/store_order.dart' as _i148;
import 'package:awhar_server/src/generated/service_request.dart' as _i149;
import 'package:awhar_server/src/generated/transaction.dart' as _i150;
import 'package:awhar_server/src/generated/report.dart' as _i151;
import 'package:awhar_server/src/generated/recent_activity.dart' as _i152;
import 'package:awhar_server/src/generated/blocked_user.dart' as _i153;
import 'package:awhar_server/src/generated/chat_message.dart' as _i154;
import 'package:awhar_server/src/generated/country.dart' as _i155;
import 'package:awhar_server/src/generated/device_fingerprint_record.dart'
    as _i156;
import 'package:awhar_server/src/generated/driver_service.dart' as _i157;
import 'package:awhar_server/src/generated/service_image.dart' as _i158;
import 'package:awhar_server/src/generated/media_metadata.dart' as _i159;
import 'package:awhar_server/src/generated/user_notification.dart' as _i160;
import 'package:awhar_server/src/generated/driver_offer.dart' as _i161;
import 'package:awhar_server/src/generated/order.dart' as _i162;
import 'package:awhar_server/src/generated/promo.dart' as _i163;
import 'package:awhar_server/src/generated/driver_proposal.dart' as _i164;
import 'package:awhar_server/src/generated/rating.dart' as _i165;
import 'package:awhar_server/src/generated/shopping_item.dart' as _i166;
import 'package:awhar_server/src/generated/client_review.dart' as _i167;
import 'package:awhar_server/src/generated/review.dart' as _i168;
import 'package:awhar_server/src/generated/service_category.dart' as _i169;
import 'package:awhar_server/src/generated/service.dart' as _i170;
import 'package:awhar_server/src/generated/nearby_driver.dart' as _i171;
import 'package:awhar_server/src/generated/store_delivery_request.dart'
    as _i172;
import 'package:awhar_server/src/generated/store_order_chat_message.dart'
    as _i173;
import 'package:awhar_server/src/generated/store_category.dart' as _i174;
import 'package:awhar_server/src/generated/order_item.dart' as _i175;
import 'package:awhar_server/src/generated/product_category.dart' as _i176;
import 'package:awhar_server/src/generated/store_product.dart' as _i177;
import 'package:awhar_server/src/generated/store_review.dart' as _i178;
import 'package:awhar_server/src/generated/review_with_reviewer.dart' as _i179;
import 'package:awhar_server/src/generated/trust_score_result.dart' as _i180;
export 'address.dart';
export 'admin_action.dart';
export 'admin_action_type_enum.dart';
export 'admin_login_response.dart';
export 'admin_user.dart';
export 'agent_builder_converse_response.dart';
export 'agent_builder_step.dart';
export 'agent_stream_event.dart';
export 'agent_stream_status.dart';
export 'ai_agent_status.dart';
export 'ai_agent_status_response.dart';
export 'ai_agent_type_enum.dart';
export 'ai_confidence_level_enum.dart';
export 'ai_demand_hotspot.dart';
export 'ai_demand_prediction_response.dart';
export 'ai_driver_matching_response.dart';
export 'ai_driver_recommendation.dart';
export 'ai_full_request_response.dart';
export 'ai_help_article.dart';
export 'ai_help_search_response.dart';
export 'ai_parsed_service_request.dart';
export 'ai_request_concierge_response.dart';
export 'ai_response_status_enum.dart';
export 'app_configuration.dart';
export 'auth_response.dart';
export 'blocked_user.dart';
export 'canceller_type_enum.dart';
export 'category.dart';
export 'chat_message.dart';
export 'chat_participants_info.dart';
export 'city.dart';
export 'client_review.dart';
export 'country.dart';
export 'dashboard_stats.dart';
export 'device_fingerprint_check_result.dart';
export 'device_fingerprint_input.dart';
export 'device_fingerprint_record.dart';
export 'dispute.dart';
export 'dispute_status_enum.dart';
export 'dispute_type_enum.dart';
export 'driver_availability_status_enum.dart';
export 'driver_earnings_response.dart';
export 'driver_location.dart';
export 'driver_offer.dart';
export 'driver_profile.dart';
export 'driver_proposal.dart';
export 'driver_service.dart';
export 'driver_statistics.dart';
export 'driver_zone.dart';
export 'es_category_count.dart';
export 'es_driver_hit.dart';
export 'es_driver_search_result.dart';
export 'es_driver_service_hit.dart';
export 'es_driver_service_search_result.dart';
export 'es_popular_search_term.dart';
export 'es_popular_searches_result.dart';
export 'es_popular_service.dart';
export 'es_popular_services_result.dart';
export 'es_price_stats.dart';
export 'es_price_stats_result.dart';
export 'es_product_hit.dart';
export 'es_product_search_result.dart';
export 'es_search_result.dart';
export 'es_service_category_counts_result.dart';
export 'es_service_hit.dart';
export 'es_service_search_result.dart';
export 'es_store_hit.dart';
export 'es_store_search_result.dart';
export 'favorite.dart';
export 'greetings/greeting.dart';
export 'language_enum.dart';
export 'location.dart';
export 'media_metadata.dart';
export 'message_type_enum.dart';
export 'nearby_driver.dart';
export 'notification_type.dart';
export 'offer_status_enum.dart';
export 'order.dart';
export 'order_item.dart';
export 'order_status_enum.dart';
export 'order_status_history.dart';
export 'order_tracking.dart';
export 'payment.dart';
export 'payment_method_enum.dart';
export 'payment_status_enum.dart';
export 'platform_statistics.dart';
export 'price_negotiation_status_enum.dart';
export 'price_type_enum.dart';
export 'product_category.dart';
export 'promo.dart';
export 'promo_action_type_enum.dart';
export 'proposal_status.dart';
export 'rating.dart';
export 'rating_stats.dart';
export 'rating_type_enum.dart';
export 'recent_activity.dart';
export 'report.dart';
export 'report_reason_enum.dart';
export 'report_resolution_enum.dart';
export 'report_status_enum.dart';
export 'reporter_type_enum.dart';
export 'request_status.dart';
export 'review.dart';
export 'review_with_reviewer.dart';
export 'search_log.dart';
export 'service.dart';
export 'service_analytics.dart';
export 'service_category.dart';
export 'service_image.dart';
export 'service_request.dart';
export 'service_type.dart';
export 'shopping_item.dart';
export 'store.dart';
export 'store_category.dart';
export 'store_delivery_request.dart';
export 'store_order.dart';
export 'store_order_chat.dart';
export 'store_order_chat_message.dart';
export 'store_order_item.dart';
export 'store_order_status_enum.dart';
export 'store_product.dart';
export 'store_report.dart';
export 'store_review.dart';
export 'subscription.dart';
export 'subscription_plan.dart';
export 'subscription_status_enum.dart';
export 'system_setting.dart';
export 'transaction.dart';
export 'transaction_status.dart';
export 'transaction_type.dart';
export 'trust_score_result.dart';
export 'user.dart';
export 'user_client.dart';
export 'user_notification.dart';
export 'user_response.dart';
export 'user_role_enum.dart';
export 'user_status_enum.dart';
export 'vehicle_type_enum.dart';
export 'wallet.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'addresses',
      dartName: 'Address',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'addresses_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'label',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fullAddress',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'cityId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'latitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'longitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'buildingNumber',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'floor',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'apartmentNumber',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'landmark',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'instructions',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isDefault',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'addresses_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'addresses_fk_1',
          columns: ['cityId'],
          referenceTable: 'cities',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'addresses_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'addr_userId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'addr_cityId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'cityId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'addr_isDefault_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isDefault',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'admin_actions',
      dartName: 'AdminAction',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'admin_actions_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'adminUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'actionType',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:AdminActionType?',
        ),
        _i2.ColumnDefinition(
          name: 'targetType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'metadata',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'admin_actions_fk_0',
          columns: ['adminUserId'],
          referenceTable: 'admin_users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'admin_actions_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'adminact_adminUserId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'adminUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'adminact_targetType_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'targetType',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'adminact_targetId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'targetId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'adminact_createdAt_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'admin_users',
      dartName: 'AdminUser',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'admin_users_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'passwordHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'photoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'admin\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'permissions',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'lastLoginAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'lastLoginIp',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'failedLoginAttempts',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'lockedUntil',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'passwordResetToken',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'passwordResetExpiry',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'admin_users_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'admin_users_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'admin_email_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'admin_userId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'admin_role_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'role',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'admin_isActive_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'blocked_users',
      dartName: 'BlockedUser',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'blocked_users_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'blockedUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'blocked_users_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'blocked_users_fk_1',
          columns: ['blockedUserId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'blocked_users_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'blocked_user_userId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'blocked_user_blockedUserId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'blockedUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'blocked_user_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'blockedUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'categories',
      dartName: 'Category',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'categories_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'nameEn',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'nameAr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'nameFr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'nameEs',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionEn',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionAr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionFr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionEs',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'iconName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'iconUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'colorHex',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'displayOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'parentCategoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'categories_fk_0',
          columns: ['parentCategoryId'],
          referenceTable: 'categories',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'categories_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'cat_isActive_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'cat_displayOrder_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'displayOrder',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'cat_parentCategoryId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'parentCategoryId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'chat_messages',
      dartName: 'ChatMessage',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'chat_messages_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'orderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'senderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'receiverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'message',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'messageType',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:MessageType?',
        ),
        _i2.ColumnDefinition(
          name: 'attachmentUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isRead',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'readAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'firebaseId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'chat_messages_fk_0',
          columns: ['orderId'],
          referenceTable: 'orders',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'chat_messages_fk_1',
          columns: ['senderId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'chat_messages_fk_2',
          columns: ['receiverId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'chat_messages_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'chat_message_orderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'orderId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'chat_message_senderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'senderId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'chat_message_receiverId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'receiverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'chat_message_firebaseId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'firebaseId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'chat_message_createdAt_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'cities',
      dartName: 'City',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'cities_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'nameEn',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'nameAr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'nameFr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'nameEs',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'countryCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'MA\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'latitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'longitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'isPopular',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'displayOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'defaultDeliveryRadius',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '10.0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'cities_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'city_nameEn_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'nameEn',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'city_isActive_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'city_displayOrder_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'displayOrder',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'client_reviews',
      dartName: 'ClientReview',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'client_reviews_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'orderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'clientId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'rating',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'communicationRating',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'respectRating',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'paymentPromptness',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'client_reviews_fk_0',
          columns: ['orderId'],
          referenceTable: 'orders',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'client_reviews_fk_1',
          columns: ['driverId'],
          referenceTable: 'driver_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'client_reviews_fk_2',
          columns: ['clientId'],
          referenceTable: 'user_clients',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'client_reviews_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'client_review_orderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'orderId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'client_review_driverId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'client_review_clientId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'clientId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'client_review_createdAt_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'countries',
      dartName: 'Country',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'countries_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'nameAr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'nameFr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'currencyCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'currencySymbol',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'currencyName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'currencyNameAr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'vatRate',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'vatName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'VAT\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'phonePrefix',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'phonePlaceholder',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'defaultLanguage',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'en\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'minPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '15.0',
        ),
        _i2.ColumnDefinition(
          name: 'commissionRate',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.05',
        ),
        _i2.ColumnDefinition(
          name: 'exchangeRateToMAD',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '1.0',
        ),
        _i2.ColumnDefinition(
          name: 'exchangeRateUpdatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'isDefault',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'countries_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'country_code_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'country_currencyCode_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'currencyCode',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'country_isActive_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'device_fingerprint_records',
      dartName: 'DeviceFingerprintRecord',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'device_fingerprint_records_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'fingerprintHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'deviceId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'deviceModel',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'deviceBrand',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'screenWidth',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'screenHeight',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'screenDensity',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'cpuCores',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'isPhysicalDevice',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'osVersion',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'timezone',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'language',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'appVersion',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'lastIpAddress',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'userIds',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'riskScore',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'riskFactors',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isBlocked',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'firstSeenAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastSeenAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'device_fingerprint_records_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'device_fingerprint_hash_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'fingerprintHash',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_fingerprint_device_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'deviceId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_fingerprint_risk_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'riskScore',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_fingerprint_blocked_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isBlocked',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'disputes',
      dartName: 'Dispute',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'disputes_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'orderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'openedByUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'clientId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'disputeType',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:DisputeType?',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'evidenceUrls',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:DisputeStatus?',
        ),
        _i2.ColumnDefinition(
          name: 'resolution',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedByAdminId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'refundAmount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'refundIssued',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'disputes_fk_0',
          columns: ['orderId'],
          referenceTable: 'orders',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'disputes_fk_1',
          columns: ['openedByUserId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'disputes_fk_2',
          columns: ['clientId'],
          referenceTable: 'user_clients',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'disputes_fk_3',
          columns: ['driverId'],
          referenceTable: 'driver_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'disputes_fk_4',
          columns: ['resolvedByAdminId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'disputes_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'disp_orderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'orderId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'disp_openedByUserId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'openedByUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'disp_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'disp_createdAt_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'driver_offers',
      dartName: 'DriverOffer',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'driver_offers_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'orderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'offeredPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'message',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:OfferStatus?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'respondedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'driver_offers_fk_0',
          columns: ['orderId'],
          referenceTable: 'orders',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'driver_offers_fk_1',
          columns: ['driverId'],
          referenceTable: 'driver_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'driver_offers_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'driver_offer_orderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'orderId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'driver_offer_driverId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'driver_offer_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'driver_offer_createdAt_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'driver_offer_order_driver_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'orderId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'driver_profiles',
      dartName: 'DriverProfile',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'driver_profiles_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'displayName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'bio',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'profilePhotoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'vehicleType',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:VehicleType?',
        ),
        _i2.ColumnDefinition(
          name: 'vehicleMake',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'vehicleModel',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'vehiclePlate',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'vehicleYear',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'vehiclePhotoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'experienceYears',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'availabilityStatus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:DriverAvailabilityStatus?',
        ),
        _i2.ColumnDefinition(
          name: 'baseCityId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'isOnline',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'lastLocationLat',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'lastLocationLng',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'lastLocationUpdatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'autoOfflineAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'ratingAverage',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'ratingCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'isVerified',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'isDocumentsSubmitted',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'isFeatured',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'isPremium',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'premiumUntil',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'totalCompletedOrders',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'totalEarnings',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'verifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'driver_profiles_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'driver_profiles_fk_1',
          columns: ['baseCityId'],
          referenceTable: 'cities',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'driver_profiles_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'driver_userId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'driver_ratingAverage_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'ratingAverage',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'driver_isFeatured_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isFeatured',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'driver_availabilityStatus_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'availabilityStatus',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'driver_baseCityId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'baseCityId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'driver_proposals',
      dartName: 'DriverProposal',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'driver_proposals_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'requestId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'proposedPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'estimatedArrival',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'message',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'driverName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'driverPhone',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'driverRating',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'driverVehicleInfo',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ProposalStatus',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'acceptedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'rejectedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'driver_proposals_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'proposal_requestId_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'requestId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'proposal_driverId_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'proposal_status_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'proposal_requestId_status_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'requestId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'driver_services',
      dartName: 'DriverService',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'driver_services_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'serviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'categoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'priceType',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:PriceType?',
        ),
        _i2.ColumnDefinition(
          name: 'basePrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'pricePerKm',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'pricePerHour',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'minPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'customDescription',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'viewCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'inquiryCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'bookingCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'isAvailable',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'availableFrom',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'availableUntil',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'displayOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'driver_services_fk_0',
          columns: ['driverId'],
          referenceTable: 'driver_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'driver_services_fk_1',
          columns: ['serviceId'],
          referenceTable: 'services',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'driver_services_fk_2',
          columns: ['categoryId'],
          referenceTable: 'service_categories',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'driver_services_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'drv_svc_driverId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'drv_svc_serviceId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'serviceId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'drv_svc_isActive_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'drv_svc_driver_service_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'serviceId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'driver_statistics',
      dartName: 'DriverStatistics',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'driver_statistics_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'periodType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'periodStart',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'periodEnd',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'totalOrders',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'completedOrders',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'cancelledOrders',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'totalRevenue',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'platformCommission',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'netRevenue',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'averageRating',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'averageResponseTime',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'averageCompletionTime',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'hoursOnline',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'hoursOffline',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'driver_statistics_fk_0',
          columns: ['driverId'],
          referenceTable: 'driver_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'driver_statistics_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'drv_stats_driverId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'drv_stats_periodType_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'periodType',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'drv_stats_periodStart_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'periodStart',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'driver_zones',
      dartName: 'DriverZone',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'driver_zones_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'zoneName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'cityId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'geoBoundary',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'centerLatitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'centerLongitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'radiusKm',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '5.0',
        ),
        _i2.ColumnDefinition(
          name: 'extraFeeOutsideZone',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'isPrimary',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'driver_zones_fk_0',
          columns: ['driverId'],
          referenceTable: 'driver_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'driver_zones_fk_1',
          columns: ['cityId'],
          referenceTable: 'cities',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'driver_zones_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'drv_zone_driverId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'drv_zone_cityId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'cityId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'drv_zone_isPrimary_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isPrimary',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'drv_zone_isActive_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'favorites',
      dartName: 'Favorite',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'favorites_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'clientId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'favorites_fk_0',
          columns: ['clientId'],
          referenceTable: 'user_clients',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'favorites_fk_1',
          columns: ['driverId'],
          referenceTable: 'driver_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'favorites_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'fav_clientId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'clientId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'fav_driverId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'fav_client_driver_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'clientId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'media_metadata',
      dartName: 'MediaMetadata',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'media_metadata_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'messageId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'requestId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'mediaUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'mediaType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fileName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fileSizeBytes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'durationMs',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'thumbnailUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'downloadCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'lastAccessedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'uploadedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'media_metadata_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'media_metadata_fk_1',
          columns: ['requestId'],
          referenceTable: 'service_requests',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'media_metadata_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'order_status_history',
      dartName: 'OrderStatusHistory',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'order_status_history_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'orderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'fromStatus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:OrderStatus?',
        ),
        _i2.ColumnDefinition(
          name: 'toStatus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:OrderStatus?',
        ),
        _i2.ColumnDefinition(
          name: 'changedByUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'order_status_history_fk_0',
          columns: ['orderId'],
          referenceTable: 'orders',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'order_status_history_fk_1',
          columns: ['changedByUserId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'order_status_history_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'order_hist_orderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'orderId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'order_hist_createdAt_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'order_tracking',
      dartName: 'OrderTracking',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'order_tracking_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'orderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'latitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'longitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'accuracy',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'speed',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'heading',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'recordedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'order_tracking_fk_0',
          columns: ['orderId'],
          referenceTable: 'orders',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'order_tracking_fk_1',
          columns: ['driverId'],
          referenceTable: 'driver_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'order_tracking_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'track_orderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'orderId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'track_recordedAt_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'recordedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'orders',
      dartName: 'Order',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'orders_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'clientId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'serviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'pickupAddressId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'dropoffAddressId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'pickupLatitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'pickupLongitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'pickupAddress',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'dropoffLatitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'dropoffLongitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'dropoffAddress',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'estimatedDistanceKm',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'estimatedPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'agreedPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'finalPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'currency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'MAD\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'currencySymbol',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'DH\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'clientProposedPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'driverCounterPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'priceNegotiationStatus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:PriceNegotiationStatus?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'clientInstructions',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:OrderStatus?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'acceptedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'cancelledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'cancellationReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'cancelledByUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'cancelledBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:CancellerType?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'orders_fk_0',
          columns: ['clientId'],
          referenceTable: 'user_clients',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'orders_fk_1',
          columns: ['driverId'],
          referenceTable: 'driver_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'orders_fk_2',
          columns: ['serviceId'],
          referenceTable: 'services',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'orders_fk_3',
          columns: ['pickupAddressId'],
          referenceTable: 'addresses',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'orders_fk_4',
          columns: ['dropoffAddressId'],
          referenceTable: 'addresses',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'orders_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'order_clientId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'clientId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'order_driverId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'order_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'order_createdAt_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'payments',
      dartName: 'Payment',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'payments_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'subscriptionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'orderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'currency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'MAD\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'paymentMethod',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:PaymentMethod?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:PaymentStatus?',
        ),
        _i2.ColumnDefinition(
          name: 'externalTransactionId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'metadata',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'failureReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'paidAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'refundedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'payments_fk_0',
          columns: ['subscriptionId'],
          referenceTable: 'subscriptions',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'payments_fk_1',
          columns: ['orderId'],
          referenceTable: 'orders',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'payments_fk_2',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'payments_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'pay_subscriptionId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'subscriptionId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'pay_orderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'orderId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'pay_userId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'pay_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'pay_externalTransactionId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'externalTransactionId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'platform_statistics',
      dartName: 'PlatformStatistics',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'platform_statistics_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'periodType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'periodStart',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'periodEnd',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'totalUsers',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'newUsers',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'activeUsers',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'totalDrivers',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'newDrivers',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'activeDrivers',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'verifiedDrivers',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'totalOrders',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'completedOrders',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'cancelledOrders',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'disputedOrders',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'totalRevenue',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'platformRevenue',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'subscriptionRevenue',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'averageOrdersPerUser',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'averageOrderValue',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'platform_statistics_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'plat_stats_periodType_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'periodType',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'plat_stats_periodStart_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'periodStart',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'product_categories',
      dartName: 'ProductCategory',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'product_categories_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'storeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'displayOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'product_categories_fk_0',
          columns: ['storeId'],
          referenceTable: 'stores',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'product_categories_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'prod_cat_storeId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'prod_cat_displayOrder_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'displayOrder',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'promos',
      dartName: 'Promo',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'promos_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'titleEn',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'titleAr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'titleFr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'titleEs',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionEn',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionAr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionFr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionEs',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetRoles',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'actionType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'none\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'actionValue',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'priority',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'startDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'endDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'viewCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'clickCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'promos_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'promo_active_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'promo_dates_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'startDate',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'endDate',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'promo_priority_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'priority',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'ratings',
      dartName: 'Rating',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'ratings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'requestId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'raterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'ratedUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'ratingValue',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'ratingType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RatingType',
        ),
        _i2.ColumnDefinition(
          name: 'reviewText',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'quickTags',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ratings_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'rating_requestId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'requestId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'rating_raterId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'raterId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'rating_ratedUserId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'ratedUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'rating_ratingType_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'ratingType',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'rating_request_rater_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'requestId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'raterId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'reports',
      dartName: 'Report',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'reports_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'reportedByUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reporterType',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:ReporterType?',
        ),
        _i2.ColumnDefinition(
          name: 'reportedDriverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'reportedClientId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'reportedStoreId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'reportedOrderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'reportedType',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:ReporterType?',
        ),
        _i2.ColumnDefinition(
          name: 'reportReason',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:ReportReason?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'evidenceUrls',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:ReportStatus?',
        ),
        _i2.ColumnDefinition(
          name: 'resolution',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:ReportResolution?',
        ),
        _i2.ColumnDefinition(
          name: 'reviewedByAdminId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'reviewNotes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'adminNotes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'reviewedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'reports_fk_0',
          columns: ['reportedByUserId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'reports_fk_1',
          columns: ['reportedDriverId'],
          referenceTable: 'driver_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'reports_fk_2',
          columns: ['reportedClientId'],
          referenceTable: 'user_clients',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'reports_fk_3',
          columns: ['reportedStoreId'],
          referenceTable: 'stores',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'reports_fk_4',
          columns: ['reportedOrderId'],
          referenceTable: 'orders',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'reports_fk_5',
          columns: ['reviewedByAdminId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'reports_fk_6',
          columns: ['resolvedBy'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'reports_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'report_reportedByUserId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'reportedByUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'report_reportedDriverId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'reportedDriverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'report_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'report_createdAt_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'reviews',
      dartName: 'Review',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'reviews_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'orderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'clientId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'rating',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isVisible',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'isVerified',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'isFlagged',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'flagReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'flaggedByUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'flaggedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'driverResponse',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'driverRespondedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'reviews_fk_0',
          columns: ['orderId'],
          referenceTable: 'orders',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'reviews_fk_1',
          columns: ['driverId'],
          referenceTable: 'driver_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'reviews_fk_2',
          columns: ['clientId'],
          referenceTable: 'user_clients',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'reviews_fk_3',
          columns: ['flaggedByUserId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'reviews_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'rev_orderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'orderId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'rev_driverId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'rev_clientId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'clientId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'rev_rating_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'rating',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'rev_isVisible_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isVisible',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'rev_createdAt_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'search_logs',
      dartName: 'SearchLog',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'search_logs_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'searchText',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'cityId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'categoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'resultsCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'clickedDriverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sessionId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'deviceType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'search_logs_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'search_logs_fk_1',
          columns: ['cityId'],
          referenceTable: 'cities',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'search_logs_fk_2',
          columns: ['categoryId'],
          referenceTable: 'categories',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'search_logs_fk_3',
          columns: ['clickedDriverId'],
          referenceTable: 'driver_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'search_logs_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'search_userId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'search_cityId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'cityId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'search_createdAt_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'service_analytics',
      dartName: 'ServiceAnalytics',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'service_analytics_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'driverServiceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'totalViews',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'uniqueViews',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'lastViewedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'totalInquiries',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'totalBookings',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'conversionRate',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'averageResponseTime',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'completionRate',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'service_analytics_fk_0',
          columns: ['driverServiceId'],
          referenceTable: 'driver_services',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'service_analytics_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'svc_analytics_driverServiceId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverServiceId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'svc_analytics_totalViews_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'totalViews',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'svc_analytics_totalBookings_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'totalBookings',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'service_categories',
      dartName: 'ServiceCategory',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'service_categories_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'nameAr',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'nameFr',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'nameEs',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'icon',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'displayOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'defaultRadiusKm',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '10.0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'service_categories_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'service_category_name_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'service_category_isActive_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'service_category_displayOrder_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'displayOrder',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'service_images',
      dartName: 'ServiceImage',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'service_images_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'driverServiceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'thumbnailUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'displayOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'caption',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'fileSize',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'width',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'height',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'service_images_fk_0',
          columns: ['driverServiceId'],
          referenceTable: 'driver_services',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'service_images_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'svc_img_driverServiceId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverServiceId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'svc_img_displayOrder_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverServiceId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'displayOrder',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'service_requests',
      dartName: 'ServiceRequest',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'service_requests_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'clientId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'proposedDriverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'serviceType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ServiceType',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RequestStatus',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'pickupLocation',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:Location?',
        ),
        _i2.ColumnDefinition(
          name: 'destinationLocation',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:Location',
        ),
        _i2.ColumnDefinition(
          name: 'basePrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'distancePrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'totalPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'estimatedPurchaseCost',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryFee',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'distance',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'estimatedDuration',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'currency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'MAD\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'currencySymbol',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'DH\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'clientOfferedPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'driverCounterPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'agreedPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'negotiationStatus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:PriceNegotiationStatus?',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'isPaid',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'itemDescription',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'recipientName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'recipientPhone',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'specialInstructions',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'packageSize',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isFragile',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'isPurchaseRequired',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'shoppingList',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ShoppingItem>?',
        ),
        _i2.ColumnDefinition(
          name: 'attachments',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'catalogServiceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'catalogDriverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'clientName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'clientPhone',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'driverName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'driverPhone',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'proposedDriverName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'proposedDriverPhone',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'cancelledBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'cancellationReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'deviceFingerprint',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'acceptedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'driverArrivingAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'cancelledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'service_requests_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'clientId_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'clientId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'driverId_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'status_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'createdAt_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'services',
      dartName: 'Service',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'services_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'categoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'nameEn',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'nameAr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'nameFr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'nameEs',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionEn',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionAr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionFr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionEs',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'iconName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'suggestedPriceMin',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'suggestedPriceMax',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'displayOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'isPopular',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'services_fk_0',
          columns: ['categoryId'],
          referenceTable: 'categories',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'services_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'svc_categoryId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'categoryId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'svc_isActive_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'svc_displayOrder_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'displayOrder',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'svc_isPopular_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isPopular',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'store_categories',
      dartName: 'StoreCategory',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'store_categories_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'nameEn',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'nameAr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'nameFr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'nameEs',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionEn',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionAr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionFr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionEs',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'iconName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'iconUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'colorHex',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'displayOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'store_categories_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'store_cat_isActive_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_cat_displayOrder_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'displayOrder',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'store_delivery_requests',
      dartName: 'StoreDeliveryRequest',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'store_delivery_requests_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'storeOrderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'storeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'requestType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetDriverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'pickupAddress',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'pickupLatitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'pickupLongitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryAddress',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryLatitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryLongitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'distanceKm',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryFee',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'driverEarnings',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'assignedDriverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'acceptedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'rejectedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'store_delivery_requests_fk_0',
          columns: ['storeOrderId'],
          referenceTable: 'store_orders',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'store_delivery_requests_fk_1',
          columns: ['storeId'],
          referenceTable: 'stores',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'store_delivery_requests_fk_2',
          columns: ['targetDriverId'],
          referenceTable: 'driver_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'store_delivery_requests_fk_3',
          columns: ['assignedDriverId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'store_delivery_requests_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'store_del_req_orderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeOrderId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_del_req_storeId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_del_req_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_del_req_targetDriverId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'targetDriverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_del_req_location_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'pickupLatitude',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'pickupLongitude',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'store_order_chat_messages',
      dartName: 'StoreOrderChatMessage',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'store_order_chat_messages_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'chatId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'senderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'senderRole',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'senderName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'messageType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'text\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'content',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'attachmentUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'latitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'longitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'readByJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'firebaseId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'store_order_chat_messages_fk_0',
          columns: ['chatId'],
          referenceTable: 'store_order_chats',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'store_order_chat_messages_fk_1',
          columns: ['senderId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'store_order_chat_messages_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'store_chat_msg_chatId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'chatId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_chat_msg_senderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'senderId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_chat_msg_createdAt_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_chat_msg_firebaseId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'firebaseId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'store_order_chats',
      dartName: 'StoreOrderChat',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'store_order_chats_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'storeOrderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'clientId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'storeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'firebaseChannelId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'store_order_chats_fk_0',
          columns: ['storeOrderId'],
          referenceTable: 'store_orders',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'store_order_chats_fk_1',
          columns: ['clientId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'store_order_chats_fk_2',
          columns: ['storeId'],
          referenceTable: 'stores',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'store_order_chats_fk_3',
          columns: ['driverId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'store_order_chats_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'store_order_chat_orderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeOrderId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_order_chat_clientId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'clientId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_order_chat_storeId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_order_chat_driverId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'store_order_items',
      dartName: 'StoreOrderItem',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'store_order_items_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'storeOrderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'productId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'productName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'productPrice',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'productImageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'itemTotal',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'store_order_items_fk_0',
          columns: ['storeOrderId'],
          referenceTable: 'store_orders',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'store_order_items_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'store_order_item_orderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeOrderId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'store_orders',
      dartName: 'StoreOrder',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'store_orders_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'orderNumber',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'storeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'clientId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:StoreOrderStatus',
        ),
        _i2.ColumnDefinition(
          name: 'itemsJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'subtotal',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryFee',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'total',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'currency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'MAD\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'currencySymbol',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'DH\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'platformCommission',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'driverEarnings',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryAddress',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryLatitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryLongitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryDistance',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'clientNotes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'storeNotes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'timelineJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'chatId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'cancelledBy',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'cancellationReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'confirmedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'readyAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'pickedUpAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'deliveredAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'cancelledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'store_orders_fk_0',
          columns: ['storeId'],
          referenceTable: 'stores',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'store_orders_fk_1',
          columns: ['clientId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'store_orders_fk_2',
          columns: ['driverId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'store_orders_fk_3',
          columns: ['chatId'],
          referenceTable: 'store_order_chats',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'store_orders_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'store_order_number_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'orderNumber',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_order_storeId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_order_clientId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'clientId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_order_driverId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_order_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_order_createdAt_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'store_products',
      dartName: 'StoreProduct',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'store_products_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'storeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'productCategoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'price',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isAvailable',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'displayOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'store_products_fk_0',
          columns: ['storeId'],
          referenceTable: 'stores',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'store_products_fk_1',
          columns: ['productCategoryId'],
          referenceTable: 'product_categories',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'store_products_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'store_prod_storeId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_prod_categoryId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'productCategoryId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_prod_isAvailable_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isAvailable',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_prod_displayOrder_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'displayOrder',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'store_reports',
      dartName: 'StoreReport',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'store_reports_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'storeOrderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'reporterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reporterType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'reportedType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'reportedId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'evidenceUrls',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'resolution',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'store_reports_fk_0',
          columns: ['storeOrderId'],
          referenceTable: 'store_orders',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'store_reports_fk_1',
          columns: ['reporterId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'store_reports_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'store_report_orderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeOrderId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_report_reporterId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'reporterId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_report_reportedType_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'reportedType',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'reportedId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_report_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'store_reviews',
      dartName: 'StoreReview',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'store_reviews_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'storeOrderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reviewerId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'revieweeType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'revieweeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'rating',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'comment',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'response',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'responseAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'store_reviews_fk_0',
          columns: ['storeOrderId'],
          referenceTable: 'store_orders',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'store_reviews_fk_1',
          columns: ['reviewerId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'store_reviews_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'store_review_orderId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeOrderId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_review_reviewerId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'reviewerId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_review_revieweeType_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'revieweeType',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'revieweeId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_review_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeOrderId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'reviewerId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'revieweeType',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'stores',
      dartName: 'Store',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'stores_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'storeCategoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'phone',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'whatsappNumber',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'websiteUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'facebookUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'instagramUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'aboutText',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'tagline',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'logoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'coverImageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'galleryImages',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'address',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'latitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'longitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'city',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryRadiusKm',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '5.0',
        ),
        _i2.ColumnDefinition(
          name: 'minimumOrderAmount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'estimatedPrepTimeMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '30',
        ),
        _i2.ColumnDefinition(
          name: 'acceptsCash',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'acceptsCard',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'hasDelivery',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'hasPickup',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'workingHours',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'isOpen',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'totalOrders',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'rating',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'totalRatings',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'stores_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'stores_fk_1',
          columns: ['storeCategoryId'],
          referenceTable: 'store_categories',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'stores_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'store_userId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_categoryId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'storeCategoryId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_isActive_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_isOpen_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isOpen',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'store_location_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'latitude',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'longitude',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subscription_plans',
      dartName: 'SubscriptionPlan',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subscription_plans_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'nameEn',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'nameAr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'nameFr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'nameEs',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionEn',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionAr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionFr',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'descriptionEs',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'priceAmount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'currency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'MAD\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'durationMonths',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'features',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'isFeatured',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'displayOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'commissionRate',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'priorityListing',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'badgeEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subscription_plans_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'plan_isActive_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isActive',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'plan_displayOrder_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'displayOrder',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subscriptions',
      dartName: 'Subscription',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subscriptions_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'driverId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'planId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'startDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:SubscriptionStatus?',
        ),
        _i2.ColumnDefinition(
          name: 'autoRenew',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'cancelledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'cancellationReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subscriptions_fk_0',
          columns: ['driverId'],
          referenceTable: 'driver_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'subscriptions_fk_1',
          columns: ['planId'],
          referenceTable: 'subscription_plans',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subscriptions_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'sub_driverId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'driverId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'sub_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'sub_endDate_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'endDate',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'system_settings',
      dartName: 'SystemSetting',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'system_settings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'key',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'system_settings_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'key',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'transactions',
      dartName: 'Transaction',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'transactions_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'requestId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TransactionType',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TransactionStatus',
          columnDefault: '\'completed\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'paymentMethod',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'cash\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'currency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'MAD\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'currencySymbol',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'DH\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'baseCurrencyAmount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'exchangeRateToBase',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '1.0',
        ),
        _i2.ColumnDefinition(
          name: 'vatRate',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'vatAmount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'platformCommission',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'driverEarnings',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'driverConfirmed',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'clientConfirmed',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'driverConfirmedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'clientConfirmedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'refundedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'transactions_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'transaction_userId_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'transaction_requestId_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'requestId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'transaction_type_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'type',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'transaction_status_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'transaction_createdAt_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'transaction_userId_createdAt_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_clients',
      dartName: 'UserClient',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_clients_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'defaultAddressId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'defaultCityId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'totalOrders',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_clients_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'user_clients_fk_1',
          columns: ['defaultAddressId'],
          referenceTable: 'addresses',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'user_clients_fk_2',
          columns: ['defaultCityId'],
          referenceTable: 'cities',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_clients_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'uclient_userId_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_notifications',
      dartName: 'UserNotification',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_notifications_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'body',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:NotificationType',
        ),
        _i2.ColumnDefinition(
          name: 'relatedEntityId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'relatedEntityType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'dataJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isRead',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'readAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_notifications_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_notifications_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'users',
      dartName: 'User',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'users_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'firebaseUid',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fullName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'phoneNumber',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'profilePhotoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'roles',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:UserRole>',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:UserStatus?',
        ),
        _i2.ColumnDefinition(
          name: 'isOnline',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'isPhoneVerified',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'isEmailVerified',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'rating',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'totalRatings',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'totalRatingsAsClient',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'ratingAsClient',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'vehicleInfo',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'vehiclePlate',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'averageRating',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'totalTrips',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'currentLatitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'currentLongitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'lastLocationUpdate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'preferredLanguage',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:Language?',
        ),
        _i2.ColumnDefinition(
          name: 'notificationsEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'darkModeEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'fcmToken',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isSuspended',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'suspendedUntil',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'suspensionReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'totalReportsReceived',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'totalReportsMade',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'trustScore',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'trustLevel',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
          columnDefault: '\'FAIR\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'trustScoreUpdatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'lastSeenAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'deletedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'users_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'firebaseUid_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'firebaseUid',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'email_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'phoneNumber_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'phoneNumber',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'user_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'wallets',
      dartName: 'Wallet',
      schema: 'public',
      module: 'awhar',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'wallets_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'totalEarned',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'totalSpent',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'pendingEarnings',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'totalTransactions',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'completedRides',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'totalCommissionPaid',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.0',
        ),
        _i2.ColumnDefinition(
          name: 'currency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'MAD\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'lastTransactionAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'wallets_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'wallet_userId_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.Address) {
      return _i5.Address.fromJson(data) as T;
    }
    if (t == _i6.AdminAction) {
      return _i6.AdminAction.fromJson(data) as T;
    }
    if (t == _i7.AdminActionType) {
      return _i7.AdminActionType.fromJson(data) as T;
    }
    if (t == _i8.AdminLoginResponse) {
      return _i8.AdminLoginResponse.fromJson(data) as T;
    }
    if (t == _i9.AdminUser) {
      return _i9.AdminUser.fromJson(data) as T;
    }
    if (t == _i10.AgentBuilderConverseResponse) {
      return _i10.AgentBuilderConverseResponse.fromJson(data) as T;
    }
    if (t == _i11.AgentBuilderStep) {
      return _i11.AgentBuilderStep.fromJson(data) as T;
    }
    if (t == _i12.AgentStreamEvent) {
      return _i12.AgentStreamEvent.fromJson(data) as T;
    }
    if (t == _i13.AgentStreamStatus) {
      return _i13.AgentStreamStatus.fromJson(data) as T;
    }
    if (t == _i14.AiAgentStatus) {
      return _i14.AiAgentStatus.fromJson(data) as T;
    }
    if (t == _i15.AiAgentStatusResponse) {
      return _i15.AiAgentStatusResponse.fromJson(data) as T;
    }
    if (t == _i16.AiAgentType) {
      return _i16.AiAgentType.fromJson(data) as T;
    }
    if (t == _i17.AiConfidenceLevel) {
      return _i17.AiConfidenceLevel.fromJson(data) as T;
    }
    if (t == _i18.AiDemandHotspot) {
      return _i18.AiDemandHotspot.fromJson(data) as T;
    }
    if (t == _i19.AiDemandPredictionResponse) {
      return _i19.AiDemandPredictionResponse.fromJson(data) as T;
    }
    if (t == _i20.AiDriverMatchingResponse) {
      return _i20.AiDriverMatchingResponse.fromJson(data) as T;
    }
    if (t == _i21.AiDriverRecommendation) {
      return _i21.AiDriverRecommendation.fromJson(data) as T;
    }
    if (t == _i22.AiFullRequestResponse) {
      return _i22.AiFullRequestResponse.fromJson(data) as T;
    }
    if (t == _i23.AiHelpArticle) {
      return _i23.AiHelpArticle.fromJson(data) as T;
    }
    if (t == _i24.AiHelpSearchResponse) {
      return _i24.AiHelpSearchResponse.fromJson(data) as T;
    }
    if (t == _i25.AiParsedServiceRequest) {
      return _i25.AiParsedServiceRequest.fromJson(data) as T;
    }
    if (t == _i26.AiRequestConciergeResponse) {
      return _i26.AiRequestConciergeResponse.fromJson(data) as T;
    }
    if (t == _i27.AiResponseStatus) {
      return _i27.AiResponseStatus.fromJson(data) as T;
    }
    if (t == _i28.AppConfiguration) {
      return _i28.AppConfiguration.fromJson(data) as T;
    }
    if (t == _i29.AuthResponse) {
      return _i29.AuthResponse.fromJson(data) as T;
    }
    if (t == _i30.BlockedUser) {
      return _i30.BlockedUser.fromJson(data) as T;
    }
    if (t == _i31.CancellerType) {
      return _i31.CancellerType.fromJson(data) as T;
    }
    if (t == _i32.Category) {
      return _i32.Category.fromJson(data) as T;
    }
    if (t == _i33.ChatMessage) {
      return _i33.ChatMessage.fromJson(data) as T;
    }
    if (t == _i34.ChatParticipantsInfo) {
      return _i34.ChatParticipantsInfo.fromJson(data) as T;
    }
    if (t == _i35.City) {
      return _i35.City.fromJson(data) as T;
    }
    if (t == _i36.ClientReview) {
      return _i36.ClientReview.fromJson(data) as T;
    }
    if (t == _i37.Country) {
      return _i37.Country.fromJson(data) as T;
    }
    if (t == _i38.DashboardStats) {
      return _i38.DashboardStats.fromJson(data) as T;
    }
    if (t == _i39.DeviceFingerprintCheckResult) {
      return _i39.DeviceFingerprintCheckResult.fromJson(data) as T;
    }
    if (t == _i40.DeviceFingerprintInput) {
      return _i40.DeviceFingerprintInput.fromJson(data) as T;
    }
    if (t == _i41.DeviceFingerprintRecord) {
      return _i41.DeviceFingerprintRecord.fromJson(data) as T;
    }
    if (t == _i42.Dispute) {
      return _i42.Dispute.fromJson(data) as T;
    }
    if (t == _i43.DisputeStatus) {
      return _i43.DisputeStatus.fromJson(data) as T;
    }
    if (t == _i44.DisputeType) {
      return _i44.DisputeType.fromJson(data) as T;
    }
    if (t == _i45.DriverAvailabilityStatus) {
      return _i45.DriverAvailabilityStatus.fromJson(data) as T;
    }
    if (t == _i46.DriverEarningsResponse) {
      return _i46.DriverEarningsResponse.fromJson(data) as T;
    }
    if (t == _i47.DriverLocation) {
      return _i47.DriverLocation.fromJson(data) as T;
    }
    if (t == _i48.DriverOffer) {
      return _i48.DriverOffer.fromJson(data) as T;
    }
    if (t == _i49.DriverProfile) {
      return _i49.DriverProfile.fromJson(data) as T;
    }
    if (t == _i50.DriverProposal) {
      return _i50.DriverProposal.fromJson(data) as T;
    }
    if (t == _i51.DriverService) {
      return _i51.DriverService.fromJson(data) as T;
    }
    if (t == _i52.DriverStatistics) {
      return _i52.DriverStatistics.fromJson(data) as T;
    }
    if (t == _i53.DriverZone) {
      return _i53.DriverZone.fromJson(data) as T;
    }
    if (t == _i54.EsCategoryCount) {
      return _i54.EsCategoryCount.fromJson(data) as T;
    }
    if (t == _i55.EsDriverHit) {
      return _i55.EsDriverHit.fromJson(data) as T;
    }
    if (t == _i56.EsDriverSearchResult) {
      return _i56.EsDriverSearchResult.fromJson(data) as T;
    }
    if (t == _i57.EsDriverServiceHit) {
      return _i57.EsDriverServiceHit.fromJson(data) as T;
    }
    if (t == _i58.EsDriverServiceSearchResult) {
      return _i58.EsDriverServiceSearchResult.fromJson(data) as T;
    }
    if (t == _i59.EsPopularSearchTerm) {
      return _i59.EsPopularSearchTerm.fromJson(data) as T;
    }
    if (t == _i60.EsPopularSearchesResult) {
      return _i60.EsPopularSearchesResult.fromJson(data) as T;
    }
    if (t == _i61.EsPopularService) {
      return _i61.EsPopularService.fromJson(data) as T;
    }
    if (t == _i62.EsPopularServicesResult) {
      return _i62.EsPopularServicesResult.fromJson(data) as T;
    }
    if (t == _i63.EsPriceStats) {
      return _i63.EsPriceStats.fromJson(data) as T;
    }
    if (t == _i64.EsPriceStatsResult) {
      return _i64.EsPriceStatsResult.fromJson(data) as T;
    }
    if (t == _i65.EsProductHit) {
      return _i65.EsProductHit.fromJson(data) as T;
    }
    if (t == _i66.EsProductSearchResult) {
      return _i66.EsProductSearchResult.fromJson(data) as T;
    }
    if (t == _i67.EsSearchResult) {
      return _i67.EsSearchResult.fromJson(data) as T;
    }
    if (t == _i68.EsServiceCategoryCountsResult) {
      return _i68.EsServiceCategoryCountsResult.fromJson(data) as T;
    }
    if (t == _i69.EsServiceHit) {
      return _i69.EsServiceHit.fromJson(data) as T;
    }
    if (t == _i70.EsServiceSearchResult) {
      return _i70.EsServiceSearchResult.fromJson(data) as T;
    }
    if (t == _i71.EsStoreHit) {
      return _i71.EsStoreHit.fromJson(data) as T;
    }
    if (t == _i72.EsStoreSearchResult) {
      return _i72.EsStoreSearchResult.fromJson(data) as T;
    }
    if (t == _i73.Favorite) {
      return _i73.Favorite.fromJson(data) as T;
    }
    if (t == _i74.Greeting) {
      return _i74.Greeting.fromJson(data) as T;
    }
    if (t == _i75.Language) {
      return _i75.Language.fromJson(data) as T;
    }
    if (t == _i76.Location) {
      return _i76.Location.fromJson(data) as T;
    }
    if (t == _i77.MediaMetadata) {
      return _i77.MediaMetadata.fromJson(data) as T;
    }
    if (t == _i78.MessageType) {
      return _i78.MessageType.fromJson(data) as T;
    }
    if (t == _i79.NearbyDriver) {
      return _i79.NearbyDriver.fromJson(data) as T;
    }
    if (t == _i80.NotificationType) {
      return _i80.NotificationType.fromJson(data) as T;
    }
    if (t == _i81.OfferStatus) {
      return _i81.OfferStatus.fromJson(data) as T;
    }
    if (t == _i82.Order) {
      return _i82.Order.fromJson(data) as T;
    }
    if (t == _i83.OrderItem) {
      return _i83.OrderItem.fromJson(data) as T;
    }
    if (t == _i84.OrderStatus) {
      return _i84.OrderStatus.fromJson(data) as T;
    }
    if (t == _i85.OrderStatusHistory) {
      return _i85.OrderStatusHistory.fromJson(data) as T;
    }
    if (t == _i86.OrderTracking) {
      return _i86.OrderTracking.fromJson(data) as T;
    }
    if (t == _i87.Payment) {
      return _i87.Payment.fromJson(data) as T;
    }
    if (t == _i88.PaymentMethod) {
      return _i88.PaymentMethod.fromJson(data) as T;
    }
    if (t == _i89.PaymentStatus) {
      return _i89.PaymentStatus.fromJson(data) as T;
    }
    if (t == _i90.PlatformStatistics) {
      return _i90.PlatformStatistics.fromJson(data) as T;
    }
    if (t == _i91.PriceNegotiationStatus) {
      return _i91.PriceNegotiationStatus.fromJson(data) as T;
    }
    if (t == _i92.PriceType) {
      return _i92.PriceType.fromJson(data) as T;
    }
    if (t == _i93.ProductCategory) {
      return _i93.ProductCategory.fromJson(data) as T;
    }
    if (t == _i94.Promo) {
      return _i94.Promo.fromJson(data) as T;
    }
    if (t == _i95.PromoActionType) {
      return _i95.PromoActionType.fromJson(data) as T;
    }
    if (t == _i96.ProposalStatus) {
      return _i96.ProposalStatus.fromJson(data) as T;
    }
    if (t == _i97.Rating) {
      return _i97.Rating.fromJson(data) as T;
    }
    if (t == _i98.RatingStats) {
      return _i98.RatingStats.fromJson(data) as T;
    }
    if (t == _i99.RatingType) {
      return _i99.RatingType.fromJson(data) as T;
    }
    if (t == _i100.RecentActivity) {
      return _i100.RecentActivity.fromJson(data) as T;
    }
    if (t == _i101.Report) {
      return _i101.Report.fromJson(data) as T;
    }
    if (t == _i102.ReportReason) {
      return _i102.ReportReason.fromJson(data) as T;
    }
    if (t == _i103.ReportResolution) {
      return _i103.ReportResolution.fromJson(data) as T;
    }
    if (t == _i104.ReportStatus) {
      return _i104.ReportStatus.fromJson(data) as T;
    }
    if (t == _i105.ReporterType) {
      return _i105.ReporterType.fromJson(data) as T;
    }
    if (t == _i106.RequestStatus) {
      return _i106.RequestStatus.fromJson(data) as T;
    }
    if (t == _i107.Review) {
      return _i107.Review.fromJson(data) as T;
    }
    if (t == _i108.ReviewWithReviewer) {
      return _i108.ReviewWithReviewer.fromJson(data) as T;
    }
    if (t == _i109.SearchLog) {
      return _i109.SearchLog.fromJson(data) as T;
    }
    if (t == _i110.Service) {
      return _i110.Service.fromJson(data) as T;
    }
    if (t == _i111.ServiceAnalytics) {
      return _i111.ServiceAnalytics.fromJson(data) as T;
    }
    if (t == _i112.ServiceCategory) {
      return _i112.ServiceCategory.fromJson(data) as T;
    }
    if (t == _i113.ServiceImage) {
      return _i113.ServiceImage.fromJson(data) as T;
    }
    if (t == _i114.ServiceRequest) {
      return _i114.ServiceRequest.fromJson(data) as T;
    }
    if (t == _i115.ServiceType) {
      return _i115.ServiceType.fromJson(data) as T;
    }
    if (t == _i116.ShoppingItem) {
      return _i116.ShoppingItem.fromJson(data) as T;
    }
    if (t == _i117.Store) {
      return _i117.Store.fromJson(data) as T;
    }
    if (t == _i118.StoreCategory) {
      return _i118.StoreCategory.fromJson(data) as T;
    }
    if (t == _i119.StoreDeliveryRequest) {
      return _i119.StoreDeliveryRequest.fromJson(data) as T;
    }
    if (t == _i120.StoreOrder) {
      return _i120.StoreOrder.fromJson(data) as T;
    }
    if (t == _i121.StoreOrderChat) {
      return _i121.StoreOrderChat.fromJson(data) as T;
    }
    if (t == _i122.StoreOrderChatMessage) {
      return _i122.StoreOrderChatMessage.fromJson(data) as T;
    }
    if (t == _i123.StoreOrderItem) {
      return _i123.StoreOrderItem.fromJson(data) as T;
    }
    if (t == _i124.StoreOrderStatus) {
      return _i124.StoreOrderStatus.fromJson(data) as T;
    }
    if (t == _i125.StoreProduct) {
      return _i125.StoreProduct.fromJson(data) as T;
    }
    if (t == _i126.StoreReport) {
      return _i126.StoreReport.fromJson(data) as T;
    }
    if (t == _i127.StoreReview) {
      return _i127.StoreReview.fromJson(data) as T;
    }
    if (t == _i128.Subscription) {
      return _i128.Subscription.fromJson(data) as T;
    }
    if (t == _i129.SubscriptionPlan) {
      return _i129.SubscriptionPlan.fromJson(data) as T;
    }
    if (t == _i130.SubscriptionStatus) {
      return _i130.SubscriptionStatus.fromJson(data) as T;
    }
    if (t == _i131.SystemSetting) {
      return _i131.SystemSetting.fromJson(data) as T;
    }
    if (t == _i132.Transaction) {
      return _i132.Transaction.fromJson(data) as T;
    }
    if (t == _i133.TransactionStatus) {
      return _i133.TransactionStatus.fromJson(data) as T;
    }
    if (t == _i134.TransactionType) {
      return _i134.TransactionType.fromJson(data) as T;
    }
    if (t == _i135.TrustScoreResult) {
      return _i135.TrustScoreResult.fromJson(data) as T;
    }
    if (t == _i136.User) {
      return _i136.User.fromJson(data) as T;
    }
    if (t == _i137.UserClient) {
      return _i137.UserClient.fromJson(data) as T;
    }
    if (t == _i138.UserNotification) {
      return _i138.UserNotification.fromJson(data) as T;
    }
    if (t == _i139.UserResponse) {
      return _i139.UserResponse.fromJson(data) as T;
    }
    if (t == _i140.UserRole) {
      return _i140.UserRole.fromJson(data) as T;
    }
    if (t == _i141.UserStatus) {
      return _i141.UserStatus.fromJson(data) as T;
    }
    if (t == _i142.VehicleType) {
      return _i142.VehicleType.fromJson(data) as T;
    }
    if (t == _i143.Wallet) {
      return _i143.Wallet.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.Address?>()) {
      return (data != null ? _i5.Address.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AdminAction?>()) {
      return (data != null ? _i6.AdminAction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AdminActionType?>()) {
      return (data != null ? _i7.AdminActionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AdminLoginResponse?>()) {
      return (data != null ? _i8.AdminLoginResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.AdminUser?>()) {
      return (data != null ? _i9.AdminUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AgentBuilderConverseResponse?>()) {
      return (data != null
              ? _i10.AgentBuilderConverseResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i11.AgentBuilderStep?>()) {
      return (data != null ? _i11.AgentBuilderStep.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.AgentStreamEvent?>()) {
      return (data != null ? _i12.AgentStreamEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.AgentStreamStatus?>()) {
      return (data != null ? _i13.AgentStreamStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.AiAgentStatus?>()) {
      return (data != null ? _i14.AiAgentStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.AiAgentStatusResponse?>()) {
      return (data != null ? _i15.AiAgentStatusResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.AiAgentType?>()) {
      return (data != null ? _i16.AiAgentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.AiConfidenceLevel?>()) {
      return (data != null ? _i17.AiConfidenceLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.AiDemandHotspot?>()) {
      return (data != null ? _i18.AiDemandHotspot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.AiDemandPredictionResponse?>()) {
      return (data != null
              ? _i19.AiDemandPredictionResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i20.AiDriverMatchingResponse?>()) {
      return (data != null
              ? _i20.AiDriverMatchingResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i21.AiDriverRecommendation?>()) {
      return (data != null ? _i21.AiDriverRecommendation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.AiFullRequestResponse?>()) {
      return (data != null ? _i22.AiFullRequestResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.AiHelpArticle?>()) {
      return (data != null ? _i23.AiHelpArticle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.AiHelpSearchResponse?>()) {
      return (data != null ? _i24.AiHelpSearchResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.AiParsedServiceRequest?>()) {
      return (data != null ? _i25.AiParsedServiceRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.AiRequestConciergeResponse?>()) {
      return (data != null
              ? _i26.AiRequestConciergeResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i27.AiResponseStatus?>()) {
      return (data != null ? _i27.AiResponseStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.AppConfiguration?>()) {
      return (data != null ? _i28.AppConfiguration.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.AuthResponse?>()) {
      return (data != null ? _i29.AuthResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.BlockedUser?>()) {
      return (data != null ? _i30.BlockedUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.CancellerType?>()) {
      return (data != null ? _i31.CancellerType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.Category?>()) {
      return (data != null ? _i32.Category.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.ChatMessage?>()) {
      return (data != null ? _i33.ChatMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.ChatParticipantsInfo?>()) {
      return (data != null ? _i34.ChatParticipantsInfo.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.City?>()) {
      return (data != null ? _i35.City.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.ClientReview?>()) {
      return (data != null ? _i36.ClientReview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.Country?>()) {
      return (data != null ? _i37.Country.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.DashboardStats?>()) {
      return (data != null ? _i38.DashboardStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.DeviceFingerprintCheckResult?>()) {
      return (data != null
              ? _i39.DeviceFingerprintCheckResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i40.DeviceFingerprintInput?>()) {
      return (data != null ? _i40.DeviceFingerprintInput.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.DeviceFingerprintRecord?>()) {
      return (data != null ? _i41.DeviceFingerprintRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.Dispute?>()) {
      return (data != null ? _i42.Dispute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.DisputeStatus?>()) {
      return (data != null ? _i43.DisputeStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.DisputeType?>()) {
      return (data != null ? _i44.DisputeType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.DriverAvailabilityStatus?>()) {
      return (data != null
              ? _i45.DriverAvailabilityStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i46.DriverEarningsResponse?>()) {
      return (data != null ? _i46.DriverEarningsResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i47.DriverLocation?>()) {
      return (data != null ? _i47.DriverLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.DriverOffer?>()) {
      return (data != null ? _i48.DriverOffer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.DriverProfile?>()) {
      return (data != null ? _i49.DriverProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.DriverProposal?>()) {
      return (data != null ? _i50.DriverProposal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.DriverService?>()) {
      return (data != null ? _i51.DriverService.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.DriverStatistics?>()) {
      return (data != null ? _i52.DriverStatistics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.DriverZone?>()) {
      return (data != null ? _i53.DriverZone.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.EsCategoryCount?>()) {
      return (data != null ? _i54.EsCategoryCount.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.EsDriverHit?>()) {
      return (data != null ? _i55.EsDriverHit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.EsDriverSearchResult?>()) {
      return (data != null ? _i56.EsDriverSearchResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i57.EsDriverServiceHit?>()) {
      return (data != null ? _i57.EsDriverServiceHit.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i58.EsDriverServiceSearchResult?>()) {
      return (data != null
              ? _i58.EsDriverServiceSearchResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i59.EsPopularSearchTerm?>()) {
      return (data != null ? _i59.EsPopularSearchTerm.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i60.EsPopularSearchesResult?>()) {
      return (data != null ? _i60.EsPopularSearchesResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i61.EsPopularService?>()) {
      return (data != null ? _i61.EsPopularService.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.EsPopularServicesResult?>()) {
      return (data != null ? _i62.EsPopularServicesResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i63.EsPriceStats?>()) {
      return (data != null ? _i63.EsPriceStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.EsPriceStatsResult?>()) {
      return (data != null ? _i64.EsPriceStatsResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i65.EsProductHit?>()) {
      return (data != null ? _i65.EsProductHit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.EsProductSearchResult?>()) {
      return (data != null ? _i66.EsProductSearchResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i67.EsSearchResult?>()) {
      return (data != null ? _i67.EsSearchResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.EsServiceCategoryCountsResult?>()) {
      return (data != null
              ? _i68.EsServiceCategoryCountsResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i69.EsServiceHit?>()) {
      return (data != null ? _i69.EsServiceHit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.EsServiceSearchResult?>()) {
      return (data != null ? _i70.EsServiceSearchResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i71.EsStoreHit?>()) {
      return (data != null ? _i71.EsStoreHit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.EsStoreSearchResult?>()) {
      return (data != null ? _i72.EsStoreSearchResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i73.Favorite?>()) {
      return (data != null ? _i73.Favorite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.Greeting?>()) {
      return (data != null ? _i74.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i75.Language?>()) {
      return (data != null ? _i75.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.Location?>()) {
      return (data != null ? _i76.Location.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.MediaMetadata?>()) {
      return (data != null ? _i77.MediaMetadata.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i78.MessageType?>()) {
      return (data != null ? _i78.MessageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.NearbyDriver?>()) {
      return (data != null ? _i79.NearbyDriver.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.NotificationType?>()) {
      return (data != null ? _i80.NotificationType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i81.OfferStatus?>()) {
      return (data != null ? _i81.OfferStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i82.Order?>()) {
      return (data != null ? _i82.Order.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i83.OrderItem?>()) {
      return (data != null ? _i83.OrderItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i84.OrderStatus?>()) {
      return (data != null ? _i84.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i85.OrderStatusHistory?>()) {
      return (data != null ? _i85.OrderStatusHistory.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i86.OrderTracking?>()) {
      return (data != null ? _i86.OrderTracking.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i87.Payment?>()) {
      return (data != null ? _i87.Payment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i88.PaymentMethod?>()) {
      return (data != null ? _i88.PaymentMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i89.PaymentStatus?>()) {
      return (data != null ? _i89.PaymentStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i90.PlatformStatistics?>()) {
      return (data != null ? _i90.PlatformStatistics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i91.PriceNegotiationStatus?>()) {
      return (data != null ? _i91.PriceNegotiationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i92.PriceType?>()) {
      return (data != null ? _i92.PriceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i93.ProductCategory?>()) {
      return (data != null ? _i93.ProductCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i94.Promo?>()) {
      return (data != null ? _i94.Promo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i95.PromoActionType?>()) {
      return (data != null ? _i95.PromoActionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i96.ProposalStatus?>()) {
      return (data != null ? _i96.ProposalStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i97.Rating?>()) {
      return (data != null ? _i97.Rating.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i98.RatingStats?>()) {
      return (data != null ? _i98.RatingStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i99.RatingType?>()) {
      return (data != null ? _i99.RatingType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i100.RecentActivity?>()) {
      return (data != null ? _i100.RecentActivity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i101.Report?>()) {
      return (data != null ? _i101.Report.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i102.ReportReason?>()) {
      return (data != null ? _i102.ReportReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i103.ReportResolution?>()) {
      return (data != null ? _i103.ReportResolution.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i104.ReportStatus?>()) {
      return (data != null ? _i104.ReportStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i105.ReporterType?>()) {
      return (data != null ? _i105.ReporterType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i106.RequestStatus?>()) {
      return (data != null ? _i106.RequestStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i107.Review?>()) {
      return (data != null ? _i107.Review.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i108.ReviewWithReviewer?>()) {
      return (data != null ? _i108.ReviewWithReviewer.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i109.SearchLog?>()) {
      return (data != null ? _i109.SearchLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i110.Service?>()) {
      return (data != null ? _i110.Service.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i111.ServiceAnalytics?>()) {
      return (data != null ? _i111.ServiceAnalytics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i112.ServiceCategory?>()) {
      return (data != null ? _i112.ServiceCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i113.ServiceImage?>()) {
      return (data != null ? _i113.ServiceImage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i114.ServiceRequest?>()) {
      return (data != null ? _i114.ServiceRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i115.ServiceType?>()) {
      return (data != null ? _i115.ServiceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i116.ShoppingItem?>()) {
      return (data != null ? _i116.ShoppingItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i117.Store?>()) {
      return (data != null ? _i117.Store.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i118.StoreCategory?>()) {
      return (data != null ? _i118.StoreCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i119.StoreDeliveryRequest?>()) {
      return (data != null ? _i119.StoreDeliveryRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i120.StoreOrder?>()) {
      return (data != null ? _i120.StoreOrder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i121.StoreOrderChat?>()) {
      return (data != null ? _i121.StoreOrderChat.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i122.StoreOrderChatMessage?>()) {
      return (data != null ? _i122.StoreOrderChatMessage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i123.StoreOrderItem?>()) {
      return (data != null ? _i123.StoreOrderItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i124.StoreOrderStatus?>()) {
      return (data != null ? _i124.StoreOrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i125.StoreProduct?>()) {
      return (data != null ? _i125.StoreProduct.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i126.StoreReport?>()) {
      return (data != null ? _i126.StoreReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i127.StoreReview?>()) {
      return (data != null ? _i127.StoreReview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i128.Subscription?>()) {
      return (data != null ? _i128.Subscription.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i129.SubscriptionPlan?>()) {
      return (data != null ? _i129.SubscriptionPlan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i130.SubscriptionStatus?>()) {
      return (data != null ? _i130.SubscriptionStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i131.SystemSetting?>()) {
      return (data != null ? _i131.SystemSetting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i132.Transaction?>()) {
      return (data != null ? _i132.Transaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i133.TransactionStatus?>()) {
      return (data != null ? _i133.TransactionStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i134.TransactionType?>()) {
      return (data != null ? _i134.TransactionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i135.TrustScoreResult?>()) {
      return (data != null ? _i135.TrustScoreResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i136.User?>()) {
      return (data != null ? _i136.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i137.UserClient?>()) {
      return (data != null ? _i137.UserClient.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i138.UserNotification?>()) {
      return (data != null ? _i138.UserNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i139.UserResponse?>()) {
      return (data != null ? _i139.UserResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i140.UserRole?>()) {
      return (data != null ? _i140.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i141.UserStatus?>()) {
      return (data != null ? _i141.UserStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i142.VehicleType?>()) {
      return (data != null ? _i142.VehicleType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i143.Wallet?>()) {
      return (data != null ? _i143.Wallet.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i11.AgentBuilderStep>) {
      return (data as List)
              .map((e) => deserialize<_i11.AgentBuilderStep>(e))
              .toList()
          as T;
    }
    if (t == List<_i12.AgentStreamEvent>) {
      return (data as List)
              .map((e) => deserialize<_i12.AgentStreamEvent>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i11.AgentBuilderStep>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i11.AgentBuilderStep>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i14.AiAgentStatus>) {
      return (data as List)
              .map((e) => deserialize<_i14.AiAgentStatus>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i18.AiDemandHotspot>) {
      return (data as List)
              .map((e) => deserialize<_i18.AiDemandHotspot>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.AiDriverRecommendation>) {
      return (data as List)
              .map((e) => deserialize<_i21.AiDriverRecommendation>(e))
              .toList()
          as T;
    }
    if (t == List<_i23.AiHelpArticle>) {
      return (data as List)
              .map((e) => deserialize<_i23.AiHelpArticle>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i132.Transaction>) {
      return (data as List)
              .map((e) => deserialize<_i132.Transaction>(e))
              .toList()
          as T;
    }
    if (t == List<_i55.EsDriverHit>) {
      return (data as List)
              .map((e) => deserialize<_i55.EsDriverHit>(e))
              .toList()
          as T;
    }
    if (t == List<_i57.EsDriverServiceHit>) {
      return (data as List)
              .map((e) => deserialize<_i57.EsDriverServiceHit>(e))
              .toList()
          as T;
    }
    if (t == List<_i59.EsPopularSearchTerm>) {
      return (data as List)
              .map((e) => deserialize<_i59.EsPopularSearchTerm>(e))
              .toList()
          as T;
    }
    if (t == List<_i61.EsPopularService>) {
      return (data as List)
              .map((e) => deserialize<_i61.EsPopularService>(e))
              .toList()
          as T;
    }
    if (t == List<_i63.EsPriceStats>) {
      return (data as List)
              .map((e) => deserialize<_i63.EsPriceStats>(e))
              .toList()
          as T;
    }
    if (t == List<_i65.EsProductHit>) {
      return (data as List)
              .map((e) => deserialize<_i65.EsProductHit>(e))
              .toList()
          as T;
    }
    if (t == List<_i54.EsCategoryCount>) {
      return (data as List)
              .map((e) => deserialize<_i54.EsCategoryCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i69.EsServiceHit>) {
      return (data as List)
              .map((e) => deserialize<_i69.EsServiceHit>(e))
              .toList()
          as T;
    }
    if (t == List<_i71.EsStoreHit>) {
      return (data as List).map((e) => deserialize<_i71.EsStoreHit>(e)).toList()
          as T;
    }
    if (t == List<_i116.ShoppingItem>) {
      return (data as List)
              .map((e) => deserialize<_i116.ShoppingItem>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i116.ShoppingItem>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i116.ShoppingItem>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i140.UserRole>) {
      return (data as List).map((e) => deserialize<_i140.UserRole>(e)).toList()
          as T;
    }
    if (t == List<_i144.AdminUser>) {
      return (data as List).map((e) => deserialize<_i144.AdminUser>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i145.User>) {
      return (data as List).map((e) => deserialize<_i145.User>(e)).toList()
          as T;
    }
    if (t == List<_i146.DriverProfile>) {
      return (data as List)
              .map((e) => deserialize<_i146.DriverProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i147.Store>) {
      return (data as List).map((e) => deserialize<_i147.Store>(e)).toList()
          as T;
    }
    if (t == List<_i148.StoreOrder>) {
      return (data as List)
              .map((e) => deserialize<_i148.StoreOrder>(e))
              .toList()
          as T;
    }
    if (t == List<_i149.ServiceRequest>) {
      return (data as List)
              .map((e) => deserialize<_i149.ServiceRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i150.Transaction>) {
      return (data as List)
              .map((e) => deserialize<_i150.Transaction>(e))
              .toList()
          as T;
    }
    if (t == List<_i151.Report>) {
      return (data as List).map((e) => deserialize<_i151.Report>(e)).toList()
          as T;
    }
    if (t == List<_i152.RecentActivity>) {
      return (data as List)
              .map((e) => deserialize<_i152.RecentActivity>(e))
              .toList()
          as T;
    }
    if (t == List<_i153.BlockedUser>) {
      return (data as List)
              .map((e) => deserialize<_i153.BlockedUser>(e))
              .toList()
          as T;
    }
    if (t == List<_i154.ChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_i154.ChatMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_i155.Country>) {
      return (data as List).map((e) => deserialize<_i155.Country>(e)).toList()
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    if (t == List<_i156.DeviceFingerprintRecord>) {
      return (data as List)
              .map((e) => deserialize<_i156.DeviceFingerprintRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i157.DriverService>) {
      return (data as List)
              .map((e) => deserialize<_i157.DriverService>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i158.ServiceImage>) {
      return (data as List)
              .map((e) => deserialize<_i158.ServiceImage>(e))
              .toList()
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == List<_i159.MediaMetadata>) {
      return (data as List)
              .map((e) => deserialize<_i159.MediaMetadata>(e))
              .toList()
          as T;
    }
    if (t == List<_i160.UserNotification>) {
      return (data as List)
              .map((e) => deserialize<_i160.UserNotification>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<Map<String, dynamic>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i161.DriverOffer>) {
      return (data as List)
              .map((e) => deserialize<_i161.DriverOffer>(e))
              .toList()
          as T;
    }
    if (t == List<_i162.Order>) {
      return (data as List).map((e) => deserialize<_i162.Order>(e)).toList()
          as T;
    }
    if (t == List<_i163.Promo>) {
      return (data as List).map((e) => deserialize<_i163.Promo>(e)).toList()
          as T;
    }
    if (t == List<_i164.DriverProposal>) {
      return (data as List)
              .map((e) => deserialize<_i164.DriverProposal>(e))
              .toList()
          as T;
    }
    if (t == List<_i165.Rating>) {
      return (data as List).map((e) => deserialize<_i165.Rating>(e)).toList()
          as T;
    }
    if (t == Map<String, bool>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<bool>(v)),
          )
          as T;
    }
    if (t == List<_i166.ShoppingItem>) {
      return (data as List)
              .map((e) => deserialize<_i166.ShoppingItem>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i166.ShoppingItem>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i166.ShoppingItem>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i167.ClientReview>) {
      return (data as List)
              .map((e) => deserialize<_i167.ClientReview>(e))
              .toList()
          as T;
    }
    if (t == List<_i168.Review>) {
      return (data as List).map((e) => deserialize<_i168.Review>(e)).toList()
          as T;
    }
    if (t == List<_i169.ServiceCategory>) {
      return (data as List)
              .map((e) => deserialize<_i169.ServiceCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_i170.Service>) {
      return (data as List).map((e) => deserialize<_i170.Service>(e)).toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i171.NearbyDriver>) {
      return (data as List)
              .map((e) => deserialize<_i171.NearbyDriver>(e))
              .toList()
          as T;
    }
    if (t == List<_i172.StoreDeliveryRequest>) {
      return (data as List)
              .map((e) => deserialize<_i172.StoreDeliveryRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i173.StoreOrderChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_i173.StoreOrderChatMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_i174.StoreCategory>) {
      return (data as List)
              .map((e) => deserialize<_i174.StoreCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_i175.OrderItem>) {
      return (data as List).map((e) => deserialize<_i175.OrderItem>(e)).toList()
          as T;
    }
    if (t == List<_i176.ProductCategory>) {
      return (data as List)
              .map((e) => deserialize<_i176.ProductCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_i177.StoreProduct>) {
      return (data as List)
              .map((e) => deserialize<_i177.StoreProduct>(e))
              .toList()
          as T;
    }
    if (t == List<_i178.StoreReview>) {
      return (data as List)
              .map((e) => deserialize<_i178.StoreReview>(e))
              .toList()
          as T;
    }
    if (t == List<_i179.ReviewWithReviewer>) {
      return (data as List)
              .map((e) => deserialize<_i179.ReviewWithReviewer>(e))
              .toList()
          as T;
    }
    if (t == List<_i180.TrustScoreResult>) {
      return (data as List)
              .map((e) => deserialize<_i180.TrustScoreResult>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.Address => 'Address',
      _i6.AdminAction => 'AdminAction',
      _i7.AdminActionType => 'AdminActionType',
      _i8.AdminLoginResponse => 'AdminLoginResponse',
      _i9.AdminUser => 'AdminUser',
      _i10.AgentBuilderConverseResponse => 'AgentBuilderConverseResponse',
      _i11.AgentBuilderStep => 'AgentBuilderStep',
      _i12.AgentStreamEvent => 'AgentStreamEvent',
      _i13.AgentStreamStatus => 'AgentStreamStatus',
      _i14.AiAgentStatus => 'AiAgentStatus',
      _i15.AiAgentStatusResponse => 'AiAgentStatusResponse',
      _i16.AiAgentType => 'AiAgentType',
      _i17.AiConfidenceLevel => 'AiConfidenceLevel',
      _i18.AiDemandHotspot => 'AiDemandHotspot',
      _i19.AiDemandPredictionResponse => 'AiDemandPredictionResponse',
      _i20.AiDriverMatchingResponse => 'AiDriverMatchingResponse',
      _i21.AiDriverRecommendation => 'AiDriverRecommendation',
      _i22.AiFullRequestResponse => 'AiFullRequestResponse',
      _i23.AiHelpArticle => 'AiHelpArticle',
      _i24.AiHelpSearchResponse => 'AiHelpSearchResponse',
      _i25.AiParsedServiceRequest => 'AiParsedServiceRequest',
      _i26.AiRequestConciergeResponse => 'AiRequestConciergeResponse',
      _i27.AiResponseStatus => 'AiResponseStatus',
      _i28.AppConfiguration => 'AppConfiguration',
      _i29.AuthResponse => 'AuthResponse',
      _i30.BlockedUser => 'BlockedUser',
      _i31.CancellerType => 'CancellerType',
      _i32.Category => 'Category',
      _i33.ChatMessage => 'ChatMessage',
      _i34.ChatParticipantsInfo => 'ChatParticipantsInfo',
      _i35.City => 'City',
      _i36.ClientReview => 'ClientReview',
      _i37.Country => 'Country',
      _i38.DashboardStats => 'DashboardStats',
      _i39.DeviceFingerprintCheckResult => 'DeviceFingerprintCheckResult',
      _i40.DeviceFingerprintInput => 'DeviceFingerprintInput',
      _i41.DeviceFingerprintRecord => 'DeviceFingerprintRecord',
      _i42.Dispute => 'Dispute',
      _i43.DisputeStatus => 'DisputeStatus',
      _i44.DisputeType => 'DisputeType',
      _i45.DriverAvailabilityStatus => 'DriverAvailabilityStatus',
      _i46.DriverEarningsResponse => 'DriverEarningsResponse',
      _i47.DriverLocation => 'DriverLocation',
      _i48.DriverOffer => 'DriverOffer',
      _i49.DriverProfile => 'DriverProfile',
      _i50.DriverProposal => 'DriverProposal',
      _i51.DriverService => 'DriverService',
      _i52.DriverStatistics => 'DriverStatistics',
      _i53.DriverZone => 'DriverZone',
      _i54.EsCategoryCount => 'EsCategoryCount',
      _i55.EsDriverHit => 'EsDriverHit',
      _i56.EsDriverSearchResult => 'EsDriverSearchResult',
      _i57.EsDriverServiceHit => 'EsDriverServiceHit',
      _i58.EsDriverServiceSearchResult => 'EsDriverServiceSearchResult',
      _i59.EsPopularSearchTerm => 'EsPopularSearchTerm',
      _i60.EsPopularSearchesResult => 'EsPopularSearchesResult',
      _i61.EsPopularService => 'EsPopularService',
      _i62.EsPopularServicesResult => 'EsPopularServicesResult',
      _i63.EsPriceStats => 'EsPriceStats',
      _i64.EsPriceStatsResult => 'EsPriceStatsResult',
      _i65.EsProductHit => 'EsProductHit',
      _i66.EsProductSearchResult => 'EsProductSearchResult',
      _i67.EsSearchResult => 'EsSearchResult',
      _i68.EsServiceCategoryCountsResult => 'EsServiceCategoryCountsResult',
      _i69.EsServiceHit => 'EsServiceHit',
      _i70.EsServiceSearchResult => 'EsServiceSearchResult',
      _i71.EsStoreHit => 'EsStoreHit',
      _i72.EsStoreSearchResult => 'EsStoreSearchResult',
      _i73.Favorite => 'Favorite',
      _i74.Greeting => 'Greeting',
      _i75.Language => 'Language',
      _i76.Location => 'Location',
      _i77.MediaMetadata => 'MediaMetadata',
      _i78.MessageType => 'MessageType',
      _i79.NearbyDriver => 'NearbyDriver',
      _i80.NotificationType => 'NotificationType',
      _i81.OfferStatus => 'OfferStatus',
      _i82.Order => 'Order',
      _i83.OrderItem => 'OrderItem',
      _i84.OrderStatus => 'OrderStatus',
      _i85.OrderStatusHistory => 'OrderStatusHistory',
      _i86.OrderTracking => 'OrderTracking',
      _i87.Payment => 'Payment',
      _i88.PaymentMethod => 'PaymentMethod',
      _i89.PaymentStatus => 'PaymentStatus',
      _i90.PlatformStatistics => 'PlatformStatistics',
      _i91.PriceNegotiationStatus => 'PriceNegotiationStatus',
      _i92.PriceType => 'PriceType',
      _i93.ProductCategory => 'ProductCategory',
      _i94.Promo => 'Promo',
      _i95.PromoActionType => 'PromoActionType',
      _i96.ProposalStatus => 'ProposalStatus',
      _i97.Rating => 'Rating',
      _i98.RatingStats => 'RatingStats',
      _i99.RatingType => 'RatingType',
      _i100.RecentActivity => 'RecentActivity',
      _i101.Report => 'Report',
      _i102.ReportReason => 'ReportReason',
      _i103.ReportResolution => 'ReportResolution',
      _i104.ReportStatus => 'ReportStatus',
      _i105.ReporterType => 'ReporterType',
      _i106.RequestStatus => 'RequestStatus',
      _i107.Review => 'Review',
      _i108.ReviewWithReviewer => 'ReviewWithReviewer',
      _i109.SearchLog => 'SearchLog',
      _i110.Service => 'Service',
      _i111.ServiceAnalytics => 'ServiceAnalytics',
      _i112.ServiceCategory => 'ServiceCategory',
      _i113.ServiceImage => 'ServiceImage',
      _i114.ServiceRequest => 'ServiceRequest',
      _i115.ServiceType => 'ServiceType',
      _i116.ShoppingItem => 'ShoppingItem',
      _i117.Store => 'Store',
      _i118.StoreCategory => 'StoreCategory',
      _i119.StoreDeliveryRequest => 'StoreDeliveryRequest',
      _i120.StoreOrder => 'StoreOrder',
      _i121.StoreOrderChat => 'StoreOrderChat',
      _i122.StoreOrderChatMessage => 'StoreOrderChatMessage',
      _i123.StoreOrderItem => 'StoreOrderItem',
      _i124.StoreOrderStatus => 'StoreOrderStatus',
      _i125.StoreProduct => 'StoreProduct',
      _i126.StoreReport => 'StoreReport',
      _i127.StoreReview => 'StoreReview',
      _i128.Subscription => 'Subscription',
      _i129.SubscriptionPlan => 'SubscriptionPlan',
      _i130.SubscriptionStatus => 'SubscriptionStatus',
      _i131.SystemSetting => 'SystemSetting',
      _i132.Transaction => 'Transaction',
      _i133.TransactionStatus => 'TransactionStatus',
      _i134.TransactionType => 'TransactionType',
      _i135.TrustScoreResult => 'TrustScoreResult',
      _i136.User => 'User',
      _i137.UserClient => 'UserClient',
      _i138.UserNotification => 'UserNotification',
      _i139.UserResponse => 'UserResponse',
      _i140.UserRole => 'UserRole',
      _i141.UserStatus => 'UserStatus',
      _i142.VehicleType => 'VehicleType',
      _i143.Wallet => 'Wallet',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('awhar.', '');
    }

    switch (data) {
      case _i5.Address():
        return 'Address';
      case _i6.AdminAction():
        return 'AdminAction';
      case _i7.AdminActionType():
        return 'AdminActionType';
      case _i8.AdminLoginResponse():
        return 'AdminLoginResponse';
      case _i9.AdminUser():
        return 'AdminUser';
      case _i10.AgentBuilderConverseResponse():
        return 'AgentBuilderConverseResponse';
      case _i11.AgentBuilderStep():
        return 'AgentBuilderStep';
      case _i12.AgentStreamEvent():
        return 'AgentStreamEvent';
      case _i13.AgentStreamStatus():
        return 'AgentStreamStatus';
      case _i14.AiAgentStatus():
        return 'AiAgentStatus';
      case _i15.AiAgentStatusResponse():
        return 'AiAgentStatusResponse';
      case _i16.AiAgentType():
        return 'AiAgentType';
      case _i17.AiConfidenceLevel():
        return 'AiConfidenceLevel';
      case _i18.AiDemandHotspot():
        return 'AiDemandHotspot';
      case _i19.AiDemandPredictionResponse():
        return 'AiDemandPredictionResponse';
      case _i20.AiDriverMatchingResponse():
        return 'AiDriverMatchingResponse';
      case _i21.AiDriverRecommendation():
        return 'AiDriverRecommendation';
      case _i22.AiFullRequestResponse():
        return 'AiFullRequestResponse';
      case _i23.AiHelpArticle():
        return 'AiHelpArticle';
      case _i24.AiHelpSearchResponse():
        return 'AiHelpSearchResponse';
      case _i25.AiParsedServiceRequest():
        return 'AiParsedServiceRequest';
      case _i26.AiRequestConciergeResponse():
        return 'AiRequestConciergeResponse';
      case _i27.AiResponseStatus():
        return 'AiResponseStatus';
      case _i28.AppConfiguration():
        return 'AppConfiguration';
      case _i29.AuthResponse():
        return 'AuthResponse';
      case _i30.BlockedUser():
        return 'BlockedUser';
      case _i31.CancellerType():
        return 'CancellerType';
      case _i32.Category():
        return 'Category';
      case _i33.ChatMessage():
        return 'ChatMessage';
      case _i34.ChatParticipantsInfo():
        return 'ChatParticipantsInfo';
      case _i35.City():
        return 'City';
      case _i36.ClientReview():
        return 'ClientReview';
      case _i37.Country():
        return 'Country';
      case _i38.DashboardStats():
        return 'DashboardStats';
      case _i39.DeviceFingerprintCheckResult():
        return 'DeviceFingerprintCheckResult';
      case _i40.DeviceFingerprintInput():
        return 'DeviceFingerprintInput';
      case _i41.DeviceFingerprintRecord():
        return 'DeviceFingerprintRecord';
      case _i42.Dispute():
        return 'Dispute';
      case _i43.DisputeStatus():
        return 'DisputeStatus';
      case _i44.DisputeType():
        return 'DisputeType';
      case _i45.DriverAvailabilityStatus():
        return 'DriverAvailabilityStatus';
      case _i46.DriverEarningsResponse():
        return 'DriverEarningsResponse';
      case _i47.DriverLocation():
        return 'DriverLocation';
      case _i48.DriverOffer():
        return 'DriverOffer';
      case _i49.DriverProfile():
        return 'DriverProfile';
      case _i50.DriverProposal():
        return 'DriverProposal';
      case _i51.DriverService():
        return 'DriverService';
      case _i52.DriverStatistics():
        return 'DriverStatistics';
      case _i53.DriverZone():
        return 'DriverZone';
      case _i54.EsCategoryCount():
        return 'EsCategoryCount';
      case _i55.EsDriverHit():
        return 'EsDriverHit';
      case _i56.EsDriverSearchResult():
        return 'EsDriverSearchResult';
      case _i57.EsDriverServiceHit():
        return 'EsDriverServiceHit';
      case _i58.EsDriverServiceSearchResult():
        return 'EsDriverServiceSearchResult';
      case _i59.EsPopularSearchTerm():
        return 'EsPopularSearchTerm';
      case _i60.EsPopularSearchesResult():
        return 'EsPopularSearchesResult';
      case _i61.EsPopularService():
        return 'EsPopularService';
      case _i62.EsPopularServicesResult():
        return 'EsPopularServicesResult';
      case _i63.EsPriceStats():
        return 'EsPriceStats';
      case _i64.EsPriceStatsResult():
        return 'EsPriceStatsResult';
      case _i65.EsProductHit():
        return 'EsProductHit';
      case _i66.EsProductSearchResult():
        return 'EsProductSearchResult';
      case _i67.EsSearchResult():
        return 'EsSearchResult';
      case _i68.EsServiceCategoryCountsResult():
        return 'EsServiceCategoryCountsResult';
      case _i69.EsServiceHit():
        return 'EsServiceHit';
      case _i70.EsServiceSearchResult():
        return 'EsServiceSearchResult';
      case _i71.EsStoreHit():
        return 'EsStoreHit';
      case _i72.EsStoreSearchResult():
        return 'EsStoreSearchResult';
      case _i73.Favorite():
        return 'Favorite';
      case _i74.Greeting():
        return 'Greeting';
      case _i75.Language():
        return 'Language';
      case _i76.Location():
        return 'Location';
      case _i77.MediaMetadata():
        return 'MediaMetadata';
      case _i78.MessageType():
        return 'MessageType';
      case _i79.NearbyDriver():
        return 'NearbyDriver';
      case _i80.NotificationType():
        return 'NotificationType';
      case _i81.OfferStatus():
        return 'OfferStatus';
      case _i82.Order():
        return 'Order';
      case _i83.OrderItem():
        return 'OrderItem';
      case _i84.OrderStatus():
        return 'OrderStatus';
      case _i85.OrderStatusHistory():
        return 'OrderStatusHistory';
      case _i86.OrderTracking():
        return 'OrderTracking';
      case _i87.Payment():
        return 'Payment';
      case _i88.PaymentMethod():
        return 'PaymentMethod';
      case _i89.PaymentStatus():
        return 'PaymentStatus';
      case _i90.PlatformStatistics():
        return 'PlatformStatistics';
      case _i91.PriceNegotiationStatus():
        return 'PriceNegotiationStatus';
      case _i92.PriceType():
        return 'PriceType';
      case _i93.ProductCategory():
        return 'ProductCategory';
      case _i94.Promo():
        return 'Promo';
      case _i95.PromoActionType():
        return 'PromoActionType';
      case _i96.ProposalStatus():
        return 'ProposalStatus';
      case _i97.Rating():
        return 'Rating';
      case _i98.RatingStats():
        return 'RatingStats';
      case _i99.RatingType():
        return 'RatingType';
      case _i100.RecentActivity():
        return 'RecentActivity';
      case _i101.Report():
        return 'Report';
      case _i102.ReportReason():
        return 'ReportReason';
      case _i103.ReportResolution():
        return 'ReportResolution';
      case _i104.ReportStatus():
        return 'ReportStatus';
      case _i105.ReporterType():
        return 'ReporterType';
      case _i106.RequestStatus():
        return 'RequestStatus';
      case _i107.Review():
        return 'Review';
      case _i108.ReviewWithReviewer():
        return 'ReviewWithReviewer';
      case _i109.SearchLog():
        return 'SearchLog';
      case _i110.Service():
        return 'Service';
      case _i111.ServiceAnalytics():
        return 'ServiceAnalytics';
      case _i112.ServiceCategory():
        return 'ServiceCategory';
      case _i113.ServiceImage():
        return 'ServiceImage';
      case _i114.ServiceRequest():
        return 'ServiceRequest';
      case _i115.ServiceType():
        return 'ServiceType';
      case _i116.ShoppingItem():
        return 'ShoppingItem';
      case _i117.Store():
        return 'Store';
      case _i118.StoreCategory():
        return 'StoreCategory';
      case _i119.StoreDeliveryRequest():
        return 'StoreDeliveryRequest';
      case _i120.StoreOrder():
        return 'StoreOrder';
      case _i121.StoreOrderChat():
        return 'StoreOrderChat';
      case _i122.StoreOrderChatMessage():
        return 'StoreOrderChatMessage';
      case _i123.StoreOrderItem():
        return 'StoreOrderItem';
      case _i124.StoreOrderStatus():
        return 'StoreOrderStatus';
      case _i125.StoreProduct():
        return 'StoreProduct';
      case _i126.StoreReport():
        return 'StoreReport';
      case _i127.StoreReview():
        return 'StoreReview';
      case _i128.Subscription():
        return 'Subscription';
      case _i129.SubscriptionPlan():
        return 'SubscriptionPlan';
      case _i130.SubscriptionStatus():
        return 'SubscriptionStatus';
      case _i131.SystemSetting():
        return 'SystemSetting';
      case _i132.Transaction():
        return 'Transaction';
      case _i133.TransactionStatus():
        return 'TransactionStatus';
      case _i134.TransactionType():
        return 'TransactionType';
      case _i135.TrustScoreResult():
        return 'TrustScoreResult';
      case _i136.User():
        return 'User';
      case _i137.UserClient():
        return 'UserClient';
      case _i138.UserNotification():
        return 'UserNotification';
      case _i139.UserResponse():
        return 'UserResponse';
      case _i140.UserRole():
        return 'UserRole';
      case _i141.UserStatus():
        return 'UserStatus';
      case _i142.VehicleType():
        return 'VehicleType';
      case _i143.Wallet():
        return 'Wallet';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Address') {
      return deserialize<_i5.Address>(data['data']);
    }
    if (dataClassName == 'AdminAction') {
      return deserialize<_i6.AdminAction>(data['data']);
    }
    if (dataClassName == 'AdminActionType') {
      return deserialize<_i7.AdminActionType>(data['data']);
    }
    if (dataClassName == 'AdminLoginResponse') {
      return deserialize<_i8.AdminLoginResponse>(data['data']);
    }
    if (dataClassName == 'AdminUser') {
      return deserialize<_i9.AdminUser>(data['data']);
    }
    if (dataClassName == 'AgentBuilderConverseResponse') {
      return deserialize<_i10.AgentBuilderConverseResponse>(data['data']);
    }
    if (dataClassName == 'AgentBuilderStep') {
      return deserialize<_i11.AgentBuilderStep>(data['data']);
    }
    if (dataClassName == 'AgentStreamEvent') {
      return deserialize<_i12.AgentStreamEvent>(data['data']);
    }
    if (dataClassName == 'AgentStreamStatus') {
      return deserialize<_i13.AgentStreamStatus>(data['data']);
    }
    if (dataClassName == 'AiAgentStatus') {
      return deserialize<_i14.AiAgentStatus>(data['data']);
    }
    if (dataClassName == 'AiAgentStatusResponse') {
      return deserialize<_i15.AiAgentStatusResponse>(data['data']);
    }
    if (dataClassName == 'AiAgentType') {
      return deserialize<_i16.AiAgentType>(data['data']);
    }
    if (dataClassName == 'AiConfidenceLevel') {
      return deserialize<_i17.AiConfidenceLevel>(data['data']);
    }
    if (dataClassName == 'AiDemandHotspot') {
      return deserialize<_i18.AiDemandHotspot>(data['data']);
    }
    if (dataClassName == 'AiDemandPredictionResponse') {
      return deserialize<_i19.AiDemandPredictionResponse>(data['data']);
    }
    if (dataClassName == 'AiDriverMatchingResponse') {
      return deserialize<_i20.AiDriverMatchingResponse>(data['data']);
    }
    if (dataClassName == 'AiDriverRecommendation') {
      return deserialize<_i21.AiDriverRecommendation>(data['data']);
    }
    if (dataClassName == 'AiFullRequestResponse') {
      return deserialize<_i22.AiFullRequestResponse>(data['data']);
    }
    if (dataClassName == 'AiHelpArticle') {
      return deserialize<_i23.AiHelpArticle>(data['data']);
    }
    if (dataClassName == 'AiHelpSearchResponse') {
      return deserialize<_i24.AiHelpSearchResponse>(data['data']);
    }
    if (dataClassName == 'AiParsedServiceRequest') {
      return deserialize<_i25.AiParsedServiceRequest>(data['data']);
    }
    if (dataClassName == 'AiRequestConciergeResponse') {
      return deserialize<_i26.AiRequestConciergeResponse>(data['data']);
    }
    if (dataClassName == 'AiResponseStatus') {
      return deserialize<_i27.AiResponseStatus>(data['data']);
    }
    if (dataClassName == 'AppConfiguration') {
      return deserialize<_i28.AppConfiguration>(data['data']);
    }
    if (dataClassName == 'AuthResponse') {
      return deserialize<_i29.AuthResponse>(data['data']);
    }
    if (dataClassName == 'BlockedUser') {
      return deserialize<_i30.BlockedUser>(data['data']);
    }
    if (dataClassName == 'CancellerType') {
      return deserialize<_i31.CancellerType>(data['data']);
    }
    if (dataClassName == 'Category') {
      return deserialize<_i32.Category>(data['data']);
    }
    if (dataClassName == 'ChatMessage') {
      return deserialize<_i33.ChatMessage>(data['data']);
    }
    if (dataClassName == 'ChatParticipantsInfo') {
      return deserialize<_i34.ChatParticipantsInfo>(data['data']);
    }
    if (dataClassName == 'City') {
      return deserialize<_i35.City>(data['data']);
    }
    if (dataClassName == 'ClientReview') {
      return deserialize<_i36.ClientReview>(data['data']);
    }
    if (dataClassName == 'Country') {
      return deserialize<_i37.Country>(data['data']);
    }
    if (dataClassName == 'DashboardStats') {
      return deserialize<_i38.DashboardStats>(data['data']);
    }
    if (dataClassName == 'DeviceFingerprintCheckResult') {
      return deserialize<_i39.DeviceFingerprintCheckResult>(data['data']);
    }
    if (dataClassName == 'DeviceFingerprintInput') {
      return deserialize<_i40.DeviceFingerprintInput>(data['data']);
    }
    if (dataClassName == 'DeviceFingerprintRecord') {
      return deserialize<_i41.DeviceFingerprintRecord>(data['data']);
    }
    if (dataClassName == 'Dispute') {
      return deserialize<_i42.Dispute>(data['data']);
    }
    if (dataClassName == 'DisputeStatus') {
      return deserialize<_i43.DisputeStatus>(data['data']);
    }
    if (dataClassName == 'DisputeType') {
      return deserialize<_i44.DisputeType>(data['data']);
    }
    if (dataClassName == 'DriverAvailabilityStatus') {
      return deserialize<_i45.DriverAvailabilityStatus>(data['data']);
    }
    if (dataClassName == 'DriverEarningsResponse') {
      return deserialize<_i46.DriverEarningsResponse>(data['data']);
    }
    if (dataClassName == 'DriverLocation') {
      return deserialize<_i47.DriverLocation>(data['data']);
    }
    if (dataClassName == 'DriverOffer') {
      return deserialize<_i48.DriverOffer>(data['data']);
    }
    if (dataClassName == 'DriverProfile') {
      return deserialize<_i49.DriverProfile>(data['data']);
    }
    if (dataClassName == 'DriverProposal') {
      return deserialize<_i50.DriverProposal>(data['data']);
    }
    if (dataClassName == 'DriverService') {
      return deserialize<_i51.DriverService>(data['data']);
    }
    if (dataClassName == 'DriverStatistics') {
      return deserialize<_i52.DriverStatistics>(data['data']);
    }
    if (dataClassName == 'DriverZone') {
      return deserialize<_i53.DriverZone>(data['data']);
    }
    if (dataClassName == 'EsCategoryCount') {
      return deserialize<_i54.EsCategoryCount>(data['data']);
    }
    if (dataClassName == 'EsDriverHit') {
      return deserialize<_i55.EsDriverHit>(data['data']);
    }
    if (dataClassName == 'EsDriverSearchResult') {
      return deserialize<_i56.EsDriverSearchResult>(data['data']);
    }
    if (dataClassName == 'EsDriverServiceHit') {
      return deserialize<_i57.EsDriverServiceHit>(data['data']);
    }
    if (dataClassName == 'EsDriverServiceSearchResult') {
      return deserialize<_i58.EsDriverServiceSearchResult>(data['data']);
    }
    if (dataClassName == 'EsPopularSearchTerm') {
      return deserialize<_i59.EsPopularSearchTerm>(data['data']);
    }
    if (dataClassName == 'EsPopularSearchesResult') {
      return deserialize<_i60.EsPopularSearchesResult>(data['data']);
    }
    if (dataClassName == 'EsPopularService') {
      return deserialize<_i61.EsPopularService>(data['data']);
    }
    if (dataClassName == 'EsPopularServicesResult') {
      return deserialize<_i62.EsPopularServicesResult>(data['data']);
    }
    if (dataClassName == 'EsPriceStats') {
      return deserialize<_i63.EsPriceStats>(data['data']);
    }
    if (dataClassName == 'EsPriceStatsResult') {
      return deserialize<_i64.EsPriceStatsResult>(data['data']);
    }
    if (dataClassName == 'EsProductHit') {
      return deserialize<_i65.EsProductHit>(data['data']);
    }
    if (dataClassName == 'EsProductSearchResult') {
      return deserialize<_i66.EsProductSearchResult>(data['data']);
    }
    if (dataClassName == 'EsSearchResult') {
      return deserialize<_i67.EsSearchResult>(data['data']);
    }
    if (dataClassName == 'EsServiceCategoryCountsResult') {
      return deserialize<_i68.EsServiceCategoryCountsResult>(data['data']);
    }
    if (dataClassName == 'EsServiceHit') {
      return deserialize<_i69.EsServiceHit>(data['data']);
    }
    if (dataClassName == 'EsServiceSearchResult') {
      return deserialize<_i70.EsServiceSearchResult>(data['data']);
    }
    if (dataClassName == 'EsStoreHit') {
      return deserialize<_i71.EsStoreHit>(data['data']);
    }
    if (dataClassName == 'EsStoreSearchResult') {
      return deserialize<_i72.EsStoreSearchResult>(data['data']);
    }
    if (dataClassName == 'Favorite') {
      return deserialize<_i73.Favorite>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i74.Greeting>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i75.Language>(data['data']);
    }
    if (dataClassName == 'Location') {
      return deserialize<_i76.Location>(data['data']);
    }
    if (dataClassName == 'MediaMetadata') {
      return deserialize<_i77.MediaMetadata>(data['data']);
    }
    if (dataClassName == 'MessageType') {
      return deserialize<_i78.MessageType>(data['data']);
    }
    if (dataClassName == 'NearbyDriver') {
      return deserialize<_i79.NearbyDriver>(data['data']);
    }
    if (dataClassName == 'NotificationType') {
      return deserialize<_i80.NotificationType>(data['data']);
    }
    if (dataClassName == 'OfferStatus') {
      return deserialize<_i81.OfferStatus>(data['data']);
    }
    if (dataClassName == 'Order') {
      return deserialize<_i82.Order>(data['data']);
    }
    if (dataClassName == 'OrderItem') {
      return deserialize<_i83.OrderItem>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i84.OrderStatus>(data['data']);
    }
    if (dataClassName == 'OrderStatusHistory') {
      return deserialize<_i85.OrderStatusHistory>(data['data']);
    }
    if (dataClassName == 'OrderTracking') {
      return deserialize<_i86.OrderTracking>(data['data']);
    }
    if (dataClassName == 'Payment') {
      return deserialize<_i87.Payment>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_i88.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'PaymentStatus') {
      return deserialize<_i89.PaymentStatus>(data['data']);
    }
    if (dataClassName == 'PlatformStatistics') {
      return deserialize<_i90.PlatformStatistics>(data['data']);
    }
    if (dataClassName == 'PriceNegotiationStatus') {
      return deserialize<_i91.PriceNegotiationStatus>(data['data']);
    }
    if (dataClassName == 'PriceType') {
      return deserialize<_i92.PriceType>(data['data']);
    }
    if (dataClassName == 'ProductCategory') {
      return deserialize<_i93.ProductCategory>(data['data']);
    }
    if (dataClassName == 'Promo') {
      return deserialize<_i94.Promo>(data['data']);
    }
    if (dataClassName == 'PromoActionType') {
      return deserialize<_i95.PromoActionType>(data['data']);
    }
    if (dataClassName == 'ProposalStatus') {
      return deserialize<_i96.ProposalStatus>(data['data']);
    }
    if (dataClassName == 'Rating') {
      return deserialize<_i97.Rating>(data['data']);
    }
    if (dataClassName == 'RatingStats') {
      return deserialize<_i98.RatingStats>(data['data']);
    }
    if (dataClassName == 'RatingType') {
      return deserialize<_i99.RatingType>(data['data']);
    }
    if (dataClassName == 'RecentActivity') {
      return deserialize<_i100.RecentActivity>(data['data']);
    }
    if (dataClassName == 'Report') {
      return deserialize<_i101.Report>(data['data']);
    }
    if (dataClassName == 'ReportReason') {
      return deserialize<_i102.ReportReason>(data['data']);
    }
    if (dataClassName == 'ReportResolution') {
      return deserialize<_i103.ReportResolution>(data['data']);
    }
    if (dataClassName == 'ReportStatus') {
      return deserialize<_i104.ReportStatus>(data['data']);
    }
    if (dataClassName == 'ReporterType') {
      return deserialize<_i105.ReporterType>(data['data']);
    }
    if (dataClassName == 'RequestStatus') {
      return deserialize<_i106.RequestStatus>(data['data']);
    }
    if (dataClassName == 'Review') {
      return deserialize<_i107.Review>(data['data']);
    }
    if (dataClassName == 'ReviewWithReviewer') {
      return deserialize<_i108.ReviewWithReviewer>(data['data']);
    }
    if (dataClassName == 'SearchLog') {
      return deserialize<_i109.SearchLog>(data['data']);
    }
    if (dataClassName == 'Service') {
      return deserialize<_i110.Service>(data['data']);
    }
    if (dataClassName == 'ServiceAnalytics') {
      return deserialize<_i111.ServiceAnalytics>(data['data']);
    }
    if (dataClassName == 'ServiceCategory') {
      return deserialize<_i112.ServiceCategory>(data['data']);
    }
    if (dataClassName == 'ServiceImage') {
      return deserialize<_i113.ServiceImage>(data['data']);
    }
    if (dataClassName == 'ServiceRequest') {
      return deserialize<_i114.ServiceRequest>(data['data']);
    }
    if (dataClassName == 'ServiceType') {
      return deserialize<_i115.ServiceType>(data['data']);
    }
    if (dataClassName == 'ShoppingItem') {
      return deserialize<_i116.ShoppingItem>(data['data']);
    }
    if (dataClassName == 'Store') {
      return deserialize<_i117.Store>(data['data']);
    }
    if (dataClassName == 'StoreCategory') {
      return deserialize<_i118.StoreCategory>(data['data']);
    }
    if (dataClassName == 'StoreDeliveryRequest') {
      return deserialize<_i119.StoreDeliveryRequest>(data['data']);
    }
    if (dataClassName == 'StoreOrder') {
      return deserialize<_i120.StoreOrder>(data['data']);
    }
    if (dataClassName == 'StoreOrderChat') {
      return deserialize<_i121.StoreOrderChat>(data['data']);
    }
    if (dataClassName == 'StoreOrderChatMessage') {
      return deserialize<_i122.StoreOrderChatMessage>(data['data']);
    }
    if (dataClassName == 'StoreOrderItem') {
      return deserialize<_i123.StoreOrderItem>(data['data']);
    }
    if (dataClassName == 'StoreOrderStatus') {
      return deserialize<_i124.StoreOrderStatus>(data['data']);
    }
    if (dataClassName == 'StoreProduct') {
      return deserialize<_i125.StoreProduct>(data['data']);
    }
    if (dataClassName == 'StoreReport') {
      return deserialize<_i126.StoreReport>(data['data']);
    }
    if (dataClassName == 'StoreReview') {
      return deserialize<_i127.StoreReview>(data['data']);
    }
    if (dataClassName == 'Subscription') {
      return deserialize<_i128.Subscription>(data['data']);
    }
    if (dataClassName == 'SubscriptionPlan') {
      return deserialize<_i129.SubscriptionPlan>(data['data']);
    }
    if (dataClassName == 'SubscriptionStatus') {
      return deserialize<_i130.SubscriptionStatus>(data['data']);
    }
    if (dataClassName == 'SystemSetting') {
      return deserialize<_i131.SystemSetting>(data['data']);
    }
    if (dataClassName == 'Transaction') {
      return deserialize<_i132.Transaction>(data['data']);
    }
    if (dataClassName == 'TransactionStatus') {
      return deserialize<_i133.TransactionStatus>(data['data']);
    }
    if (dataClassName == 'TransactionType') {
      return deserialize<_i134.TransactionType>(data['data']);
    }
    if (dataClassName == 'TrustScoreResult') {
      return deserialize<_i135.TrustScoreResult>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i136.User>(data['data']);
    }
    if (dataClassName == 'UserClient') {
      return deserialize<_i137.UserClient>(data['data']);
    }
    if (dataClassName == 'UserNotification') {
      return deserialize<_i138.UserNotification>(data['data']);
    }
    if (dataClassName == 'UserResponse') {
      return deserialize<_i139.UserResponse>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i140.UserRole>(data['data']);
    }
    if (dataClassName == 'UserStatus') {
      return deserialize<_i141.UserStatus>(data['data']);
    }
    if (dataClassName == 'VehicleType') {
      return deserialize<_i142.VehicleType>(data['data']);
    }
    if (dataClassName == 'Wallet') {
      return deserialize<_i143.Wallet>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.Address:
        return _i5.Address.t;
      case _i6.AdminAction:
        return _i6.AdminAction.t;
      case _i9.AdminUser:
        return _i9.AdminUser.t;
      case _i30.BlockedUser:
        return _i30.BlockedUser.t;
      case _i32.Category:
        return _i32.Category.t;
      case _i33.ChatMessage:
        return _i33.ChatMessage.t;
      case _i35.City:
        return _i35.City.t;
      case _i36.ClientReview:
        return _i36.ClientReview.t;
      case _i37.Country:
        return _i37.Country.t;
      case _i41.DeviceFingerprintRecord:
        return _i41.DeviceFingerprintRecord.t;
      case _i42.Dispute:
        return _i42.Dispute.t;
      case _i48.DriverOffer:
        return _i48.DriverOffer.t;
      case _i49.DriverProfile:
        return _i49.DriverProfile.t;
      case _i50.DriverProposal:
        return _i50.DriverProposal.t;
      case _i51.DriverService:
        return _i51.DriverService.t;
      case _i52.DriverStatistics:
        return _i52.DriverStatistics.t;
      case _i53.DriverZone:
        return _i53.DriverZone.t;
      case _i73.Favorite:
        return _i73.Favorite.t;
      case _i77.MediaMetadata:
        return _i77.MediaMetadata.t;
      case _i82.Order:
        return _i82.Order.t;
      case _i85.OrderStatusHistory:
        return _i85.OrderStatusHistory.t;
      case _i86.OrderTracking:
        return _i86.OrderTracking.t;
      case _i87.Payment:
        return _i87.Payment.t;
      case _i90.PlatformStatistics:
        return _i90.PlatformStatistics.t;
      case _i93.ProductCategory:
        return _i93.ProductCategory.t;
      case _i94.Promo:
        return _i94.Promo.t;
      case _i97.Rating:
        return _i97.Rating.t;
      case _i101.Report:
        return _i101.Report.t;
      case _i107.Review:
        return _i107.Review.t;
      case _i109.SearchLog:
        return _i109.SearchLog.t;
      case _i110.Service:
        return _i110.Service.t;
      case _i111.ServiceAnalytics:
        return _i111.ServiceAnalytics.t;
      case _i112.ServiceCategory:
        return _i112.ServiceCategory.t;
      case _i113.ServiceImage:
        return _i113.ServiceImage.t;
      case _i114.ServiceRequest:
        return _i114.ServiceRequest.t;
      case _i117.Store:
        return _i117.Store.t;
      case _i118.StoreCategory:
        return _i118.StoreCategory.t;
      case _i119.StoreDeliveryRequest:
        return _i119.StoreDeliveryRequest.t;
      case _i120.StoreOrder:
        return _i120.StoreOrder.t;
      case _i121.StoreOrderChat:
        return _i121.StoreOrderChat.t;
      case _i122.StoreOrderChatMessage:
        return _i122.StoreOrderChatMessage.t;
      case _i123.StoreOrderItem:
        return _i123.StoreOrderItem.t;
      case _i125.StoreProduct:
        return _i125.StoreProduct.t;
      case _i126.StoreReport:
        return _i126.StoreReport.t;
      case _i127.StoreReview:
        return _i127.StoreReview.t;
      case _i128.Subscription:
        return _i128.Subscription.t;
      case _i129.SubscriptionPlan:
        return _i129.SubscriptionPlan.t;
      case _i131.SystemSetting:
        return _i131.SystemSetting.t;
      case _i132.Transaction:
        return _i132.Transaction.t;
      case _i136.User:
        return _i136.User.t;
      case _i137.UserClient:
        return _i137.UserClient.t;
      case _i138.UserNotification:
        return _i138.UserNotification.t;
      case _i143.Wallet:
        return _i143.Wallet.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'awhar';
}
