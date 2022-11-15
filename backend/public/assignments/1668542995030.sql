DROP TABLE IF EXISTS `assignment_submission`;
CREATE TABLE `assignment_submission` (
  `assignment_submissionId` bigint NOT NULL AUTO_INCREMENT,
  `assignmentId` bigint NOT NULL,
  `courseId` bigint NOT NULL,
  `studentId` bigint NOT NULL,
  `file` varchar(1000) NOT NULL,
  `fileName` varchar(45) NOT NULL,
  `comment` varchar(1000) NOT NULL,
  `late` tinyint NOT NULL,
  PRIMARY KEY (`assignment_submissionId`),
  CONSTRAINT `fk_assignSubmission_assignmentId` FOREIGN KEY (`assignmentId`) REFERENCES `assignment` (`assignmentId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_assignSubmission_courseId` FOREIGN KEY (`courseId`) REFERENCES `courses` (`courseId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_assignSubmission_studentId` FOREIGN KEY (`studentId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
