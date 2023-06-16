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

Есть собранный apk, именно релизная сборка. Найти готовый apk для установки можно по пути `build/app/outputs/flutter-apk/app-release.apk`. Или скачать по ссылке - [`тык`](https://drive.google.com/file/d/11cbF6if4kgXhypLeux4g3RCLzayoY0KI/view?usp=sharing) Или можно найти ее в релизах гита)

## Скриншоты
<img src="https://github.com/Mavericketoff/to_do_application/assets/47009823/43aeca75-c64d-4396-934e-2cdb0a94134b.png" width="400" height="700">

<img src="https://github.com/Mavericketoff/to_do_application/assets/47009823/65f2f7e1-7ea6-436f-afe2-f98b9f936182.png" width="400" height="700">

<img src="https://github.com/Mavericketoff/to_do_application/assets/47009823/8e7228de-e0ce-4907-8e40-c241a61616ca.png" width="400" height="700">

<img src="https://github.com/Mavericketoff/to_do_application/assets/47009823/2b46838f-004e-42c6-b6c5-d3f2c569c096.png" width="400" height="700">

## В случае возникновения вопросов

Писать в тг - @mavericketoff
