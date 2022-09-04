![example event parameter](https://github.com/github/docs/actions/workflows/main.yml/badge.svg?event=push)

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

Установка

- Шаг 1. Проверьте установлен ли у вас Docker
Прежде, чем приступать к работе, необходимо знать, что Docker установлен. Для этого достаточно ввести:

```
docker -v
```
Или скачайте Docker Desktop для Mac или Windows. Docker Compose будет установлен автоматически. В Linux убедитесь, что у вас установлена последняя версия Compose. Также вы можете воспользоваться официальной инструкцией.

- Шаг 2. Клонируйте репозиторий себе на компьютер
Введите команду:

```
git clone https://github.com/viplod/infra_sp2.git
```

- Шаг 3. Создайте в клонированной директории файл .env
Пример:
```
DB_ENGINE=django.db.backends.postgresql
DB_NAME=postgres
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
DB_HOST=db
DB_PORT=5432
```

- Шаг 4. Запуск docker-compose
Для запуска необходимо выполнить из директории с проектом команду:
```
docker-compose up -d
```

- Шаг 5. База данных
Создаем и применяем миграции:
```
docker-compose exec web python manage.py makemigrations --noinput
docker-compose exec web python manage.py migrate --noinput
```

- Шаг 6. Подгружаем статику
Выполните команду:
```
docker-compose exec web python manage.py collectstatic --no-input 
```

- Шаг 7. Заполнение базы тестовыми данными
Для заполнения базы тестовыми данными вы можете использовать файл fixtures.json, который находится в infra_sp2. Выполните команду:
```
docker-compose exec web python manage.py loaddata fixtures.json
```

Другие команды
Создание суперпользователя:
```
docker-compose exec web python manage.py createsuperuser
```

Остановить работу всех контейнеров можно командой:
```
docker-compose down
```

Для пересборки и запуска контейнеров воспользуйтесь командой:
```
docker-compose up -d --build
```

Мониторинг запущенных контейнеров:
```
docker stats
```

Останавливаем и удаляем контейнеры, сети, тома и образы:
```
docker-compose down -v
```

Ознакомиться с документацией по адресу.
[http://127.0.0.1/redoc/](http://127.0.0.1/redoc/)


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
