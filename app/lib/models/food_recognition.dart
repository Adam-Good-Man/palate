import 'food.dart';

class FoodRecognition {
  final int id;
  final Food food;
  final double confidence;
  final DateTime recognizedAt;

  FoodRecognition({
    required this.id,
    required this.food,
    required this.confidence,
    required this.recognizedAt,
  });

  factory FoodRecognition.fromJson(Map<String, dynamic> json) {
    return FoodRecognition(
      id: json['id'],
      food: Food.fromJson(json['food']),
      confidence: json['confidence'].toDouble(),
      recognizedAt: DateTime.parse(json['recognized_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'food': food.toJson(),
      'confidence': confidence,
      'recognized_at': recognizedAt.toIso8601String(),
    };
  }
}
