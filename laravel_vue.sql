-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 22, 2024 at 04:03 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravel_vue`
--

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ten_xe` varchar(255) NOT NULL,
  `mau_xe` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `bien_so_xe` varchar(255) NOT NULL,
  `so_khung` varchar(255) NOT NULL,
  `so_cho` int(11) NOT NULL,
  `dac_diem_mac_dinh` enum('A','B') DEFAULT NULL,
  `so_dau_xang_tieu_thu` double(8,2) NOT NULL,
  `ngay_bao_duong_gan_nhat` date DEFAULT NULL,
  `han_dang_kiem_tiep_theo` date DEFAULT NULL,
  `anh_xe` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`id`, `ten_xe`, `mau_xe`, `user_id`, `bien_so_xe`, `so_khung`, `so_cho`, `dac_diem_mac_dinh`, `so_dau_xang_tieu_thu`, `ngay_bao_duong_gan_nhat`, `han_dang_kiem_tiep_theo`, `anh_xe`, `created_at`, `updated_at`) VALUES
(2, 'Honda', 'black', 6, 'a', 'a', 12, 'A', 123.00, '1212-12-12', '1212-12-12', 'images/Lexus-LS-500-2018.jpg', '2024-04-21 20:03:50', '2024-04-21 20:04:04'),
(3, 'Lexus', 'black', 1, 'd', 'd', 12, 'A', 123.00, '1212-12-12', '1212-12-12', 'images/Lexus-LS-500-2018.jpg', '2024-04-21 20:03:50', '2024-04-21 20:03:50');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `parent_id`, `created_at`, `updated_at`) VALUES
(1, 'Tổng Giám Đốc', NULL, NULL, NULL),
(2, 'Phó Giám Đốc', 1, NULL, NULL),
(3, 'Markerting', 2, '2024-04-21 20:57:54', '2024-04-21 21:11:19'),
(4, 'IT', 2, '2024-04-21 20:58:29', '2024-04-22 01:59:39'),
(7, 'Kinh Doanh', 2, '2024-04-22 01:42:48', '2024-04-22 01:55:26'),
(8, 'Kinh Doanh', NULL, '2024-04-22 01:43:50', '2024-04-22 01:43:50');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2024_03_29_014929_create_car_table', 1),
(6, '2024_04_22_023401_create_departments_table', 1),
(7, '2024_04_22_023919_add_department_id_to_users_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(2, 'App\\Models\\User', 1, 'auth_token', 'f0f67b83230995e17e4e68ee81c53ccf8d93826ac95043da434cf561a7d6b6ec', '[\"*\"]', '2024-04-22 06:53:07', NULL, '2024-04-22 03:15:30', '2024-04-22 06:53:07');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','quản trị công tác','quản trị vật tư','user') NOT NULL DEFAULT 'user',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` date NOT NULL,
  `updated_at` date NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`, `department_id`) VALUES
(1, 'bach', 'nepack2002@gmail.com', NULL, '$2y$10$DSKmIg2v/XDYDWvtQM72QuePY8Dv/LArgYalWv9M6Q3gI0GGQPOm6', 'admin', NULL, '2024-04-22', '2024-04-22', 1),
(3, 'bach', 'nepack2001@gmail.com', NULL, '$2y$10$VFMUc4PngkdzQI8xJyuIe.RC17NQPEnl9AQEQJogARRjZAqPiEk3m', 'admin', NULL, '2024-04-22', '2024-04-22', 0),
(4, 'bach', 'nepack2003@gmail.com', NULL, '$2y$10$SyCJbGnY61n8qPQp5n1K4esiKcAXVeDlzF.zNkBl6whaRLPXlryha', 'quản trị công tác', NULL, '2024-04-22', '2024-04-22', 0),
(5, 'nepack', 'nepack@gmail.com', NULL, '$2y$10$32SOD2/v8SO/kKWQuznnI.uXgrgEPSH7sHj1k5GIq15VpriIbOw.y', 'quản trị công tác', NULL, '2024-04-22', '2024-04-22', 0),
(6, 'nepack123', 'admin@gmail.com', NULL, '$2y$10$3awklDiawSmsjBHXtvRo1eLZPC67Dwx/Adn4ZiTDxGmcl5GfVHDFa', 'admin', NULL, '2024-04-22', '2024-04-22', 0),
(7, 'lebach', 'abcd@gmail.com', NULL, '$2y$10$zDNbPTWRZZiEhhjyYELQHevuWFeryoI3ijNw9S2913CKpCE1kEVNy', 'admin', NULL, '2024-04-22', '2024-04-22', 0),
(8, 'lebach', 'abacd@gmail.com', NULL, '$2y$10$eEMreMiqsiaaaFPuzfHcuuJUO6QPi558RW1scxXDoVkkDn3F0SbVK', 'admin', NULL, '2024-04-22', '2024-04-22', 0),
(9, 'lebach', 'abcaad@gmail.com', NULL, '$2y$10$h0L0DdxDFqwbTgyJ/wWlcezFja89g.F2QWbm0/Ipov5YDjgL87tIG', 'admin', NULL, '2024-04-22', '2024-04-22', 0),
(10, 'lebach', 'acbcd@gmail.com', NULL, '$2y$10$Jqmf1tzl6RkAoauyIQS2L.cXL8s/EW67frgJ8GMmtovp0tBt6oaoq', 'admin', NULL, '2024-04-22', '2024-04-22', 0),
(11, 'lebach', 'abrcd@gmail.com', NULL, '$2y$10$Xxf/wBCHA5rI7bn6Uj9j9Oaf2BAjZrMj5/E4WguqhXv86vZpF1f6q', 'admin', NULL, '2024-04-22', '2024-04-22', 0),
(12, 'lebach', 'abbcd@gmail.com', NULL, '$2y$10$GwMXGeIHGVaTy4/Pi2E36eJnGTzSTA0VVhFzYxo7zrdTK51/qAbYW', 'admin', NULL, '2024-04-22', '2024-04-22', 0),
(14, 'bach', 'nepack2004@gmail.com', NULL, '$2y$10$rEh1jdsA2ZJhu1X6/BU9HuetEPFgOsftKCerl0Bt8yo0TNFcZEHwW', 'user', NULL, '2024-04-22', '2024-04-22', 0),
(15, 'bach', 'nepack2005@gmail.com', NULL, '$2y$10$bQZE4s31jWtSdcsVLnStiOBYs1AjKS5MSTD5cUZJF6djEUQVNhY6m', 'user', NULL, '2024-04-22', '2024-04-22', 0),
(17, 'bach', 'nepack2006@gmail.com', NULL, '$2y$10$Xnk9Vn5Cvf7VaEN2l8nkeeYdWWqoSbf2XG3zs02RN97X2Ufn/tbKC', 'user', NULL, '2024-04-22', '2024-04-22', 1),
(18, 'bach', 'nepack2007@gmail.com', NULL, '$2y$10$PCMi1dl1399.wspLeslRAuTBJzjXWR.DSMoGRh/XP.kYE9TfzQpT2', 'admin', NULL, '2024-04-22', '2024-04-22', 1),
(19, 'banh cuon', 'nepack20010@gmail.com', NULL, '$2y$10$Bpe.0bHVDxcAVwPihOlFTeCbcjUyNfyxOwpoBdDYGjbbNHJsHwl3e', 'admin', NULL, '2024-04-22', '2024-04-22', 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cars_bien_so_xe_unique` (`bien_so_xe`),
  ADD UNIQUE KEY `cars_so_khung_unique` (`so_khung`),
  ADD KEY `cars_user_id_foreign` (`user_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `departments_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_department_id_foreign` (`department_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cars`
--
ALTER TABLE `cars`
  ADD CONSTRAINT `cars_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `departments_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
