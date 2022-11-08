DROP TABLE IF EXISTS `studies`;
CREATE TABLE `studies` (
  `studentId` bigint NOT NULL,
  `courseId` bigint NOT NULL,
  PRIMARY KEY (`studentId`,`courseId`),
  KEY `fk_courseId_idx` (`courseId`),
  CONSTRAINT `fk_courseId` FOREIGN KEY (`courseId`) REFERENCES `courses` (`courseId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_studentId` FOREIGN KEY (`studentId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
