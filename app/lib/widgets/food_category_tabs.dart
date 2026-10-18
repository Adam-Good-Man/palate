import 'package:flutter/material.dart';

class FoodTag {
  final String name;
  final Color? backgroundColor;
  final Color? textColor;

  const FoodTag({
    required this.name,
    this.backgroundColor,
    this.textColor,
  });
}

class FoodTagList extends StatefulWidget {
  const FoodTagList({super.key});

  @override
  State<FoodTagList> createState() => _FoodTagListState();
}

class _FoodTagListState extends State<FoodTagList> {
  int _selectedIndex = 0;

  final List<FoodTag> _tags = const [
    FoodTag(
      name: 'HOT',
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
    ),
    FoodTag(
      name: '瘦身',
      backgroundColor: Color(0xFF8BC34A),
      textColor: Colors.white,
    ),
    FoodTag(
      name: '要辣',
      backgroundColor: Color(0xFFFF5722),
      textColor: Colors.white,
    ),
    FoodTag(
      name: '清淡',
      backgroundColor: Color(0xFF4CAF50),
      textColor: Colors.white,
    ),
    FoodTag(
      name: '高蛋白',
      backgroundColor: Color(0xFF2196F3),
      textColor: Colors.white,
    ),
    FoodTag(
      name: '低脂',
      backgroundColor: Color(0xFF9C27B0),
      textColor: Colors.white,
    ),
    FoodTag(
      name: '高纤维',
      backgroundColor: Color(0xFF795548),
      textColor: Colors.white,
    ),
    FoodTag(
      name: '无糖',
      backgroundColor: Color(0xFF607D8B),
      textColor: Colors.white,
    ),
    FoodTag(
      name: '养生',
      backgroundColor: Color(0xFF009688),
      textColor: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      margin: const EdgeInsets.only(top: 12, bottom: 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            _tags.length,
            (index) => _buildTag(index),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(int index) {
    final bool isSelected = _selectedIndex == index;
    final tag = _tags[index];
    final color = tag.backgroundColor ?? Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        // TODO: 处理标签切换事件
      },
      child: Container(
        margin: EdgeInsets.only(
          left: index == 0 ? 16 : 8,
          right: index == _tags.length - 1 ? 16 : 8,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: 1,
          ),
          boxShadow: isSelected
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        child: Text(
          tag.name,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
