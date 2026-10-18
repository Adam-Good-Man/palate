package model

import (
	"time"

	"gorm.io/gorm"
)

// Food represents a food item in the database
type Food struct {
	gorm.Model
	Name        string    `gorm:"type:varchar(100);not null;uniqueIndex" json:"name"`
	Category    string    `gorm:"type:varchar(50);not null" json:"category"`
	SubCategory string    `gorm:"type:varchar(50)" json:"sub_category"`
	Calories    float64   `gorm:"type:decimal(10,2)" json:"calories"`
	Taste       string    `gorm:"type:varchar(50)" json:"taste"`
	Ingredients []string  `gorm:"type:text[]" json:"ingredients"`
	Nutrition   string    `gorm:"type:text" json:"nutrition"`
	Origin      string    `gorm:"type:text" json:"origin"`
	Quality     string    `gorm:"type:text" json:"quality"`
	HealthScore int       `gorm:"type:integer" json:"health_score"`
	Season      string    `gorm:"type:varchar(50)" json:"season"`
	Storage     string    `gorm:"type:text" json:"storage"`
	Tips        string    `gorm:"type:text" json:"tips"`
	ImageURL    string    `gorm:"type:varchar(255)" json:"image_url"`
	IsActive    bool      `gorm:"default:true" json:"is_active"`
	CreatedAt   time.Time `json:"created_at"`
	UpdatedAt   time.Time `json:"updated_at"`
}

// FoodRecognition represents a food recognition result
type FoodRecognition struct {
	gorm.Model
	FoodID       uint      `gorm:"not null" json:"food_id"`
	Confidence   float64   `gorm:"type:decimal(5,4)" json:"confidence"`
	ImagePath    string    `gorm:"type:varchar(255)" json:"image_path"`
	RecognizedAt time.Time `json:"recognized_at"`
	Food         Food      `gorm:"foreignKey:FoodID" json:"food"`
}
