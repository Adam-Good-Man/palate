package handler

import (
	"log"
	"net/http"
	"path/filepath"

	"yfj/backend/internal/service"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type Handler struct {
	db      *gorm.DB
	yoyoURL string
}

func NewHandler(db *gorm.DB, yoyoURL string) *Handler {
	return &Handler{
		db:      db,
		yoyoURL: yoyoURL,
	}
}

func RegisterRoutes(r *gin.Engine, db *gorm.DB, yoyoURL string) {
	h := NewHandler(db, yoyoURL)

	// 食物相关路由
	food := r.Group("/api/food")
	{
		food.POST("/recognize", h.RecognizeFood)
		food.GET("/:id", h.GetFood)
		food.GET("/", h.ListFoods)
	}

	// 健康检查
	r.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"status": "ok",
		})
	})
}

func (h *Handler) RecognizeFood(c *gin.Context) {
	log.Println("收到食物识别请求")

	file, err := c.FormFile("file")
	if err != nil {
		log.Printf("文件上传失败: %v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": "No file uploaded"})
		return
	}
	log.Printf("成功接收文件: %s", file.Filename)

	// 打开上传的文件
	src, err := file.Open()
	if err != nil {
		log.Printf("打开文件失败: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to open file"})
		return
	}
	defer src.Close()
	log.Println("文件已成功打开")

	// 创建食物服务
	foodService := service.NewFoodService(h.db, h.yoyoURL)
	log.Printf("准备调用 YOLO 服务进行识别，YOLO 服务地址: %s", h.yoyoURL)

	// 识别食物
	recognition, err := foodService.RecognizeFood(src, filepath.Base(file.Filename))
	if err != nil {
		log.Printf("食物识别失败: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	log.Printf("食物识别成功: %+v", recognition)

	c.JSON(http.StatusOK, gin.H{
		"status": "success",
		"data":   recognition,
	})
}

func (h *Handler) GetFood(c *gin.Context) {
	// TODO: 实现获取食物详情逻辑
	c.JSON(http.StatusNotImplemented, gin.H{
		"error": "Not implemented",
	})
}

func (h *Handler) ListFoods(c *gin.Context) {
	// TODO: 实现获取食物列表逻辑
	c.JSON(http.StatusNotImplemented, gin.H{
		"error": "Not implemented",
	})
}
