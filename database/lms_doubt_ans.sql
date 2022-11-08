DROP TABLE IF EXISTS `doubt_ans`;
CREATE TABLE `doubt_ans` (
  `doubt_ansId` bigint NOT NULL AUTO_INCREMENT,
  `doubtId` bigint NOT NULL,
  `doubt_ans` text NOT NULL,
  `replierId` bigint NOT NULL,
  PRIMARY KEY (`doubt_ansId`),
  KEY `fk_doubtAns_doubtId_idx` (`doubtId`),
  KEY `fk_doubtAns_replierId_idx` (`replierId`),
  CONSTRAINT `fk_doubtAns_doubtId` FOREIGN KEY (`doubtId`) REFERENCES `doubt` (`doubtId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_doubtAns_replierId` FOREIGN KEY (`replierId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
