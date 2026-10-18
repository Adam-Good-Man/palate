import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/food.dart';
import '../models/food_recognition.dart';
import '../models/food_info.dart';

class ApiService {
  static String get baseUrl => '${dotenv.env['API_BASE_URL']}/api';
  final http.Client _client = http.Client();

  Future<List<Food>> getFoods() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/food'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Food.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load foods');
      }
    } catch (e) {
      throw Exception('Failed to load foods: $e');
    }
  }

  Future<Food> getFood(int id) async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/food/$id'));
      if (response.statusCode == 200) {
        return Food.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load food');
      }
    } catch (e) {
      throw Exception('Failed to load food: $e');
    }
  }

  Future<FoodRecognition> recognizeFood(File imageFile) async {
    print('Recognizing food+++');
    try {
      print('Recognizing food: $baseUrl');
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/food/recognize'),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
        ),
      );

      final response = await request.send();
      print('Response: ${response.statusCode}');
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return FoodRecognition.fromJson(json.decode(responseBody)['data']);
      } else {
        throw Exception('Failed to recognize food');
      }
    } catch (e) {
      throw Exception('Failed to recognize food: $e');
    }
  }

  Future<void> saveFood(FoodInfo foodInfo) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/food'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(foodInfo.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to save food');
      }
    } catch (e) {
      throw Exception('Failed to save food: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
