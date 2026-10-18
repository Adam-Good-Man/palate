import 'dart:async';
import 'package:flutter/material.dart';

class FoodRecommendation {
  final String imageUrl;
  final String name;
  final String nutrition;
  final String reason;
  final String? history;

  const FoodRecommendation({
    required this.imageUrl,
    required this.name,
    required this.nutrition,
    required this.reason,
    this.history,
  });
}

class DailyFood extends StatefulWidget {
  const DailyFood({super.key});

  @override
  State<DailyFood> createState() => _DailyFoodState();
}

class _DailyFoodState extends State<DailyFood> {
  int _currentRecommendIndex = 0;
  Timer? _timer;
  final Duration _switchDuration = const Duration(seconds: 8);
  final Duration _fadeAnimationDuration = const Duration(milliseconds: 500);

  final List<FoodRecommendation> _recommendations = const [
    FoodRecommendation(
      imageUrl:
          'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg',
      name: '东坡肉',
      nutrition: '蛋白质 25g/100g，脂肪 30g/100g，碳水化合物 3g/100g',
      reason: '肥而不腻，入口即化，香味浓郁，是江南地区最具代表性的传统名菜之一。',
      history: '相传为北宋文豪苏东坡所创，始于苏东坡在密州（今山东诸城）任知州时期。',
    ),
    FoodRecommendation(
      imageUrl:
          'https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg',
      name: '佛跳墙',
      nutrition: '富含胶原蛋白，多种氨基酸，维生素B族',
      reason: '汤浓味美，营养丰富，是福建闽菜的代表作品。',
      history: '始于清朝道光年间，因其香气四溢，据说连佛闻到都会跳墙而出，故名"佛跳墙"。',
    ),
    FoodRecommendation(
      imageUrl:
          'https://images.pexels.com/photos/1640772/pexels-photo-1640772.jpeg',
      name: '叫花鸡',
      nutrition: '优质蛋白质，维生素B6，铁质含量丰富',
      reason: '外焦里嫩，香味独特，是杭州传统名菜。',
      history: '相传起源于南宋，由乞丐所创，采用独特的泥封烤制工艺。',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSwitch();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoSwitch() {
    _timer = Timer.periodic(_switchDuration, (timer) {
      setState(() {
        _currentRecommendIndex =
            (_currentRecommendIndex + 1) % _recommendations.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '每日美食',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: const Center(
            child: Text('今日推荐美食内容'),
          ),
        ),
      ],
    );
  }
}
