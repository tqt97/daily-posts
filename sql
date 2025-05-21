# Database Schema for Staff Daily Post System

---

## 1. Table: `staff_daily_posts`

```sql
CREATE TABLE `staff_daily_posts` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `shop_id` BIGINT UNSIGNED NOT NULL,
  `full_name` VARCHAR(100) NOT NULL COMMENT 'Full name, max 100 half-width or 50 full-width chars',
  `job_type` VARCHAR(50) NOT NULL COMMENT 'Job type: Store Manager, Staff, Driver...',
  `is_within_3_months` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Joined company <= 3 months: 1=yes, 0=no',
  `age_group` TINYINT NULL COMMENT 'Age group: 1=10s, 2=20s,... 7=70s',
  `shift` VARCHAR(50) NULL COMMENT 'Shift',
  `business_type` VARCHAR(100) NULL COMMENT 'Business type from shop',
  `publication_status` VARCHAR(20) NOT NULL DEFAULT 'draft' COMMENT 'Publication status',
  `publication_date` DATE NULL COMMENT 'Publication date',
  `thumbnail_image` VARCHAR(255) NOT NULL COMMENT 'Thumbnail image path',
  `top_image` VARCHAR(255) NOT NULL COMMENT 'Article top image path',
  `created_by` BIGINT UNSIGNED NULL,
  `updated_by` BIGINT UNSIGNED NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_shop_id` (`shop_id`),
  CONSTRAINT `fk_staff_daily_posts_shop` FOREIGN KEY (`shop_id`) REFERENCES `shops`(`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

## 2. Table: staff_daily_schedules
```sql
CREATE TABLE `staff_daily_schedules` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` BIGINT UNSIGNED NOT NULL,
  `position` TINYINT UNSIGNED NOT NULL COMMENT 'Order of schedule block 1-12',
  `time_from` TIME NOT NULL,
  `job_title` VARCHAR(50) NULL,
  `job_content` VARCHAR(200) NULL,
  `main_image` VARCHAR(255) NULL,
  `sub_image1` VARCHAR(255) NULL,
  `sub_image2` VARCHAR(255) NULL,
  `editor_comment` VARCHAR(200) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_post_id` (`post_id`),
  CONSTRAINT `fk_staff_daily_schedules_post` FOREIGN KEY (`post_id`) REFERENCES `staff_daily_posts`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

## 3. Table: staff_daily_points
```sql
CREATE TABLE `staff_daily_points` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` BIGINT UNSIGNED NOT NULL,
  `position` TINYINT UNSIGNED NOT NULL COMMENT 'Order of point block 1-3',
  `title` VARCHAR(50) NULL,
  `detail` VARCHAR(200) NULL,
  `image` VARCHAR(255) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_post_id` (`post_id`),
  CONSTRAINT `fk_staff_daily_points_post` FOREIGN KEY (`post_id`) REFERENCES `staff_daily_posts`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```
