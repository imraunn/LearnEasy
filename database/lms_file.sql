DROP TABLE IF EXISTS `file`;

CREATE TABLE `file` (
  `fileId` bigint NOT NULL AUTO_INCREMENT,
  `courseId` bigint NOT NULL,
  `file` varchar(5000) NOT NULL,
  `file_name` varchar(45) NOT NULL,
  PRIMARY KEY (`fileId`),
  KEY `fk_file_idx` (`courseId`),
  CONSTRAINT `fk_file` FOREIGN KEY (`courseId`) REFERENCES `courses` (`courseId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
