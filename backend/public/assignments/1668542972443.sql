DROP TABLE IF EXISTS `announce`;
CREATE TABLE `announce` (
  `courseId` bigint NOT NULL,
  `announcementId` bigint NOT NULL AUTO_INCREMENT,
  `announcement` text,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`announcementId`),
  CONSTRAINT `fk_announce` FOREIGN KEY (`courseId`) REFERENCES `courses` (`courseId`) ON DELETE CASCADE ON UPDATE CASCADE
);