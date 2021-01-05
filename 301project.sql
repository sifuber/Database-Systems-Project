-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 05 Oca 2021, 09:33:28
-- Sunucu sürümü: 10.4.11-MariaDB
-- PHP Sürümü: 7.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `301project`
--

DELIMITER $$
--
-- Yordamlar
--
CREATE DEFINER=`user301`@`localhost` PROCEDURE `SimpleSearch` (IN `keyWord` VARCHAR(255))  BEGIN

	SELECT * FROM books LEFT JOIN bookgenres ON bookgenres.isbn = books.isbn
    WHERE bname LIKE CONCAT('%',keyWord,'%') or author LIKE CONCAT('%',keyWord,'%') or publisher LIKE CONCAT('%',keyWord,'%') or pubyear LIKE CONCAT('%',keyWord,'%') or genre LIKE CONCAT('%',keyWord,'%')
    GROUP BY books.isbn;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bookgenres`
--

CREATE TABLE `bookgenres` (
  `isbn` bigint(20) DEFAULT NULL,
  `genre` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `bookgenres`
--

INSERT INTO `bookgenres` (`isbn`, `genre`) VALUES
(12345, 'Children'),
(12345, 'Cultural'),
(169541, 'Fiction'),
(169541, 'Murder');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `books`
--

CREATE TABLE `books` (
  `isbn` bigint(20) NOT NULL,
  `bname` varchar(128) DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL,
  `publisher` varchar(64) DEFAULT NULL,
  `pubyear` date DEFAULT NULL,
  `borrowedby` varchar(32) DEFAULT NULL,
  `borrowedDate` date DEFAULT NULL,
  `addedby` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `books`
--

INSERT INTO `books` (`isbn`, `bname`, `author`, `publisher`, `pubyear`, `borrowedby`, `borrowedDate`, `addedby`) VALUES
(12345, 'asd', 'asdg', 'ags', '2021-01-01', NULL, '2021-01-05', 'admin'),
(169541, '5asfa654', 'a6s5f46', 'asf', '2021-01-02', NULL, NULL, 'admin'),
(975845790, 'H. P. Lovecraft Toplu Eserleri 1', 'H. P. Lovecraft', 'Dost Yayinlari', '2011-05-01', NULL, NULL, NULL),
(9789750718533, '1984', 'George Orwell', 'Can Yayınları', '2000-01-01', NULL, NULL, NULL),
(9789750738609, 'Seker Portakali', 'José Mauro de Vasconcelos', 'Can Cocuk Yayınları', '1984-01-01', NULL, NULL, NULL),
(9789750743108, 'Seker Portakali', 'José Mauro de Vasconcelos', 'Can Yayınları', '2020-01-01', NULL, NULL, NULL),
(9789750807145, 'Ince Memed I', 'Yasar Kemal', 'YKY', '2009-07-01', NULL, NULL, NULL),
(9789750807176, 'Ince Memed II', 'Yasar Kemal', 'YKY', '2009-07-15', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `genres`
--

CREATE TABLE `genres` (
  `genre` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `genres`
--

INSERT INTO `genres` (`genre`) VALUES
('Adventure'),
('Children'),
('Classics'),
('Cultural'),
('Detective'),
('Fiction'),
('Horror'),
('Murder'),
('Science Fiction'),
('Short Stories');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `username` varchar(32) NOT NULL,
  `password` varchar(32) DEFAULT NULL,
  `fname` varchar(32) DEFAULT NULL,
  `lname` varchar(32) DEFAULT NULL,
  `address` varchar(32) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `mail` varchar(32) DEFAULT NULL,
  `isadmin` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`username`, `password`, `fname`, `lname`, `address`, `phone`, `mail`, `isadmin`) VALUES
('admin', 'admin', 'Berkehan', 'Avan', 'Test Address', 'Test Phone', 'test@mail.com', 1),
('Brrr', '123', 'Brra', 'Grra', 'Hrra', 'Zrra', 'Srra', 0),
('demo', 'demo', 'Fatih', 'DemoLast', 'DemoAddress', 'DemoPhone', 'demo@mail.com', 0),
('demo2', 'demo', 'demoName', 'demoName2', 'demo Address', 'demo Phone', 'demomail@mail.com', 0),
('testAcc', 'testPass', 'Second Berkehan', 'Second Avan', 'Second Test Adres', 'Second Test Phone', 'mail@mail.com', 0);

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `bookgenres`
--
ALTER TABLE `bookgenres`
  ADD KEY `isbn` (`isbn`),
  ADD KEY `genre` (`genre`);

--
-- Tablo için indeksler `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`isbn`),
  ADD KEY `addedby` (`addedby`);

--
-- Tablo için indeksler `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`genre`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`);

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `bookgenres`
--
ALTER TABLE `bookgenres`
  ADD CONSTRAINT `bookgenres_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bookgenres_ibfk_2` FOREIGN KEY (`genre`) REFERENCES `genres` (`genre`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `users` (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
