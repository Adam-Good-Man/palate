# YFJ · Your Food Journal

食物日记应用。用手机拍下食物，后端把图片交给识别服务，再按识别出的类别查出食物资料，并记下这一次识别。

当前真正接通的是拍照识别这条链路。首页是静态展示，觅食、问答和个人页还是占位。

## 组成

| 目录 | 作用 | 技术 |
| --- | --- | --- |
| `app/` | 手机客户端 | Flutter 3，Dart |
| `backend/` | HTTP API | Go 1.21，Gin，GORM |
| `yoyo/` | 食物识别服务 | 目录为空，需另行提供 |
| `docker-compose.yml` | 拉起数据库、识别服务和 API | Postgres 15 |

客户端底栏有五个入口：

- **首页**：搜索框、四个功能入口（膳食健康、大厨在线、食材搭配、食谱典籍）、每日美食、标签和两张写死的菜谱卡片。这些都不请求接口。
- **觅食 / 问答 / 我的**：居中占位文字。
- **相机**：拍照后调用 `POST /api/food/recognize`，在预览上方显示名称、热量、营养和置信度。

## 识别怎么走

1. App 把图片以 `file` 字段上传到 `POST /api/food/recognize`。
2. 后端原样转发给识别服务的 `POST /api/v1/recognize`。
3. 识别服务返回 `probabilities` 和 `class_indices`。后端取第一条概率，并把第一个类别下标当作 `foods.id` 去查。
4. 查到食物后，把置信度、文件名和时间写入 `food_recognitions`，再把结果返回给 App。

类别下标必须和数据库主键一致，否则会查错食物或查不到。

## 接口

服务默认监听 `8081`。

| 方法 | 路径 | 状态 |
| --- | --- | --- |
| `POST` | `/api/food/recognize` | 已实现 |
| `GET` | `/health` | 已实现，返回 `{"status":"ok"}` |
| `GET` | `/api/food/:id` | 返回 501 |
| `GET` | `/api/food/` | 返回 501 |

客户端还会调用 `POST /api/food` 保存食物，后端还没有这条路由。

## 本地启动

依赖：Go 1.21+、Flutter 3、Docker。

只看界面时，数据库和识别服务可以先不启。首页不访问网络接口；点相机并拍照时才会请求后端。

```bash
cd app
# 把 .env 里的 API_BASE_URL 改成你的后端地址，模拟器或浏览器可用 http://127.0.0.1:8081
flutter run
```

本机没有手机模拟器时，可以用 `flutter run -d chrome` 或 `flutter run -d macos`。相机在浏览器和 macOS 上不一定可用。

后端和数据库：

```bash
docker compose up -d postgres

cd backend
go mod tidy
go run cmd/server/main.go
```

数据库配置在 `backend/config/config.yaml`：本机连 `localhost:5433`，库名 `yfj`，用户和密码都是 `postgres`。容器内跑后端时，compose 会用环境变量把主机改成 `postgres`、端口改成 `5432`。

识别服务地址在同一份配置里，默认是 `http://localhost:5001`。`docker-compose.yml` 里 yoyo 映射的是 `8000`，两边需要对齐之后识别才会通。`yoyo/` 目前是空目录，`docker compose up` 整套服务会在构建 yoyo 时失败。

## 数据

种子脚本在 `backend/sql/`：

- `001_create_tables.sql`：食物、识别记录、密度、每 100 克营养
- `002_insert_initial_data.sql`：58 种食物，英文名加中文描述
- `003_insert_food_densities.sql`：密度，以及每 100 克的热量、蛋白质、脂肪、碳水

`backend/migrations/` 里还有另一套表结构，字段更接近 Go 模型（类别、口味、健康分等）。两套脚本不要一起执行。Go 模型、Flutter 模型和这两套 SQL 的字段还没有对齐，识别结果返回给 App 时可能缺 `calories`、`protein` 等字段。

## 目录

```
yfj/
├── app/lib/          # 页面、相机、接口和模型
├── backend/
│   ├── cmd/server/   # 入口
│   ├── internal/     # handler、service、model
│   ├── config/       # 端口、数据库、识别服务地址
│   └── sql/          # 建表和种子数据
├── yoyo/             # 识别服务，待放入
└── docker-compose.yml
```
