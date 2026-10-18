-- 插入食物密度数据 (克/立方厘米)
INSERT INTO food_densities (food_id, density) VALUES
-- 水果
((SELECT id FROM foods WHERE name = 'apple'), 0.85),
((SELECT id FROM foods WHERE name = 'banana'), 0.95),
((SELECT id FROM foods WHERE name = 'orange'), 0.90),
((SELECT id FROM foods WHERE name = 'pineapple'), 0.95),
((SELECT id FROM foods WHERE name = 'strawberry'), 0.80),
((SELECT id FROM foods WHERE name = 'grapes'), 0.90),
((SELECT id FROM foods WHERE name = 'watermelon'), 0.95),

-- 蔬菜
((SELECT id FROM foods WHERE name = 'broccoli'), 0.40),
((SELECT id FROM foods WHERE name = 'carrot'), 0.85),
((SELECT id FROM foods WHERE name = 'corn'), 0.75),
((SELECT id FROM foods WHERE name = 'cucumber'), 0.95),
((SELECT id FROM foods WHERE name = 'lettuce'), 0.30),
((SELECT id FROM foods WHERE name = 'tomato'), 0.95),
((SELECT id FROM foods WHERE name = 'potato'), 0.80),
((SELECT id FROM foods WHERE name = 'onion'), 0.85),
((SELECT id FROM foods WHERE name = 'eggplant'), 0.90),
((SELECT id FROM foods WHERE name = 'bell pepper'), 0.90),
((SELECT id FROM foods WHERE name = 'mushroom'), 0.85),
((SELECT id FROM foods WHERE name = 'garlic'), 0.90),
((SELECT id FROM foods WHERE name = 'ginger'), 0.90),

-- 主食
((SELECT id FROM foods WHERE name = 'bread'), 0.25),
((SELECT id FROM foods WHERE name = 'rice'), 0.80),
((SELECT id FROM foods WHERE name = 'noodles'), 0.60),
((SELECT id FROM foods WHERE name = 'pasta'), 0.60),

-- 肉类
((SELECT id FROM foods WHERE name = 'chicken'), 1.05),
((SELECT id FROM foods WHERE name = 'fish'), 1.00),
((SELECT id FROM foods WHERE name = 'shrimp'), 1.00),
((SELECT id FROM foods WHERE name = 'crab'), 1.00),
((SELECT id FROM foods WHERE name = 'lobster'), 1.00),
((SELECT id FROM foods WHERE name = 'steak'), 1.05),

-- 快餐
((SELECT id FROM foods WHERE name = 'hamburger'), 0.90),
((SELECT id FROM foods WHERE name = 'french fries'), 0.50),
((SELECT id FROM foods WHERE name = 'pizza'), 0.80),
((SELECT id FROM foods WHERE name = 'hot dog'), 1.00),
((SELECT id FROM foods WHERE name = 'taco'), 0.80),
((SELECT id FROM foods WHERE name = 'burrito'), 0.80),

-- 甜点
((SELECT id FROM foods WHERE name = 'donut'), 0.40),
((SELECT id FROM foods WHERE name = 'cake'), 0.45),
((SELECT id FROM foods WHERE name = 'ice cream'), 0.60),
((SELECT id FROM foods WHERE name = 'chocolate'), 1.20),
((SELECT id FROM foods WHERE name = 'cookie'), 0.50),
((SELECT id FROM foods WHERE name = 'candy'), 1.30),

-- 饮料
((SELECT id FROM foods WHERE name = 'coffee'), 1.00),
((SELECT id FROM foods WHERE name = 'tea'), 1.00),
((SELECT id FROM foods WHERE name = 'juice'), 1.05),
((SELECT id FROM foods WHERE name = 'soda'), 1.00),
((SELECT id FROM foods WHERE name = 'beer'), 1.00),
((SELECT id FROM foods WHERE name = 'wine'), 1.00),

-- 其他
((SELECT id FROM foods WHERE name = 'soup'), 1.00),
((SELECT id FROM foods WHERE name = 'salad'), 0.30),
((SELECT id FROM foods WHERE name = 'sushi'), 1.00),
((SELECT id FROM foods WHERE name = 'sausage'), 1.00),
((SELECT id FROM foods WHERE name = 'bacon'), 1.00),
((SELECT id FROM foods WHERE name = 'egg'), 1.00),
((SELECT id FROM foods WHERE name = 'pancake'), 0.40),
((SELECT id FROM foods WHERE name = 'waffle'), 0.35),
((SELECT id FROM foods WHERE name = 'muffin'), 0.40),
((SELECT id FROM foods WHERE name = 'bagel'), 0.30);

-- 插入食物营养密度数据 (每100克)
INSERT INTO food_nutrition_densities (food_id, calories, protein, fat, carbohydrates) VALUES
-- 水果
((SELECT id FROM foods WHERE name = 'apple'), 52, 0.3, 0.2, 14),
((SELECT id FROM foods WHERE name = 'banana'), 89, 1.1, 0.3, 23),
((SELECT id FROM foods WHERE name = 'orange'), 47, 0.9, 0.1, 12),
((SELECT id FROM foods WHERE name = 'pineapple'), 50, 0.5, 0.1, 13),
((SELECT id FROM foods WHERE name = 'strawberry'), 32, 0.7, 0.3, 7.7),
((SELECT id FROM foods WHERE name = 'grapes'), 69, 0.7, 0.2, 18),
((SELECT id FROM foods WHERE name = 'watermelon'), 30, 0.6, 0.2, 7.6),

-- 蔬菜
((SELECT id FROM foods WHERE name = 'broccoli'), 34, 2.8, 0.4, 6.6),
((SELECT id FROM foods WHERE name = 'carrot'), 41, 0.9, 0.2, 10),
((SELECT id FROM foods WHERE name = 'corn'), 86, 3.2, 1.2, 19),
((SELECT id FROM foods WHERE name = 'cucumber'), 16, 0.7, 0.1, 3.6),
((SELECT id FROM foods WHERE name = 'lettuce'), 15, 1.4, 0.2, 2.9),
((SELECT id FROM foods WHERE name = 'tomato'), 18, 0.9, 0.2, 3.9),
((SELECT id FROM foods WHERE name = 'potato'), 77, 2, 0.1, 17),
((SELECT id FROM foods WHERE name = 'onion'), 40, 1.1, 0.1, 9.3),
((SELECT id FROM foods WHERE name = 'eggplant'), 25, 1, 0.2, 6),
((SELECT id FROM foods WHERE name = 'bell pepper'), 31, 1, 0.3, 6),
((SELECT id FROM foods WHERE name = 'mushroom'), 22, 3.1, 0.3, 3.3),
((SELECT id FROM foods WHERE name = 'garlic'), 149, 6.4, 0.5, 33),
((SELECT id FROM foods WHERE name = 'ginger'), 80, 1.8, 0.8, 18),

-- 主食
((SELECT id FROM foods WHERE name = 'bread'), 265, 9, 3.2, 49),
((SELECT id FROM foods WHERE name = 'rice'), 130, 2.7, 0.3, 28),
((SELECT id FROM foods WHERE name = 'noodles'), 138, 4.5, 0.5, 27),
((SELECT id FROM foods WHERE name = 'pasta'), 131, 5, 1.1, 25),

-- 肉类
((SELECT id FROM foods WHERE name = 'chicken'), 239, 27, 14, 0),
((SELECT id FROM foods WHERE name = 'fish'), 206, 22, 13, 0),
((SELECT id FROM foods WHERE name = 'shrimp'), 99, 24, 1.3, 0.2),
((SELECT id FROM foods WHERE name = 'crab'), 97, 19, 1.5, 0),
((SELECT id FROM foods WHERE name = 'lobster'), 89, 19, 0.5, 0),
((SELECT id FROM foods WHERE name = 'steak'), 271, 26, 19, 0),

-- 快餐
((SELECT id FROM foods WHERE name = 'hamburger'), 295, 17, 12, 31),
((SELECT id FROM foods WHERE name = 'french fries'), 312, 3.4, 15, 41),
((SELECT id FROM foods WHERE name = 'pizza'), 266, 11, 10, 33),
((SELECT id FROM foods WHERE name = 'hot dog'), 290, 10, 26, 4),
((SELECT id FROM foods WHERE name = 'taco'), 226, 9, 12, 20),
((SELECT id FROM foods WHERE name = 'burrito'), 206, 6.7, 6.3, 27),

-- 甜点
((SELECT id FROM foods WHERE name = 'donut'), 452, 4.9, 25, 51),
((SELECT id FROM foods WHERE name = 'cake'), 350, 5, 15, 50),
((SELECT id FROM foods WHERE name = 'ice cream'), 207, 3.5, 11, 24),
((SELECT id FROM foods WHERE name = 'chocolate'), 546, 4.9, 31, 61),
((SELECT id FROM foods WHERE name = 'cookie'), 502, 6, 24, 65),
((SELECT id FROM foods WHERE name = 'candy'), 394, 0, 0.2, 98),

-- 饮料
((SELECT id FROM foods WHERE name = 'coffee'), 2, 0.3, 0, 0),
((SELECT id FROM foods WHERE name = 'tea'), 1, 0, 0, 0.3),
((SELECT id FROM foods WHERE name = 'juice'), 45, 0.5, 0.1, 11),
((SELECT id FROM foods WHERE name = 'soda'), 150, 0, 0, 39),
((SELECT id FROM foods WHERE name = 'beer'), 43, 0.5, 0, 3.6),
((SELECT id FROM foods WHERE name = 'wine'), 123, 0.1, 0, 3.8),

-- 其他
((SELECT id FROM foods WHERE name = 'soup'), 100, 5, 4, 10),
((SELECT id FROM foods WHERE name = 'salad'), 15, 1, 0.2, 3),
((SELECT id FROM foods WHERE name = 'sushi'), 200, 9, 1, 38),
((SELECT id FROM foods WHERE name = 'sausage'), 296, 12, 26, 1.3),
((SELECT id FROM foods WHERE name = 'bacon'), 43, 3, 3.3, 0.1),
((SELECT id FROM foods WHERE name = 'egg'), 143, 13, 10, 1.1),
((SELECT id FROM foods WHERE name = 'pancake'), 227, 6, 10, 28),
((SELECT id FROM foods WHERE name = 'waffle'), 291, 7.9, 14, 33),
((SELECT id FROM foods WHERE name = 'muffin'), 377, 4.5, 16, 53),
((SELECT id FROM foods WHERE name = 'bagel'), 245, 9, 1.5, 48); 