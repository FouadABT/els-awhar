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
import 'address.dart' as _i2;
import 'admin_action.dart' as _i3;
import 'admin_action_type_enum.dart' as _i4;
import 'admin_login_response.dart' as _i5;
import 'admin_user.dart' as _i6;
import 'agent_builder_converse_response.dart' as _i7;
import 'agent_builder_step.dart' as _i8;
import 'agent_stream_event.dart' as _i9;
import 'agent_stream_status.dart' as _i10;
import 'ai_agent_status.dart' as _i11;
import 'ai_agent_status_response.dart' as _i12;
import 'ai_agent_type_enum.dart' as _i13;
import 'ai_confidence_level_enum.dart' as _i14;
import 'ai_demand_hotspot.dart' as _i15;
import 'ai_demand_prediction_response.dart' as _i16;
import 'ai_driver_matching_response.dart' as _i17;
import 'ai_driver_recommendation.dart' as _i18;
import 'ai_full_request_response.dart' as _i19;
import 'ai_help_article.dart' as _i20;
import 'ai_help_search_response.dart' as _i21;
import 'ai_parsed_service_request.dart' as _i22;
import 'ai_request_concierge_response.dart' as _i23;
import 'ai_response_status_enum.dart' as _i24;
import 'app_configuration.dart' as _i25;
import 'auth_response.dart' as _i26;
import 'blocked_user.dart' as _i27;
import 'canceller_type_enum.dart' as _i28;
import 'category.dart' as _i29;
import 'chat_message.dart' as _i30;
import 'chat_participants_info.dart' as _i31;
import 'city.dart' as _i32;
import 'client_review.dart' as _i33;
import 'country.dart' as _i34;
import 'dashboard_stats.dart' as _i35;
import 'device_fingerprint_check_result.dart' as _i36;
import 'device_fingerprint_input.dart' as _i37;
import 'device_fingerprint_record.dart' as _i38;
import 'dispute.dart' as _i39;
import 'dispute_status_enum.dart' as _i40;
import 'dispute_type_enum.dart' as _i41;
import 'driver_availability_status_enum.dart' as _i42;
import 'driver_earnings_response.dart' as _i43;
import 'driver_location.dart' as _i44;
import 'driver_offer.dart' as _i45;
import 'driver_profile.dart' as _i46;
import 'driver_proposal.dart' as _i47;
import 'driver_service.dart' as _i48;
import 'driver_statistics.dart' as _i49;
import 'driver_zone.dart' as _i50;
import 'es_category_count.dart' as _i51;
import 'es_driver_hit.dart' as _i52;
import 'es_driver_search_result.dart' as _i53;
import 'es_driver_service_hit.dart' as _i54;
import 'es_driver_service_search_result.dart' as _i55;
import 'es_popular_search_term.dart' as _i56;
import 'es_popular_searches_result.dart' as _i57;
import 'es_popular_service.dart' as _i58;
import 'es_popular_services_result.dart' as _i59;
import 'es_price_stats.dart' as _i60;
import 'es_price_stats_result.dart' as _i61;
import 'es_product_hit.dart' as _i62;
import 'es_product_search_result.dart' as _i63;
import 'es_search_result.dart' as _i64;
import 'es_service_category_counts_result.dart' as _i65;
import 'es_service_hit.dart' as _i66;
import 'es_service_search_result.dart' as _i67;
import 'es_store_hit.dart' as _i68;
import 'es_store_search_result.dart' as _i69;
import 'favorite.dart' as _i70;
import 'greetings/greeting.dart' as _i71;
import 'language_enum.dart' as _i72;
import 'location.dart' as _i73;
import 'media_metadata.dart' as _i74;
import 'message_type_enum.dart' as _i75;
import 'nearby_driver.dart' as _i76;
import 'notification_type.dart' as _i77;
import 'offer_status_enum.dart' as _i78;
import 'order.dart' as _i79;
import 'order_item.dart' as _i80;
import 'order_status_enum.dart' as _i81;
import 'order_status_history.dart' as _i82;
import 'order_tracking.dart' as _i83;
import 'payment.dart' as _i84;
import 'payment_method_enum.dart' as _i85;
import 'payment_status_enum.dart' as _i86;
import 'platform_statistics.dart' as _i87;
import 'price_negotiation_status_enum.dart' as _i88;
import 'price_type_enum.dart' as _i89;
import 'product_category.dart' as _i90;
import 'promo.dart' as _i91;
import 'promo_action_type_enum.dart' as _i92;
import 'proposal_status.dart' as _i93;
import 'rating.dart' as _i94;
import 'rating_stats.dart' as _i95;
import 'rating_type_enum.dart' as _i96;
import 'recent_activity.dart' as _i97;
import 'report.dart' as _i98;
import 'report_reason_enum.dart' as _i99;
import 'report_resolution_enum.dart' as _i100;
import 'report_status_enum.dart' as _i101;
import 'reporter_type_enum.dart' as _i102;
import 'request_status.dart' as _i103;
import 'review.dart' as _i104;
import 'review_with_reviewer.dart' as _i105;
import 'search_log.dart' as _i106;
import 'service.dart' as _i107;
import 'service_analytics.dart' as _i108;
import 'service_category.dart' as _i109;
import 'service_image.dart' as _i110;
import 'service_request.dart' as _i111;
import 'service_type.dart' as _i112;
import 'shopping_item.dart' as _i113;
import 'store.dart' as _i114;
import 'store_category.dart' as _i115;
import 'store_delivery_request.dart' as _i116;
import 'store_order.dart' as _i117;
import 'store_order_chat.dart' as _i118;
import 'store_order_chat_message.dart' as _i119;
import 'store_order_item.dart' as _i120;
import 'store_order_status_enum.dart' as _i121;
import 'store_product.dart' as _i122;
import 'store_report.dart' as _i123;
import 'store_review.dart' as _i124;
import 'subscription.dart' as _i125;
import 'subscription_plan.dart' as _i126;
import 'subscription_status_enum.dart' as _i127;
import 'system_setting.dart' as _i128;
import 'transaction.dart' as _i129;
import 'transaction_status.dart' as _i130;
import 'transaction_type.dart' as _i131;
import 'trust_score_result.dart' as _i132;
import 'user.dart' as _i133;
import 'user_client.dart' as _i134;
import 'user_notification.dart' as _i135;
import 'user_response.dart' as _i136;
import 'user_role_enum.dart' as _i137;
import 'user_status_enum.dart' as _i138;
import 'vehicle_type_enum.dart' as _i139;
import 'wallet.dart' as _i140;
import 'package:awhar_client/src/protocol/admin_user.dart' as _i141;
import 'package:awhar_client/src/protocol/user.dart' as _i142;
import 'package:awhar_client/src/protocol/driver_profile.dart' as _i143;
import 'package:awhar_client/src/protocol/store.dart' as _i144;
import 'package:awhar_client/src/protocol/store_order.dart' as _i145;
import 'package:awhar_client/src/protocol/service_request.dart' as _i146;
import 'package:awhar_client/src/protocol/transaction.dart' as _i147;
import 'package:awhar_client/src/protocol/report.dart' as _i148;
import 'package:awhar_client/src/protocol/recent_activity.dart' as _i149;
import 'package:awhar_client/src/protocol/blocked_user.dart' as _i150;
import 'package:awhar_client/src/protocol/chat_message.dart' as _i151;
import 'package:awhar_client/src/protocol/country.dart' as _i152;
import 'package:awhar_client/src/protocol/device_fingerprint_record.dart'
    as _i153;
import 'package:awhar_client/src/protocol/driver_service.dart' as _i154;
import 'package:awhar_client/src/protocol/service_image.dart' as _i155;
import 'package:awhar_client/src/protocol/media_metadata.dart' as _i156;
import 'package:awhar_client/src/protocol/user_notification.dart' as _i157;
import 'package:awhar_client/src/protocol/driver_offer.dart' as _i158;
import 'package:awhar_client/src/protocol/order.dart' as _i159;
import 'package:awhar_client/src/protocol/promo.dart' as _i160;
import 'package:awhar_client/src/protocol/driver_proposal.dart' as _i161;
import 'package:awhar_client/src/protocol/rating.dart' as _i162;
import 'package:awhar_client/src/protocol/shopping_item.dart' as _i163;
import 'package:awhar_client/src/protocol/client_review.dart' as _i164;
import 'package:awhar_client/src/protocol/review.dart' as _i165;
import 'package:awhar_client/src/protocol/service_category.dart' as _i166;
import 'package:awhar_client/src/protocol/service.dart' as _i167;
import 'package:awhar_client/src/protocol/nearby_driver.dart' as _i168;
import 'package:awhar_client/src/protocol/store_delivery_request.dart' as _i169;
import 'package:awhar_client/src/protocol/store_order_chat_message.dart'
    as _i170;
import 'package:awhar_client/src/protocol/store_category.dart' as _i171;
import 'package:awhar_client/src/protocol/order_item.dart' as _i172;
import 'package:awhar_client/src/protocol/product_category.dart' as _i173;
import 'package:awhar_client/src/protocol/store_product.dart' as _i174;
import 'package:awhar_client/src/protocol/store_review.dart' as _i175;
import 'package:awhar_client/src/protocol/review_with_reviewer.dart' as _i176;
import 'package:awhar_client/src/protocol/trust_score_result.dart' as _i177;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i178;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i179;
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
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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

    if (t == _i2.Address) {
      return _i2.Address.fromJson(data) as T;
    }
    if (t == _i3.AdminAction) {
      return _i3.AdminAction.fromJson(data) as T;
    }
    if (t == _i4.AdminActionType) {
      return _i4.AdminActionType.fromJson(data) as T;
    }
    if (t == _i5.AdminLoginResponse) {
      return _i5.AdminLoginResponse.fromJson(data) as T;
    }
    if (t == _i6.AdminUser) {
      return _i6.AdminUser.fromJson(data) as T;
    }
    if (t == _i7.AgentBuilderConverseResponse) {
      return _i7.AgentBuilderConverseResponse.fromJson(data) as T;
    }
    if (t == _i8.AgentBuilderStep) {
      return _i8.AgentBuilderStep.fromJson(data) as T;
    }
    if (t == _i9.AgentStreamEvent) {
      return _i9.AgentStreamEvent.fromJson(data) as T;
    }
    if (t == _i10.AgentStreamStatus) {
      return _i10.AgentStreamStatus.fromJson(data) as T;
    }
    if (t == _i11.AiAgentStatus) {
      return _i11.AiAgentStatus.fromJson(data) as T;
    }
    if (t == _i12.AiAgentStatusResponse) {
      return _i12.AiAgentStatusResponse.fromJson(data) as T;
    }
    if (t == _i13.AiAgentType) {
      return _i13.AiAgentType.fromJson(data) as T;
    }
    if (t == _i14.AiConfidenceLevel) {
      return _i14.AiConfidenceLevel.fromJson(data) as T;
    }
    if (t == _i15.AiDemandHotspot) {
      return _i15.AiDemandHotspot.fromJson(data) as T;
    }
    if (t == _i16.AiDemandPredictionResponse) {
      return _i16.AiDemandPredictionResponse.fromJson(data) as T;
    }
    if (t == _i17.AiDriverMatchingResponse) {
      return _i17.AiDriverMatchingResponse.fromJson(data) as T;
    }
    if (t == _i18.AiDriverRecommendation) {
      return _i18.AiDriverRecommendation.fromJson(data) as T;
    }
    if (t == _i19.AiFullRequestResponse) {
      return _i19.AiFullRequestResponse.fromJson(data) as T;
    }
    if (t == _i20.AiHelpArticle) {
      return _i20.AiHelpArticle.fromJson(data) as T;
    }
    if (t == _i21.AiHelpSearchResponse) {
      return _i21.AiHelpSearchResponse.fromJson(data) as T;
    }
    if (t == _i22.AiParsedServiceRequest) {
      return _i22.AiParsedServiceRequest.fromJson(data) as T;
    }
    if (t == _i23.AiRequestConciergeResponse) {
      return _i23.AiRequestConciergeResponse.fromJson(data) as T;
    }
    if (t == _i24.AiResponseStatus) {
      return _i24.AiResponseStatus.fromJson(data) as T;
    }
    if (t == _i25.AppConfiguration) {
      return _i25.AppConfiguration.fromJson(data) as T;
    }
    if (t == _i26.AuthResponse) {
      return _i26.AuthResponse.fromJson(data) as T;
    }
    if (t == _i27.BlockedUser) {
      return _i27.BlockedUser.fromJson(data) as T;
    }
    if (t == _i28.CancellerType) {
      return _i28.CancellerType.fromJson(data) as T;
    }
    if (t == _i29.Category) {
      return _i29.Category.fromJson(data) as T;
    }
    if (t == _i30.ChatMessage) {
      return _i30.ChatMessage.fromJson(data) as T;
    }
    if (t == _i31.ChatParticipantsInfo) {
      return _i31.ChatParticipantsInfo.fromJson(data) as T;
    }
    if (t == _i32.City) {
      return _i32.City.fromJson(data) as T;
    }
    if (t == _i33.ClientReview) {
      return _i33.ClientReview.fromJson(data) as T;
    }
    if (t == _i34.Country) {
      return _i34.Country.fromJson(data) as T;
    }
    if (t == _i35.DashboardStats) {
      return _i35.DashboardStats.fromJson(data) as T;
    }
    if (t == _i36.DeviceFingerprintCheckResult) {
      return _i36.DeviceFingerprintCheckResult.fromJson(data) as T;
    }
    if (t == _i37.DeviceFingerprintInput) {
      return _i37.DeviceFingerprintInput.fromJson(data) as T;
    }
    if (t == _i38.DeviceFingerprintRecord) {
      return _i38.DeviceFingerprintRecord.fromJson(data) as T;
    }
    if (t == _i39.Dispute) {
      return _i39.Dispute.fromJson(data) as T;
    }
    if (t == _i40.DisputeStatus) {
      return _i40.DisputeStatus.fromJson(data) as T;
    }
    if (t == _i41.DisputeType) {
      return _i41.DisputeType.fromJson(data) as T;
    }
    if (t == _i42.DriverAvailabilityStatus) {
      return _i42.DriverAvailabilityStatus.fromJson(data) as T;
    }
    if (t == _i43.DriverEarningsResponse) {
      return _i43.DriverEarningsResponse.fromJson(data) as T;
    }
    if (t == _i44.DriverLocation) {
      return _i44.DriverLocation.fromJson(data) as T;
    }
    if (t == _i45.DriverOffer) {
      return _i45.DriverOffer.fromJson(data) as T;
    }
    if (t == _i46.DriverProfile) {
      return _i46.DriverProfile.fromJson(data) as T;
    }
    if (t == _i47.DriverProposal) {
      return _i47.DriverProposal.fromJson(data) as T;
    }
    if (t == _i48.DriverService) {
      return _i48.DriverService.fromJson(data) as T;
    }
    if (t == _i49.DriverStatistics) {
      return _i49.DriverStatistics.fromJson(data) as T;
    }
    if (t == _i50.DriverZone) {
      return _i50.DriverZone.fromJson(data) as T;
    }
    if (t == _i51.EsCategoryCount) {
      return _i51.EsCategoryCount.fromJson(data) as T;
    }
    if (t == _i52.EsDriverHit) {
      return _i52.EsDriverHit.fromJson(data) as T;
    }
    if (t == _i53.EsDriverSearchResult) {
      return _i53.EsDriverSearchResult.fromJson(data) as T;
    }
    if (t == _i54.EsDriverServiceHit) {
      return _i54.EsDriverServiceHit.fromJson(data) as T;
    }
    if (t == _i55.EsDriverServiceSearchResult) {
      return _i55.EsDriverServiceSearchResult.fromJson(data) as T;
    }
    if (t == _i56.EsPopularSearchTerm) {
      return _i56.EsPopularSearchTerm.fromJson(data) as T;
    }
    if (t == _i57.EsPopularSearchesResult) {
      return _i57.EsPopularSearchesResult.fromJson(data) as T;
    }
    if (t == _i58.EsPopularService) {
      return _i58.EsPopularService.fromJson(data) as T;
    }
    if (t == _i59.EsPopularServicesResult) {
      return _i59.EsPopularServicesResult.fromJson(data) as T;
    }
    if (t == _i60.EsPriceStats) {
      return _i60.EsPriceStats.fromJson(data) as T;
    }
    if (t == _i61.EsPriceStatsResult) {
      return _i61.EsPriceStatsResult.fromJson(data) as T;
    }
    if (t == _i62.EsProductHit) {
      return _i62.EsProductHit.fromJson(data) as T;
    }
    if (t == _i63.EsProductSearchResult) {
      return _i63.EsProductSearchResult.fromJson(data) as T;
    }
    if (t == _i64.EsSearchResult) {
      return _i64.EsSearchResult.fromJson(data) as T;
    }
    if (t == _i65.EsServiceCategoryCountsResult) {
      return _i65.EsServiceCategoryCountsResult.fromJson(data) as T;
    }
    if (t == _i66.EsServiceHit) {
      return _i66.EsServiceHit.fromJson(data) as T;
    }
    if (t == _i67.EsServiceSearchResult) {
      return _i67.EsServiceSearchResult.fromJson(data) as T;
    }
    if (t == _i68.EsStoreHit) {
      return _i68.EsStoreHit.fromJson(data) as T;
    }
    if (t == _i69.EsStoreSearchResult) {
      return _i69.EsStoreSearchResult.fromJson(data) as T;
    }
    if (t == _i70.Favorite) {
      return _i70.Favorite.fromJson(data) as T;
    }
    if (t == _i71.Greeting) {
      return _i71.Greeting.fromJson(data) as T;
    }
    if (t == _i72.Language) {
      return _i72.Language.fromJson(data) as T;
    }
    if (t == _i73.Location) {
      return _i73.Location.fromJson(data) as T;
    }
    if (t == _i74.MediaMetadata) {
      return _i74.MediaMetadata.fromJson(data) as T;
    }
    if (t == _i75.MessageType) {
      return _i75.MessageType.fromJson(data) as T;
    }
    if (t == _i76.NearbyDriver) {
      return _i76.NearbyDriver.fromJson(data) as T;
    }
    if (t == _i77.NotificationType) {
      return _i77.NotificationType.fromJson(data) as T;
    }
    if (t == _i78.OfferStatus) {
      return _i78.OfferStatus.fromJson(data) as T;
    }
    if (t == _i79.Order) {
      return _i79.Order.fromJson(data) as T;
    }
    if (t == _i80.OrderItem) {
      return _i80.OrderItem.fromJson(data) as T;
    }
    if (t == _i81.OrderStatus) {
      return _i81.OrderStatus.fromJson(data) as T;
    }
    if (t == _i82.OrderStatusHistory) {
      return _i82.OrderStatusHistory.fromJson(data) as T;
    }
    if (t == _i83.OrderTracking) {
      return _i83.OrderTracking.fromJson(data) as T;
    }
    if (t == _i84.Payment) {
      return _i84.Payment.fromJson(data) as T;
    }
    if (t == _i85.PaymentMethod) {
      return _i85.PaymentMethod.fromJson(data) as T;
    }
    if (t == _i86.PaymentStatus) {
      return _i86.PaymentStatus.fromJson(data) as T;
    }
    if (t == _i87.PlatformStatistics) {
      return _i87.PlatformStatistics.fromJson(data) as T;
    }
    if (t == _i88.PriceNegotiationStatus) {
      return _i88.PriceNegotiationStatus.fromJson(data) as T;
    }
    if (t == _i89.PriceType) {
      return _i89.PriceType.fromJson(data) as T;
    }
    if (t == _i90.ProductCategory) {
      return _i90.ProductCategory.fromJson(data) as T;
    }
    if (t == _i91.Promo) {
      return _i91.Promo.fromJson(data) as T;
    }
    if (t == _i92.PromoActionType) {
      return _i92.PromoActionType.fromJson(data) as T;
    }
    if (t == _i93.ProposalStatus) {
      return _i93.ProposalStatus.fromJson(data) as T;
    }
    if (t == _i94.Rating) {
      return _i94.Rating.fromJson(data) as T;
    }
    if (t == _i95.RatingStats) {
      return _i95.RatingStats.fromJson(data) as T;
    }
    if (t == _i96.RatingType) {
      return _i96.RatingType.fromJson(data) as T;
    }
    if (t == _i97.RecentActivity) {
      return _i97.RecentActivity.fromJson(data) as T;
    }
    if (t == _i98.Report) {
      return _i98.Report.fromJson(data) as T;
    }
    if (t == _i99.ReportReason) {
      return _i99.ReportReason.fromJson(data) as T;
    }
    if (t == _i100.ReportResolution) {
      return _i100.ReportResolution.fromJson(data) as T;
    }
    if (t == _i101.ReportStatus) {
      return _i101.ReportStatus.fromJson(data) as T;
    }
    if (t == _i102.ReporterType) {
      return _i102.ReporterType.fromJson(data) as T;
    }
    if (t == _i103.RequestStatus) {
      return _i103.RequestStatus.fromJson(data) as T;
    }
    if (t == _i104.Review) {
      return _i104.Review.fromJson(data) as T;
    }
    if (t == _i105.ReviewWithReviewer) {
      return _i105.ReviewWithReviewer.fromJson(data) as T;
    }
    if (t == _i106.SearchLog) {
      return _i106.SearchLog.fromJson(data) as T;
    }
    if (t == _i107.Service) {
      return _i107.Service.fromJson(data) as T;
    }
    if (t == _i108.ServiceAnalytics) {
      return _i108.ServiceAnalytics.fromJson(data) as T;
    }
    if (t == _i109.ServiceCategory) {
      return _i109.ServiceCategory.fromJson(data) as T;
    }
    if (t == _i110.ServiceImage) {
      return _i110.ServiceImage.fromJson(data) as T;
    }
    if (t == _i111.ServiceRequest) {
      return _i111.ServiceRequest.fromJson(data) as T;
    }
    if (t == _i112.ServiceType) {
      return _i112.ServiceType.fromJson(data) as T;
    }
    if (t == _i113.ShoppingItem) {
      return _i113.ShoppingItem.fromJson(data) as T;
    }
    if (t == _i114.Store) {
      return _i114.Store.fromJson(data) as T;
    }
    if (t == _i115.StoreCategory) {
      return _i115.StoreCategory.fromJson(data) as T;
    }
    if (t == _i116.StoreDeliveryRequest) {
      return _i116.StoreDeliveryRequest.fromJson(data) as T;
    }
    if (t == _i117.StoreOrder) {
      return _i117.StoreOrder.fromJson(data) as T;
    }
    if (t == _i118.StoreOrderChat) {
      return _i118.StoreOrderChat.fromJson(data) as T;
    }
    if (t == _i119.StoreOrderChatMessage) {
      return _i119.StoreOrderChatMessage.fromJson(data) as T;
    }
    if (t == _i120.StoreOrderItem) {
      return _i120.StoreOrderItem.fromJson(data) as T;
    }
    if (t == _i121.StoreOrderStatus) {
      return _i121.StoreOrderStatus.fromJson(data) as T;
    }
    if (t == _i122.StoreProduct) {
      return _i122.StoreProduct.fromJson(data) as T;
    }
    if (t == _i123.StoreReport) {
      return _i123.StoreReport.fromJson(data) as T;
    }
    if (t == _i124.StoreReview) {
      return _i124.StoreReview.fromJson(data) as T;
    }
    if (t == _i125.Subscription) {
      return _i125.Subscription.fromJson(data) as T;
    }
    if (t == _i126.SubscriptionPlan) {
      return _i126.SubscriptionPlan.fromJson(data) as T;
    }
    if (t == _i127.SubscriptionStatus) {
      return _i127.SubscriptionStatus.fromJson(data) as T;
    }
    if (t == _i128.SystemSetting) {
      return _i128.SystemSetting.fromJson(data) as T;
    }
    if (t == _i129.Transaction) {
      return _i129.Transaction.fromJson(data) as T;
    }
    if (t == _i130.TransactionStatus) {
      return _i130.TransactionStatus.fromJson(data) as T;
    }
    if (t == _i131.TransactionType) {
      return _i131.TransactionType.fromJson(data) as T;
    }
    if (t == _i132.TrustScoreResult) {
      return _i132.TrustScoreResult.fromJson(data) as T;
    }
    if (t == _i133.User) {
      return _i133.User.fromJson(data) as T;
    }
    if (t == _i134.UserClient) {
      return _i134.UserClient.fromJson(data) as T;
    }
    if (t == _i135.UserNotification) {
      return _i135.UserNotification.fromJson(data) as T;
    }
    if (t == _i136.UserResponse) {
      return _i136.UserResponse.fromJson(data) as T;
    }
    if (t == _i137.UserRole) {
      return _i137.UserRole.fromJson(data) as T;
    }
    if (t == _i138.UserStatus) {
      return _i138.UserStatus.fromJson(data) as T;
    }
    if (t == _i139.VehicleType) {
      return _i139.VehicleType.fromJson(data) as T;
    }
    if (t == _i140.Wallet) {
      return _i140.Wallet.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Address?>()) {
      return (data != null ? _i2.Address.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AdminAction?>()) {
      return (data != null ? _i3.AdminAction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AdminActionType?>()) {
      return (data != null ? _i4.AdminActionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AdminLoginResponse?>()) {
      return (data != null ? _i5.AdminLoginResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AdminUser?>()) {
      return (data != null ? _i6.AdminUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AgentBuilderConverseResponse?>()) {
      return (data != null
              ? _i7.AgentBuilderConverseResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i8.AgentBuilderStep?>()) {
      return (data != null ? _i8.AgentBuilderStep.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.AgentStreamEvent?>()) {
      return (data != null ? _i9.AgentStreamEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AgentStreamStatus?>()) {
      return (data != null ? _i10.AgentStreamStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.AiAgentStatus?>()) {
      return (data != null ? _i11.AiAgentStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.AiAgentStatusResponse?>()) {
      return (data != null ? _i12.AiAgentStatusResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.AiAgentType?>()) {
      return (data != null ? _i13.AiAgentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.AiConfidenceLevel?>()) {
      return (data != null ? _i14.AiConfidenceLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.AiDemandHotspot?>()) {
      return (data != null ? _i15.AiDemandHotspot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.AiDemandPredictionResponse?>()) {
      return (data != null
              ? _i16.AiDemandPredictionResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i17.AiDriverMatchingResponse?>()) {
      return (data != null
              ? _i17.AiDriverMatchingResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i18.AiDriverRecommendation?>()) {
      return (data != null ? _i18.AiDriverRecommendation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.AiFullRequestResponse?>()) {
      return (data != null ? _i19.AiFullRequestResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.AiHelpArticle?>()) {
      return (data != null ? _i20.AiHelpArticle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.AiHelpSearchResponse?>()) {
      return (data != null ? _i21.AiHelpSearchResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.AiParsedServiceRequest?>()) {
      return (data != null ? _i22.AiParsedServiceRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.AiRequestConciergeResponse?>()) {
      return (data != null
              ? _i23.AiRequestConciergeResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i24.AiResponseStatus?>()) {
      return (data != null ? _i24.AiResponseStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.AppConfiguration?>()) {
      return (data != null ? _i25.AppConfiguration.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.AuthResponse?>()) {
      return (data != null ? _i26.AuthResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.BlockedUser?>()) {
      return (data != null ? _i27.BlockedUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.CancellerType?>()) {
      return (data != null ? _i28.CancellerType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.Category?>()) {
      return (data != null ? _i29.Category.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.ChatMessage?>()) {
      return (data != null ? _i30.ChatMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.ChatParticipantsInfo?>()) {
      return (data != null ? _i31.ChatParticipantsInfo.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.City?>()) {
      return (data != null ? _i32.City.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.ClientReview?>()) {
      return (data != null ? _i33.ClientReview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.Country?>()) {
      return (data != null ? _i34.Country.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.DashboardStats?>()) {
      return (data != null ? _i35.DashboardStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.DeviceFingerprintCheckResult?>()) {
      return (data != null
              ? _i36.DeviceFingerprintCheckResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i37.DeviceFingerprintInput?>()) {
      return (data != null ? _i37.DeviceFingerprintInput.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i38.DeviceFingerprintRecord?>()) {
      return (data != null ? _i38.DeviceFingerprintRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.Dispute?>()) {
      return (data != null ? _i39.Dispute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.DisputeStatus?>()) {
      return (data != null ? _i40.DisputeStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.DisputeType?>()) {
      return (data != null ? _i41.DisputeType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.DriverAvailabilityStatus?>()) {
      return (data != null
              ? _i42.DriverAvailabilityStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i43.DriverEarningsResponse?>()) {
      return (data != null ? _i43.DriverEarningsResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.DriverLocation?>()) {
      return (data != null ? _i44.DriverLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.DriverOffer?>()) {
      return (data != null ? _i45.DriverOffer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.DriverProfile?>()) {
      return (data != null ? _i46.DriverProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.DriverProposal?>()) {
      return (data != null ? _i47.DriverProposal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.DriverService?>()) {
      return (data != null ? _i48.DriverService.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.DriverStatistics?>()) {
      return (data != null ? _i49.DriverStatistics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.DriverZone?>()) {
      return (data != null ? _i50.DriverZone.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.EsCategoryCount?>()) {
      return (data != null ? _i51.EsCategoryCount.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.EsDriverHit?>()) {
      return (data != null ? _i52.EsDriverHit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.EsDriverSearchResult?>()) {
      return (data != null ? _i53.EsDriverSearchResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.EsDriverServiceHit?>()) {
      return (data != null ? _i54.EsDriverServiceHit.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.EsDriverServiceSearchResult?>()) {
      return (data != null
              ? _i55.EsDriverServiceSearchResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i56.EsPopularSearchTerm?>()) {
      return (data != null ? _i56.EsPopularSearchTerm.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i57.EsPopularSearchesResult?>()) {
      return (data != null ? _i57.EsPopularSearchesResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i58.EsPopularService?>()) {
      return (data != null ? _i58.EsPopularService.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.EsPopularServicesResult?>()) {
      return (data != null ? _i59.EsPopularServicesResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i60.EsPriceStats?>()) {
      return (data != null ? _i60.EsPriceStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.EsPriceStatsResult?>()) {
      return (data != null ? _i61.EsPriceStatsResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i62.EsProductHit?>()) {
      return (data != null ? _i62.EsProductHit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.EsProductSearchResult?>()) {
      return (data != null ? _i63.EsProductSearchResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i64.EsSearchResult?>()) {
      return (data != null ? _i64.EsSearchResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.EsServiceCategoryCountsResult?>()) {
      return (data != null
              ? _i65.EsServiceCategoryCountsResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i66.EsServiceHit?>()) {
      return (data != null ? _i66.EsServiceHit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.EsServiceSearchResult?>()) {
      return (data != null ? _i67.EsServiceSearchResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i68.EsStoreHit?>()) {
      return (data != null ? _i68.EsStoreHit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.EsStoreSearchResult?>()) {
      return (data != null ? _i69.EsStoreSearchResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i70.Favorite?>()) {
      return (data != null ? _i70.Favorite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.Greeting?>()) {
      return (data != null ? _i71.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.Language?>()) {
      return (data != null ? _i72.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.Location?>()) {
      return (data != null ? _i73.Location.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.MediaMetadata?>()) {
      return (data != null ? _i74.MediaMetadata.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i75.MessageType?>()) {
      return (data != null ? _i75.MessageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.NearbyDriver?>()) {
      return (data != null ? _i76.NearbyDriver.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.NotificationType?>()) {
      return (data != null ? _i77.NotificationType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i78.OfferStatus?>()) {
      return (data != null ? _i78.OfferStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.Order?>()) {
      return (data != null ? _i79.Order.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.OrderItem?>()) {
      return (data != null ? _i80.OrderItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i81.OrderStatus?>()) {
      return (data != null ? _i81.OrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i82.OrderStatusHistory?>()) {
      return (data != null ? _i82.OrderStatusHistory.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i83.OrderTracking?>()) {
      return (data != null ? _i83.OrderTracking.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i84.Payment?>()) {
      return (data != null ? _i84.Payment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i85.PaymentMethod?>()) {
      return (data != null ? _i85.PaymentMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i86.PaymentStatus?>()) {
      return (data != null ? _i86.PaymentStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i87.PlatformStatistics?>()) {
      return (data != null ? _i87.PlatformStatistics.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i88.PriceNegotiationStatus?>()) {
      return (data != null ? _i88.PriceNegotiationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i89.PriceType?>()) {
      return (data != null ? _i89.PriceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i90.ProductCategory?>()) {
      return (data != null ? _i90.ProductCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i91.Promo?>()) {
      return (data != null ? _i91.Promo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i92.PromoActionType?>()) {
      return (data != null ? _i92.PromoActionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i93.ProposalStatus?>()) {
      return (data != null ? _i93.ProposalStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i94.Rating?>()) {
      return (data != null ? _i94.Rating.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i95.RatingStats?>()) {
      return (data != null ? _i95.RatingStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i96.RatingType?>()) {
      return (data != null ? _i96.RatingType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i97.RecentActivity?>()) {
      return (data != null ? _i97.RecentActivity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i98.Report?>()) {
      return (data != null ? _i98.Report.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i99.ReportReason?>()) {
      return (data != null ? _i99.ReportReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i100.ReportResolution?>()) {
      return (data != null ? _i100.ReportResolution.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i101.ReportStatus?>()) {
      return (data != null ? _i101.ReportStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i102.ReporterType?>()) {
      return (data != null ? _i102.ReporterType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i103.RequestStatus?>()) {
      return (data != null ? _i103.RequestStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i104.Review?>()) {
      return (data != null ? _i104.Review.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i105.ReviewWithReviewer?>()) {
      return (data != null ? _i105.ReviewWithReviewer.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i106.SearchLog?>()) {
      return (data != null ? _i106.SearchLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i107.Service?>()) {
      return (data != null ? _i107.Service.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i108.ServiceAnalytics?>()) {
      return (data != null ? _i108.ServiceAnalytics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i109.ServiceCategory?>()) {
      return (data != null ? _i109.ServiceCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i110.ServiceImage?>()) {
      return (data != null ? _i110.ServiceImage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i111.ServiceRequest?>()) {
      return (data != null ? _i111.ServiceRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i112.ServiceType?>()) {
      return (data != null ? _i112.ServiceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i113.ShoppingItem?>()) {
      return (data != null ? _i113.ShoppingItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i114.Store?>()) {
      return (data != null ? _i114.Store.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i115.StoreCategory?>()) {
      return (data != null ? _i115.StoreCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i116.StoreDeliveryRequest?>()) {
      return (data != null ? _i116.StoreDeliveryRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i117.StoreOrder?>()) {
      return (data != null ? _i117.StoreOrder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i118.StoreOrderChat?>()) {
      return (data != null ? _i118.StoreOrderChat.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i119.StoreOrderChatMessage?>()) {
      return (data != null ? _i119.StoreOrderChatMessage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i120.StoreOrderItem?>()) {
      return (data != null ? _i120.StoreOrderItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i121.StoreOrderStatus?>()) {
      return (data != null ? _i121.StoreOrderStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i122.StoreProduct?>()) {
      return (data != null ? _i122.StoreProduct.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i123.StoreReport?>()) {
      return (data != null ? _i123.StoreReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i124.StoreReview?>()) {
      return (data != null ? _i124.StoreReview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i125.Subscription?>()) {
      return (data != null ? _i125.Subscription.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i126.SubscriptionPlan?>()) {
      return (data != null ? _i126.SubscriptionPlan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i127.SubscriptionStatus?>()) {
      return (data != null ? _i127.SubscriptionStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i128.SystemSetting?>()) {
      return (data != null ? _i128.SystemSetting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i129.Transaction?>()) {
      return (data != null ? _i129.Transaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i130.TransactionStatus?>()) {
      return (data != null ? _i130.TransactionStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i131.TransactionType?>()) {
      return (data != null ? _i131.TransactionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i132.TrustScoreResult?>()) {
      return (data != null ? _i132.TrustScoreResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i133.User?>()) {
      return (data != null ? _i133.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i134.UserClient?>()) {
      return (data != null ? _i134.UserClient.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i135.UserNotification?>()) {
      return (data != null ? _i135.UserNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i136.UserResponse?>()) {
      return (data != null ? _i136.UserResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i137.UserRole?>()) {
      return (data != null ? _i137.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i138.UserStatus?>()) {
      return (data != null ? _i138.UserStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i139.VehicleType?>()) {
      return (data != null ? _i139.VehicleType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i140.Wallet?>()) {
      return (data != null ? _i140.Wallet.fromJson(data) : null) as T;
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
    if (t == List<_i8.AgentBuilderStep>) {
      return (data as List)
              .map((e) => deserialize<_i8.AgentBuilderStep>(e))
              .toList()
          as T;
    }
    if (t == List<_i9.AgentStreamEvent>) {
      return (data as List)
              .map((e) => deserialize<_i9.AgentStreamEvent>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i8.AgentBuilderStep>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i8.AgentBuilderStep>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i11.AiAgentStatus>) {
      return (data as List)
              .map((e) => deserialize<_i11.AiAgentStatus>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i15.AiDemandHotspot>) {
      return (data as List)
              .map((e) => deserialize<_i15.AiDemandHotspot>(e))
              .toList()
          as T;
    }
    if (t == List<_i18.AiDriverRecommendation>) {
      return (data as List)
              .map((e) => deserialize<_i18.AiDriverRecommendation>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.AiHelpArticle>) {
      return (data as List)
              .map((e) => deserialize<_i20.AiHelpArticle>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i129.Transaction>) {
      return (data as List)
              .map((e) => deserialize<_i129.Transaction>(e))
              .toList()
          as T;
    }
    if (t == List<_i52.EsDriverHit>) {
      return (data as List)
              .map((e) => deserialize<_i52.EsDriverHit>(e))
              .toList()
          as T;
    }
    if (t == List<_i54.EsDriverServiceHit>) {
      return (data as List)
              .map((e) => deserialize<_i54.EsDriverServiceHit>(e))
              .toList()
          as T;
    }
    if (t == List<_i56.EsPopularSearchTerm>) {
      return (data as List)
              .map((e) => deserialize<_i56.EsPopularSearchTerm>(e))
              .toList()
          as T;
    }
    if (t == List<_i58.EsPopularService>) {
      return (data as List)
              .map((e) => deserialize<_i58.EsPopularService>(e))
              .toList()
          as T;
    }
    if (t == List<_i60.EsPriceStats>) {
      return (data as List)
              .map((e) => deserialize<_i60.EsPriceStats>(e))
              .toList()
          as T;
    }
    if (t == List<_i62.EsProductHit>) {
      return (data as List)
              .map((e) => deserialize<_i62.EsProductHit>(e))
              .toList()
          as T;
    }
    if (t == List<_i51.EsCategoryCount>) {
      return (data as List)
              .map((e) => deserialize<_i51.EsCategoryCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i66.EsServiceHit>) {
      return (data as List)
              .map((e) => deserialize<_i66.EsServiceHit>(e))
              .toList()
          as T;
    }
    if (t == List<_i68.EsStoreHit>) {
      return (data as List).map((e) => deserialize<_i68.EsStoreHit>(e)).toList()
          as T;
    }
    if (t == List<_i113.ShoppingItem>) {
      return (data as List)
              .map((e) => deserialize<_i113.ShoppingItem>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i113.ShoppingItem>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i113.ShoppingItem>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i137.UserRole>) {
      return (data as List).map((e) => deserialize<_i137.UserRole>(e)).toList()
          as T;
    }
    if (t == List<_i141.AdminUser>) {
      return (data as List).map((e) => deserialize<_i141.AdminUser>(e)).toList()
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
    if (t == List<_i142.User>) {
      return (data as List).map((e) => deserialize<_i142.User>(e)).toList()
          as T;
    }
    if (t == List<_i143.DriverProfile>) {
      return (data as List)
              .map((e) => deserialize<_i143.DriverProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i144.Store>) {
      return (data as List).map((e) => deserialize<_i144.Store>(e)).toList()
          as T;
    }
    if (t == List<_i145.StoreOrder>) {
      return (data as List)
              .map((e) => deserialize<_i145.StoreOrder>(e))
              .toList()
          as T;
    }
    if (t == List<_i146.ServiceRequest>) {
      return (data as List)
              .map((e) => deserialize<_i146.ServiceRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i147.Transaction>) {
      return (data as List)
              .map((e) => deserialize<_i147.Transaction>(e))
              .toList()
          as T;
    }
    if (t == List<_i148.Report>) {
      return (data as List).map((e) => deserialize<_i148.Report>(e)).toList()
          as T;
    }
    if (t == List<_i149.RecentActivity>) {
      return (data as List)
              .map((e) => deserialize<_i149.RecentActivity>(e))
              .toList()
          as T;
    }
    if (t == List<_i150.BlockedUser>) {
      return (data as List)
              .map((e) => deserialize<_i150.BlockedUser>(e))
              .toList()
          as T;
    }
    if (t == List<_i151.ChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_i151.ChatMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_i152.Country>) {
      return (data as List).map((e) => deserialize<_i152.Country>(e)).toList()
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    if (t == List<_i153.DeviceFingerprintRecord>) {
      return (data as List)
              .map((e) => deserialize<_i153.DeviceFingerprintRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i154.DriverService>) {
      return (data as List)
              .map((e) => deserialize<_i154.DriverService>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i155.ServiceImage>) {
      return (data as List)
              .map((e) => deserialize<_i155.ServiceImage>(e))
              .toList()
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == List<_i156.MediaMetadata>) {
      return (data as List)
              .map((e) => deserialize<_i156.MediaMetadata>(e))
              .toList()
          as T;
    }
    if (t == List<_i157.UserNotification>) {
      return (data as List)
              .map((e) => deserialize<_i157.UserNotification>(e))
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
    if (t == List<_i158.DriverOffer>) {
      return (data as List)
              .map((e) => deserialize<_i158.DriverOffer>(e))
              .toList()
          as T;
    }
    if (t == List<_i159.Order>) {
      return (data as List).map((e) => deserialize<_i159.Order>(e)).toList()
          as T;
    }
    if (t == List<_i160.Promo>) {
      return (data as List).map((e) => deserialize<_i160.Promo>(e)).toList()
          as T;
    }
    if (t == List<_i161.DriverProposal>) {
      return (data as List)
              .map((e) => deserialize<_i161.DriverProposal>(e))
              .toList()
          as T;
    }
    if (t == List<_i162.Rating>) {
      return (data as List).map((e) => deserialize<_i162.Rating>(e)).toList()
          as T;
    }
    if (t == Map<String, bool>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<bool>(v)),
          )
          as T;
    }
    if (t == List<_i163.ShoppingItem>) {
      return (data as List)
              .map((e) => deserialize<_i163.ShoppingItem>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i163.ShoppingItem>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i163.ShoppingItem>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i164.ClientReview>) {
      return (data as List)
              .map((e) => deserialize<_i164.ClientReview>(e))
              .toList()
          as T;
    }
    if (t == List<_i165.Review>) {
      return (data as List).map((e) => deserialize<_i165.Review>(e)).toList()
          as T;
    }
    if (t == List<_i166.ServiceCategory>) {
      return (data as List)
              .map((e) => deserialize<_i166.ServiceCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_i167.Service>) {
      return (data as List).map((e) => deserialize<_i167.Service>(e)).toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i168.NearbyDriver>) {
      return (data as List)
              .map((e) => deserialize<_i168.NearbyDriver>(e))
              .toList()
          as T;
    }
    if (t == List<_i169.StoreDeliveryRequest>) {
      return (data as List)
              .map((e) => deserialize<_i169.StoreDeliveryRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i170.StoreOrderChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_i170.StoreOrderChatMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_i171.StoreCategory>) {
      return (data as List)
              .map((e) => deserialize<_i171.StoreCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_i172.OrderItem>) {
      return (data as List).map((e) => deserialize<_i172.OrderItem>(e)).toList()
          as T;
    }
    if (t == List<_i173.ProductCategory>) {
      return (data as List)
              .map((e) => deserialize<_i173.ProductCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_i174.StoreProduct>) {
      return (data as List)
              .map((e) => deserialize<_i174.StoreProduct>(e))
              .toList()
          as T;
    }
    if (t == List<_i175.StoreReview>) {
      return (data as List)
              .map((e) => deserialize<_i175.StoreReview>(e))
              .toList()
          as T;
    }
    if (t == List<_i176.ReviewWithReviewer>) {
      return (data as List)
              .map((e) => deserialize<_i176.ReviewWithReviewer>(e))
              .toList()
          as T;
    }
    if (t == List<_i177.TrustScoreResult>) {
      return (data as List)
              .map((e) => deserialize<_i177.TrustScoreResult>(e))
              .toList()
          as T;
    }
    try {
      return _i178.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i179.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Address => 'Address',
      _i3.AdminAction => 'AdminAction',
      _i4.AdminActionType => 'AdminActionType',
      _i5.AdminLoginResponse => 'AdminLoginResponse',
      _i6.AdminUser => 'AdminUser',
      _i7.AgentBuilderConverseResponse => 'AgentBuilderConverseResponse',
      _i8.AgentBuilderStep => 'AgentBuilderStep',
      _i9.AgentStreamEvent => 'AgentStreamEvent',
      _i10.AgentStreamStatus => 'AgentStreamStatus',
      _i11.AiAgentStatus => 'AiAgentStatus',
      _i12.AiAgentStatusResponse => 'AiAgentStatusResponse',
      _i13.AiAgentType => 'AiAgentType',
      _i14.AiConfidenceLevel => 'AiConfidenceLevel',
      _i15.AiDemandHotspot => 'AiDemandHotspot',
      _i16.AiDemandPredictionResponse => 'AiDemandPredictionResponse',
      _i17.AiDriverMatchingResponse => 'AiDriverMatchingResponse',
      _i18.AiDriverRecommendation => 'AiDriverRecommendation',
      _i19.AiFullRequestResponse => 'AiFullRequestResponse',
      _i20.AiHelpArticle => 'AiHelpArticle',
      _i21.AiHelpSearchResponse => 'AiHelpSearchResponse',
      _i22.AiParsedServiceRequest => 'AiParsedServiceRequest',
      _i23.AiRequestConciergeResponse => 'AiRequestConciergeResponse',
      _i24.AiResponseStatus => 'AiResponseStatus',
      _i25.AppConfiguration => 'AppConfiguration',
      _i26.AuthResponse => 'AuthResponse',
      _i27.BlockedUser => 'BlockedUser',
      _i28.CancellerType => 'CancellerType',
      _i29.Category => 'Category',
      _i30.ChatMessage => 'ChatMessage',
      _i31.ChatParticipantsInfo => 'ChatParticipantsInfo',
      _i32.City => 'City',
      _i33.ClientReview => 'ClientReview',
      _i34.Country => 'Country',
      _i35.DashboardStats => 'DashboardStats',
      _i36.DeviceFingerprintCheckResult => 'DeviceFingerprintCheckResult',
      _i37.DeviceFingerprintInput => 'DeviceFingerprintInput',
      _i38.DeviceFingerprintRecord => 'DeviceFingerprintRecord',
      _i39.Dispute => 'Dispute',
      _i40.DisputeStatus => 'DisputeStatus',
      _i41.DisputeType => 'DisputeType',
      _i42.DriverAvailabilityStatus => 'DriverAvailabilityStatus',
      _i43.DriverEarningsResponse => 'DriverEarningsResponse',
      _i44.DriverLocation => 'DriverLocation',
      _i45.DriverOffer => 'DriverOffer',
      _i46.DriverProfile => 'DriverProfile',
      _i47.DriverProposal => 'DriverProposal',
      _i48.DriverService => 'DriverService',
      _i49.DriverStatistics => 'DriverStatistics',
      _i50.DriverZone => 'DriverZone',
      _i51.EsCategoryCount => 'EsCategoryCount',
      _i52.EsDriverHit => 'EsDriverHit',
      _i53.EsDriverSearchResult => 'EsDriverSearchResult',
      _i54.EsDriverServiceHit => 'EsDriverServiceHit',
      _i55.EsDriverServiceSearchResult => 'EsDriverServiceSearchResult',
      _i56.EsPopularSearchTerm => 'EsPopularSearchTerm',
      _i57.EsPopularSearchesResult => 'EsPopularSearchesResult',
      _i58.EsPopularService => 'EsPopularService',
      _i59.EsPopularServicesResult => 'EsPopularServicesResult',
      _i60.EsPriceStats => 'EsPriceStats',
      _i61.EsPriceStatsResult => 'EsPriceStatsResult',
      _i62.EsProductHit => 'EsProductHit',
      _i63.EsProductSearchResult => 'EsProductSearchResult',
      _i64.EsSearchResult => 'EsSearchResult',
      _i65.EsServiceCategoryCountsResult => 'EsServiceCategoryCountsResult',
      _i66.EsServiceHit => 'EsServiceHit',
      _i67.EsServiceSearchResult => 'EsServiceSearchResult',
      _i68.EsStoreHit => 'EsStoreHit',
      _i69.EsStoreSearchResult => 'EsStoreSearchResult',
      _i70.Favorite => 'Favorite',
      _i71.Greeting => 'Greeting',
      _i72.Language => 'Language',
      _i73.Location => 'Location',
      _i74.MediaMetadata => 'MediaMetadata',
      _i75.MessageType => 'MessageType',
      _i76.NearbyDriver => 'NearbyDriver',
      _i77.NotificationType => 'NotificationType',
      _i78.OfferStatus => 'OfferStatus',
      _i79.Order => 'Order',
      _i80.OrderItem => 'OrderItem',
      _i81.OrderStatus => 'OrderStatus',
      _i82.OrderStatusHistory => 'OrderStatusHistory',
      _i83.OrderTracking => 'OrderTracking',
      _i84.Payment => 'Payment',
      _i85.PaymentMethod => 'PaymentMethod',
      _i86.PaymentStatus => 'PaymentStatus',
      _i87.PlatformStatistics => 'PlatformStatistics',
      _i88.PriceNegotiationStatus => 'PriceNegotiationStatus',
      _i89.PriceType => 'PriceType',
      _i90.ProductCategory => 'ProductCategory',
      _i91.Promo => 'Promo',
      _i92.PromoActionType => 'PromoActionType',
      _i93.ProposalStatus => 'ProposalStatus',
      _i94.Rating => 'Rating',
      _i95.RatingStats => 'RatingStats',
      _i96.RatingType => 'RatingType',
      _i97.RecentActivity => 'RecentActivity',
      _i98.Report => 'Report',
      _i99.ReportReason => 'ReportReason',
      _i100.ReportResolution => 'ReportResolution',
      _i101.ReportStatus => 'ReportStatus',
      _i102.ReporterType => 'ReporterType',
      _i103.RequestStatus => 'RequestStatus',
      _i104.Review => 'Review',
      _i105.ReviewWithReviewer => 'ReviewWithReviewer',
      _i106.SearchLog => 'SearchLog',
      _i107.Service => 'Service',
      _i108.ServiceAnalytics => 'ServiceAnalytics',
      _i109.ServiceCategory => 'ServiceCategory',
      _i110.ServiceImage => 'ServiceImage',
      _i111.ServiceRequest => 'ServiceRequest',
      _i112.ServiceType => 'ServiceType',
      _i113.ShoppingItem => 'ShoppingItem',
      _i114.Store => 'Store',
      _i115.StoreCategory => 'StoreCategory',
      _i116.StoreDeliveryRequest => 'StoreDeliveryRequest',
      _i117.StoreOrder => 'StoreOrder',
      _i118.StoreOrderChat => 'StoreOrderChat',
      _i119.StoreOrderChatMessage => 'StoreOrderChatMessage',
      _i120.StoreOrderItem => 'StoreOrderItem',
      _i121.StoreOrderStatus => 'StoreOrderStatus',
      _i122.StoreProduct => 'StoreProduct',
      _i123.StoreReport => 'StoreReport',
      _i124.StoreReview => 'StoreReview',
      _i125.Subscription => 'Subscription',
      _i126.SubscriptionPlan => 'SubscriptionPlan',
      _i127.SubscriptionStatus => 'SubscriptionStatus',
      _i128.SystemSetting => 'SystemSetting',
      _i129.Transaction => 'Transaction',
      _i130.TransactionStatus => 'TransactionStatus',
      _i131.TransactionType => 'TransactionType',
      _i132.TrustScoreResult => 'TrustScoreResult',
      _i133.User => 'User',
      _i134.UserClient => 'UserClient',
      _i135.UserNotification => 'UserNotification',
      _i136.UserResponse => 'UserResponse',
      _i137.UserRole => 'UserRole',
      _i138.UserStatus => 'UserStatus',
      _i139.VehicleType => 'VehicleType',
      _i140.Wallet => 'Wallet',
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
      case _i2.Address():
        return 'Address';
      case _i3.AdminAction():
        return 'AdminAction';
      case _i4.AdminActionType():
        return 'AdminActionType';
      case _i5.AdminLoginResponse():
        return 'AdminLoginResponse';
      case _i6.AdminUser():
        return 'AdminUser';
      case _i7.AgentBuilderConverseResponse():
        return 'AgentBuilderConverseResponse';
      case _i8.AgentBuilderStep():
        return 'AgentBuilderStep';
      case _i9.AgentStreamEvent():
        return 'AgentStreamEvent';
      case _i10.AgentStreamStatus():
        return 'AgentStreamStatus';
      case _i11.AiAgentStatus():
        return 'AiAgentStatus';
      case _i12.AiAgentStatusResponse():
        return 'AiAgentStatusResponse';
      case _i13.AiAgentType():
        return 'AiAgentType';
      case _i14.AiConfidenceLevel():
        return 'AiConfidenceLevel';
      case _i15.AiDemandHotspot():
        return 'AiDemandHotspot';
      case _i16.AiDemandPredictionResponse():
        return 'AiDemandPredictionResponse';
      case _i17.AiDriverMatchingResponse():
        return 'AiDriverMatchingResponse';
      case _i18.AiDriverRecommendation():
        return 'AiDriverRecommendation';
      case _i19.AiFullRequestResponse():
        return 'AiFullRequestResponse';
      case _i20.AiHelpArticle():
        return 'AiHelpArticle';
      case _i21.AiHelpSearchResponse():
        return 'AiHelpSearchResponse';
      case _i22.AiParsedServiceRequest():
        return 'AiParsedServiceRequest';
      case _i23.AiRequestConciergeResponse():
        return 'AiRequestConciergeResponse';
      case _i24.AiResponseStatus():
        return 'AiResponseStatus';
      case _i25.AppConfiguration():
        return 'AppConfiguration';
      case _i26.AuthResponse():
        return 'AuthResponse';
      case _i27.BlockedUser():
        return 'BlockedUser';
      case _i28.CancellerType():
        return 'CancellerType';
      case _i29.Category():
        return 'Category';
      case _i30.ChatMessage():
        return 'ChatMessage';
      case _i31.ChatParticipantsInfo():
        return 'ChatParticipantsInfo';
      case _i32.City():
        return 'City';
      case _i33.ClientReview():
        return 'ClientReview';
      case _i34.Country():
        return 'Country';
      case _i35.DashboardStats():
        return 'DashboardStats';
      case _i36.DeviceFingerprintCheckResult():
        return 'DeviceFingerprintCheckResult';
      case _i37.DeviceFingerprintInput():
        return 'DeviceFingerprintInput';
      case _i38.DeviceFingerprintRecord():
        return 'DeviceFingerprintRecord';
      case _i39.Dispute():
        return 'Dispute';
      case _i40.DisputeStatus():
        return 'DisputeStatus';
      case _i41.DisputeType():
        return 'DisputeType';
      case _i42.DriverAvailabilityStatus():
        return 'DriverAvailabilityStatus';
      case _i43.DriverEarningsResponse():
        return 'DriverEarningsResponse';
      case _i44.DriverLocation():
        return 'DriverLocation';
      case _i45.DriverOffer():
        return 'DriverOffer';
      case _i46.DriverProfile():
        return 'DriverProfile';
      case _i47.DriverProposal():
        return 'DriverProposal';
      case _i48.DriverService():
        return 'DriverService';
      case _i49.DriverStatistics():
        return 'DriverStatistics';
      case _i50.DriverZone():
        return 'DriverZone';
      case _i51.EsCategoryCount():
        return 'EsCategoryCount';
      case _i52.EsDriverHit():
        return 'EsDriverHit';
      case _i53.EsDriverSearchResult():
        return 'EsDriverSearchResult';
      case _i54.EsDriverServiceHit():
        return 'EsDriverServiceHit';
      case _i55.EsDriverServiceSearchResult():
        return 'EsDriverServiceSearchResult';
      case _i56.EsPopularSearchTerm():
        return 'EsPopularSearchTerm';
      case _i57.EsPopularSearchesResult():
        return 'EsPopularSearchesResult';
      case _i58.EsPopularService():
        return 'EsPopularService';
      case _i59.EsPopularServicesResult():
        return 'EsPopularServicesResult';
      case _i60.EsPriceStats():
        return 'EsPriceStats';
      case _i61.EsPriceStatsResult():
        return 'EsPriceStatsResult';
      case _i62.EsProductHit():
        return 'EsProductHit';
      case _i63.EsProductSearchResult():
        return 'EsProductSearchResult';
      case _i64.EsSearchResult():
        return 'EsSearchResult';
      case _i65.EsServiceCategoryCountsResult():
        return 'EsServiceCategoryCountsResult';
      case _i66.EsServiceHit():
        return 'EsServiceHit';
      case _i67.EsServiceSearchResult():
        return 'EsServiceSearchResult';
      case _i68.EsStoreHit():
        return 'EsStoreHit';
      case _i69.EsStoreSearchResult():
        return 'EsStoreSearchResult';
      case _i70.Favorite():
        return 'Favorite';
      case _i71.Greeting():
        return 'Greeting';
      case _i72.Language():
        return 'Language';
      case _i73.Location():
        return 'Location';
      case _i74.MediaMetadata():
        return 'MediaMetadata';
      case _i75.MessageType():
        return 'MessageType';
      case _i76.NearbyDriver():
        return 'NearbyDriver';
      case _i77.NotificationType():
        return 'NotificationType';
      case _i78.OfferStatus():
        return 'OfferStatus';
      case _i79.Order():
        return 'Order';
      case _i80.OrderItem():
        return 'OrderItem';
      case _i81.OrderStatus():
        return 'OrderStatus';
      case _i82.OrderStatusHistory():
        return 'OrderStatusHistory';
      case _i83.OrderTracking():
        return 'OrderTracking';
      case _i84.Payment():
        return 'Payment';
      case _i85.PaymentMethod():
        return 'PaymentMethod';
      case _i86.PaymentStatus():
        return 'PaymentStatus';
      case _i87.PlatformStatistics():
        return 'PlatformStatistics';
      case _i88.PriceNegotiationStatus():
        return 'PriceNegotiationStatus';
      case _i89.PriceType():
        return 'PriceType';
      case _i90.ProductCategory():
        return 'ProductCategory';
      case _i91.Promo():
        return 'Promo';
      case _i92.PromoActionType():
        return 'PromoActionType';
      case _i93.ProposalStatus():
        return 'ProposalStatus';
      case _i94.Rating():
        return 'Rating';
      case _i95.RatingStats():
        return 'RatingStats';
      case _i96.RatingType():
        return 'RatingType';
      case _i97.RecentActivity():
        return 'RecentActivity';
      case _i98.Report():
        return 'Report';
      case _i99.ReportReason():
        return 'ReportReason';
      case _i100.ReportResolution():
        return 'ReportResolution';
      case _i101.ReportStatus():
        return 'ReportStatus';
      case _i102.ReporterType():
        return 'ReporterType';
      case _i103.RequestStatus():
        return 'RequestStatus';
      case _i104.Review():
        return 'Review';
      case _i105.ReviewWithReviewer():
        return 'ReviewWithReviewer';
      case _i106.SearchLog():
        return 'SearchLog';
      case _i107.Service():
        return 'Service';
      case _i108.ServiceAnalytics():
        return 'ServiceAnalytics';
      case _i109.ServiceCategory():
        return 'ServiceCategory';
      case _i110.ServiceImage():
        return 'ServiceImage';
      case _i111.ServiceRequest():
        return 'ServiceRequest';
      case _i112.ServiceType():
        return 'ServiceType';
      case _i113.ShoppingItem():
        return 'ShoppingItem';
      case _i114.Store():
        return 'Store';
      case _i115.StoreCategory():
        return 'StoreCategory';
      case _i116.StoreDeliveryRequest():
        return 'StoreDeliveryRequest';
      case _i117.StoreOrder():
        return 'StoreOrder';
      case _i118.StoreOrderChat():
        return 'StoreOrderChat';
      case _i119.StoreOrderChatMessage():
        return 'StoreOrderChatMessage';
      case _i120.StoreOrderItem():
        return 'StoreOrderItem';
      case _i121.StoreOrderStatus():
        return 'StoreOrderStatus';
      case _i122.StoreProduct():
        return 'StoreProduct';
      case _i123.StoreReport():
        return 'StoreReport';
      case _i124.StoreReview():
        return 'StoreReview';
      case _i125.Subscription():
        return 'Subscription';
      case _i126.SubscriptionPlan():
        return 'SubscriptionPlan';
      case _i127.SubscriptionStatus():
        return 'SubscriptionStatus';
      case _i128.SystemSetting():
        return 'SystemSetting';
      case _i129.Transaction():
        return 'Transaction';
      case _i130.TransactionStatus():
        return 'TransactionStatus';
      case _i131.TransactionType():
        return 'TransactionType';
      case _i132.TrustScoreResult():
        return 'TrustScoreResult';
      case _i133.User():
        return 'User';
      case _i134.UserClient():
        return 'UserClient';
      case _i135.UserNotification():
        return 'UserNotification';
      case _i136.UserResponse():
        return 'UserResponse';
      case _i137.UserRole():
        return 'UserRole';
      case _i138.UserStatus():
        return 'UserStatus';
      case _i139.VehicleType():
        return 'VehicleType';
      case _i140.Wallet():
        return 'Wallet';
    }
    className = _i178.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i179.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.Address>(data['data']);
    }
    if (dataClassName == 'AdminAction') {
      return deserialize<_i3.AdminAction>(data['data']);
    }
    if (dataClassName == 'AdminActionType') {
      return deserialize<_i4.AdminActionType>(data['data']);
    }
    if (dataClassName == 'AdminLoginResponse') {
      return deserialize<_i5.AdminLoginResponse>(data['data']);
    }
    if (dataClassName == 'AdminUser') {
      return deserialize<_i6.AdminUser>(data['data']);
    }
    if (dataClassName == 'AgentBuilderConverseResponse') {
      return deserialize<_i7.AgentBuilderConverseResponse>(data['data']);
    }
    if (dataClassName == 'AgentBuilderStep') {
      return deserialize<_i8.AgentBuilderStep>(data['data']);
    }
    if (dataClassName == 'AgentStreamEvent') {
      return deserialize<_i9.AgentStreamEvent>(data['data']);
    }
    if (dataClassName == 'AgentStreamStatus') {
      return deserialize<_i10.AgentStreamStatus>(data['data']);
    }
    if (dataClassName == 'AiAgentStatus') {
      return deserialize<_i11.AiAgentStatus>(data['data']);
    }
    if (dataClassName == 'AiAgentStatusResponse') {
      return deserialize<_i12.AiAgentStatusResponse>(data['data']);
    }
    if (dataClassName == 'AiAgentType') {
      return deserialize<_i13.AiAgentType>(data['data']);
    }
    if (dataClassName == 'AiConfidenceLevel') {
      return deserialize<_i14.AiConfidenceLevel>(data['data']);
    }
    if (dataClassName == 'AiDemandHotspot') {
      return deserialize<_i15.AiDemandHotspot>(data['data']);
    }
    if (dataClassName == 'AiDemandPredictionResponse') {
      return deserialize<_i16.AiDemandPredictionResponse>(data['data']);
    }
    if (dataClassName == 'AiDriverMatchingResponse') {
      return deserialize<_i17.AiDriverMatchingResponse>(data['data']);
    }
    if (dataClassName == 'AiDriverRecommendation') {
      return deserialize<_i18.AiDriverRecommendation>(data['data']);
    }
    if (dataClassName == 'AiFullRequestResponse') {
      return deserialize<_i19.AiFullRequestResponse>(data['data']);
    }
    if (dataClassName == 'AiHelpArticle') {
      return deserialize<_i20.AiHelpArticle>(data['data']);
    }
    if (dataClassName == 'AiHelpSearchResponse') {
      return deserialize<_i21.AiHelpSearchResponse>(data['data']);
    }
    if (dataClassName == 'AiParsedServiceRequest') {
      return deserialize<_i22.AiParsedServiceRequest>(data['data']);
    }
    if (dataClassName == 'AiRequestConciergeResponse') {
      return deserialize<_i23.AiRequestConciergeResponse>(data['data']);
    }
    if (dataClassName == 'AiResponseStatus') {
      return deserialize<_i24.AiResponseStatus>(data['data']);
    }
    if (dataClassName == 'AppConfiguration') {
      return deserialize<_i25.AppConfiguration>(data['data']);
    }
    if (dataClassName == 'AuthResponse') {
      return deserialize<_i26.AuthResponse>(data['data']);
    }
    if (dataClassName == 'BlockedUser') {
      return deserialize<_i27.BlockedUser>(data['data']);
    }
    if (dataClassName == 'CancellerType') {
      return deserialize<_i28.CancellerType>(data['data']);
    }
    if (dataClassName == 'Category') {
      return deserialize<_i29.Category>(data['data']);
    }
    if (dataClassName == 'ChatMessage') {
      return deserialize<_i30.ChatMessage>(data['data']);
    }
    if (dataClassName == 'ChatParticipantsInfo') {
      return deserialize<_i31.ChatParticipantsInfo>(data['data']);
    }
    if (dataClassName == 'City') {
      return deserialize<_i32.City>(data['data']);
    }
    if (dataClassName == 'ClientReview') {
      return deserialize<_i33.ClientReview>(data['data']);
    }
    if (dataClassName == 'Country') {
      return deserialize<_i34.Country>(data['data']);
    }
    if (dataClassName == 'DashboardStats') {
      return deserialize<_i35.DashboardStats>(data['data']);
    }
    if (dataClassName == 'DeviceFingerprintCheckResult') {
      return deserialize<_i36.DeviceFingerprintCheckResult>(data['data']);
    }
    if (dataClassName == 'DeviceFingerprintInput') {
      return deserialize<_i37.DeviceFingerprintInput>(data['data']);
    }
    if (dataClassName == 'DeviceFingerprintRecord') {
      return deserialize<_i38.DeviceFingerprintRecord>(data['data']);
    }
    if (dataClassName == 'Dispute') {
      return deserialize<_i39.Dispute>(data['data']);
    }
    if (dataClassName == 'DisputeStatus') {
      return deserialize<_i40.DisputeStatus>(data['data']);
    }
    if (dataClassName == 'DisputeType') {
      return deserialize<_i41.DisputeType>(data['data']);
    }
    if (dataClassName == 'DriverAvailabilityStatus') {
      return deserialize<_i42.DriverAvailabilityStatus>(data['data']);
    }
    if (dataClassName == 'DriverEarningsResponse') {
      return deserialize<_i43.DriverEarningsResponse>(data['data']);
    }
    if (dataClassName == 'DriverLocation') {
      return deserialize<_i44.DriverLocation>(data['data']);
    }
    if (dataClassName == 'DriverOffer') {
      return deserialize<_i45.DriverOffer>(data['data']);
    }
    if (dataClassName == 'DriverProfile') {
      return deserialize<_i46.DriverProfile>(data['data']);
    }
    if (dataClassName == 'DriverProposal') {
      return deserialize<_i47.DriverProposal>(data['data']);
    }
    if (dataClassName == 'DriverService') {
      return deserialize<_i48.DriverService>(data['data']);
    }
    if (dataClassName == 'DriverStatistics') {
      return deserialize<_i49.DriverStatistics>(data['data']);
    }
    if (dataClassName == 'DriverZone') {
      return deserialize<_i50.DriverZone>(data['data']);
    }
    if (dataClassName == 'EsCategoryCount') {
      return deserialize<_i51.EsCategoryCount>(data['data']);
    }
    if (dataClassName == 'EsDriverHit') {
      return deserialize<_i52.EsDriverHit>(data['data']);
    }
    if (dataClassName == 'EsDriverSearchResult') {
      return deserialize<_i53.EsDriverSearchResult>(data['data']);
    }
    if (dataClassName == 'EsDriverServiceHit') {
      return deserialize<_i54.EsDriverServiceHit>(data['data']);
    }
    if (dataClassName == 'EsDriverServiceSearchResult') {
      return deserialize<_i55.EsDriverServiceSearchResult>(data['data']);
    }
    if (dataClassName == 'EsPopularSearchTerm') {
      return deserialize<_i56.EsPopularSearchTerm>(data['data']);
    }
    if (dataClassName == 'EsPopularSearchesResult') {
      return deserialize<_i57.EsPopularSearchesResult>(data['data']);
    }
    if (dataClassName == 'EsPopularService') {
      return deserialize<_i58.EsPopularService>(data['data']);
    }
    if (dataClassName == 'EsPopularServicesResult') {
      return deserialize<_i59.EsPopularServicesResult>(data['data']);
    }
    if (dataClassName == 'EsPriceStats') {
      return deserialize<_i60.EsPriceStats>(data['data']);
    }
    if (dataClassName == 'EsPriceStatsResult') {
      return deserialize<_i61.EsPriceStatsResult>(data['data']);
    }
    if (dataClassName == 'EsProductHit') {
      return deserialize<_i62.EsProductHit>(data['data']);
    }
    if (dataClassName == 'EsProductSearchResult') {
      return deserialize<_i63.EsProductSearchResult>(data['data']);
    }
    if (dataClassName == 'EsSearchResult') {
      return deserialize<_i64.EsSearchResult>(data['data']);
    }
    if (dataClassName == 'EsServiceCategoryCountsResult') {
      return deserialize<_i65.EsServiceCategoryCountsResult>(data['data']);
    }
    if (dataClassName == 'EsServiceHit') {
      return deserialize<_i66.EsServiceHit>(data['data']);
    }
    if (dataClassName == 'EsServiceSearchResult') {
      return deserialize<_i67.EsServiceSearchResult>(data['data']);
    }
    if (dataClassName == 'EsStoreHit') {
      return deserialize<_i68.EsStoreHit>(data['data']);
    }
    if (dataClassName == 'EsStoreSearchResult') {
      return deserialize<_i69.EsStoreSearchResult>(data['data']);
    }
    if (dataClassName == 'Favorite') {
      return deserialize<_i70.Favorite>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i71.Greeting>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i72.Language>(data['data']);
    }
    if (dataClassName == 'Location') {
      return deserialize<_i73.Location>(data['data']);
    }
    if (dataClassName == 'MediaMetadata') {
      return deserialize<_i74.MediaMetadata>(data['data']);
    }
    if (dataClassName == 'MessageType') {
      return deserialize<_i75.MessageType>(data['data']);
    }
    if (dataClassName == 'NearbyDriver') {
      return deserialize<_i76.NearbyDriver>(data['data']);
    }
    if (dataClassName == 'NotificationType') {
      return deserialize<_i77.NotificationType>(data['data']);
    }
    if (dataClassName == 'OfferStatus') {
      return deserialize<_i78.OfferStatus>(data['data']);
    }
    if (dataClassName == 'Order') {
      return deserialize<_i79.Order>(data['data']);
    }
    if (dataClassName == 'OrderItem') {
      return deserialize<_i80.OrderItem>(data['data']);
    }
    if (dataClassName == 'OrderStatus') {
      return deserialize<_i81.OrderStatus>(data['data']);
    }
    if (dataClassName == 'OrderStatusHistory') {
      return deserialize<_i82.OrderStatusHistory>(data['data']);
    }
    if (dataClassName == 'OrderTracking') {
      return deserialize<_i83.OrderTracking>(data['data']);
    }
    if (dataClassName == 'Payment') {
      return deserialize<_i84.Payment>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_i85.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'PaymentStatus') {
      return deserialize<_i86.PaymentStatus>(data['data']);
    }
    if (dataClassName == 'PlatformStatistics') {
      return deserialize<_i87.PlatformStatistics>(data['data']);
    }
    if (dataClassName == 'PriceNegotiationStatus') {
      return deserialize<_i88.PriceNegotiationStatus>(data['data']);
    }
    if (dataClassName == 'PriceType') {
      return deserialize<_i89.PriceType>(data['data']);
    }
    if (dataClassName == 'ProductCategory') {
      return deserialize<_i90.ProductCategory>(data['data']);
    }
    if (dataClassName == 'Promo') {
      return deserialize<_i91.Promo>(data['data']);
    }
    if (dataClassName == 'PromoActionType') {
      return deserialize<_i92.PromoActionType>(data['data']);
    }
    if (dataClassName == 'ProposalStatus') {
      return deserialize<_i93.ProposalStatus>(data['data']);
    }
    if (dataClassName == 'Rating') {
      return deserialize<_i94.Rating>(data['data']);
    }
    if (dataClassName == 'RatingStats') {
      return deserialize<_i95.RatingStats>(data['data']);
    }
    if (dataClassName == 'RatingType') {
      return deserialize<_i96.RatingType>(data['data']);
    }
    if (dataClassName == 'RecentActivity') {
      return deserialize<_i97.RecentActivity>(data['data']);
    }
    if (dataClassName == 'Report') {
      return deserialize<_i98.Report>(data['data']);
    }
    if (dataClassName == 'ReportReason') {
      return deserialize<_i99.ReportReason>(data['data']);
    }
    if (dataClassName == 'ReportResolution') {
      return deserialize<_i100.ReportResolution>(data['data']);
    }
    if (dataClassName == 'ReportStatus') {
      return deserialize<_i101.ReportStatus>(data['data']);
    }
    if (dataClassName == 'ReporterType') {
      return deserialize<_i102.ReporterType>(data['data']);
    }
    if (dataClassName == 'RequestStatus') {
      return deserialize<_i103.RequestStatus>(data['data']);
    }
    if (dataClassName == 'Review') {
      return deserialize<_i104.Review>(data['data']);
    }
    if (dataClassName == 'ReviewWithReviewer') {
      return deserialize<_i105.ReviewWithReviewer>(data['data']);
    }
    if (dataClassName == 'SearchLog') {
      return deserialize<_i106.SearchLog>(data['data']);
    }
    if (dataClassName == 'Service') {
      return deserialize<_i107.Service>(data['data']);
    }
    if (dataClassName == 'ServiceAnalytics') {
      return deserialize<_i108.ServiceAnalytics>(data['data']);
    }
    if (dataClassName == 'ServiceCategory') {
      return deserialize<_i109.ServiceCategory>(data['data']);
    }
    if (dataClassName == 'ServiceImage') {
      return deserialize<_i110.ServiceImage>(data['data']);
    }
    if (dataClassName == 'ServiceRequest') {
      return deserialize<_i111.ServiceRequest>(data['data']);
    }
    if (dataClassName == 'ServiceType') {
      return deserialize<_i112.ServiceType>(data['data']);
    }
    if (dataClassName == 'ShoppingItem') {
      return deserialize<_i113.ShoppingItem>(data['data']);
    }
    if (dataClassName == 'Store') {
      return deserialize<_i114.Store>(data['data']);
    }
    if (dataClassName == 'StoreCategory') {
      return deserialize<_i115.StoreCategory>(data['data']);
    }
    if (dataClassName == 'StoreDeliveryRequest') {
      return deserialize<_i116.StoreDeliveryRequest>(data['data']);
    }
    if (dataClassName == 'StoreOrder') {
      return deserialize<_i117.StoreOrder>(data['data']);
    }
    if (dataClassName == 'StoreOrderChat') {
      return deserialize<_i118.StoreOrderChat>(data['data']);
    }
    if (dataClassName == 'StoreOrderChatMessage') {
      return deserialize<_i119.StoreOrderChatMessage>(data['data']);
    }
    if (dataClassName == 'StoreOrderItem') {
      return deserialize<_i120.StoreOrderItem>(data['data']);
    }
    if (dataClassName == 'StoreOrderStatus') {
      return deserialize<_i121.StoreOrderStatus>(data['data']);
    }
    if (dataClassName == 'StoreProduct') {
      return deserialize<_i122.StoreProduct>(data['data']);
    }
    if (dataClassName == 'StoreReport') {
      return deserialize<_i123.StoreReport>(data['data']);
    }
    if (dataClassName == 'StoreReview') {
      return deserialize<_i124.StoreReview>(data['data']);
    }
    if (dataClassName == 'Subscription') {
      return deserialize<_i125.Subscription>(data['data']);
    }
    if (dataClassName == 'SubscriptionPlan') {
      return deserialize<_i126.SubscriptionPlan>(data['data']);
    }
    if (dataClassName == 'SubscriptionStatus') {
      return deserialize<_i127.SubscriptionStatus>(data['data']);
    }
    if (dataClassName == 'SystemSetting') {
      return deserialize<_i128.SystemSetting>(data['data']);
    }
    if (dataClassName == 'Transaction') {
      return deserialize<_i129.Transaction>(data['data']);
    }
    if (dataClassName == 'TransactionStatus') {
      return deserialize<_i130.TransactionStatus>(data['data']);
    }
    if (dataClassName == 'TransactionType') {
      return deserialize<_i131.TransactionType>(data['data']);
    }
    if (dataClassName == 'TrustScoreResult') {
      return deserialize<_i132.TrustScoreResult>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i133.User>(data['data']);
    }
    if (dataClassName == 'UserClient') {
      return deserialize<_i134.UserClient>(data['data']);
    }
    if (dataClassName == 'UserNotification') {
      return deserialize<_i135.UserNotification>(data['data']);
    }
    if (dataClassName == 'UserResponse') {
      return deserialize<_i136.UserResponse>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i137.UserRole>(data['data']);
    }
    if (dataClassName == 'UserStatus') {
      return deserialize<_i138.UserStatus>(data['data']);
    }
    if (dataClassName == 'VehicleType') {
      return deserialize<_i139.VehicleType>(data['data']);
    }
    if (dataClassName == 'Wallet') {
      return deserialize<_i140.Wallet>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i178.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i179.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
