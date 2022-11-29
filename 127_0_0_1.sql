-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2022. Nov 24. 11:15
-- Kiszolgáló verziója: 10.4.6-MariaDB
-- PHP verzió: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `konyvtarbl`
--
CREATE DATABASE IF NOT EXISTS `konyvtarbl` DEFAULT CHARACTER SET utf8 COLLATE utf8_hungarian_ci;
USE `konyvtarbl`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `iro`
--

CREATE TABLE `iro` (
  `iro_id` int(11) NOT NULL,
  `iro_nev` text COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `iro`
--

INSERT INTO `iro` (`iro_id`, `iro_nev`) VALUES
(1, 'Mikszáth Kálmán'),
(2, 'Jókai Mór'),
(3, 'Dr. Csernus Imre'),
(4, 'Móricz Zsigmond'),
(5, 'Shakespeare');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `konyv`
--

CREATE TABLE `konyv` (
  `konyv_id` int(11) NOT NULL,
  `konyv_nev` text COLLATE utf8_hungarian_ci NOT NULL,
  `konyv_iro` int(11) NOT NULL DEFAULT 1,
  `konyv_mufaj` int(11) NOT NULL DEFAULT 1,
  `konyv_kiadaseve` int(11) NOT NULL,
  `konyv_oldalszam` int(11) NOT NULL DEFAULT 1,
  `konyv_kiado` int(11) NOT NULL DEFAULT 1,
  `kotelezo` tinyint(1) NOT NULL DEFAULT 0,
  `konyv_kep` varchar(255) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `konyv`
--

INSERT INTO `konyv` (`konyv_id`, `konyv_nev`, `konyv_iro`, `konyv_mufaj`, `konyv_kiadaseve`, `konyv_oldalszam`, `konyv_kiado`, `kotelezo`, `konyv_kep`) VALUES
(10, 'Főnix ', 3, 2, 2021, 0, 2, 0, '1.jpg'),
(11, 'Légy jó mindhalálig', 4, 2, 1920, 281, 2, 1, '2.jpg'),
(12, 'Szent Péter esernyője', 1, 2, 1895, 341, 1, 1, '3.jpg'),
(13, 'Erdély aranykora', 2, 2, 1852, 320, 1, 0, ''),
(14, 'Rómeó és Júlia', 5, 1, 1597, 221, 1, 1, '');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `mufaj`
--

CREATE TABLE `mufaj` (
  `mufaj_id` int(11) NOT NULL,
  `mufaj_nev` text COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `mufaj`
--

INSERT INTO `mufaj` (`mufaj_id`, `mufaj_nev`) VALUES
(1, 'Fikció'),
(2, 'Regény');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `iro`
--
ALTER TABLE `iro`
  ADD PRIMARY KEY (`iro_id`);

--
-- A tábla indexei `konyv`
--
ALTER TABLE `konyv`
  ADD PRIMARY KEY (`konyv_id`),
  ADD KEY `konyv_iro` (`konyv_iro`),
  ADD KEY `konyv_mufaj` (`konyv_mufaj`),
  ADD KEY `konyv_kiado` (`konyv_kiado`);

--
-- A tábla indexei `mufaj`
--
ALTER TABLE `mufaj`
  ADD PRIMARY KEY (`mufaj_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `iro`
--
ALTER TABLE `iro`
  MODIFY `iro_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `konyv`
--
ALTER TABLE `konyv`
  MODIFY `konyv_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT a táblához `mufaj`
--
ALTER TABLE `mufaj`
  MODIFY `mufaj_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `konyv`
--
ALTER TABLE `konyv`
  ADD CONSTRAINT `konyv_ibfk_2` FOREIGN KEY (`konyv_mufaj`) REFERENCES `mufaj` (`mufaj_id`),
  ADD CONSTRAINT `konyv_ibfk_3` FOREIGN KEY (`konyv_iro`) REFERENCES `iro` (`iro_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
