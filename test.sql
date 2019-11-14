-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Авг 16 2019 г., 11:22
-- Версия сервера: 5.7.20
-- Версия PHP: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `test`
--

-- --------------------------------------------------------

--
-- Структура таблицы `authors`
--

CREATE TABLE `authors` (
  `id` int(10) NOT NULL,
  `first_name` varchar(256) NOT NULL,
  `last_name` varchar(256) NOT NULL,
  `birth_year` int(4) NOT NULL,
  `country` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `authors`
--

INSERT INTO `authors` (`id`, `first_name`, `last_name`, `birth_year`, `country`) VALUES
(1, 'Александр', 'Пушкин', 1799, 'Россия'),
(2, 'Михаил', 'Лермонтов', 1814, 'Россия'),
(3, 'Иван', 'Тургенев', 1818, 'Россия'),
(4, 'Лев', 'Толстой', 1828, 'Россия'),
(5, 'Марк', 'Твен', 1835, 'Америка');

-- --------------------------------------------------------

--
-- Структура таблицы `books`
--

CREATE TABLE `books` (
  `id` int(10) NOT NULL,
  `issue_year` int(4) NOT NULL,
  `name` varchar(512) NOT NULL,
  `author_id` int(10) NOT NULL,
  `edition_id` int(10) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `books`
--

INSERT INTO `books` (`id`, `issue_year`, `name`, `author_id`, `edition_id`) VALUES
(1, 2003, 'Дворянское гнездо', 3, 1),
(2, 2008, 'Три портрета', 3, 3),
(3, 2001, 'Война и Мир', 4, 1),
(4, 2002, 'Декабристы', 4, 3),
(5, 2008, 'Анна Каренина ', 4, 3),
(6, 2001, 'Евгений Онегин', 1, 1),
(7, 2004, 'Сказка о царе Салтане', 1, 3),
(8, 2008, 'Руслан и Людмила', 1, 3),
(9, 2003, 'Герой нашего времени', 2, 3),
(10, 2000, 'Мцыри', 2, 3),
(11, 2002, 'Княжна Мери', 2, 1),
(12, 2005, 'Приключения Тома Сойера и Гекльберри Финна', 5, 3),
(13, 2004, 'Принц и нищий', 5, 2),
(14, 2006, 'Янки из Коннектикута при дворе короля Артура', 5, 1),
(15, 2013, 'Жанна д\'Арк', 5, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `editions`
--

CREATE TABLE `editions` (
  `id` int(10) NOT NULL,
  `name` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `editions`
--

INSERT INTO `editions` (`id`, `name`) VALUES
(1, 'Издательский дом \"Какой-то\"'),
(2, 'Avangarde Books'),
(3, 'Издательство \"СКИФ\"');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `author_id` (`author_id`),
  ADD KEY `edition_id` (`edition_id`);

--
-- Индексы таблицы `editions`
--
ALTER TABLE `editions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `authors`
--
ALTER TABLE `authors`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `books`
--
ALTER TABLE `books`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT для таблицы `editions`
--
ALTER TABLE `editions`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`),
  ADD CONSTRAINT `books_ibfk_2` FOREIGN KEY (`edition_id`) REFERENCES `editions` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
