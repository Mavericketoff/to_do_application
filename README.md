# To-Do Application

Еще не финальный вариант README. Данный проект реализовывается (в данный момент времени) в рамках курс ШМР по направлению Flutter от Yandex.

## Зависимости

**State management:** [`bloc`](https://pub.dev/packages/bloc)

**Dependency injection:** none

**DataBase:** none

**Network:** none

По ходу выполнения проекта все будет изменяться)

## Функционал

### Добавление, редактирование и удаление задач

В данный момент времени приложение не подключено к базе и серверу, поэтому сохранение данных происходит хардовым способом - закидыванием в массив.

### Тема

Была реализована темная/светалая темы, но пока что они не меняются динамически в зависимости от системной темы. Темы были реализованны с помощью bloc. Возможно, будут переделаны.

### Логирование и Error handler

Было реализовано нормальное логирование без print'ов) И Error handler - посмотреть их можно в слое CORE

### Локализация

Помимо всего вышеперечисленного была добавлена небольшая локализация.

### Преднастройка

Из преднастройки проекта был добавен анализатор и форматер. Также настроена релизная сборка под Android.

## Релизная сборка

Есть собранный apk, именно релизная сборка. Найти готовый apk для установки можно по пути `/Users/mavericketoff/Documents/GitHub/to_do_application/build/app/outputs/flutter-apk/app-release.apk`. Или скачать по ссылке - [`тык`](https://drive.google.com/file/d/11cbF6if4kgXhypLeux4g3RCLzayoY0KI/view?usp=sharing)

## Скриншоты

![Основной экран со слайдом Done](https://drive.google.com/file/d/1jMzz0CMVRW2_H0cHgzzSh2QR2VyUjhJj/view?usp=drive_link)
![Основной экран со слайдом delete](https://drive.google.com/file/d/1HygeKKVYDhcU8RM4VY3wLxf0Qd5XrT-A/view?usp=drive_link)
![Основной экран с мал. аппбаром](https://drive.google.com/file/d/1742oH0Zn_69ssgbqkEQMcE8DJJQ96mqL/view?usp=drive_link)
![Экран редактирования + информации](https://drive.google.com/file/d/1udl4rkpUNGTtYmA-2tDwd7fffRCLY9Aw/view?usp=drive_link)

## В случае возникновения вопросов

Писать в тг - @mavericketoff
