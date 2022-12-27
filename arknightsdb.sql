-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 27, 2022 at 05:23 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `arknightsdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `player`
--

CREATE TABLE `player` (
  `playerID` char(8) NOT NULL,
  `playerLevel` int(11) NOT NULL,
  `lmd` int(11) NOT NULL,
  `orundum` int(11) NOT NULL,
  `orPrime` int(11) NOT NULL,
  `lastLogin` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player`
--

INSERT INTO `player` (`playerID`, `playerLevel`, `lmd`, `orundum`, `orPrime`, `lastLogin`) VALUES
('02913821', 77, 1502308, 1200, 24, '2022-12-27 00:57:10'),
('12323664', 75, 1103595, 21930, 9, '2022-12-27 01:00:09'),
('21903434', 60, 900432, 4600, 17, '2022-12-27 00:59:30'),
('77264930', 45, 188249, 10610, 0, '2022-12-27 00:52:41');

-- --------------------------------------------------------

--
-- Table structure for table `player_base`
--

CREATE TABLE `player_base` (
  `playerID` char(8) NOT NULL,
  `baseSlotNumber` int(11) NOT NULL,
  `buildingName` varchar(20) NOT NULL,
  `buildingLevel` int(11) NOT NULL,
  `assignedUnit1` varchar(20) NOT NULL,
  `assignedUnit2` varchar(20) NOT NULL,
  `assignedUnit3` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_base`
--

INSERT INTO `player_base` (`playerID`, `baseSlotNumber`, `buildingName`, `buildingLevel`, `assignedUnit1`, `assignedUnit2`, `assignedUnit3`) VALUES
('02913821', 3, 'Factory', 3, 'Ling', 'Blaze', 'N/A'),
('77264930', 1, 'Trading Post', 3, 'Goldenglow', 'N/A', 'N/A');

-- --------------------------------------------------------

--
-- Table structure for table `player_friends`
--

CREATE TABLE `player_friends` (
  `playerID` char(8) NOT NULL,
  `friendID` char(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_friends`
--

INSERT INTO `player_friends` (`playerID`, `friendID`) VALUES
('77264930', '02913821'),
('21903434', '12323664'),
('12323664', '21903434'),
('02913821', '77264930');

-- --------------------------------------------------------

--
-- Table structure for table `player_profile`
--

CREATE TABLE `player_profile` (
  `playerID` char(8) NOT NULL,
  `playerName` varchar(30) NOT NULL,
  `tags` char(4) NOT NULL,
  `favUnit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_profile`
--

INSERT INTO `player_profile` (`playerID`, `playerName`, `tags`, `favUnit`) VALUES
('02913821', 'Vet', '9865', 6),
('12323664', 'Chira', '2802', 7),
('21903434', 'Rainy', '6094', 4),
('77264930', 'ham', '1985', 2);

-- --------------------------------------------------------

--
-- Table structure for table `player_units`
--

CREATE TABLE `player_units` (
  `playerID` char(8) NOT NULL,
  `unitID` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `promotion` varchar(2) NOT NULL,
  `trust` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_units`
--

INSERT INTO `player_units` (`playerID`, `unitID`, `level`, `promotion`, `trust`) VALUES
('77264930', 1, 55, 'E2', 133),
('77264930', 2, 10, 'E2', 79),
('02913821', 3, 80, 'E2', 200),
('77264930', 3, 55, 'E1', 138),
('02913821', 4, 90, 'E2', 200),
('02913821', 5, 90, 'E2', 200);

-- --------------------------------------------------------

--
-- Table structure for table `unit`
--

CREATE TABLE `unit` (
  `unitID` int(11) NOT NULL,
  `unitName` varchar(20) NOT NULL,
  `rarity` int(11) NOT NULL,
  `maxLevel` int(11) NOT NULL,
  `module_available` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `unit`
--

INSERT INTO `unit` (`unitID`, `unitName`, `rarity`, `maxLevel`, `module_available`) VALUES
(1, 'Fartooth', 6, 80, 1),
(2, 'Goldenglow', 6, 90, 0),
(3, 'Myrtle', 4, 70, 0),
(4, 'Ling', 6, 90, 1),
(5, 'Blaze', 6, 90, 1),
(6, 'Dusk', 6, 90, 1),
(7, 'Lappland', 5, 80, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`playerID`);

--
-- Indexes for table `player_base`
--
ALTER TABLE `player_base`
  ADD PRIMARY KEY (`playerID`,`baseSlotNumber`);

--
-- Indexes for table `player_friends`
--
ALTER TABLE `player_friends`
  ADD PRIMARY KEY (`playerID`),
  ADD KEY `friend-profile` (`friendID`);

--
-- Indexes for table `player_profile`
--
ALTER TABLE `player_profile`
  ADD PRIMARY KEY (`playerID`),
  ADD KEY `profile-unit` (`favUnit`);

--
-- Indexes for table `player_units`
--
ALTER TABLE `player_units`
  ADD PRIMARY KEY (`unitID`,`playerID`),
  ADD KEY `unit-player` (`playerID`);

--
-- Indexes for table `unit`
--
ALTER TABLE `unit`
  ADD PRIMARY KEY (`unitID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `unit`
--
ALTER TABLE `unit`
  MODIFY `unitID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `player_base`
--
ALTER TABLE `player_base`
  ADD CONSTRAINT `aaa` FOREIGN KEY (`playerID`) REFERENCES `player` (`playerID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `player_friends`
--
ALTER TABLE `player_friends`
  ADD CONSTRAINT `friend-profile` FOREIGN KEY (`friendID`) REFERENCES `player_profile` (`playerID`),
  ADD CONSTRAINT `player-profile` FOREIGN KEY (`playerID`) REFERENCES `player_profile` (`playerID`);

--
-- Constraints for table `player_profile`
--
ALTER TABLE `player_profile`
  ADD CONSTRAINT `profile-player` FOREIGN KEY (`playerID`) REFERENCES `player` (`playerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `profile-unit` FOREIGN KEY (`favUnit`) REFERENCES `unit` (`unitID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `player_units`
--
ALTER TABLE `player_units`
  ADD CONSTRAINT `unit-attr` FOREIGN KEY (`unitID`) REFERENCES `unit` (`unitID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `unit-player` FOREIGN KEY (`playerID`) REFERENCES `player` (`playerID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
