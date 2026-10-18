import 'dart:io';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import '../models/food_info.dart';
import '../models/food_recognition.dart';
import 'api_service.dart';
import 'package:http/http.dart' as http;

class FoodAnalysisService {
  late final ApiService _apiService;

  FoodAnalysisService() {
    _apiService = ApiService();
  }

  Future<bool> requestPermissions() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<FoodInfo?> analyzeImage(File imageFile) async {
    try {
      // 使用 API 服务识别食物
      final recognition = await _apiService.recognizeFood(imageFile);

      if (recognition == null) {
        print('No recognition result returned');
        return null;
      }

      if (recognition.confidence < 0.6) {
        // 置信度阈值
        print('Recognition confidence too low: ${recognition.confidence}');
        return null;
      }

      // 创建 FoodInfo 对象
      return FoodInfo(
        name: recognition.food.name,
        category: recognition.food.category,
        calories: recognition.food.calories,
        taste: '', // 这些信息现在从后端获取
        ingredients: [recognition.food.description],
        nutrition: {
          '蛋白质': recognition.food.protein,
          '碳水化合物': recognition.food.carbs,
          '脂肪': recognition.food.fat,
        },
        origin: '', // 这些信息现在从后端获取
        confidence: recognition.confidence,
        isFood: true,
      );
    } catch (e) {
      print('Error analyzing image: $e');
      rethrow; // 让调用者处理错误
    }
  }

  Future<void> saveFoodInfo(FoodInfo foodInfo) async {
    try {
      // 使用 API 服务保存食物信息
      await _apiService.saveFood(foodInfo);
    } catch (e) {
      print('Error saving food info: $e');
      rethrow;
    }
  }

  Future<FoodInfo> analyzeFood(String imagePath) async {
    final file = File(imagePath);
    print('Analyzing food: $imagePath');
    final recognition = await _apiService.recognizeFood(file);
    return FoodInfo(
      name: recognition.food.name,
      category: recognition.food.category,
      calories: recognition.food.calories,
      taste: '',
      ingredients: [recognition.food.description],
      nutrition: {
        '蛋白质': recognition.food.protein,
        '碳水化合物': recognition.food.carbs,
        '脂肪': recognition.food.fat,
      },
      origin: '',
      confidence: recognition.confidence,
      isFood: true,
    );
  }

  void dispose() {
    _apiService.dispose();
  }
}
