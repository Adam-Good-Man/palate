-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create food table
CREATE TABLE IF NOT EXISTS foods (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP WITH TIME ZONE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    sub_category VARCHAR(50),
    calories DECIMAL(10,2),
    taste VARCHAR(50),
    ingredients TEXT[],
    nutrition TEXT,
    origin TEXT,
    quality TEXT,
    health_score INTEGER,
    season VARCHAR(50),
    storage TEXT,
    tips TEXT,
    image_url VARCHAR(255),
    is_active BOOLEAN DEFAULT true,
    UNIQUE(name)
);

-- Create food recognition table
CREATE TABLE IF NOT EXISTS food_recognitions (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP WITH TIME ZONE,
    food_id INTEGER NOT NULL REFERENCES foods(id),
    confidence DECIMAL(5,4),
    image_path VARCHAR(255),
    recognized_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_foods_name ON foods(name);
CREATE INDEX IF NOT EXISTS idx_foods_category ON foods(category);
CREATE INDEX IF NOT EXISTS idx_food_recognitions_food_id ON food_recognitions(food_id);
CREATE INDEX IF NOT EXISTS idx_food_recognitions_recognized_at ON food_recognitions(recognized_at); 