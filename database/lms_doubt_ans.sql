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