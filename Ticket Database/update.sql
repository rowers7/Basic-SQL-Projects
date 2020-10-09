------Update 1 -----
------Sube adı 5 ila 10 karakter arasında olan subelerden en cok bilet kesen personelin ünvanını satış danışmanı yap
UPDATE Unvan
SET Unvan.GorevTuru  = 'Satış danışmanı' 
FROM Unvan U
INNER JOIN Personel P ON U.UnvanNo = P.UnvanNo
INNER JOIN Sube S ON S.SubeNo = P.SubeNo 
WHERE LEN(s.SubeIsmi) BETWEEN 5 AND 10 
AND P.PersonelNo = (SELECT TOP(1)COUNT(PersonelNo)PersonelNO FROM Bilet GROUP BY PersonelNo )


----------Update2----------
--Bilet fiyatı 90 tlden fazla olan biletlerin toplam net ödemesi yüzde 10 arttırıldı. Net ödeme de fiyat ne kadar arttıysa bu indirim tutarına eklendi.

UPDATE Bilet 
SET ToplamIndirim = ToplamIndirim + ToplamNetOdeme%10 ,
	ToplamNetOdeme  = ToplamNetOdeme-ToplamNetOdeme%10 
    
FROM Bilet
WHERE CONVERT(int,ToplamNetOdeme) >= 90


-----Update 3 ----------
----23/02/2018 ve 08/08/2018 tarihleri arasındaki saytılan biletlerdeki telefon numarasının sonu 7 biten 
----musterilerin indirim oranını 5 arttır matematik kısmını kontrol etmek lazım
----
SELECT * FROM Uyee
SELECT * FROM Bilet
UPDATE Bilet 
Set ToplamIndirim = ToplamIndirim+5 ,
    ToplamNetOdeme= ToplamNetOdeme - ToplamNetOdeme%5
FROM Bilet B
INNER JOIN Uyee U ON U.TcNo = B.UyeTcNo
WHERE U.TelNo LIKE '%7' AND DATEPART(yy,B.Tarih) BETWEEN  2018 AND 2019

-----Update 4 ---------İsmine göre cinsiyeti yanlışlıkla Erkek girilen 2 kişinin cinsiyeti kız yapıldı 

UPDATE Uyee
Set Cinsiyet ='KIZ'
From Uyee
inner join Bilet on Bilet.UyeTcNo=Uyee.TcNo
where Uyee.Ad='Tutkum' or Uyee.Ad='Cansev'


-----Update 5 -------- Ak Turizm ve Ak Aksu Turizm birleşme kararı aldı ve yeni şubelerini Maraşta açtılar. İsimlerini Ede Turizm koydular

UPDATE Sirket
Set SirketIsmi ='EDE TURIZM'
From Sirket
inner join Sube on Sirket.SirketNo=Sube.SirketNO
where SirketIsmi='Ak Turizm' or SirketIsmi='Ak Aksu Turizm'  






