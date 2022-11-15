DROP TABLE IF EXISTS `doubt`;
CREATE TABLE `doubt` (
  `doubtId` bigint NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `title` varchar(100) NOT NULL,
  `topic` varchar(100) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `askerId` bigint NOT NULL,
  PRIMARY KEY (`doubtId`),
  CONSTRAINT `fk_doubt_askerId` FOREIGN KEY (`askerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);
