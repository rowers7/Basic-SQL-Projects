--1)THY i�in 2018 y�l�nda en az doluluk oran�na(en az dolulu�a) sahip oldu�u ilk 3 ay da seyahat eden yolcular�n bilgileri
--Buradaki t�m biletler ayn� araca al�nd� ve onun kontejan� 350 bu y�zden oran da ayn� sonucu veriyor


SELECT Ad,SirketIsmi,Bilet.Tarih FROM Uyee
INNER JOIN Bilet ON Bilet.UyeTcNo = Uyee.TcNo
INNER JOIN Sirket ON Sirket.SirketNo = Bilet.SirketNo
WHERE bilet.Tarih>'2017-12-31' and bilet.Tarih<'2019-01-01' and SirketIsmi='T�rk Hava Yollar�' and MONTH(Bilet.Tarih) IN (
SELECT TOP 3 MONTH(Bilet.Tarih) AS 'Ay' FROM Bilet
INNER JOIN Sirket ON Sirket.SirketNo = Bilet.SirketNo
where bilet.Tarih>'2017-12-31' and bilet.Tarih<'2019-01-01' and SirketIsmi='T�rk Hava Yollar�'
GROUP BY MONTH(Bilet.Tarih)
ORDER BY COUNT(Bilet.KoltukNo)  ASC)





--2)Bu ay i�inde Pamukkale firmas�ndan hem  Ankara-istanbul hem de �zmir-�stanbul otob�s bileti alan yolcular�n tcno,ad,soyad,tel bilgileri
--(not:�nemli olan g�zergah ba�lang��-biti� noktalar� de�il biletin ba�lang��-biti� noktas�)


select uyee.TcNo,Uyee.Ad,Uyee.Soyad,Uyee.TelNo,SirketIsmi from Uyee
inner join Bilet on Bilet.UyeTcNo=Uyee.TcNo
inner join Sirket on Sirket.SirketNo=Bilet.SirketNO
inner join BiletinDurag� on BiletinDurag�.BiletID=Bilet.BiletID
where Sirket.SirketIsmi='Pamukkale' and BiletinDurag�.Kalk�sNoktasi='�zmir' and BiletinDurag�.Var�sNoktas�='�stanbul'  and  month(bilet.Tarih)=(select DATEPART(MONTH,GETDATE()))


intersect

select uyee.TcNo,Uyee.Ad,Uyee.Soyad,Uyee.TelNo,SirketIsmi from Uyee
inner join Bilet on Bilet.UyeTcNo=Uyee.TcNo
inner join Sirket on Sirket.SirketNo=Bilet.SirketNO
inner join BiletinDurag� on BiletinDurag�.BiletID=Bilet.BiletID
where Sirket.SirketIsmi='Pamukkale' and BiletinDurag�.Kalk�sNoktasi='Ankara' and BiletinDurag�.Var�sNoktas�='�stanbul' and  month(bilet.Tarih)=(select DATEPART(MONTH,GETDATE()))


-------B�Z�M SORGULARIMIZ----------------


-------------------------------select1----------------------

--G�n�m�ze en yak�n al�nm�� 3 bilet
SELECT  top 3 MIN(DATEDIFF(dd,Tarih,GETDATE())) as [Ka� G�n �nce Al�nd�?] ,BiletID,PeronNo FROM Bilet
INNER JOIN Peron ON Bilet.PeronID = Peron.PeronId  
GROUP BY PeronNo , BiletID order by [Ka� G�n �nce Al�nd�?] asc

-------------------------------select2----------------------
--En �ok bilet alan �yelerin ka� bilet ald��� ve isim soy ismi
SELECT top 3 COUNT(UyeTcNo) as [ka� bilet ald�],Uyee.Ad,Uyee.Soyad FROM uyee 
inner join Bilet on Bilet.UyeTcNo=Uyee.TcNo
INNER JOIN Personel ON  Bilet.PersonelNo = Personel.PersonelNo
INNER JOIN Il ON Personel.IlNO = Il.IlNO
WHERE UyeTcNo  NOT IN (SELECT Tarih FROM Bilet WHERE DATEDIFF(MONTH,Tarih,GETDATE()) >= DATEDIFF(MONTH,Tarih,GETDATE())+6 ) GROUP BY UyeTcNo,Uyee.Ad,Uyee.Soyad Order BY COUNT(UyeTcNo) DESC


-------------------------------select3-----------------------
---- Sube ad� 8 karakterden az olan �ube veya subelerdeki g�rev t�r� y�netici olanlar�n �ube ismi,personel isim soy isim ve g�revini  getir
SELECT S.SubeIsmi , P.�sim , P.SoyIsim,U.GorevTuru  FROM Sube S 
INNER JOIN Personel P ON S.SubeNo = P.SubeNo
INNER JOIN Unvan U ON U.UnvanNo = P.UnvanNo
WHERE LEN(SubeIsmi) < 8 AND U.GorevTuru = 'Y�netici'












