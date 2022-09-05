![API for YaMDB](https://github.com/viplod/yamdb_final/actions/workflows/yamdb_workflow.yml/badge.svg?branch=master)

Проект размещается по адресу http://viplod.sytes.net/

![](./api_yamdb/static/header.png)
#Документация к API проекта YAMDB (v1)
Проект YaMDb собирает отзывы пользователей на различные произведения;
___
![DjangoREST](https://img.shields.io/badge/DJANGO-REST-ff1709?style=for-the-badge&logo=django&logoColor=white&color=ff1709&labelColor=gray)
![Django](https://img.shields.io/badge/django-%23092E20.svg?style=for-the-badge&logo=django&logoColor=white)
![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white)

![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/26remph/api_final_yatube)
![GitHub repo size](https://img.shields.io/github/repo-size/26remph/api_yamdb)
![GitHub](https://img.shields.io/github/license/26remph/api_yamdb)
![pythonversion](https://img.shields.io/badge/python-%3E%3D3.7-blue)


## Оглавление
0. [Описание](#описание)
1. [Стек технологий](#стек-технологий)
2. [Как запустить проект](#как-запустить-проект)
3. [Документация по api](#документация-по-api)
4. [Примеры запросов к api](#примеры-запросов-к-api)
5. [Авторы проекта](#авторы-проекта)


## Описание
Проект YaMDb собирает отзывы пользователей на произведения. Произведения делятся на категории: «Книги», «Фильмы», «Музыка». Произведению может быть присвоен жанр. Новые жанры может создавать только администратор. Читатели оставляют к произведениям текстовые отзывы и выставляют произведению рейтинг (оценку в диапазоне от одного до десяти). Из множества оценок автоматически высчитывается средняя оценка произведения.


## Стек технологий
- проект написан на Python с использованием Django REST Framework
- библиотека Simple JWT - работа с JWT-токеном
- библиотека django-filter - фильтрация запросов
- базы данны - SQLite3
- система управления версиями - git


## Как запустить проект:

### Шаблон описания файла .env
 - DB_ENGINE=django.db.backends.postgresql
 - DB_NAME=postgres
 - POSTGRES_USER=postgres
 - POSTGRES_PASSWORD=postgres
 - DB_HOST=db
 - DB_PORT=5432
 - SECRET_KEY=<секретный ключ проекта django>
### Инструкции для развертывания и запуска приложения
для Linux-систем все команды необходимо выполнять от имени администратора
- Склонировать репозиторий
```bash
git clone https://github.com/viplod/yamdb_final.git
```
- Выполнить вход на удаленный сервер
- Установить docker на сервер:
```bash
apt install docker.io 
```
- Установить docker-compose на сервер:
```bash
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```
- Локально отредактировать файл infra/nginx.conf, обязательно в строке server_name вписать IP-адрес сервера
- Скопировать файлы docker-compose.yml и nginx.conf из директории infra на сервер:
```bash
scp docker-compose.yml <username>@<host>:/home/<username>/docker-compose.yml
scp nginx.conf <username>@<host>:/home/<username>/nginx.conf
```
- Создать .env файл по предлагаемому выше шаблону. Обязательно изменить значения POSTGRES_USER и POSTGRES_PASSWORD
- Для работы с Workflow добавить в Secrets GitHub переменные окружения для работы:
    ```
    DB_ENGINE=<django.db.backends.postgresql>
    DB_NAME=<имя базы данных postgres>
    DB_USER=<пользователь бд>
    DB_PASSWORD=<пароль>
    DB_HOST=<db>
    DB_PORT=<5432>
    
    DOCKER_PASSWORD=<пароль от DockerHub>
    DOCKER_USERNAME=<имя пользователя>
    
    SECRET_KEY=<секретный ключ проекта django>

    USER=<username для подключения к серверу>
    HOST=<IP сервера>
    PASSPHRASE=<пароль для сервера, если он установлен>
    SSH_KEY=<ваш SSH ключ (для получения команда: cat ~/.ssh/id_rsa)>

    TELEGRAM_TO=<ID чата, в который придет сообщение>
    TELEGRAM_TOKEN=<токен вашего бота>
    ```
    Workflow состоит из четырёх шагов:
     - Проверка кода на соответствие PEP8
     - Сборка и публикация образа бекенда на DockerHub.
     - Автоматический деплой на удаленный сервер.
     - Отправка уведомления в телеграм-чат.
- собрать и запустить контейнеры на сервере:
```bash
docker-compose up -d --build
```
- После успешной сборки выполнить следующие действия (только при первом деплое):
    * провести миграции внутри контейнеров:
    ```bash
    docker-compose exec web python manage.py migrate
    ```
    * собрать статику проекта:
    ```bash
    docker-compose exec web python manage.py collectstatic --no-input
    ```  
    * Создать суперпользователя Django, после запроса от терминала ввести логин и пароль для суперпользователя:
    ```bash
    docker-compose exec web python manage.py createsuperuser
    ```
Ознакомиться с документацией можно в формате ReDoc


## Документация по api

### Алгоритм получения токена:
#### 1. Получить код подтвержения.
в теле передать JSON
{
  "username": "имя_пользователя",
  "email": "адрес эл. почты"
}
POST-запрос на эндпоинт:
```
http://127.0.0.1/api/v1/auth/signup/
```


в папке sent_emails найти письмо и скопировать полученный код подтверждения.

#### 2. Получить токен.
в теле передать JSON
{
  "username": "имя_пользователя",
  "confirmation_code": "код_подтвержения"
}
POST-запрос на эндпоинт:
```
http://127.0.0.1/api/v1/auth/token/
```
Токен использовать для авторизации


## Примеры запросов к api

### Некоторые примеры запросов к API.
Доступные энд-поинты:
GET-запросы
```
/api/v1/users/
```
```
/api/v1/titles/
```
```
/api/v1/categories/
```
```
/api/v1/genres/
```
```
/api/v1/titles/{title_id}/reviews/
```
```
/api/v1/titles/{title_id}/reviews/{review_id}/comments/
```


## Авторы проекта
_[Вадим Барсуков](https://github.com/26remph)_, python-developer  
_[Денис Мурашов](https://github.com/okazivaetsya)_, python-developer  
_[Юра Ананьин](https://github.com/viplod/)_, python-developer  

___
<p>
    <span>© 2022, Contributors on git: 26Remph, viplod, okazivaetsya. ツ </span>
</p>
