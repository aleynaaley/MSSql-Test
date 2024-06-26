select COUNT (*) COUNTDEĞERİ, SUM (TOTALPRICE) SUMDEĞERİ, AVG(AMOUNT),AVG(TOTALPRICE)
from SALES
where CITY = 'BAYBURT' 

-- BAYBURT ŞEHRİİ FİLTRELEYİP  TÜM SATIRLARI SAYIP BİR KOLONDA DEĞERİNİ VERİYOR , SUM DA TOTALPRİCE LARI TOPLATIP BAŞKA BİR KOLONDA YAZIYOR AVG DE ORTLAMAYI 
--ALIYOR. YANINDAKİ COUNTDEĞERİ GİBİ İSİMLER KOLONLARIN BANA ÇIKTI OLARAK VERDİĞİ TABLONUN KOLONUNUN ADI OLUYOR . BAŞINA 'AS ' DE GETİREBİLİRSİN

select COUNT (*) AS COUNTDEĞERİ, SUM (TOTALPRICE) SUMDEĞERİ, AVG(AMOUNT),AVG(TOTALPRICE)
from SALES
where CITY = 'BAYBURT' 

--AS EKLENMİŞ HALİ


SELECT *,
       (SELECT SUM(TOTALPRICE) FROM SALES) AS count_değeri
FROM SALES;

-- BURADA TÜM ÇIKTILARIN TOTAL PRİCE LARI TOPLAYIP ORJİNAL TABLODADA COUNTDEĞERİ DİYE KOLON AÇIP ONA YAZIYOR -TÜM DEĞERLER AYNI-



--ÇIKTIDAKİ TABLOLARDA KOLON ADINI DEĞİŞTİREBİLİRSİN 
SELECT 
CITY CITYNAME, FICHENO FISHENUMBER
FROM SALES
ORDER BY CITY 


SELECT 
CITY,DISTRICT,
COUNT(*) SATIRSAYISI, SUM(TOTALPRICE) TOPLAMCIRO, MAX(TOTALPRICE) ENYUKSEKFIYAT, MIN (TOTALPRICE) ENDUSUKFIYAT 
FROM SALES
--WHERE CITY IN ('İSTANBUL', 'BAYBURT')
GROUP BY CITY ,DISTRICT
ORDER BY CITY , DISTRICT

-- İSTANBUL VE BAYBURTU GRUP YAPIYOR İKİSİNİN DE KENDİ İÇİNDE İSTANBULUN SATIR SAYISI CE TOPLAM CİR ALTINDA DA DİĞER SATIR BAYBURT SATIR VE TOPLAM CİRO VERİR.
--WHERE ŞARTI KALKSA TÜM ŞEHİRLER İÇİN YAPAR








--ALIŞTIRMALAR


--Bir mağazanın günlük bazlı satış rakamını getirme
SELECT 
CONVERT(DATE, DATE_) AS DATE__, SUM (TOTALPRICE) TOTALSALE
FROM SALES
WHERE CITY = 'İSTANBUL'

GROUP BY CONVERT (DATE,DATE_)
ORDER BY 1--CONVERT (DATE,DATE_) , DATE__

--DATE_ değerinde saat de olduğu için sadece date e çevirdik CONVERT ile gruplamayı da yeni date e göre yaptık.
-- DATE__ YENİ OLUŞAN GROUP BY da çalışmaz ama order by da çalışır



SELECT 
CITY , SUM (TOTALPRICE) TOTALPRICE_,COUNT(*) TOTALSALE
FROM SALES
WHERE CONVERT(DATE,DATE_) = '2019-04-22'
--WHERE DATE_ BETWEEN '2019-04-22 00:00:00' AND '2019-04-22 23:59:59'

GROUP BY CITY
ORDER BY TOTALSALE DESC--1--CITY,

--burada herhangi bir günde tüm mağazzzalarda ne kadar ürün satılmış ve ne kadar tutmuş onu getiren kod





--belirli bir cironun üzerinde olan mağazaları getirme
SELECT 
CITY, SUM(TOTALPRICE) TOTALSALE
FROM SALES
HAVING SUM(TOTALPRICE) >  100000
GROUP BY CITY 
ORDER BY 2 DESC

--HAVING where şartıyla aynı çalışır ama where şartında agg. func. kullanamzsın bu yüzden having kullanılır


--mağazanın aylara göre satılarını getiren sorgu

SET language turkish
SELECT 
CITY, SUM(TOTALPRICE) TOTALSALE,
DATENAME(MONTH,DATE_) MONTHNAME_,
DATEPART(MONTH,DATE_) MONTHNUM
FROM SALES
GROUP BY CITY, DATENAME(MONTH,DATE_) MONTHNAME_,DATEPART(MONTH,DATE_) MONTHNUM
ORDER BY 1,2

-- burada DATANAME () fonksiyonu belirtilen şekilde tarihleri filtreler ve adını döndürür ingilizce, DATEPART() ise belirtilen şekilde tarihi filtreler ama 
--sayı döndürün (1-12 ay gibi) , türkçe yazdırması için set language kullanılır.



--her ürün için kaç adet satıldı, tl olarak ne kadara satıldı, ilk ne zaman son ne zaman satıldı, en düşük fiyat ve en yüksek fiyatı ortalama hangi fiyattan satıldı 
--bunaları içeren sql sorgusu

SELECT 
ITEMCODE, ITEMNAME, BRAND , CATEGORY1, CATEGORY2,SUM(AMOUNT) TOTALAMOUNT ,SUM(TOTALPRICE) TOTALSALE,
MIN(DATE_) FIRSTDATE, MAX(DATE_) LASTDATE,
MIN(PRICE) MINPRICE, MAX(PRICE) MAXPRICE, AVG(PRICE) AVGPRICE
FROM SALES
GROUP BY ITEMCODE, ITEMNAME, BRAND , CATEGORY1, CATEGORY2



--mağazaların müşteri sayılarını gösterme
SELECT
CITY, COUNT(DISTINCT CUSTOMERCODE)
FROM SALES
GROUP BY CITY


