DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role` varchar(45) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `photo` varchar(5000) DEFAULT NULL,
  `contact` bigint DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user` (`role`,`email`)
);

DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `courseId` bigint NOT NULL AUTO_INCREMENT,
  `courseName` varchar(100) NOT NULL,
  `credits` int DEFAULT 0,
  `bio` text NOT NULL,
  `teacherId` bigint NOT NULL,
  `prerequisite` text NOT NULL,
  PRIMARY KEY (`courseId`),
  UNIQUE KEY `courseName_UNIQUE` (`courseName`),
  CONSTRAINT `id` FOREIGN KEY (`teacherId`) REFERENCES `user` (`id`)
);

DROP TABLE IF EXISTS `studies`;
CREATE TABLE `studies` (
  `studentId` bigint NOT NULL,
  `courseId` bigint NOT NULL,
  PRIMARY KEY (`studentId`,`courseId`),
  CONSTRAINT `fk_courseId` FOREIGN KEY (`courseId`) REFERENCES `courses` (`courseId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_studentId` FOREIGN KEY (`studentId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `announce`;
CREATE TABLE `announce` (
  `courseId` bigint NOT NULL,
  `announcementId` bigint NOT NULL AUTO_INCREMENT,
  `announcement` text,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`announcementId`),
  CONSTRAINT `fk_announce` FOREIGN KEY (`courseId`) REFERENCES `courses` (`courseId`) ON DELETE CASCADE ON UPDATE CASCADE
);

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
  CONSTRAINT `fk_assign_courseId` FOREIGN KEY (`courseId`) REFERENCES `courses` (`courseId`) ON DELETE CASCADE ON UPDATE CASCADE
);

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
);

DROP TABLE IF EXISTS `doubt`;
CREATE TABLE `doubt` (
  `doubtId` bigint NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `title` varchar(100) NOT NULL,
  `topic` varchar(100) NOT NULL,
  `askerId` bigint NOT NULL,
  PRIMARY KEY (`doubtId`),
  CONSTRAINT `fk_doubt_askerId` FOREIGN KEY (`askerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `doubt_ans`;
CREATE TABLE `doubt_ans` (
  `doubt_ansId` bigint NOT NULL AUTO_INCREMENT,
  `doubtId` bigint NOT NULL,
  `doubt_ans` text NOT NULL,
  `replierId` bigint NOT NULL,
  PRIMARY KEY (`doubt_ansId`),
  CONSTRAINT `fk_doubtAns_doubtId` FOREIGN KEY (`doubtId`) REFERENCES `doubt` (`doubtId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_doubtAns_replierId` FOREIGN KEY (`replierId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);