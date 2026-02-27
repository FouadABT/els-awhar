import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';

/// Client-side vision service using Google Gemini Flash.
///
/// Describes images so their content can be sent as text to the
/// concierge agent (which is text-only via Kibana Agent Builder).
///
/// Flow: Pick image → compress → Gemini Vision → text description → agent
class VisionService {
  static VisionService? _instance;
  factory VisionService() => _instance ??= VisionService._();
  VisionService._();

  // Gemini API key from Google AI Studio (authorized for Generative Language API)
  static const _apiKey = 'AIzaSyCvZi43D3yjoZHWP9Zv5fJMyuTHbEVR4Hw';

  GenerativeModel? _model;

  GenerativeModel get _gemini {
    _model ??= GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: _apiKey,
    );
    return _model!;
  }

  /// Describe an image file for the AI agent.
  ///
  /// Returns a detailed text description of what's in the image,
  /// optimized for product/service search on Awhar.
  Future<String> describeImage(File imageFile, {String? userHint}) async {
    try {
      // Compress image for faster upload (max 800px, quality 75)
      final compressed = await FlutterImageCompress.compressWithFile(
        imageFile.absolute.path,
        minWidth: 800,
        minHeight: 800,
        quality: 75,
      );

      final Uint8List imageBytes =
          compressed ?? await imageFile.readAsBytes();

      // Detect mime type from extension
      final ext = imageFile.path.split('.').last.toLowerCase();
      final mimeType = switch (ext) {
        'png' => 'image/png',
        'webp' => 'image/webp',
        'gif' => 'image/gif',
        _ => 'image/jpeg',
      };

      final lang = Get.locale?.languageCode ?? 'en';
      final langInstruction = switch (lang) {
        'ar' => 'Respond in Arabic.',
        'fr' => 'Respond in French.',
        'es' => 'Respond in Spanish.',
        _ => 'Respond in English.',
      };

      final prompt = userHint != null && userHint.trim().isNotEmpty
          ? '''Describe this image in detail for a service marketplace app. 
The user says: "$userHint"
Focus on: what the item/product/place/issue is, brand/model if visible, condition, colors, size indicators.
Keep it concise (2-3 sentences). $langInstruction'''
          : '''Describe this image in detail for a service marketplace app.
Focus on: what the item/product/place/issue is, brand/model if visible, condition, colors, size indicators.
Keep it concise (2-3 sentences). $langInstruction''';

      final content = Content.multi([
        DataPart(mimeType, imageBytes),
        TextPart(prompt),
      ]);

      final response = await _gemini.generateContent([content]);
      final description = response.text?.trim() ?? '';

      debugPrint('[VisionService] Image described: ${description.length} chars');
      return description;
    } catch (e) {
      debugPrint('[VisionService] Error describing image: $e');
      rethrow;
    }
  }
}
