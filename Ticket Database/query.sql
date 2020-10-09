--1)THY için 2018 yýlýnda en az doluluk oranýna(en az doluluða) sahip olduðu ilk 3 ay da seyahat eden yolcularýn bilgileri
--Buradaki tüm biletler ayný araca alýndý ve onun kontejaný 350 bu yüzden oran da ayný sonucu veriyor


SELECT Ad,SirketIsmi,Bilet.Tarih FROM Uyee
INNER JOIN Bilet ON Bilet.UyeTcNo = Uyee.TcNo
INNER JOIN Sirket ON Sirket.SirketNo = Bilet.SirketNo
WHERE bilet.Tarih>'2017-12-31' and bilet.Tarih<'2019-01-01' and SirketIsmi='Türk Hava Yollarý' and MONTH(Bilet.Tarih) IN (
SELECT TOP 3 MONTH(Bilet.Tarih) AS 'Ay' FROM Bilet
INNER JOIN Sirket ON Sirket.SirketNo = Bilet.SirketNo
where bilet.Tarih>'2017-12-31' and bilet.Tarih<'2019-01-01' and SirketIsmi='Türk Hava Yollarý'
GROUP BY MONTH(Bilet.Tarih)
ORDER BY COUNT(Bilet.KoltukNo)  ASC)





--2)Bu ay içinde Pamukkale firmasýndan hem  Ankara-istanbul hem de Ýzmir-Ýstanbul otobüs bileti alan yolcularýn tcno,ad,soyad,tel bilgileri
--(not:önemli olan güzergah baþlangýç-bitiþ noktalarý deðil biletin baþlangýç-bitiþ noktasý)


select uyee.TcNo,Uyee.Ad,Uyee.Soyad,Uyee.TelNo,SirketIsmi from Uyee
inner join Bilet on Bilet.UyeTcNo=Uyee.TcNo
inner join Sirket on Sirket.SirketNo=Bilet.SirketNO
inner join BiletinDuragý on BiletinDuragý.BiletID=Bilet.BiletID
where Sirket.SirketIsmi='Pamukkale' and BiletinDuragý.KalkýsNoktasi='Ýzmir' and BiletinDuragý.VarýsNoktasý='Ýstanbul'  and  month(bilet.Tarih)=(select DATEPART(MONTH,GETDATE()))


intersect

select uyee.TcNo,Uyee.Ad,Uyee.Soyad,Uyee.TelNo,SirketIsmi from Uyee
inner join Bilet on Bilet.UyeTcNo=Uyee.TcNo
inner join Sirket on Sirket.SirketNo=Bilet.SirketNO
inner join BiletinDuragý on BiletinDuragý.BiletID=Bilet.BiletID
where Sirket.SirketIsmi='Pamukkale' and BiletinDuragý.KalkýsNoktasi='Ankara' and BiletinDuragý.VarýsNoktasý='Ýstanbul' and  month(bilet.Tarih)=(select DATEPART(MONTH,GETDATE()))


-------BÝZÝM SORGULARIMIZ----------------


-------------------------------select1----------------------

--Günümüze en yakýn alýnmýþ 3 bilet
SELECT  top 3 MIN(DATEDIFF(dd,Tarih,GETDATE())) as [Kaç Gün Önce Alýndý?] ,BiletID,PeronNo FROM Bilet
INNER JOIN Peron ON Bilet.PeronID = Peron.PeronId  
GROUP BY PeronNo , BiletID order by [Kaç Gün Önce Alýndý?] asc

-------------------------------select2----------------------
--En çok bilet alan üyelerin kaç bilet aldýðý ve isim soy ismi
SELECT top 3 COUNT(UyeTcNo) as [kaç bilet aldý],Uyee.Ad,Uyee.Soyad FROM uyee 
inner join Bilet on Bilet.UyeTcNo=Uyee.TcNo
INNER JOIN Personel ON  Bilet.PersonelNo = Personel.PersonelNo
INNER JOIN Il ON Personel.IlNO = Il.IlNO
WHERE UyeTcNo  NOT IN (SELECT Tarih FROM Bilet WHERE DATEDIFF(MONTH,Tarih,GETDATE()) >= DATEDIFF(MONTH,Tarih,GETDATE())+6 ) GROUP BY UyeTcNo,Uyee.Ad,Uyee.Soyad Order BY COUNT(UyeTcNo) DESC


-------------------------------select3-----------------------
---- Sube adý 8 karakterden az olan þube veya subelerdeki görev türü yönetici olanlarýn þube ismi,personel isim soy isim ve görevini  getir
SELECT S.SubeIsmi , P.Ýsim , P.SoyIsim,U.GorevTuru  FROM Sube S 
INNER JOIN Personel P ON S.SubeNo = P.SubeNo
INNER JOIN Unvan U ON U.UnvanNo = P.UnvanNo
WHERE LEN(SubeIsmi) < 8 AND U.GorevTuru = 'Yönetici'












