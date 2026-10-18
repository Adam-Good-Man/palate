import 'package:flutter/material.dart';
import '../widgets/daily_food.dart';
import '../widgets/search_bar.dart';
import '../widgets/function_navigation.dart';
import '../widgets/content_card.dart';
import '../widgets/food_category_tabs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 搜索栏
            const CustomSearchBar(),

            // 主要内容区域
            Expanded(
              child: Container(
                color: const Color(0xFFF5F5F5), // Light gray background
                child: ListView(
                  children: [
                    // 功能导航
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          const FunctionNavigation(),
                          // 每日美食标签区
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: const DailyFood(),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),
                    // 标签列表
                    const FoodTagList(),
                    const SizedBox(height: 8),

                    // 内容卡片列表
                    const ContentCard(
                      imageUrl:
                          'https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg',
                      title: '回锅肉',
                      reason: '肉质鲜嫩，口感独特，咸鲜适中，是四川传统名菜，深受大众喜爱。',
                      tags: ['川菜', '热门', '推荐'],
                    ),
                    const ContentCard(
                      imageUrl:
                          'https://images.pexels.com/photos/2673353/pexels-photo-2673353.jpeg',
                      title: '东坡肉',
                      reason: '肥而不腻，入口即化，香味浓郁，是江南地区最具代表性的传统名菜之一。',
                      tags: ['苏菜', '特色', '推荐'],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
