FROM postgres:latest

# Устанавливаем переменные окружения (можно переопределять при запуске)
ENV POSTGRES_USER=myuser
ENV POSTGRES_PASSWORD=mypassword
ENV POSTGRES_DB=mydb

# Копируем файлы конфигурации и SQL-инициализации в контейнер
COPY postgresql.conf /etc/postgresql/postgresql.conf
COPY init-user.sql /docker-entrypoint-initdb.d/init-user.sql

# Запускаем PostgreSQL с кастомным конфигом
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
