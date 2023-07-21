# To-Do Application

Еще не финальный вариант README. Данный проект реализовывается (в данный момент времени) в рамках курс ШМР по направлению Flutter от Yandex.

## Важное пояснение!!!

Почему я заливаю коммит после дедлайна - я как последний дебил напортачил с коммитами и по итогу похерил себе ветку для 4 дз из-за чего у меня произошли конфликты, которые убили пол файлов и сломали весь проект) Поэтому я сейчас все сиправил (никаких доп изменений не вносил, только то, что успел сделать до дедлайна), просьба понять и простить дурачка с гитом)

## Зависимости

**State management:** [`bloc`](https://pub.dev/packages/bloc)

**Internationalization:** [`intl`](https://pub.dev/packages/intl)

**HTTP:** [`dio`](https://pub.dev/packages/dio)

**Network:** [`dio`](https://pub.dev/packages/dio)

**Logs:** [`logging`](https://pub.dev/packages/logging)

**LocalStorage:** [`shared_preferences`](https://pub.dev/packages/shared_preferences) + [`sqflite`](https://pub.dev/packages/sqflite)

**FireBase:** [`firebase`](https://console.firebase.google.com/u/0/)

По ходу выполнения проекта все будет изменяться)

## Функционал

### Добавление, редактирование и удаление задач

В данный момент времени приложение подключено к базе и серверу.

### Тема

Была реализована темная/светалая темы, но пока что они не меняются динамически в зависимости от системной темы. Темы были реализованны с помощью bloc. Возможно, будут переделаны.

### Логирование и Error handler

Было реализовано нормальное логирование без print'ов) И Error handler - посмотреть их можно в слое CORE

### Локализация

Помимо всего вышеперечисленного была добавлена небольшая локализация.

### Преднастройка

## Краткое перечисление фичей

- Локализация
- Error Handler
- Логгирование
- Просмотр списка задач
- Скрытие выполненых задач
- Быстрое добавление задач
- Степень важности задач
- Дедлайны
- Добавление, редактирование, удаление
- Сохранение задач на сервере
- Сохранение задач локально на устройстве
- Синхронизация локальных данных и сервера
- Скрытие выполненных задач
- Можно работать с задачами без ожидания выполнения действий связанных с данными хранящимися в хранилище
- Какая-то попытка в Unit тесты и Integration тесты
- Переезд на Navigator 2.0
- Подключены DeepLinks
- Реализована поддержка лендскейп-ориентации
- Почти реализована работа с Remote Configs (все ломалось, но я пытался)
- Подключен и настроен Firebase Crashlytics
- Не собирается аналитика по событиям с помощью Firebase Analytics (тоже пытался, но FireBase меня послал)
- Настроен CI, но без распространения через Firebase App Distribution (какашка не заработала)
- Поддержаны несколько флейворов: для разработки и продакшена
- Добавлена анимация при свайпе (не знаю что с ней, на разных эмуляторах работает по разному)

Из преднастройки проекта был добавен анализатор и форматер. Также настроена релизная сборка под Android.

## Релизная сборка

Есть собранный apk, именно релизная сборка. Найти готовый apk для установки можно по пути `build/app/outputs/flutter-apk/app-release.apk`. Или можно найти ее в релизах гита)

## Скриншоты

<img src="https://github.com/Mavericketoff/to_do_application/assets/47009823/43aeca75-c64d-4396-934e-2cdb0a94134b.png" width="400" height="700">

<img src="https://github.com/Mavericketoff/to_do_application/assets/47009823/65f2f7e1-7ea6-436f-afe2-f98b9f936182.png" width="400" height="700">

<img src="https://github.com/Mavericketoff/to_do_application/assets/47009823/8e7228de-e0ce-4907-8e40-c241a61616ca.png" width="400" height="700">

<img src="https://github.com/Mavericketoff/to_do_application/assets/47009823/2b46838f-004e-42c6-b6c5-d3f2c569c096.png" width="400" height="700">

## В случае возникновения вопросов

Писать в тг - @mavericketoff
