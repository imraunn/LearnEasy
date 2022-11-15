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
  CONSTRAINT `id` FOREIGN KEY (`teacherId`) REFERENCES `user` (`id`)
);
