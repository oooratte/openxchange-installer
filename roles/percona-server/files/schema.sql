CREATE TABLE `domains` (
	  `id` int(11) unsigned NOT NULL auto_increment,
	  `name` varchar(128) NOT NULL,
	  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
	  `id` int(11) unsigned NOT NULL auto_increment,
	  `domain_id` int(11) unsigned NOT NULL,
	  `email` varchar(128) NOT NULL,
	  `active` tinyint(1) unsigned NOT NULL DEFAULT 1,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `email` (`email`),
	  FOREIGN KEY (domain_id) REFERENCES domains(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `aliases` (
	  `id` int(11) unsigned NOT NULL auto_increment,
	  `domain_id` int(11) unsigned NOT NULL,
	  `source` varchar(128) NOT NULL,
	  `destination` varchar(128) NOT NULL,
	  PRIMARY KEY (`id`),
	  FOREIGN KEY (domain_id) REFERENCES domains(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
