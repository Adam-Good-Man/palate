import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/food_info.dart';
import '../services/food_analysis_service.dart';

class FoodCameraPage extends StatefulWidget {
  const FoodCameraPage({super.key});

  @override
  State<FoodCameraPage> createState() => _FoodCameraPageState();
}

class _FoodCameraPageState extends State<FoodCameraPage> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  bool _isProcessing = false;
  FoodInfo? _foodInfo;
  double _confidence = 0.0;
  String? _errorMessage;
  final FoodAnalysisService _foodAnalysisService = FoodAnalysisService();

  @override
  void initState() {
    super.initState();
    print('初始化页面');
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      print('初始化相机');
      final status = await Permission.camera.request();
      print('相机权限状态: $status');
      if (status.isDenied) {
        setState(() {
          _errorMessage = '需要相机权限才能使用此功能';
        });
        return;
      }

      if (status.isPermanentlyDenied) {
        setState(() {
          _errorMessage = '请在系统设置中授予相机权限';
        });
        return;
      }

      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _errorMessage = '未找到可用的相机';
        });
        return;
      }

      _controller = CameraController(
        cameras[0],
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
          _errorMessage = null;
        });
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
      setState(() {
        _errorMessage = '相机初始化失败，请重试';
      });
    }
  }

  Future<void> _processImage() async {
    if (_isProcessing ||
        _controller == null ||
        !_controller!.value.isInitialized) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final XFile image = await _controller!.takePicture();

      // 使用 YOLOv5 分析图片
      final foodInfo = await _foodAnalysisService.analyzeFood(image.path);

      setState(() {
        _foodInfo = foodInfo;
        _confidence = foodInfo.confidence ?? 0.0;
      });
    } catch (e) {
      debugPrint('Error processing image: $e');
      setState(() {
        _errorMessage = '分析食物时出错，请重试';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              else
                const CircularProgressIndicator(),
              const SizedBox(height: 16),
              if (_errorMessage != null)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _errorMessage = null;
                    });
                    _initializeCamera();
                  },
                  child: const Text('重试'),
                ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // 相机预览
            Center(
              child: CameraPreview(_controller!),
            ),

            // 顶部信息栏
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.black.withOpacity(0.5),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_foodInfo != null) ...[
                        Text(
                          '识别结果: ${_foodInfo!.name}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (!_foodInfo!.isFood)
                          const Text(
                            '这不是食物',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          )
                        else ...[
                          if (_foodInfo!.category != null)
                            Text(
                              '类别: ${_foodInfo!.category}${_foodInfo!.subCategory != null ? " (${_foodInfo!.subCategory})" : ""}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          if (_foodInfo!.calories != null)
                            Text(
                              '热量: ${_foodInfo!.calories} 千卡/100g',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          if (_foodInfo!.taste != null)
                            Text(
                              '口味: ${_foodInfo!.taste}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          if (_foodInfo!.ingredients != null)
                            Text(
                              '主要原料: ${_foodInfo!.ingredients.join(", ")}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          if (_foodInfo!.nutrition != null)
                            Text(
                              '营养价值: ${_foodInfo!.nutrition}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          if (_foodInfo!.origin != null)
                            Text(
                              '起源/典故: ${_foodInfo!.origin}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          if (_foodInfo!.quality != null)
                            Text(
                              '品质评估: ${_foodInfo!.quality}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          if (_foodInfo!.healthScore != null)
                            Text(
                              '健康评分: ${_foodInfo!.healthScore}/10',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          if (_foodInfo!.season != null)
                            Text(
                              '最佳食用季节: ${_foodInfo!.season}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          if (_foodInfo!.storage != null)
                            Text(
                              '保存方法: ${_foodInfo!.storage}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          if (_foodInfo!.tips != null)
                            Text(
                              '食用建议: ${_foodInfo!.tips}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                        ],
                        Text(
                          '置信度: ${(_confidence * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ] else
                        const Text(
                          '未识别',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // 底部控制栏
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 返回按钮
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),

                  // 拍照按钮
                  GestureDetector(
                    onTap: _processImage,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: _isProcessing ? Colors.grey : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 切换相机按钮
                  IconButton(
                    icon: const Icon(
                      Icons.flip_camera_ios,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () async {
                      final cameras = await availableCameras();
                      final currentCamera = _controller!.description;
                      final newCamera = cameras.firstWhere(
                        (camera) =>
                            camera.lensDirection != currentCamera.lensDirection,
                      );

                      await _controller!.dispose();
                      _controller = CameraController(
                        newCamera,
                        ResolutionPreset.high,
                        enableAudio: false,
                      );

                      await _controller!.initialize();
                      if (mounted) {
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
