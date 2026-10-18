-- 创建食物基础信息表
CREATE TABLE IF NOT EXISTS foods (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 创建食物识别记录表
CREATE TABLE IF NOT EXISTS food_recognitions (
    id SERIAL PRIMARY KEY,
    food_id INTEGER REFERENCES foods(id),
    confidence DECIMAL(10,2) NOT NULL,
    image_path VARCHAR(255) NOT NULL,
    volume DECIMAL(10,2),  -- 体积（立方厘米）
    weight DECIMAL(10,2),  -- 重量（克）
    calories DECIMAL(10,2),  -- 卡路里
    protein DECIMAL(10,2),  -- 蛋白质
    fat DECIMAL(10,2),      -- 脂肪
    carbohydrates DECIMAL(10,2),  -- 碳水化合物
    recognized_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 创建食物密度表（用于计算体积到重量的转换）
CREATE TABLE IF NOT EXISTS food_densities (
    id SERIAL PRIMARY KEY,
    food_id INTEGER REFERENCES foods(id),
    density DECIMAL(10,2) NOT NULL,  -- 密度（克/立方厘米）
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 创建食物营养密度表（每100克）
CREATE TABLE IF NOT EXISTS food_nutrition_densities (
    id SERIAL PRIMARY KEY,
    food_id INTEGER REFERENCES foods(id),
    calories_per_100g DECIMAL(10,2) NOT NULL,  -- 每100克卡路里
    protein_per_100g DECIMAL(10,2) NOT NULL,   -- 每100克蛋白质
    fat_per_100g DECIMAL(10,2) NOT NULL,       -- 每100克脂肪
    carbs_per_100g DECIMAL(10,2) NOT NULL,     -- 每100克碳水化合物
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 创建索引
CREATE INDEX IF NOT EXISTS idx_foods_name ON foods(name);
CREATE INDEX IF NOT EXISTS idx_food_recognitions_food_id ON food_recognitions(food_id);
CREATE INDEX IF NOT EXISTS idx_food_recognitions_recognized_at ON food_recognitions(recognized_at);
CREATE INDEX IF NOT EXISTS idx_food_densities_food_id ON food_densities(food_id);
CREATE INDEX IF NOT EXISTS idx_food_nutrition_densities_food_id ON food_nutrition_densities(food_id); 