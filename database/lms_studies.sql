DROP TABLE IF EXISTS `studies`;
CREATE TABLE `studies` (
  `studentId` bigint NOT NULL,
  `courseId` bigint NOT NULL,
  PRIMARY KEY (`studentId`,`courseId`),
  CONSTRAINT `fk_courseId` FOREIGN KEY (`courseId`) REFERENCES `courses` (`courseId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_studentId` FOREIGN KEY (`studentId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);
