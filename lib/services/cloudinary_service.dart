
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class CloudinaryService {
  static const String cloudName = 'dxfg7om7j';
  static const String apiKey = '466934647797747';
  static const String apiSecret = 'FmV2dYhtcTBdNYXZuV51T2AEZ48';
  static const String baseUrl = 'https://api.cloudinary.com/v1_1/$cloudName';

  /// Upload an image file to Cloudinary
  /// Returns the secure URL of the uploaded image
  Future<String> uploadImage(File imageFile, {String? publicId}) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final publicIdParam = publicId ?? 'recipe_$timestamp';
      
      // Generate signature for authentication
      final signature = _generateSignature(publicIdParam, timestamp);
      
      // Create multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/image/upload'),
      );

      // Add fields
      request.fields['api_key'] = apiKey;
      request.fields['timestamp'] = timestamp;
      request.fields['signature'] = signature;
      request.fields['public_id'] = publicIdParam;
      request.fields['folder'] = 'menu_recommender';

      // Add file
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['secure_url'] as String;
      } else {
        throw Exception('Failed to upload image: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error uploading to Cloudinary: $e');
    }
  }

  /// Generate signature for Cloudinary API authentication
  String _generateSignature(String publicId, String timestamp) {
    final params = {
      'public_id': publicId,
      'timestamp': timestamp,
      'folder': 'menu_recommender',
    };

    // Sort parameters
    final sortedParams = params.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    // Create string to sign
    final stringToSign = sortedParams
        .map((e) => '${e.key}=${e.value}')
        .join('&');
    final fullString = '$stringToSign$apiSecret';

    // Generate SHA1 hash
    final bytes = utf8.encode(fullString);
    final hash = sha1.convert(bytes);
    
    return hash.toString();
  }
}

