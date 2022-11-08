DROP TABLE IF EXISTS `assignment`;
CREATE TABLE `assignment` (
  `assignmentId` bigint NOT NULL AUTO_INCREMENT,
  `courseId` bigint NOT NULL,
  `file` varchar(1000) NOT NULL,
  `fileName` varchar(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `topic` varchar(100) NOT NULL,
  `deadline` varchar(45) NOT NULL,
  PRIMARY KEY (`assignmentId`),
  KEY `fk_assign_courseId_idx` (`courseId`),
  CONSTRAINT `fk_assign_courseId` FOREIGN KEY (`courseId`) REFERENCES `courses` (`courseId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
