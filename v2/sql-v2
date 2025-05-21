```sql
-- Main job types table
CREATE TABLE `job_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `name_ja` varchar(50) NOT NULL COMMENT 'Japanese name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Job type classifications';

-- Insert default job types
INSERT INTO `job_types` (`name`, `name_ja`) VALUES
('Store Manager/Cadre', '店長・幹部候補'),
('Store Staff', '店舗スタッフ'),
('Transport Driver', '送迎ドライバー'),
('Office/Accounting Staff', '事務・経理スタッフ'),
('Web Designer', 'Webデザイナー');

-- Main post table
CREATE TABLE `staff_daily_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL COMMENT 'Reference to shop',
  `autonum` varchar(50) DEFAULT NULL COMMENT 'Auto number from shop',
  `title` varchar(255) NOT NULL COMMENT 'Post title',
  `slug` varchar(255) NOT NULL COMMENT 'URL-friendly slug',
  `staff_name` varchar(100) NOT NULL COMMENT 'Staff full name',
  `job_type_id` int(11) NOT NULL COMMENT 'Reference to job_types',
  `joined_3_months` tinyint(1) DEFAULT 0 COMMENT '3 months employed flag',
  `age_group` enum('10代','20代','30代','40代','50代','60代','70代') DEFAULT NULL,
  `shift` enum('早番','中番','遅番','日勤','夜勤','準夜勤','深夜勤','2交代制','3交代制','通し') DEFAULT NULL,
  `business_type` varchar(100) DEFAULT NULL COMMENT 'Business type from shop',
  `thumbnail_image` varchar(255) NOT NULL COMMENT 'Thumbnail image path',
  `top_image` varchar(255) NOT NULL COMMENT 'Top image path',
  `public_status` enum('draft','published','private') NOT NULL DEFAULT 'draft',
  `public_date` datetime DEFAULT NULL COMMENT 'Publication date/time',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL COMMENT 'Soft delete timestamp',
  `created_by` int(11) DEFAULT NULL COMMENT 'User ID who created',
  `updated_by` int(11) DEFAULT NULL COMMENT 'User ID who last updated',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_slug` (`slug`),
  KEY `idx_shop` (`shop_id`),
  KEY `idx_job_type` (`job_type_id`),
  KEY `idx_public` (`public_status`,`public_date`),
  KEY `idx_staff_name` (`staff_name`),
  CONSTRAINT `fk_post_jobtype` FOREIGN KEY (`job_type_id`) REFERENCES `job_types` (`id`),
  CONSTRAINT `fk_post_shop` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Main staff daily post table';

-- Schedule blocks table
CREATE TABLE `staff_daily_schedules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL COMMENT 'Reference to main post',
  `sort_order` tinyint(2) NOT NULL DEFAULT 0 COMMENT 'Order of display (0-11)',
  `time_hh` tinyint(2) NOT NULL DEFAULT 0 COMMENT 'Hour (0-23)',
  `time_mm` tinyint(2) NOT NULL DEFAULT 0 COMMENT 'Minute (0-59)',
  `job_title` varchar(100) DEFAULT NULL COMMENT 'Job title/heading',
  `job_content` text DEFAULT NULL COMMENT 'Job description',
  `main_image` varchar(255) DEFAULT NULL COMMENT 'Main image path',
  `sub_image1` varchar(255) DEFAULT NULL COMMENT 'Sub image 1 path',
  `sub_image2` varchar(255) DEFAULT NULL COMMENT 'Sub image 2 path',
  `editor_comment` text DEFAULT NULL COMMENT 'Editor notes',
  PRIMARY KEY (`id`),
  KEY `idx_post` (`post_id`),
  KEY `idx_order` (`sort_order`),
  KEY `idx_time` (`time_hh`,`time_mm`),
  CONSTRAINT `fk_schedule_post` FOREIGN KEY (`post_id`) REFERENCES `staff_daily_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chk_schedule_order` CHECK (`sort_order` BETWEEN 0 AND 11),
  CONSTRAINT `chk_time_hh` CHECK (`time_hh` BETWEEN 0 AND 23),
  CONSTRAINT `chk_time_mm` CHECK (`time_mm` BETWEEN 0 AND 59)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Schedule blocks for staff daily posts';

-- Attractive points table
CREATE TABLE `staff_daily_points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL COMMENT 'Reference to main post',
  `sort_order` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Order of display (0-2)',
  `title` varchar(100) DEFAULT NULL COMMENT 'Point title',
  `details` text DEFAULT NULL COMMENT 'Point details',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image path',
  PRIMARY KEY (`id`),
  KEY `idx_post` (`post_id`),
  KEY `idx_order` (`sort_order`),
  CONSTRAINT `fk_point_post` FOREIGN KEY (`post_id`) REFERENCES `staff_daily_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chk_point_order` CHECK (`sort_order` BETWEEN 0 AND 2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Attractive points for staff daily posts';

-- Add constraint for public date (requires MySQL 8.0+)
ALTER TABLE `staff_daily_posts`
ADD CONSTRAINT `chk_public_date` 
CHECK ((`public_status` = 'published' AND `public_date` IS NOT NULL) OR 
      (`public_status` != 'published' AND `public_date` IS NULL));
```
