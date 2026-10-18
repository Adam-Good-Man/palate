package database

import (
	"fmt"
	"log"
	"os"
	"time"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

// DBConfig represents the database configuration
type DBConfig struct {
	Host            string
	Port            string
	User            string
	Password        string
	DBName          string
	SSLMode         string
	ConnMaxLifetime time.Duration
	MaxOpenConns    int
	MaxIdleConns    int
}

func getEnvOrDefault(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}

// ConnectMySQL creates a new PostgreSQL database connection
func ConnectMySQL(config *DBConfig) (*gorm.DB, error) {
	// 从环境变量获取配置，如果环境变量不存在则使用默认值
	host := getEnvOrDefault("DB_HOST", config.Host)
	port := getEnvOrDefault("DB_PORT", config.Port)
	user := getEnvOrDefault("DB_USER", config.User)
	password := getEnvOrDefault("DB_PASSWORD", config.Password)
	dbname := getEnvOrDefault("DB_NAME", config.DBName)
	sslmode := getEnvOrDefault("DB_SSL_MODE", config.SSLMode)

	dsn := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=%s",
		host, port, user, password, dbname, sslmode)

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		return nil, fmt.Errorf("failed to connect to database: %w", err)
	}

	sqlDB, err := db.DB()
	if err != nil {
		return nil, fmt.Errorf("failed to get database instance: %w", err)
	}

	// Set connection pool settings
	sqlDB.SetMaxIdleConns(config.MaxIdleConns)
	sqlDB.SetMaxOpenConns(config.MaxOpenConns)
	sqlDB.SetConnMaxLifetime(config.ConnMaxLifetime)

	log.Println("Successfully connected to database")
	return db, nil
}
