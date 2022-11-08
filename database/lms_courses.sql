DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `courseId` bigint NOT NULL AUTO_INCREMENT,
  `courseName` varchar(100) NOT NULL,
  `credits` int DEFAULT NULL,
  `bio` text NOT NULL,
  `teacherId` bigint NOT NULL,
  `prerequisite` text NOT NULL,
  PRIMARY KEY (`courseId`),
  UNIQUE KEY `courseName_UNIQUE` (`courseName`),
  KEY `id_idx` (`teacherId`),
  CONSTRAINT `id` FOREIGN KEY (`teacherId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
