---  

# PostgreSQL Docker Light  

Этот проект предоставляет лёгкий способ развернуть PostgreSQL в контейнере Docker с кастомными настройками.  

## 📌 Возможности  
- Развёртывание PostgreSQL через `docker run` или `docker compose`.  
- Кастомная конфигурация через `postgresql.conf`.  
- Переменные окружения загружаются из `env`.  
- Логирование и контроль потребления ресурсов.  
- Автоматический `healthcheck`.  

## 🚀 Установка и запуск  

### 1. Клонируем репозиторий  
```bash
git clone https://github.com/Evgenykravchenko/postgres-docker-light.git
cd postgres-docker-light
```

### 2. Создаём файл `.env`  
При необходимости отредактируйте `.env`, задав свои параметры.  

### 3. Запуск с `docker compose` (рекомендуется)  
```bash
docker compose up -d
```
Если у вас `docker-compose` старой версии:  
```bash
docker-compose up -d
```
Проверить, что контейнер запущен:  
```bash
docker ps
```

### 4. Запуск без `docker compose`  
Можно запустить напрямую через `docker run`:  
```bash
docker run -d \
  --name postgres_light \
  --env-file .env \
  -p 6543:5432 \
  -v pgdata:/var/lib/postgresql/data \
  -v "$(pwd)/postgresql.conf:/etc/postgresql/postgresql.conf" \
  --restart unless-stopped \
  --memory=512m \
  --health-cmd="pg_isready -U myuser" \
  --health-interval=10s \
  --health-timeout=5s \
  --health-retries=5 \
  postgres:latest \
  -c config_file=/etc/postgresql/postgresql.conf
```

## 🔍 Проверка работоспособности  

### 1. Проверяем состояние контейнера  
```bash
docker ps
```

### 2. Подключаемся к БД через `psql`  
```bash
psql -h localhost -p 6543 -U myuser -d mydb
```
Пароль возьмите из `.env` (`POSTGRES_PASSWORD`).  

Или через `docker exec`:  
```bash
docker exec -it postgres_light psql -U myuser -d mydb
```

### 3. Проверяем `healthcheck`  
```bash
docker inspect --format='{{json .State.Health}}' postgres_light | jq
```
Если `Status` = `healthy`, то всё работает! 🚀  

## 🛑 Остановка и удаление контейнера  

### Остановить контейнер:  
```bash
docker stop postgres_light
```
  
### Удалить контейнер:  
```bash
docker rm postgres_light
```

### Полностью удалить с volume:  
```bash
docker stop postgres_light && docker rm postgres_light && docker volume rm pgdata
```

## 🛠 Полезные команды  

Посмотреть логи:  
```bash
docker logs postgres_light
```

Перезапустить контейнер:  
```bash
docker restart postgres_light
```

Зайти в контейнер:  
```bash
docker exec -it postgres_light bash
```

Удалить все контейнеры и тома (⚠️ очистит всё!):  
```bash
docker system prune -a --volumes
```

## 📜 Лицензия  
MIT  

---  
