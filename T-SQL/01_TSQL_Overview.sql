
--	PRINT Komutu

GO
DECLARE @kitap VARCHAR(29);   -- tanimlama alani
SET @kitap = 'Ýleri Seviye SQL Server T-SQL';  -- deger atama alani
PRINT @kitap  -- goruntuleme alani
GO


--	CREATE DATABASE ile Veritabani Olusturmak


USE master
CREATE DATABASE Bootcamp


CREATE DATABASE XBank 
ON  PRIMARY 
( 
	NAME = N'XBank_Data', 
	FILENAME = N'C:\Databases\XBank_Data.mdf',
	SIZE = 21632KB, 
	MAXSIZE = UNLIMITED, 
	FILEGROWTH = 16384KB 
)
LOG ON 
( 
	NAME = N'XBank_Log', 
	FILENAME = N'C:\Databases\XBank_Log.ldf',
	SIZE = 2048KB, 
	MAXSIZE = 2048GB, 
	FILEGROWTH = 16384KB 
)
GO


EXEC sp_helpdb 'XBank';


--	CREATE TABLE ile Tablo Oluþturmak


SELECT FirstName + ' ' + LastName AS [Isim] FROM Person.Person;


USE XBank
GO
CREATE TABLE XBank_Kullanicilar(
	kul_ID	INT	       NOT NULL,
	kul_ad	VARCHAR(20)  NOT NULL,
	kul_soyad	VARCHAR(20)  NOT NULL,
	kul_telefon	VARCHAR(11)  NULL,
	kul_email	VARCHAR(320) NOT NULL
);



EXECUTE sp_help 'XBank_Kullanicilar';



--	ALTER ile Veritabaný Yapýsýný Deðiþtirmek



EXEC sp_helpdb XBank;



ALTER DATABASE XBank
MODIFY FILE
(
	NAME = XBank_Data,
	SIZE = 300MB
);


EXEC sp_helpdb XBank;



--	ALTER ile Tablo Yapýsýný Deðiþtirmek




EXEC sp_help XBank_Kullanicilar;



ALTER TABLE XBank_Kullanicilar
ADD
kul_adres	    VARCHAR(150) NULL,
kul_kayitTarih  DATETIME     NOT NULL DEFAULT GETDATE();




--	DROP ile Tablo Silmek
USE XBank
GO
CREATE TABLE XBank_Kitaplar(
	kit_ID	Int       NOT NULL,
	kit_ad	VARCHAR(20)  NOT NULL,
	kul_telefon	VARCHAR(11)  NULL,
	kul_email	VARCHAR(320) NOT NULL
);

USE XBank						
GO
DROP TABLE XBank_Kitaplar;




--	DROP ile Veritabaný Silmek


USE master
GO
DROP DATABASE Bootcamp;



--	INSERT ile Veri Eklemek



INSERT INTO XBank_Kullanicilar
VALUES(2,'Emre','Ceylan','5531114569','em3recyln@gmail.com','Istanbul',GETDATE());




--	SELECT ile Veri Seçmek


USE XBank
GO
SELECT * FROM XBank_Kullanicilar;



USE XBank
GO
SELECT 
	kul_ID,kul_ad,kul_soyad,kul_telefon,
	kul_email,kul_adres,kul_kayitTarih 
FROM 
	XBank_Kullanicilar;




--	UPDATE ile Veri Güncellemek


UPDATE XBank_Kullanicilar
SET 	kul_adres = 'Ýstanbul / Baþakþehir'
WHERE kul_ID = 2;



--	DELETE ile Veri Silmek


DELETE FROM XBank_Kullanicilar WHERE kul_ID = 2;



DELETE FROM XBank_Kullanicilar;



--	GRANT ile Yetki Vermek


GRANT CREATE TABLE
TO XBankUser;


GRANT CREATE TABLE TO AppRole, XBankUser;


CREATE USER newXBankUser FOR LOGIN XBankLogin;


GRANT CREATE DATABASE, CREATE TABLE TO newXBankUser;



--	WITH GRANT OPTION ile Basamaklý Yetkilendirme



GRANT SELECT, INSERT ON XBank_Kullanicilar
TO AppRole
WITH GRANT OPTION;



--	DENY ile Eriþimi Kýsýtlamak


DENY CREATE TABLE TO XBankUser;


DENY SELECT ON XBank_Kullanicilar TO XBankUser;



--	REVOKE ile Eriþim Tanýmýný Kaldýrmak


REVOKE ALL TO PUBLIC


REVOKE SELECT ON XBank_Kullanicilar TO XBankUser;








