class FoodInfo {
  final String name;
  final String category;
  final double calories;
  final String taste;
  final List<String> ingredients;
  final Map<String, double> nutrition;
  final String origin;
  final double confidence;
  final bool isFood;
  final double? healthScore; // 健康评分 (1-10)
  final String? season; // 最佳食用季节
  final String? storage; // 保存方法
  final String? subCategory; // 子类别
  final String? quality; // 品质评估
  final String? tips; // 挑选/食用建议

  FoodInfo({
    required this.name,
    required this.category,
    required this.calories,
    required this.taste,
    required this.ingredients,
    required this.nutrition,
    required this.origin,
    required this.confidence,
    required this.isFood,
    this.healthScore,
    this.season,
    this.storage,
    this.subCategory,
    this.quality,
    this.tips,
  });

  factory FoodInfo.fromJson(Map<String, dynamic> json) {
    return FoodInfo(
      name: json['name'],
      category: json['category'],
      calories: json['calories'].toDouble(),
      taste: json['taste'],
      ingredients: List<String>.from(json['ingredients']),
      nutrition: Map<String, double>.from(json['nutrition']),
      origin: json['origin'],
      confidence: json['confidence'].toDouble(),
      isFood: json['is_food'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'calories': calories,
      'taste': taste,
      'ingredients': ingredients,
      'nutrition': nutrition,
      'origin': origin,
      'confidence': confidence,
      'is_food': isFood,
    };
  }

  factory FoodInfo.fromLabel(String label) {
    // 这里可以根据标签名称返回对应的食物信息
    // 实际应用中，这里应该连接到一个食物数据库或API
    return _getFoodInfoFromLabel(label);
  }

  static FoodInfo _getFoodInfoFromLabel(String label) {
    // 示例数据，实际应用中应该使用数据库或API
    final foodData = {
      'apple': FoodInfo(
        name: '苹果',
        category: '水果',
        calories: 52,
        taste: '甜',
        ingredients: ['苹果'],
        nutrition: {'维生素C': 8, '纤维': 2.4, '糖': 10},
        origin: '中国',
        confidence: 0.95,
        isFood: true,
      ),
      'pizza': FoodInfo(
        name: '披萨',
        category: '主食',
        calories: 266,
        taste: '咸',
        ingredients: ['面粉', '番茄酱', '奶酪', '配料'],
        nutrition: {'蛋白质': 11, '脂肪': 10, '碳水化合物': 33},
        origin: '意大利',
        confidence: 0.92,
        isFood: true,
      ),
      // 可以添加更多食物数据
    };

    // 检查是否是食物
    if (foodData.containsKey(label.toLowerCase())) {
      return foodData[label.toLowerCase()]!;
    } else {
      // 如果不是已知食物，返回一个非食物的信息
      return FoodInfo(
        name: label,
        category: '未知',
        calories: 0,
        taste: '未知',
        ingredients: [],
        nutrition: {},
        origin: '未知',
        confidence: 0.0,
        isFood: false,
      );
    }
  }
}
