package database

import "time"

// DefaultConfig returns the default database configuration
func DefaultConfig() *DBConfig {
	return &DBConfig{
		Host:            "postgres",
		Port:            "5432",
		User:            "postgres",
		Password:        "postgres",
		DBName:          "yfj",
		SSLMode:         "disable",
		ConnMaxLifetime: time.Hour,
		MaxOpenConns:    10,
		MaxIdleConns:    5,
	}
}
