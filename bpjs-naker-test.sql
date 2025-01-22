/*
 Navicat Premium Data Transfer

 Source Server         : postgre-local
 Source Server Type    : PostgreSQL
 Source Server Version : 140015 (140015)
 Source Host           : localhost:5432
 Source Catalog        : bpjs-naker-test
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 140015 (140015)
 File Encoding         : 65001

 Date: 22/01/2025 11:47:49
*/


-- ----------------------------
-- Type structure for tenors
-- ----------------------------
DROP TYPE IF EXISTS "tenors";
CREATE TYPE "tenors" AS ENUM (
  '1 Month',
  '3 Month',
  '6 Month',
  '12 Month'
);
ALTER TYPE "tenors" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for banks_id_bank_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "banks_id_bank_seq";
CREATE SEQUENCE "banks_id_bank_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for deposito_id_deposito_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "deposito_id_deposito_seq";
CREATE SEQUENCE "deposito_id_deposito_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for deposito_rate_id_deposito_rate_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "deposito_rate_id_deposito_rate_seq";
CREATE SEQUENCE "deposito_rate_id_deposito_rate_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for role_id_role_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "role_id_role_seq";
CREATE SEQUENCE "role_id_role_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for settlement_process_id_settlement_status_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "settlement_process_id_settlement_status_seq";
CREATE SEQUENCE "settlement_process_id_settlement_status_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for unit_bisnis_id_unit_bisnis_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "unit_bisnis_id_unit_bisnis_seq";
CREATE SEQUENCE "unit_bisnis_id_unit_bisnis_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for user_id_user_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "user_id_user_seq";
CREATE SEQUENCE "user_id_user_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for bank
-- ----------------------------
DROP TABLE IF EXISTS "bank";
CREATE TABLE "bank" (
  "id_bank" int4 NOT NULL DEFAULT nextval('banks_id_bank_seq'::regclass),
  "bank_name" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of bank
-- ----------------------------
BEGIN;
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (1, 'BCA');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (2, 'BNI');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (3, 'BRI');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (4, 'BTN');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (5, 'BANK MANDIRI');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (6, 'BANK DKI');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (7, 'BANK JATENG');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (8, 'BANK JATIM');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (9, 'BANK MEGA');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (10, 'BANK MASPION');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (11, 'BANK PANIN');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (12, 'BANK SINARMAS');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (13, 'CIMB');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (14, 'MAYBANK');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (15, 'OCBC NISP');
INSERT INTO "bank" ("id_bank", "bank_name") VALUES (16, 'J TRUST BANK');
COMMIT;

-- ----------------------------
-- Table structure for deposito
-- ----------------------------
DROP TABLE IF EXISTS "deposito";
CREATE TABLE "deposito" (
  "id_deposito" int4 NOT NULL DEFAULT nextval('deposito_id_deposito_seq'::regclass),
  "id_deposito_rate" int2 NOT NULL,
  "deposit_value" numeric,
  "estimated_interest" numeric,
  "estimated_value" numeric,
  "tanggal_penempatan" timestamp(6),
  "tanggal_jatuh_tempo" timestamp(6),
  "settlement_status" int2,
  "latest_update" timestamp(6),
  "name" varchar(255) COLLATE "pg_catalog"."default",
  "email" varchar(255) COLLATE "pg_catalog"."default",
  "phone" varchar(255) COLLATE "pg_catalog"."default",
  "nama_pemegang_rekening" varchar(255) COLLATE "pg_catalog"."default",
  "id_bank" int2,
  "nomor_rekening" varchar(255) COLLATE "pg_catalog"."default",
  "created_at" timestamp(6),
  "created_by" int2,
  "updated_at" timestamp(6),
  "updated_by" int2,
  "latest_update_text" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of deposito
-- ----------------------------
BEGIN;
INSERT INTO "deposito" ("id_deposito", "id_deposito_rate", "deposit_value", "estimated_interest", "estimated_value", "tanggal_penempatan", "tanggal_jatuh_tempo", "settlement_status", "latest_update", "name", "email", "phone", "nama_pemegang_rekening", "id_bank", "nomor_rekening", "created_at", "created_by", "updated_at", "updated_by", "latest_update_text") VALUES (1, 1, 1000000, 30000.00, 1030000, '2025-01-18 06:32:55', '2025-02-18 06:32:59', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "deposito" ("id_deposito", "id_deposito_rate", "deposit_value", "estimated_interest", "estimated_value", "tanggal_penempatan", "tanggal_jatuh_tempo", "settlement_status", "latest_update", "name", "email", "phone", "nama_pemegang_rekening", "id_bank", "nomor_rekening", "created_at", "created_by", "updated_at", "updated_by", "latest_update_text") VALUES (2, 6, 1000000, 6164.38, 1006164.38, '2025-01-19 21:08:20', '2025-04-19 21:08:20', 0, NULL, 'Test', 'test@mail.com', '080989999', 'Testing', 2, '9891887281', NULL, 12, NULL, NULL, NULL);
INSERT INTO "deposito" ("id_deposito", "id_deposito_rate", "deposit_value", "estimated_interest", "estimated_value", "tanggal_penempatan", "tanggal_jatuh_tempo", "settlement_status", "latest_update", "name", "email", "phone", "nama_pemegang_rekening", "id_bank", "nomor_rekening", "created_at", "created_by", "updated_at", "updated_by", "latest_update_text") VALUES (3, 10, 1000000, 8630.14, 1008630.14, '2025-01-19 21:27:52', '2025-04-19 21:27:52', 0, NULL, 'JOOSO', 'joss@mail.com', '12351514331', 'SJOOSJ', 4, '121312321', NULL, 12, NULL, NULL, NULL);
INSERT INTO "deposito" ("id_deposito", "id_deposito_rate", "deposit_value", "estimated_interest", "estimated_value", "tanggal_penempatan", "tanggal_jatuh_tempo", "settlement_status", "latest_update", "name", "email", "phone", "nama_pemegang_rekening", "id_bank", "nomor_rekening", "created_at", "created_by", "updated_at", "updated_by", "latest_update_text") VALUES (4, 45, 1000000, 12328.77, 1012328.77, '2025-01-20 23:45:04', '2025-07-20 23:45:04', 0, NULL, 'Testomg', 'test@mail.com', '1231313141', 'Test', 8, '9189189819', NULL, 8, NULL, NULL, NULL);
INSERT INTO "deposito" ("id_deposito", "id_deposito_rate", "deposit_value", "estimated_interest", "estimated_value", "tanggal_penempatan", "tanggal_jatuh_tempo", "settlement_status", "latest_update", "name", "email", "phone", "nama_pemegang_rekening", "id_bank", "nomor_rekening", "created_at", "created_by", "updated_at", "updated_by", "latest_update_text") VALUES (5, 40, 10000000, 92465.75, 10092465.75, '2025-01-20 23:47:03', '2025-04-20 23:47:03', 0, NULL, 'New Testing', 'newtest@mail.com', '18299292901', 'New Testing', 11, '998228811', '2025-01-20 23:47:03', 8, NULL, NULL, NULL);
INSERT INTO "deposito" ("id_deposito", "id_deposito_rate", "deposit_value", "estimated_interest", "estimated_value", "tanggal_penempatan", "tanggal_jatuh_tempo", "settlement_status", "latest_update", "name", "email", "phone", "nama_pemegang_rekening", "id_bank", "nomor_rekening", "created_at", "created_by", "updated_at", "updated_by", "latest_update_text") VALUES (6, 40, 10000000, 92465.75, 10092465.75, '2025-01-20 23:48:38', '2025-04-20 23:48:38', 0, NULL, 'New Testing', 'newtest@mail.com', '18299292901', 'New Testing', 11, '998228811', '2025-01-20 23:48:38', 8, NULL, NULL, NULL);
INSERT INTO "deposito" ("id_deposito", "id_deposito_rate", "deposit_value", "estimated_interest", "estimated_value", "tanggal_penempatan", "tanggal_jatuh_tempo", "settlement_status", "latest_update", "name", "email", "phone", "nama_pemegang_rekening", "id_bank", "nomor_rekening", "created_at", "created_by", "updated_at", "updated_by", "latest_update_text") VALUES (7, 40, 10000000, 92465.75, 10092465.75, '2025-01-20 23:49:02', '2025-04-20 23:49:02', 0, NULL, 'New Testing', 'newtest@mail.com', '18299292901', 'New Testing', 11, '998228811', '2025-01-20 23:49:02', 8, NULL, NULL, NULL);
INSERT INTO "deposito" ("id_deposito", "id_deposito_rate", "deposit_value", "estimated_interest", "estimated_value", "tanggal_penempatan", "tanggal_jatuh_tempo", "settlement_status", "latest_update", "name", "email", "phone", "nama_pemegang_rekening", "id_bank", "nomor_rekening", "created_at", "created_by", "updated_at", "updated_by", "latest_update_text") VALUES (8, 40, 10000000, 92465.75, 10092465.75, '2025-01-20 23:49:02', '2025-04-20 23:49:02', 0, NULL, 'New Testing', 'newtest@mail.com', '18299292901', 'New Testing', 11, '998228811', '2025-01-20 23:49:02', 8, NULL, NULL, NULL);
INSERT INTO "deposito" ("id_deposito", "id_deposito_rate", "deposit_value", "estimated_interest", "estimated_value", "tanggal_penempatan", "tanggal_jatuh_tempo", "settlement_status", "latest_update", "name", "email", "phone", "nama_pemegang_rekening", "id_bank", "nomor_rekening", "created_at", "created_by", "updated_at", "updated_by", "latest_update_text") VALUES (9, 40, 10000000, 92465.75, 10092465.75, '2025-01-20 23:51:35', '2025-04-20 23:51:35', 0, NULL, 'New Testing', 'newtest@mail.com', '18299292901', 'New Testing', 11, '998228811', '2025-01-20 23:51:35', 8, NULL, NULL, NULL);
INSERT INTO "deposito" ("id_deposito", "id_deposito_rate", "deposit_value", "estimated_interest", "estimated_value", "tanggal_penempatan", "tanggal_jatuh_tempo", "settlement_status", "latest_update", "name", "email", "phone", "nama_pemegang_rekening", "id_bank", "nomor_rekening", "created_at", "created_by", "updated_at", "updated_by", "latest_update_text") VALUES (10, 40, 10000000, 92465.75, 10092465.75, '2025-01-20 23:55:49', '2025-04-20 23:55:49', 0, NULL, 'New Testing', 'newtest@mail.com', '18299292901', 'New Testing', 11, '998228811', '2025-01-20 23:55:49', 8, NULL, NULL, NULL);
INSERT INTO "deposito" ("id_deposito", "id_deposito_rate", "deposit_value", "estimated_interest", "estimated_value", "tanggal_penempatan", "tanggal_jatuh_tempo", "settlement_status", "latest_update", "name", "email", "phone", "nama_pemegang_rekening", "id_bank", "nomor_rekening", "created_at", "created_by", "updated_at", "updated_by", "latest_update_text") VALUES (11, 40, 10000000, 92465.75, 10092465.75, '2025-01-21 00:00:29', '2025-04-21 00:00:29', 0, NULL, 'New Testing', 'newtest@mail.com', '18299292901', 'New Testing', 11, '998228811', '2025-01-21 00:00:29', 8, NULL, NULL, NULL);
INSERT INTO "deposito" ("id_deposito", "id_deposito_rate", "deposit_value", "estimated_interest", "estimated_value", "tanggal_penempatan", "tanggal_jatuh_tempo", "settlement_status", "latest_update", "name", "email", "phone", "nama_pemegang_rekening", "id_bank", "nomor_rekening", "created_at", "created_by", "updated_at", "updated_by", "latest_update_text") VALUES (12, 40, 10000000, 92465.75, 10092465.75, '2025-01-21 00:01:36', '2025-04-21 00:01:36', 0, NULL, 'New Testing', 'newtest@mail.com', '18299292901', 'New Testing', 11, '998228811', '2025-01-21 00:01:36', 8, NULL, NULL, NULL);
INSERT INTO "deposito" ("id_deposito", "id_deposito_rate", "deposit_value", "estimated_interest", "estimated_value", "tanggal_penempatan", "tanggal_jatuh_tempo", "settlement_status", "latest_update", "name", "email", "phone", "nama_pemegang_rekening", "id_bank", "nomor_rekening", "created_at", "created_by", "updated_at", "updated_by", "latest_update_text") VALUES (14, 53, 15000000, 351369.86, 15351369.86, '2025-01-22 02:19:31', '2025-07-22 02:19:31', 1, '2025-01-22 04:42:55', 'Deposito Baru', 'newDeps@mail.com', '182020109010', 'Deposito Baru', 1, '1998882779', '2025-01-22 02:19:31', 12, '2025-01-22 04:42:55', 14, 'Approved By Dorothy Reyes dari DIREKTUR Unit Bisnis Investasi');
INSERT INTO "deposito" ("id_deposito", "id_deposito_rate", "deposit_value", "estimated_interest", "estimated_value", "tanggal_penempatan", "tanggal_jatuh_tempo", "settlement_status", "latest_update", "name", "email", "phone", "nama_pemegang_rekening", "id_bank", "nomor_rekening", "created_at", "created_by", "updated_at", "updated_by", "latest_update_text") VALUES (13, 40, 10000000, 92465.75, 10092465.75, '2025-01-21 00:02:26', '2025-04-21 00:02:26', 2, '2025-01-22 04:46:17', 'New Testing', 'newtest@mail.com', '18299292901', 'New Testing', 11, '998228811', '2025-01-21 00:02:26', 8, '2025-01-22 04:46:17', 2, 'Approved By Jason Scott dari PENATA SETTLEMENT Unit Bisnis Settlement');
COMMIT;

-- ----------------------------
-- Table structure for deposito_rate
-- ----------------------------
DROP TABLE IF EXISTS "deposito_rate";
CREATE TABLE "deposito_rate" (
  "id_deposito_rate" int4 NOT NULL DEFAULT nextval('deposito_rate_id_deposito_rate_seq'::regclass),
  "id_bank" int4 NOT NULL,
  "tenor" "public"."tenors" NOT NULL,
  "rate" numeric(5,4)
)
;

-- ----------------------------
-- Records of deposito_rate
-- ----------------------------
BEGIN;
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (1, 1, '1 Month', 0.0325);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (2, 1, '3 Month', 0.0325);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (3, 1, '6 Month', 0.0225);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (4, 1, '12 Month', 0.0200);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (5, 2, '1 Month', 0.0225);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (6, 2, '3 Month', 0.0250);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (7, 2, '6 Month', 0.0275);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (8, 2, '12 Month', 0.0300);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (9, 3, '1 Month', 0.0335);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (10, 3, '3 Month', 0.0350);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (11, 3, '6 Month', 0.0300);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (12, 3, '12 Month', 0.0300);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (13, 4, '1 Month', 0.0225);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (14, 4, '3 Month', 0.0265);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (15, 4, '6 Month', 0.0290);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (16, 4, '12 Month', 0.0290);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (17, 5, '1 Month', 0.0225);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (18, 5, '3 Month', 0.0225);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (19, 5, '6 Month', 0.0250);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (20, 5, '12 Month', 0.0250);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (21, 6, '1 Month', 0.0250);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (22, 6, '3 Month', 0.0350);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (23, 6, '6 Month', 0.0325);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (24, 6, '12 Month', 0.0325);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (25, 7, '1 Month', 0.0200);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (26, 7, '3 Month', 0.0200);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (27, 7, '6 Month', 0.0200);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (28, 7, '12 Month', 0.0200);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (29, 8, '1 Month', 0.0260);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (30, 8, '3 Month', 0.0275);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (31, 8, '6 Month', 0.0290);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (32, 8, '12 Month', 0.0295);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (33, 9, '1 Month', 0.0375);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (34, 9, '3 Month', 0.0375);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (35, 9, '6 Month', 0.0275);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (36, 9, '12 Month', 0.0350);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (37, 10, '1 Month', 0.0375);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (38, 10, '3 Month', 0.0375);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (39, 11, '1 Month', 0.0375);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (40, 11, '3 Month', 0.0375);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (41, 11, '6 Month', 0.0375);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (42, 11, '12 Month', 0.0375);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (43, 12, '1 Month', 0.0200);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (44, 12, '3 Month', 0.0225);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (45, 12, '6 Month', 0.0250);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (46, 12, '12 Month', 0.0250);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (47, 13, '1 Month', 0.0225);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (48, 13, '3 Month', 0.0300);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (49, 13, '6 Month', 0.0275);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (50, 13, '12 Month', 0.0275);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (51, 14, '1 Month', 0.0400);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (52, 14, '3 Month', 0.0450);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (53, 14, '6 Month', 0.0475);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (54, 14, '12 Month', 0.0475);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (55, 15, '1 Month', 0.0375);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (56, 15, '3 Month', 0.0400);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (57, 15, '6 Month', 0.0425);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (58, 15, '12 Month', 0.0425);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (59, 16, '1 Month', 0.0350);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (60, 16, '3 Month', 0.0375);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (61, 16, '6 Month', 0.0400);
INSERT INTO "deposito_rate" ("id_deposito_rate", "id_bank", "tenor", "rate") VALUES (62, 16, '12 Month', 0.0425);
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS "role";
CREATE TABLE "role" (
  "id_role" int4 NOT NULL DEFAULT nextval('role_id_role_seq'::regclass),
  "role" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO "role" ("id_role", "role") VALUES (1, 'SUPERADMIN');
INSERT INTO "role" ("id_role", "role") VALUES (2, 'DIREKTUR');
INSERT INTO "role" ("id_role", "role") VALUES (3, 'DEPUTI');
INSERT INTO "role" ("id_role", "role") VALUES (4, 'ASISTEN DEPUTI');
INSERT INTO "role" ("id_role", "role") VALUES (5, 'DEAELER');
INSERT INTO "role" ("id_role", "role") VALUES (6, 'PENATA SETTLEMENT');
COMMIT;

-- ----------------------------
-- Table structure for settlement_process
-- ----------------------------
DROP TABLE IF EXISTS "settlement_process";
CREATE TABLE "settlement_process" (
  "id_settlement_process" int4 NOT NULL DEFAULT nextval('settlement_process_id_settlement_status_seq'::regclass),
  "id_deposito" int2,
  "id_unit_bisnis" int2,
  "id_role" int2,
  "id_user" int2,
  "priority" int2,
  "status" int2,
  "remarks" varchar(255) COLLATE "pg_catalog"."default",
  "updated_at" timestamp(6),
  "updated_by" int2
)
;

-- ----------------------------
-- Records of settlement_process
-- ----------------------------
BEGIN;
INSERT INTO "settlement_process" ("id_settlement_process", "id_deposito", "id_unit_bisnis", "id_role", "id_user", "priority", "status", "remarks", "updated_at", "updated_by") VALUES (9, 14, 2, 2, 13, 4, 0, NULL, NULL, NULL);
INSERT INTO "settlement_process" ("id_settlement_process", "id_deposito", "id_unit_bisnis", "id_role", "id_user", "priority", "status", "remarks", "updated_at", "updated_by") VALUES (10, 14, 2, 3, 5, 5, 0, NULL, NULL, NULL);
INSERT INTO "settlement_process" ("id_settlement_process", "id_deposito", "id_unit_bisnis", "id_role", "id_user", "priority", "status", "remarks", "updated_at", "updated_by") VALUES (11, 14, 2, 4, NULL, 6, 0, NULL, NULL, NULL);
INSERT INTO "settlement_process" ("id_settlement_process", "id_deposito", "id_unit_bisnis", "id_role", "id_user", "priority", "status", "remarks", "updated_at", "updated_by") VALUES (12, 14, 2, 6, NULL, 7, 0, NULL, NULL, NULL);
INSERT INTO "settlement_process" ("id_settlement_process", "id_deposito", "id_unit_bisnis", "id_role", "id_user", "priority", "status", "remarks", "updated_at", "updated_by") VALUES (1, 13, 1, 4, NULL, 1, 1, 'Lengkap', '2025-01-22 04:07:49', 7);
INSERT INTO "settlement_process" ("id_settlement_process", "id_deposito", "id_unit_bisnis", "id_role", "id_user", "priority", "status", "remarks", "updated_at", "updated_by") VALUES (6, 14, 1, 4, 16, 1, 1, '', '2025-01-22 04:11:38', 16);
INSERT INTO "settlement_process" ("id_settlement_process", "id_deposito", "id_unit_bisnis", "id_role", "id_user", "priority", "status", "remarks", "updated_at", "updated_by") VALUES (7, 14, 1, 3, NULL, 2, 1, '', '2025-01-22 04:25:00', 4);
INSERT INTO "settlement_process" ("id_settlement_process", "id_deposito", "id_unit_bisnis", "id_role", "id_user", "priority", "status", "remarks", "updated_at", "updated_by") VALUES (8, 14, 1, 2, 14, 3, 1, 'Sip', '2025-01-22 04:42:55', 14);
INSERT INTO "settlement_process" ("id_settlement_process", "id_deposito", "id_unit_bisnis", "id_role", "id_user", "priority", "status", "remarks", "updated_at", "updated_by") VALUES (2, 13, 1, 2, 14, 2, 1, '', '2025-01-22 04:44:04', 14);
INSERT INTO "settlement_process" ("id_settlement_process", "id_deposito", "id_unit_bisnis", "id_role", "id_user", "priority", "status", "remarks", "updated_at", "updated_by") VALUES (3, 13, 2, 2, 13, 3, 1, '', '2025-01-22 04:44:55', 13);
INSERT INTO "settlement_process" ("id_settlement_process", "id_deposito", "id_unit_bisnis", "id_role", "id_user", "priority", "status", "remarks", "updated_at", "updated_by") VALUES (4, 13, 2, 3, NULL, 4, 1, '', '2025-01-22 04:45:47', 5);
INSERT INTO "settlement_process" ("id_settlement_process", "id_deposito", "id_unit_bisnis", "id_role", "id_user", "priority", "status", "remarks", "updated_at", "updated_by") VALUES (5, 13, 2, 6, 2, 5, 1, 'Selesai', '2025-01-22 04:46:17', 2);
COMMIT;

-- ----------------------------
-- Table structure for unit_bisnis
-- ----------------------------
DROP TABLE IF EXISTS "unit_bisnis";
CREATE TABLE "unit_bisnis" (
  "id_unit_bisnis" int4 NOT NULL DEFAULT nextval('unit_bisnis_id_unit_bisnis_seq'::regclass),
  "unit_bisnis" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of unit_bisnis
-- ----------------------------
BEGIN;
INSERT INTO "unit_bisnis" ("id_unit_bisnis", "unit_bisnis") VALUES (1, 'Unit Bisnis Investasi');
INSERT INTO "unit_bisnis" ("id_unit_bisnis", "unit_bisnis") VALUES (2, 'Unit Bisnis Settlement');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS "user";
CREATE TABLE "user" (
  "id_user" int4 NOT NULL DEFAULT nextval('user_id_user_seq'::regclass),
  "id_role" int2 NOT NULL,
  "name" varchar(255) COLLATE "pg_catalog"."default",
  "email" varchar(255) COLLATE "pg_catalog"."default",
  "password" text COLLATE "pg_catalog"."default",
  "created_at" timestamp(6),
  "created_by" int2,
  "updated_at" timestamp(6),
  "updated_by" int2,
  "id_unit_bisnis" int2
)
;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (1, 1, 'Admin', 'admin@admin.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', '2025-01-16 12:38:59', NULL, NULL, NULL, NULL);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (2, 6, 'Jason Scott', 'scotjas@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 2);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (3, 6, 'Paul Mendez', 'mendezpaul@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 1);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (4, 3, 'Sherry Jimenez', 'sjim@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 1);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (6, 1, 'Lillian Gray', 'lilliangray4@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 2);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (7, 4, 'Brandon Hayes', 'hayesbrand@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 1);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (8, 5, 'Janice Gutierrez', 'janigu@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 2);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (9, 1, 'Patrick Aguilar', 'agup@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 1);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (10, 2, 'James Griffin', 'james93@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 1);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (11, 4, 'Curtis Mills', 'mic51@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 2);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (12, 5, 'Bryan Flores', 'fbryan@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 2);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (14, 2, 'Dorothy Reyes', 'dorothyre416@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 1);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (15, 1, 'John Medina', 'medinjohn2020@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 2);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (16, 4, 'Patricia Stevens', 'stevenspatr@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 1);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (17, 3, 'Linda Meyer', 'lmeyer2@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 1);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (18, 4, 'Anna Bryant', 'annbr@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 1);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (19, 4, 'Gladys Adams', 'adamsgladys@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 1);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (20, 4, 'Brandon Evans', 'evans226@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 2);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (21, 6, 'Francisco Henderson', 'frh@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 1);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (13, 2, 'Alexander Spencer', 'alspencer71@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 2);
INSERT INTO "user" ("id_user", "id_role", "name", "email", "password", "created_at", "created_by", "updated_at", "updated_by", "id_unit_bisnis") VALUES (5, 3, 'Richard Guzman', 'richaguzman@gmail.com', '$2a$12$CiL0f897Fo7Wt6C3rK4CHurVvB.3tHtWxROnrNM773TakoLQ09.wa', NULL, NULL, NULL, NULL, 2);
COMMIT;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "banks_id_bank_seq"
OWNED BY "bank"."id_bank";
SELECT setval('"banks_id_bank_seq"', 16, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "deposito_id_deposito_seq"
OWNED BY "deposito"."id_deposito";
SELECT setval('"deposito_id_deposito_seq"', 14, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "deposito_rate_id_deposito_rate_seq"
OWNED BY "deposito_rate"."id_deposito_rate";
SELECT setval('"deposito_rate_id_deposito_rate_seq"', 62, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "role_id_role_seq"
OWNED BY "role"."id_role";
SELECT setval('"role_id_role_seq"', 6, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "settlement_process_id_settlement_status_seq"
OWNED BY "settlement_process"."id_settlement_process";
SELECT setval('"settlement_process_id_settlement_status_seq"', 12, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "unit_bisnis_id_unit_bisnis_seq"
OWNED BY "unit_bisnis"."id_unit_bisnis";
SELECT setval('"unit_bisnis_id_unit_bisnis_seq"', 2, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "user_id_user_seq"
OWNED BY "user"."id_user";
SELECT setval('"user_id_user_seq"', 1, true);

-- ----------------------------
-- Primary Key structure for table bank
-- ----------------------------
ALTER TABLE "bank" ADD CONSTRAINT "banks_pkey" PRIMARY KEY ("id_bank");

-- ----------------------------
-- Primary Key structure for table deposito
-- ----------------------------
ALTER TABLE "deposito" ADD CONSTRAINT "deposito_pkey" PRIMARY KEY ("id_deposito");

-- ----------------------------
-- Primary Key structure for table deposito_rate
-- ----------------------------
ALTER TABLE "deposito_rate" ADD CONSTRAINT "deposito_rate_pkey" PRIMARY KEY ("id_deposito_rate");

-- ----------------------------
-- Primary Key structure for table role
-- ----------------------------
ALTER TABLE "role" ADD CONSTRAINT "role_pkey" PRIMARY KEY ("id_role");

-- ----------------------------
-- Primary Key structure for table settlement_process
-- ----------------------------
ALTER TABLE "settlement_process" ADD CONSTRAINT "settlement_process_pkey" PRIMARY KEY ("id_settlement_process");

-- ----------------------------
-- Primary Key structure for table unit_bisnis
-- ----------------------------
ALTER TABLE "unit_bisnis" ADD CONSTRAINT "unit_bisnis_pkey" PRIMARY KEY ("id_unit_bisnis");

-- ----------------------------
-- Primary Key structure for table user
-- ----------------------------
ALTER TABLE "user" ADD CONSTRAINT "user_pkey" PRIMARY KEY ("id_user");
