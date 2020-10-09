IF DB_ID('Onlinebilet') IS NOT NULL
	BEGIN 
		ALTER DATABASE Onlinebilet SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		USE master
		DROP DATABASE Onlinebilet
	END
GO


 CREATE DATABASE Onlinebilet;

GO 

USE OnlineBilet;

CREATE TABLE Il (
	IlNO INT PRIMARY KEY,
	İlAdı VARCHAR(20) 

)

GO
CREATE TABLE Ilce (
	IlceNO INT PRIMARY KEY,
	İlceAdı VARCHAR(20) ,
	IlNO INT,
	CONSTRAINT FK_IlNO FOREIGN KEY(IlNO) REFERENCES Il(IlNO)
)

GO
CREATE TABLE Kampanya(
	KampanyaIsmi VARCHAR(20)  PRIMARY KEY,
	KampanyaOran VARCHAR(20) ,
	
	
)

	GO

CREATE TABLE Unvan (
	UnvanNo VARCHAR(20) PRIMARY KEY,
	GorevTuru VARCHAR(20)
	
)
GO

CREATE TABLE Sirket (
	SirketNo INT PRIMARY KEY,
	SirketIsmi VARCHAR(50),
	VergiNo varchar(50)

)



GO



GO
CREATE TABLE Uyee(
	TcNo varchar(20) PRIMARY KEY,
	Ad VARCHAR (20),
	Soyad VARCHAR (20),
	Cinsiyet VARCHAR (6),
	TelNo VARCHAR(20) ,
	Mail VARCHAR(30),
	Adres VARCHAR(20) ,
	IlNO INT,
	IlceNO INT,
	CONSTRAINT FK_IlNO1 FOREIGN KEY(IlNO) REFERENCES Il(IlNO),
	CONSTRAINT FK_IlceNO1 FOREIGN KEY(IlceNO) REFERENCES Ilce(IlceNO)
	

)

GO

CREATE TABLE Güzergah (
	GüzergahID INT PRIMARY KEY,
	GüzergahAdı VARCHAR(20) 

)


GO
CREATE TABLE Durak (
	DurakID INT PRIMARY KEY,
	DurakAd VARCHAR(20)  ,
	IlNO INT,
	IlceNO INT,
	CONSTRAINT FK_IlNO2 FOREIGN KEY (IlNO) REFERENCES Il(IlNO),
	CONSTRAINT FK_IlceNO2 FOREIGN KEY (IlceNO) REFERENCES Ilce(IlceNO)
)


GO


GO

CREATE TABLE Peron(
	PeronId INT PRIMARY KEY,
	PeronNo INT,
	DurakID INT,
	CONSTRAINT FK_DurakID FOREIGN KEY(DurakID) REFERENCES Durak(DurakID)
	)
	










	--Muharrem---






CREATE TABLE GüzergahDurak(
	SıraNO  INT PRIMARY KEY ,
	DurakID INT ,
	GüzergahID INT ,
	CONSTRAINT FK_GüzergahID FOREIGN KEY (GüzergahID) REFERENCES Güzergah(GüzergahID),
	CONSTRAINT FK_DurakID2 FOREIGN KEY (DurakID) REFERENCES Durak(DurakID)

	
)


GO

CREATE TABLE Uretici (
	UreticiID INT PRIMARY KEY,
	UreticiAd VARCHAR(20)  

)
GO

CREATE TABLE AraçTipi (
	AraçTipNo INT PRIMARY KEY,
	Tip VARCHAR(20) 
)


CREATE TABLE Model (
	ModelID INT PRIMARY KEY,
	ModelAD VARCHAR(20) ,
	AraçTipNo INT,
	CONSTRAINT FK_AraçTipNo FOREIGN KEY (AraçTipNo) REFERENCES AraçTipi(AraçTipNo)
)


GO





CREATE TABLE Arac (
	AracID INT PRIMARY KEY ,
	Kapasite INT,
	Plaka VARCHAR(20) ,
	AlındıgıYıl Int,
	AktifPasifDurumu INT,
	UreticiID INT,
	ModelID INT,
	
	CONSTRAINT FK_UreticiID FOREIGN KEY (UreticiID) REFERENCES Uretici(UreticiID),
	CONSTRAINT FK_ModelID FOREIGN KEY (ModelID) REFERENCES Model(ModelID)
)



	GO


CREATE TABLE Sefer(
	SeferID INT PRIMARY KEY,
	BaşlangıcSaat TIME,
	SonlanmaTarihi TIME,
	AracID INT,
	CONSTRAINT FK_AracID FOREIGN KEY(AracID) REFERENCES Arac(AracID)

	
)


GO

CREATE TABLE SEFERDURAK(
	PlanlanKalkısSaati TIME,
	GerceklesenKalkısSaati TIME,
	DuragaGirisSaati TIME,
	DurakID INT,
	SeferID INT,
	CONSTRAINT PK_BiletinDuragı PRIMARY KEY NONCLUSTERED (SeferID, DurakID),
	CONSTRAINT FK_DurakID3 FOREIGN KEY(DurakID) REFERENCES Durak(DurakID),
	CONSTRAINT FK_SeferID FOREIGN KEY(SeferID) REFERENCES Sefer(SeferID)
)











---Saygın---








GO

CREATE TABLE Sube (
	SubeNo INT PRIMARY KEY,
	SubeIsmi VARCHAR(20) ,
	AcıkAdres VARCHAR(20) ,
    SirketNO INT,
	IlNo INT,
	IlceNO INT,
	CONSTRAINT FK_SirketNO FOREIGN KEY (SirketNO) REFERENCES Sirket(SirketNO),
	CONSTRAINT FK_IlNO4 FOREIGN KEY (IlNO) REFERENCES Il(IlNO),
	CONSTRAINT FK_IlceNO4 FOREIGN KEY (IlceNO) REFERENCES Ilce(IlceNO)
)

GO



GO


CREATE TABLE Personel(
	PersonelNo INT PRIMARY KEY,
	İsim VARCHAR(20),
	SoyIsim VARCHAR(20),
	TelNo VARCHAR(20),
	Adres VARCHAR(50),
	Mail VARCHAR(25),
	UnvanNo VARCHAR(20),
	SubeNo INT ,
	IlNO INT,
	IlceNO INT,
	CONSTRAINT FK_IlNO3 FOREIGN KEY (IlNO) REFERENCES Il(IlNO),
	CONSTRAINT FK_IlceNO3 FOREIGN KEY (IlceNO) REFERENCES Ilce(IlceNO),
	CONSTRAINT FK_UnvanNo FOREIGN KEY(UnvanNo) REFERENCES Unvan(UnvanNo),
	CONSTRAINT FK_SubeNo FOREIGN KEY(SubeNo) REFERENCES Sube(SubeNo)
)


GO 

CREATE TABLE BiletTuru(
	BiletTuruNo int PRIMARY KEY,
	Isim VARCHAR(20)  ,
	Oran varchar(20)
	)



GO
CREATE TABLE Bilet(
    BiletID INT PRIMARY KEY,
	KoltukNo INT ,
	Tarih DATE,
	Saat TIME,
	DurumKodu VARCHAR(20) ,
	OdemeTuru int,
	ToplamIndirim INT,
	ToplamNetOdeme INT,
	CheckInDurumu INT,
	CheckInNo INT,
	CheckInTarihi DATE,
	Bagaj VARCHAR(20) ,
	KampanyaIsmi VARCHAR(20) ,
	UyeTcNo VARCHAR(20),
	BiletTuruNo int,
	PeronID INT,
	PersonelNo INT,
	DurakID INT,
	SeferID INT,
	SirketNO INT,
	CONSTRAINT FK_DurakID4 FOREIGN KEY(DurakID) REFERENCES Durak(DurakID),
	CONSTRAINT FK_KampanyaIsmi FOREIGN KEY(KampanyaIsmi) REFERENCES Kampanya(KampanyaIsmi),
	CONSTRAINT FK_UyeID1 FOREIGN KEY(UyeTcNo) REFERENCES Uyee(TcNo),
	CONSTRAINT FK_BiletTuru FOREIGN KEY(BiletTuruNo) REFERENCES BiletTuru(BiletTuruNo),
	CONSTRAINT FK_PeronID FOREIGN KEY(PeronID) REFERENCES Peron(PeronId),
	CONSTRAINT FK_PersonelNo FOREIGN KEY(PersonelNo) REFERENCES Personel(PersonelNo),	
	CONSTRAINT FK_SeferID1 FOREIGN KEY(SeferID) REFERENCES Sefer(SeferID),	
	CONSTRAINT FK_SirketNo1 FOREIGN KEY(SirketNo) REFERENCES Sirket(SirketNO)		

)
GO
CREATE TABLE BiletinDuragı(
	KalkısNoktasi VARCHAR(30),
	VarısNoktası VARCHAR(30),
	BiletID INT,
	DurakID INT,
	CONSTRAINT PK_BiletinDuragı1 PRIMARY KEY NONCLUSTERED (BiletID, DurakID),
	CONSTRAINT BiletID FOREIGN KEY (BiletID) REFERENCES Bilet(BiletID),
	CONSTRAINT DurakID FOREIGN KEY (DurakID) REFERENCES Durak(DurakID)
)

GO


/*
CREATE TABLE KampanyaOran(
	Oran INT ,
	BiletID INT,
	KampanyaIsmi VARCHAR,
	CONSTRAINT PK_KampanyaOran PRIMARY KEY NONCLUSTERED (BiletID, KampanyaIsmi),
	CONSTRAINT BiletID1 FOREIGN KEY (BiletID) REFERENCES Bilet(BiletID),
	CONSTRAINT KampanyaIsmi FOREIGN KEY (KampanyaIsmi) REFERENCES Kampanya(KampanyaIsmi)
)
GO


*/
	