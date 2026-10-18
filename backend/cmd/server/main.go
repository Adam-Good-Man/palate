package main

import (
	"log"
	"time"

	"yfj/backend/internal/handler"
	"yfj/backend/pkg/database"

	"github.com/gin-gonic/gin"
	"github.com/spf13/viper"
)

func main() {
	// 加载配置
	viper.SetConfigName("config")
	viper.SetConfigType("yaml")
	viper.AddConfigPath("./config")
	if err := viper.ReadInConfig(); err != nil {
		log.Fatalf("Error reading config file: %v", err)
	}

	// 从配置文件创建数据库配置
	dbConfig := &database.DBConfig{
		Host:            viper.GetString("database.host"),
		Port:            viper.GetString("database.port"),
		User:            viper.GetString("database.username"),
		Password:        viper.GetString("database.password"),
		DBName:          viper.GetString("database.dbname"),
		SSLMode:         "disable",
		ConnMaxLifetime: time.Duration(viper.GetInt("database.conn_max_lifetime")) * time.Second,
		MaxOpenConns:    viper.GetInt("database.max_open_conns"),
		MaxIdleConns:    viper.GetInt("database.max_idle_conns"),
	}

	db, err := database.ConnectMySQL(dbConfig)
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}

	// 设置 Gin 模式
	if viper.GetString("server.mode") == "release" {
		gin.SetMode(gin.ReleaseMode)
	}

	// 创建路由
	r := gin.Default()

	// 获取 YOYO URL
	yoyoURL := viper.GetString("yoyo.url")

	// 注册路由
	handler.RegisterRoutes(r, db, yoyoURL)

	// 启动服务器
	port := viper.GetString("server.port")
	log.Printf("Server starting on port %s", port)
	if err := r.Run("0.0.0.0:" + port); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
