-----------------------------------DELETE 1--------------------------
----Arac IDsi 7 den kucuk olan seferlerin uyelerini sil
---Sefer bilet yolcu 
DELETE FROM Uyee WHERE Uyee.TcNo IN (SELECT TcNo FROM Uyee U INNER JOIN Bilet B ON B.UyeTcNo = U.TcNo INNER JOIN Sefer S ON 
S.SeferID = B.SeferID WHERE S.AracID < 7)


------------------------------------DELETE 2-------------------------
--sefer saati 5 saaten az olan 2016 yılından önce alınmış mercedes benz markalı araçları sil
---- Sefer araç üretici
DELETE FROM Arac WHERE Arac.AracID IN (SELECT AracID FROM Arac A INNER JOIN Uretici U
ON U.UreticiID = A.UreticiID INNER JOIN Sefer S ON 
S.AracID = A.AracID WHERE Arac.UreticiID = 1 AND S.BaşlangıcSaat-S.SonlanmaTarihi < 5 AND AlındıgıYıl < 2016)

------------------------------------DELETE 3 ------------------------
DELETE FROM Personel WHERE PersonelNo IN (
SELECT DISTINCT P.PersonelNo FROM Personel P INNER JOIN Bilet B ON 
P.PersonelNo = B.PersonelNo INNER JOIN Uyee U ON  U.TcNo = B.UyeTcNo INNER JOIN 
Unvan Un ON Un.UnvanNo=P.UnvanNo WHERE U.Cinsiyet='KIZ' AND B.Tarih='2018-03-08' AND Un.GorevTuru='Kasiyer')

------------------------------------DELETE 4 ------------------------
DELETE FROM Ilce WHERE Ilce.IlceNO IN (SELECT I.IlceNO FROM Ilce I INNER JOIN Uyee U ON I.IlceNO = U.IlceNO 
INNER JOIN Bilet B ON B.UyeTcNo = U.TcNo INNER JOIN Durak D ON D.DurakID = B.DurakID WHERE D.DurakAd='Esenler Otogar'
INTERSECT
SELECT I.IlceNO FROM Ilce I INNER JOIN Uyee U ON I.IlceNO = U.IlceNO 
INNER JOIN Bilet B ON B.UyeTcNo = U.TcNo INNER JOIN Durak D ON D.DurakID = B.DurakID WHERE U.TcNo LIKE '%7'
)

------------------------------------DELETE 5 ------------------------
DELETE FROM Peron WHERE PeronNo IN (SELECT P.PeronNo FROM Peron P INNER JOIN Bilet B 
ON B.PeronID = P.PeronId INNER JOIN BiletTuru Bt ON Bt.BiletTuruNo = B.BiletTuruNo 
WHERE Bt.Isim = 'Promo' AND B.Bagaj = '30kg' 
UNION
SELECT P.PeronNo FROM Peron P INNER JOIN Bilet B 
ON B.PeronID = P.PeronId INNER JOIN BiletTuru Bt ON Bt.BiletTuruNo = B.BiletTuruNo 
WHERE Bt.Isim = 'Öğrenci' AND B.Bagaj = '40kg' )

