-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 29, 2026 at 12:23 PM
-- Server version: 10.11.15-MariaDB-cll-lve
-- PHP Version: 8.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kesd1999_kesenian_banyuwangi`
--

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
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kik_anggota`
--

CREATE TABLE `kik_anggota` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `jenis_kelamin` enum('L','P') DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `pekerjaan` varchar(255) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `whatsapp` varchar(255) DEFAULT NULL,
  `telepon` varchar(255) DEFAULT NULL,
  `jabatan` varchar(255) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `organisasi_id` int(11) DEFAULT NULL,
  `validasi` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `kik_anggota`
--


--
-- Table structure for table `kik_datapendukung`
--

CREATE TABLE `kik_datapendukung` (
  `id` int(11) NOT NULL,
  `tipe` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `organisasi_id` int(11) DEFAULT NULL,
  `validasi` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `kik_datapendukung`
--


-- --------------------------------------------------------

--
-- Table structure for table `kik_inventaris`
--

CREATE TABLE `kik_inventaris` (
  `id` int(11) NOT NULL,
  `nama` varchar(500) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `pembelian_th` year(4) DEFAULT NULL,
  `kondisi` varchar(255) DEFAULT NULL,
  `organisasi_id` int(11) DEFAULT NULL,
  `validasi` tinyint(1) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `kik_inventaris`
--

--
-- Table structure for table `kik_jeniskesenian`
--

CREATE TABLE `kik_jeniskesenian` (
  `id` int(11) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `jenis_kesenian_id_lama` int(11) DEFAULT NULL,
  `sub_kesenian_id_lama` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `kik_jeniskesenian`
--

INSERT INTO `kik_jeniskesenian` (`id`, `parent`, `nama`, `jenis_kesenian_id_lama`, `sub_kesenian_id_lama`) VALUES
(1, NULL, 'JARANAN', 1, NULL),
(2, NULL, 'HADRAH', 3, NULL),
(3, NULL, 'WAYANG', 4, NULL),
(4, NULL, 'BARONG', 5, NULL),
(5, NULL, 'SANGGAR', 6, NULL),
(6, NULL, 'GANDRUNG', 8, NULL),
(7, NULL, 'ORKES', 9, NULL),
(8, NULL, 'CAMPURSARI', 10, NULL),
(9, NULL, 'TEATER', 13, NULL),
(10, NULL, 'BORDAH', 15, NULL),
(11, NULL, 'KARAWITAN', 17, NULL),
(12, NULL, 'REOG', 18, NULL),
(13, NULL, 'MUSIK TRADISIONAL', 19, NULL),
(14, NULL, 'SRUNEN', 20, NULL),
(15, NULL, 'MOCOPAT / MOCOAN', 21, NULL),
(16, NULL, 'KOLINTANG', 22, NULL),
(17, NULL, 'GEDHOGAN', 24, NULL),
(18, 1, 'JARANAN PEGON', NULL, 1),
(19, 1, 'JARANAN BUTO', NULL, 2),
(20, 1, 'JARANAN CAMPURSARI', NULL, 3),
(31, 5, 'SANGGAR TARI', NULL, 28),
(32, 5, 'SANGGAR LUKIS', NULL, 30),
(33, 5, 'SANGGAR MUSIK', NULL, 52),
(34, 2, 'KUNTULAN', NULL, 9),
(35, 2, 'REBANA', NULL, 10),
(36, 2, 'ISHARI', NULL, 11),
(37, 2, 'ALBANJARI', NULL, 12),
(38, 2, 'SAMROH', NULL, 25),
(39, 4, 'BARONG CAMPURSARI', NULL, 16),
(40, 4, 'BARONG OGOH-OGOH', NULL, 20),
(41, 4, 'BARONG PREJENG', NULL, 47),
(42, 8, 'CAMPUR SARI', NULL, 40),
(43, 6, 'GANDRUNG TEROB', NULL, 31),
(44, 17, 'GEDHOGAN', NULL, 27),
(45, 11, 'KARAWITAN', NULL, 42),
(46, 11, 'JAWA', NULL, 53),
(47, 11, 'BALAGANJUR', NULL, 54),
(48, 11, 'JOGED BUMBUNG', NULL, 65),
(49, 15, 'MOCOPAT CAMPURSARI', NULL, 21),
(50, 15, 'PACUL GUANG', NULL, 22),
(51, 15, 'PACUL GUANG CAMPURSARI', NULL, 23),
(52, 15, 'MOCOPAT MADURAAN', NULL, 64),
(53, 13, 'ANGKLUNG PATROL', NULL, 58),
(54, 13, 'ANGKLUNG CARUK', NULL, 59),
(55, 13, 'ANGKLUNG CAMPURSARI', NULL, 60),
(56, 13, 'ANGKLUNG KLASIK', NULL, 62),
(57, 7, 'GAMBUS', NULL, 4),
(58, 7, 'KERONCONG', NULL, 5),
(59, 7, 'DANGDUT', NULL, 6),
(60, 7, 'KENDANG KEMPUL', NULL, 7),
(61, 7, 'BAND', NULL, 26),
(62, 12, 'REOG PONOROGO', NULL, 43),
(63, 12, 'REOG CAMPURSARI', NULL, 44),
(64, 14, 'SRUNEN', NULL, 39),
(65, 9, 'JANGER', NULL, 32),
(66, 9, 'PRABU RORO', NULL, 33),
(67, 9, 'LUDRUK', NULL, 34),
(68, 9, 'KETOPRAK', NULL, 35),
(69, 9, 'ANDE-ANDE LUMUT', NULL, 36),
(70, 9, 'DRAMADOR', NULL, 37),
(71, 9, 'BADUT PERTUNJUKAN', NULL, 51),
(72, 9, 'PERFILMAN', NULL, 56),
(73, 9, 'WAYANG TOPENG', NULL, 61),
(74, 9, 'DRAMA MUSIKAL', NULL, 63),
(75, 3, 'WAYANG KULIT', NULL, 13),
(76, 3, 'WAYANG ORANG', NULL, 14),
(77, 3, 'WAYANG KULIT RUWATAN', NULL, 50),
(78, 3, 'WAYANG GOLEK', NULL, 55),
(79, 10, 'BORDAH', NULL, NULL),
(80, 16, 'KOLINTANG', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kik_organisasi`
--

CREATE TABLE `kik_organisasi` (
  `id` int(11) NOT NULL,
  `nomor_induk` varchar(255) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `nama_ketua` varchar(200) DEFAULT NULL,
  `no_telp_ketua` varchar(20) DEFAULT NULL,
  `tanggal_berdiri` date DEFAULT NULL,
  `tanggal_daftar` date DEFAULT NULL,
  `tanggal_expired` date DEFAULT NULL,
  `tanggal_cetak_kartu` date DEFAULT NULL,
  `perpanjangan_ke` int(11) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `desa` varchar(255) DEFAULT NULL,
  `kecamatan` varchar(255) DEFAULT NULL,
  `kabupaten` varchar(255) DEFAULT NULL,
  `nama_kecamatan` varchar(255) DEFAULT NULL,
  `nama_desa` varchar(255) DEFAULT NULL,
  `jenis_kesenian` varchar(255) DEFAULT NULL,
  `sub_kesenian` varchar(100) DEFAULT NULL,
  `nama_jenis_kesenian` varchar(255) DEFAULT NULL,
  `nama_sub_kesenian` varchar(255) DEFAULT NULL,
  `jumlah_anggota` int(11) DEFAULT NULL,
  `logo` int(11) DEFAULT NULL,
  `status` enum('Request','Allow','Denny','DataLama') DEFAULT NULL,
  `kartu` varchar(255) DEFAULT NULL,
  `kode_kartu` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `kik_organisasi`
--

--
-- Table structure for table `kik_organisasi_anggota`
--

CREATE TABLE `kik_organisasi_anggota` (
  `id` int(11) NOT NULL,
  `organisasi_id` int(11) NOT NULL,
  `anggota_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `kik_organisasi_anggota`
--


--
-- Table structure for table `kik_verifikasi`
--

CREATE TABLE `kik_verifikasi` (
  `id` int(11) NOT NULL,
  `organisasi_id` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `tipe` varchar(255) DEFAULT NULL,
  `tanggal_review` datetime DEFAULT NULL,
  `userid_review` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `kik_verifikasi`
--
--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `kik_anggota`
--
ALTER TABLE `kik_anggota`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kik_datapendukung`
--
ALTER TABLE `kik_datapendukung`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kik_inventaris`
--
ALTER TABLE `kik_inventaris`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kik_jeniskesenian`
--
ALTER TABLE `kik_jeniskesenian`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kik_organisasi`
--
ALTER TABLE `kik_organisasi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `nomor_induk` (`nomor_induk`),
  ADD UNIQUE KEY `kode_kartu` (`kode_kartu`);

--
-- Indexes for table `kik_organisasi_anggota`
--
ALTER TABLE `kik_organisasi_anggota`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kik_verifikasi`
--
ALTER TABLE `kik_verifikasi`
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
  ADD KEY `password_resets_email_index` (`email`);

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
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kik_anggota`
--
ALTER TABLE `kik_anggota`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5117;

--
-- AUTO_INCREMENT for table `kik_datapendukung`
--
ALTER TABLE `kik_datapendukung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3655;

--
-- AUTO_INCREMENT for table `kik_inventaris`
--
ALTER TABLE `kik_inventaris`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2896;

--
-- AUTO_INCREMENT for table `kik_jeniskesenian`
--
ALTER TABLE `kik_jeniskesenian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `kik_organisasi`
--
ALTER TABLE `kik_organisasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1510;

--
-- AUTO_INCREMENT for table `kik_organisasi_anggota`
--
ALTER TABLE `kik_organisasi_anggota`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5280;

--
-- AUTO_INCREMENT for table `kik_verifikasi`
--
ALTER TABLE `kik_verifikasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1614;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `providers`
--
ALTER TABLE `providers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `records_api`
--
ALTER TABLE `records_api`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=304;

--
-- AUTO_INCREMENT for table `src_undangan`
--

--
-- AUTO_INCREMENT for table `tamu_lucky_settings`
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=838;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `providers`
--
ALTER TABLE `providers`
  ADD CONSTRAINT `providers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
