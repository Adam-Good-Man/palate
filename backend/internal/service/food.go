package service

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"mime/multipart"
	"net/http"
	"time"
	"yfj/backend/internal/model"

	"gorm.io/gorm"
)

type FoodService struct {
	db      *gorm.DB
	yoyoURL string
}

func NewFoodService(db *gorm.DB, yoyoURL string) *FoodService {
	return &FoodService{
		db:      db,
		yoyoURL: yoyoURL,
	}
}

func (s *FoodService) RecognizeFood(image io.Reader, filename string) (*model.FoodRecognition, error) {
	log.Printf("开始处理食物识别请求，文件名: %s", filename)

	// 创建 multipart 请求
	var requestBody bytes.Buffer
	writer := multipart.NewWriter(&requestBody)
	log.Println("创建 multipart 请求")

	// 添加文件
	part, err := writer.CreateFormFile("file", filename)
	if err != nil {
		log.Printf("创建表单文件失败: %v", err)
		return nil, fmt.Errorf("failed to create form file: %v", err)
	}

	if _, err := io.Copy(part, image); err != nil {
		log.Printf("复制图片数据失败: %v", err)
		return nil, fmt.Errorf("failed to copy image: %v", err)
	}

	writer.Close()
	log.Println("准备发送请求到 YOLO 服务")

	// 发送请求到 yoyo 服务
	resp, err := http.Post(s.yoyoURL+"/api/v1/recognize", writer.FormDataContentType(), &requestBody)
	if err != nil {
		log.Printf("发送请求到 YOLO 服务失败: %v", err)
		return nil, fmt.Errorf("failed to send request to yoyo service: %v", err)
	}
	defer resp.Body.Close()
	log.Printf("收到 YOLO 服务响应，状态码: %d", resp.StatusCode)

	// 检查响应状态码
	if resp.StatusCode != http.StatusOK {
		bodyBytes, _ := io.ReadAll(resp.Body)
		log.Printf("YOLO 服务返回错误: %d, 响应体: %s", resp.StatusCode, string(bodyBytes))
		return nil, fmt.Errorf("yoyo service returned non-200 status code: %d, body: %s", resp.StatusCode, string(bodyBytes))
	}

	// 解析响应
	var result struct {
		Status string `json:"status"`
		Data   struct {
			Probabilities []float64 `json:"probabilities"`
			ClassIndices  []int     `json:"class_indices"`
		} `json:"data"`
	}

	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		log.Printf("解析 YOLO 服务响应失败: %v", err)
		return nil, fmt.Errorf("failed to decode response: %v", err)
	}

	if result.Status != "success" {
		log.Printf("YOLO 服务返回错误状态: %s", result.Status)
		return nil, fmt.Errorf("yoyo service returned error status: %s", result.Status)
	}

	// 验证返回的数据
	if len(result.Data.Probabilities) == 0 || len(result.Data.ClassIndices) == 0 {
		log.Println("YOLO 服务返回空结果")
		return nil, fmt.Errorf("yoyo service returned empty results")
	}

	log.Printf("YOLO 服务返回结果: 概率=%v, 类别=%v", result.Data.Probabilities, result.Data.ClassIndices)

	// 创建食物识别记录
	recognition := &model.FoodRecognition{
		Confidence:   result.Data.Probabilities[0],
		RecognizedAt: time.Now(),
		ImagePath:    filename, // 保存图片路径
	}

	// 获取对应的食物信息
	foodID := uint(result.Data.ClassIndices[0])
	log.Printf("准备获取食物信息，ID: %d", foodID)

	food, err := s.GetFood(foodID)
	if err != nil {
		log.Printf("获取食物信息失败: %v", err)
		return nil, fmt.Errorf("failed to get food info: %v", err)
	}

	if food == nil {
		log.Printf("未找到食物，ID: %d", foodID)
		return nil, fmt.Errorf("food with ID %d not found", foodID)
	}

	recognition.FoodID = food.ID
	recognition.Food = *food
	log.Printf("成功获取食物信息: %+v", food)

	// 保存识别记录
	if err := s.db.Create(recognition).Error; err != nil {
		log.Printf("保存识别记录失败: %v", err)
		return nil, fmt.Errorf("failed to save recognition: %v", err)
	}
	log.Printf("成功保存识别记录: %+v", recognition)

	return recognition, nil
}

func (s *FoodService) CreateFood(food *model.Food) error {
	return s.db.Create(food).Error
}

func (s *FoodService) GetFood(id uint) (*model.Food, error) {
	var food model.Food
	err := s.db.First(&food, id).Error
	if err != nil {
		return nil, err
	}
	return &food, nil
}

func (s *FoodService) ListFoods() ([]model.Food, error) {
	var foods []model.Food
	err := s.db.Find(&foods).Error
	if err != nil {
		return nil, err
	}
	return foods, nil
}

func (s *FoodService) CreateFoodRecognition(recognition *model.FoodRecognition) error {
	return s.db.Create(recognition).Error
}

func (s *FoodService) GetFoodRecognition(id uint) (*model.FoodRecognition, error) {
	var recognition model.FoodRecognition
	err := s.db.Preload("Food").First(&recognition, id).Error
	if err != nil {
		return nil, err
	}
	return &recognition, nil
}
