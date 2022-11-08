DROP TABLE IF EXISTS `announce`;
CREATE TABLE `announce` (
  `courseId` bigint NOT NULL,
  `announcementId` bigint NOT NULL AUTO_INCREMENT,
  `announcement` text,
  `my_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`announcementId`),
  KEY `fk_announce_idx` (`courseId`),
  CONSTRAINT `fk_announce` FOREIGN KEY (`courseId`) REFERENCES `courses` (`courseId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;