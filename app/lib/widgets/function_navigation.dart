import 'package:flutter/material.dart';

class FunctionNavigation extends StatelessWidget {
  const FunctionNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavigationItem(
              Icons.restaurant, '膳食健康', const Color(0xFF4CAF50)),
          _buildNavigationItem(Icons.person, '大厨在线', const Color(0xFF2196F3)),
          _buildNavigationItem(
              Icons.restaurant_menu, '食材搭配', const Color(0xFFFF9800)),
          _buildNavigationItem(
              Icons.food_bank, '食谱典籍', const Color(0xFFE91E63)),
        ],
      ),
    );
  }

  Widget _buildNavigationItem(IconData icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 26,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildScanButton() {
    return GestureDetector(
      onTap: () {
        // TODO: 处理扫描功能
      },
      child: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF9800).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Image.asset(
          'assets/images/cartoon_camera.png',
          width: 36,
          height: 36,
        ),
      ),
    );
  }
}
