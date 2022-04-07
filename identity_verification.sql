-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 07, 2022 at 06:41 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `identity_verification`
--

-- --------------------------------------------------------

--
-- Table structure for table `avatars`
--

CREATE TABLE `avatars` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `avatars`
--

INSERT INTO `avatars` (`id`, `created_at`, `updated_at`, `user_id`, `name`, `path`) VALUES
(1, '2022-03-29 10:32:37', '2022-03-29 10:32:37', '9', '1648582357_Photo.jpeg', '/private/storage/app/public/uploads/1648582357_Photo.jpeg'),
(2, '2022-03-29 10:51:25', '2022-03-29 10:51:25', '10', '1648583485_Photo.jpeg', '/private/storage/app/public/uploads/1648583485_Photo.jpeg'),
(3, '2022-03-29 10:56:14', '2022-04-03 18:06:44', '1', '1649041604_profile_logo_.jpg', '/private/storage/app/public/uploads/1649041604_profile_logo_.jpg'),
(4, '2022-03-29 11:06:57', '2022-03-29 11:06:57', '11', '1648584417_Vladislav P.jpg', '/private/storage/app/public/uploads/1648584417_Vladislav P.jpg'),
(5, '2022-03-29 21:22:06', '2022-04-03 18:06:26', '13', '1649041586_myPicture3.PNG', '/private/storage/app/public/uploads/1649041586_myPicture3.PNG'),
(6, '2022-03-29 21:32:08', '2022-04-03 18:06:35', '14', '1649041595_Photo.jpeg', '/private/storage/app/public/uploads/1649041595_Photo.jpeg'),
(7, '2022-03-29 21:34:46', '2022-04-03 18:06:12', '16', '1649041572_images (5).jpg', '/private/storage/app/public/uploads/1649041572_images (5).jpg'),
(8, '2022-03-29 21:37:20', '2022-04-03 18:05:48', '17', '1649041548_profile_logo_ROALO_d9f9e833dfa2ab2cdeebd91393d9ea01.jpeg', '/private/storage/app/public/uploads/1649041548_profile_logo_ROALO_d9f9e833dfa2ab2cdeebd91393d9ea01.jpeg'),
(9, '2022-03-29 23:18:14', '2022-04-03 18:06:05', '18', '1649041565_image-original.jpg', '/private/storage/app/public/uploads/1649041565_image-original.jpg'),
(10, '2022-03-30 03:01:47', '2022-04-03 18:05:37', '19', '1649041537_Vladislav P.jpg', '/private/storage/app/public/uploads/1649041537_Vladislav P.jpg'),
(11, '2022-03-30 03:54:25', '2022-04-03 18:05:57', '25', '1649041557_85980370.jpg', '/private/storage/app/public/uploads/1649041557_85980370.jpg'),
(12, '2022-03-30 04:34:41', '2022-04-03 18:05:16', '26', '1649041516_Ivan Pinteley.jpg', '/private/storage/app/public/uploads/1649041516_Ivan Pinteley.jpg'),
(13, '2022-03-30 06:41:06', '2022-04-03 18:04:54', '30', '1649041494_Angely.jpg', '/private/storage/app/public/uploads/1649041494_Angely.jpg'),
(14, '2022-03-30 06:47:09', '2022-04-03 18:04:18', '31', '1649041458_Ashraf.png', '/private/storage/app/public/uploads/1649041458_Ashraf.png'),
(15, '2022-04-01 07:30:26', '2022-04-03 18:04:00', '32', '1649041440_avatar6.png', '/private/storage/app/public/uploads/1649041440_avatar6.png'),
(16, '2022-04-02 01:22:49', '2022-04-03 18:03:28', '33', '1649041408_avatar3.png', '/private/storage/app/public/uploads/1649041407_avatar3.png'),
(17, '2022-04-02 02:26:35', '2022-04-02 02:26:35', '34', '1648898795_avatar3.png', '/private/storage/app/public/uploads/1648898795_avatar3.png'),
(18, '2022-04-02 03:15:58', '2022-04-02 03:16:14', '35', '1648901774_sss.jpg', '/private/storage/app/public/uploads/1648901774_sss.jpg'),
(19, '2022-04-03 18:19:46', '2022-04-05 05:19:37', '38', '1649168377_123 (2).jpg', '/private/storage/app/public/uploads/1649168376_123 (2).jpg'),
(20, '2022-04-04 00:44:49', '2022-04-04 00:44:49', '39', '1649065489_Ivan Pinteley.jpg', '/private/storage/app/public/uploads/1649065489_Ivan Pinteley.jpg'),
(21, '2022-04-04 11:31:34', '2022-04-04 11:31:34', '40', '1649104294_avatar6.png', '/private/storage/app/public/uploads/1649104293_avatar6.png'),
(22, '2022-04-06 02:45:36', '2022-04-06 02:45:36', '86', '1649245536_profile_logo_.jpg', '/private/storage/app/public/uploads/1649245536_profile_logo_.jpg'),
(23, '2022-04-06 22:03:29', '2022-04-06 22:04:45', '99', '1649315085_avatar3.png', '/private/storage/app/public/uploads/1649315085_avatar3.png');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_05_13_060834_create_settings_table', 1),
(4, '2018_05_22_084901_create_todos_table', 1),
(5, '2022_03_28_120705_add_new_columns_to_users_table', 1),
(6, '2022_03_28_181458_create_avatars_table', 1),
(7, '2022_03_28_181645_add_user_id_to_avatars_table', 1),
(8, '2022_04_06_051644_add_email_verification_status_to_users_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `option` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `todos`
--

CREATE TABLE `todos` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `completed` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'practitioner',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `picture` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '...',
  `id_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '...',
  `serial_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '...',
  `validity_period` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '...',
  `company` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '...',
  `region` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '...',
  `verification_result` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'nonactivated',
  `health_status` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'normal',
  `remark_information` longtext COLLATE utf8_unicode_ci,
  `email_verification_status` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `role`, `created_at`, `updated_at`, `gender`, `picture`, `id_number`, `serial_number`, `validity_period`, `company`, `region`, `verification_result`, `health_status`, `remark_information`, `email_verification_status`) VALUES
(1, 'System', 'Admin', 'tenochbush@gmail.com', '$2y$10$Cl901ni4fGuKjIJeY3XOneiJvtKqEzwmplzV1x17X8wJrl0EfTIB6', 'admin', '2022-03-29 07:37:26', '2022-04-07 06:47:39', 'male', '...', '...', '202231601', '2023|01|01', 'Alibaba Group Holding Ltd.', '...', 'nonactivated', 'bad', '{\"time\":\"2022-4-8 0:43:28\",\"type\":\"email_verification\",\"result\":true}', 1),
(13, 'Ivan', 'Petrovich', 'IvanPetrovich199899@gmail.com', '$2y$10$H4ooTwCALmsBv./llWYVre9Edw0F/UY57Cn8g0RcoE9PixUWtwFTW', 'practitioner', '2022-03-29 21:21:43', '2022-03-29 23:06:56', 'male', '...', '...', '...', '...', '...', 'region_1', 'nonactivated', 'bad', '', 1),
(14, 'Okcana', 'Deshura', 'oxankaorb@gmail.com', '$2y$10$n8kKSKjrgfJP1bAPINb2h.32eHwl6yv6B/3kI4voalComBf5fkH66', 'practitioner', '2022-03-29 21:25:21', '2022-03-29 21:25:21', 'female', '...', '...', '...', '...', '...', 'region_2', 'nonactivated', 'good', '', 1),
(16, 'Alex', 'Rossi', 'stanojevicognjen30@gmail.com', '$2y$10$ZDT36ijaPimV2CfzYJYPzuGdIxii5Y2VeKXkmDnypmm0HCAbF3yJu', 'practitioner', '2022-03-29 21:34:28', '2022-03-29 21:34:28', 'male', '...', '...', '...', '...', '...', 'region_2', 'nonactivated', 'normal', '', 1),
(17, 'Anastasia', 'Dorisela', 'anastasia9899@gmail.com', '$2y$10$1h.PWMV9/aGCi64TOWE/S.9ECYAXobqVhTr0skTYCU15ubvg1Q9Ee', 'practitioner', '2022-03-29 21:37:05', '2022-03-29 22:48:06', 'female', '...', '...', '...', '...', '...', 'region_3', 'nonactivated', 'good', '', 1),
(18, 'Sergey', 'Petrov', 'sergeylee199585@gmail.com', '$2y$10$AVydFiWwbFNcGj2s2F7n7ePB9yVpcsaHXGR6b0T8zV9xTpF89ffX2', 'practitioner', '2022-03-29 23:17:58', '2022-03-29 23:21:07', 'male', '...', '...', '...', '...', '...', 'region_3', 'nonactivated', 'bad', '', 1),
(19, 'Alexandr', 'Oblask', 'Alexandr@gmail.com', '$2y$10$sADGMEQZbmAYDGecjkeqxeXT7c0mfW08DLr5QisvxQ9YSrEi44TPu', 'practitioner', '2022-03-30 01:30:48', '2022-03-30 01:30:48', 'male', '...', '...', '...', '...', '...', 'region_2', 'nonactivated', 'normal', '', 1),
(25, 'Olga', 'Angely', 'angelyolga@gmail.com', '$2y$10$7PO/QHYQgVhsXQjLFljbAuV6vSwUcud8bmLtfkJy3c21GknJMvm3S', 'practitioner', '2022-03-30 03:52:51', '2022-03-30 03:52:51', 'female', '...', '...', '...', '...', '...', 'region_2', 'nonactivated', 'normal', '', 1),
(26, 'Jackson', 'Starksss', 'jackson.stark@gmail.com', '$2y$10$IWIbf1fOsBCNzzRKFKqiqO2ZwOkekEbVvKsuilSXGFB3QzPSoYfd2', 'regional_admin', '2022-03-30 04:34:27', '2022-04-01 23:52:14', 'male', '...', '...', '...', '...', '...', 'region_1', 'nonactivated', 'good', '', 1),
(30, 'Reem', 'Ashraf', 'reem.ashraf@gmail.com', '$2y$10$eQzIk8CtBtF1bGwhEwJUdOVdCNCzEVHgCktuTNxwyPOtDUrAxWT26', 'regional_admin', '2022-03-30 06:40:51', '2022-03-30 06:40:51', 'female', '...', '...', '...', '...', '...', 'region_3', 'nonactivated', 'normal', '', 1),
(31, 'Nathalia', 'Indigo', 'natalia.indigo@gmail.com', '$2y$10$pF9UsM6ZkUhOzLgqY7chje291LDUpzkdiDBEDmrPA91JVGGpdAgs.', 'practitioner', '2022-03-30 06:46:51', '2022-04-03 18:21:33', 'female', '...', '...', '...', '...', '...', 'region_2', 'nonactivated', 'bad', '', 1),
(32, 'Jamess', 'Potterr', 'potter.james@gmail.com', '$2y$10$Dxg3yrlpBz1qxsxlh1r.rekN8TttsI8yml0GY98565OXxUGvppGNm', 'practitioner', '2022-04-01 07:30:10', '2022-04-01 23:29:05', 'male', '...', '...', '...', '...', '...', 'region_2', 'nonactivated', 'normal', '', 1),
(33, 'Eli', 'Kunkka', 'Eli.Kunkka@gmail.com', '$2y$10$RCIUpJ3er72r3x9yTAhElO5IFywVovhpFTUWQ976tKPvT2G.71NfW', 'practitioner', '2022-04-02 01:22:39', '2022-04-02 01:22:39', 'male', '...', '...', '...', '...', '...', 'region_2', 'nonactivated', 'normal', '', 1),
(38, 'Daniel', 'Dashee', 'Test@gmail.com', '$2y$10$TrORiy26gd.hEHWiJNHfDuDYYIKl53oMRaSVyQRuKthfNMDe1O4By', 'regional_admin', '2022-04-03 18:19:35', '2022-04-07 07:29:24', 'male', '...', '110221199003043217', '202204081251', '2023|01|01', 'BAIC Motor Corp. Ltd.', 'region_1', 'nonactivated', 'normal', '{\"time\":\"2022-4-8 0:34:19\",\"type\":\"first_name\",\"result\":\"Daniell\"}, {\"time\":\"2022-4-8 0:38:11\",\"type\":\"password\",\"result\":\"IvanP.9899\"}, {\"time\":\"2022-4-8 1:19:59\",\"type\":\"id_number\",\"result\":\"110221199003043217\"}, {\"time\":\"2022-4-8 1:20:26\",\"type\":\"serial_number\",\"result\":\"202204081251\"}, {\"time\":\"2022-4-8 1:20:33\",\"type\":\"validity_period\",\"result\":\"2023|01|01\"}, {\"time\":\"2022-4-8 1:21:23\",\"type\":\"company\",\"result\":\"BAIC Motor Corp. Ltd.\"}, {\"time\":\"2022-4-8 1:26:1\",\"type\":\"first_name\",\"result\":\"Daniel\"}, {\"time\":\"2022-4-8 1:29:24\",\"type\":\"password\",\"result\":\"IvanP.989999\"}', 1),
(99, 'Tenoch', 'Bush', 'daniel.dashe@gmail.com', '$2y$10$Ah4QxaQn1Orjq9ezLGEpcOt2KtNH6AxtC8TJNOKvly/3sK5yyRtpS', 'practitioner', '2022-04-06 06:35:35', '2022-04-06 22:13:10', 'male', '...', '...', '20223206', '2023|01|01', 'IT Company', 'region_2', 'nonactivated', 'normal', '', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `avatars`
--
ALTER TABLE `avatars`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `todos`
--
ALTER TABLE `todos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `avatars`
--
ALTER TABLE `avatars`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `todos`
--
ALTER TABLE `todos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
