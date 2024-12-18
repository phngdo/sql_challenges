-- create database:
CREATE DATABASE SampleDB
GO

USE SampleDB
GO

-- create tables:
CREATE TABLE dbo.AREA (
	ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	AREA_CODE VARCHAR(10) NOT NULL UNIQUE,
	AREA_NAME NVARCHAR(255) NOT NULL
);

CREATE TABLE dbo.BRANCH (
	ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	BRCODE VARCHAR(10) NOT NULL UNIQUE,
	BRNAME NVARCHAR(255) NOT NULL,
	BRADDRESS NVARCHAR(255) NOT NULL,
	AREA VARCHAR(10) NOT NULL,
	CONSTRAINT FK_BRANCH_AREA FOREIGN KEY(AREA) REFERENCES dbo.AREA(AREA_CODE)
);

CREATE TABLE dbo.CIF (
	ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	BRCODE VARCHAR(10) NOT NULL,
	CIF_ID VARCHAR(20) NOT NULL,
	CIF_NAME NVARCHAR(255) NOT NULL,
	ID_NUMBER VARCHAR(50) NOT NULL,
	CIF_TYPE NVARCHAR(50) NOT NULL,
	CONSTRAINT FK_CIF_BRANCH FOREIGN KEY(BRCODE) REFERENCES dbo.BRANCH(BRCODE)
);

-- insert values:
INSERT INTO dbo.AREA (AREA_CODE, AREA_NAME)
VALUES ('A01', N'HỘI SỞ CHÍNH'),
	   ('A02', N'TÂY BẮC BỘ'),
	   ('A03', N'ĐÔNG BẮC BỘ'),
	   ('A04', N'BẮC TRUNG BỘ'),
	   ('A05', N'NAM TRUNG BỘ');

INSERT INTO dbo.BRANCH (BRCODE, BRNAME, BRADDRESS, AREA)
VALUES ('1302001', N'Chi nhánh Đống Đa', N'Tôn Đức Thắng - Đống Đa - HN', 'A01'),
	   ('1302002', N'Chi nhánh Sở Giao dịch', N'22 Kim Mã Thượng - Hà Nội', 'A02'),
	   ('1302004', N'Chi nhánh hoàn kiếm', N'Trần Hưng Đạo - Đống Đa - HN', 'A03');

INSERT INTO dbo.CIF (BRCODE, CIF_ID, CIF_NAME, ID_NUMBER, CIF_TYPE)
VALUES ('1302001', 'CIF02001', N'CÔNG TY TNHH SÁNG TẠO MỚI', '805000457', N'Tổ chức'),
	   ('1302001', 'CIF02002', N'NGUYỄN VĂN ANH', '6200417055', N'Cá nhân'),
	   ('1302001', 'CIF02003', N'CÔNG TY TNHH PHÁT TRIỂN THƯƠNG MẠI BẮC NAM', '6200588086', N'Tổ chức'),
	   ('1302001', 'CIF02004', N'TRẦN THỊ THANH', '6200558854', N'Cá nhân'),
	   ('1302001', 'CIF02005', N'DOANH NGHIỆP TƯ NHÂN ĐỨC PHÚC', '5706200571', N'Tổ chức'),
	   ('1302001', 'CIF02006', N'LÊ VĂN HẢI', '62088205', N'Cá nhân'),
	   ('1302001', 'CIF02007', N'CÔNG TY TNHH THƯƠNG MẠI HOÀNG GIA', '5620516786', N'Tổ chức'),
	   ('1302002', 'CIF02008', N'CÔNG TY CỔ PHẦN PHÁT TRIỂN ĐẦU TƯ VIỆT NAM', '624075627', N'Tổ chức'),
	   ('1302002', 'CIF02009', N'HOÀNG NGỌC ANH', '800254255', N'Cá nhân'),
	   ('1302002', 'CIF02010', N'CÔNG TY CP XÂY DỰNG ĐÔ THỊ VIỆT NAM', '700487565', N'Tổ chức');
