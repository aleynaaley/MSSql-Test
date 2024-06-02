select * from USERS

SELECT
U.USERNAME_, U.NAMESURNAME, U.EMAIL, C.COUNTRY, CT.CITY ,T.TOWN , A.ADDRESSTEXT
FROM USERS U , ADDRESS A , COUNTRIES C , CITIES CT , TOWNS T
WHERE U.ID = A.USERID AND A.COUNTRYID = C.ID AND   A.CITYID = CT.ID AND A.TOWNID = T.ID 
ORDER BY 1,2,5

SELECT * FROM CITIES

--buradakiler geleneksel yöntem þuanda pek kullanýlmýyor , iliþkili veri tablolarýndan primary key ve foreign key arasýnda baðlantý kurarak(where þartýnda)
--ayný sorguda birden fazla iliþkili tablodan veri alabiliyoruz . alias da tablolarda kullandýk



--JOIN KULLANIMI

SELECT
U.USERNAME_, U.NAMESURNAME, U.EMAIL,  A.ADDRESSTEXT
FROM USERS U JOIN ADDRESS A  ON U.ID = A.USERID 
ORDER BY 1

--iki tablo arasýnda JOIN iliþikisini tanýmlarken de ON kullanýlýr . birden fazla her kullannýldýðýnda joýn eklenir

SELECT
U.USERNAME_, U.NAMESURNAME, U.EMAIL,  A.*
FROM USERS U JOIN ADDRESS A  ON U.ID = A.USERID 
ORDER BY 1

-- a.* ile a tablosundaki tüm kolonlarý seçmiþ olursun

SELECT
U.USERNAME_, U.NAMESURNAME, U.EMAIL, C.COUNTRY, CT.CITY ,T.TOWN , A.ADDRESSTEXT
FROM USERS U 
JOIN ADDRESS A ON U.ID = A.USERID
JOIN COUNTRIES C ON A.COUNTRYID = C.ID
JOIN CITIES CT ON   A.CITYID = CT.ID
JOIN TOWNS T ON A.TOWNID = T.ID 
ORDER BY 1,2,5

-- üsttekiyle ayný çýktýyý verir 



select * from ORDERS where ID = 1
select * from USERS where ýd = 7678
SELECT * FROM ADDRESS WHERE ID= 18770
SELECT * FROM ORDERDETAILS WHERE ORDERID = 1
SELECT * FROM ITEMS WHERE ID = 660


SELECT 
O.ID,O.USERID,U.NAMESURNAME,U.ID,O.DATE_,O.TOTALPRICE,OD.AMOUNT , OD.UNITPRICE,OD.LINETOTAL,
I.ITEMNAME,I.BRAND,I.CATEGORY1,I.UNITPRICE,A.ADDRESSTEXT
FROM ORDERS O
JOIN ORDERDETAILS OD ON O.ID = OD.ORDERID
JOIN ITEMS I ON I.ID = OD.ITEMID
JOIN USERS U ON U.ID = O.USERID
JOIN ADDRESS A ON A.ID = O.ADDRESSID
WHERE O.ID = 1



--INNER ,LEFT,RIGHT,FULL JOIN KULLANIMI

SELECT 
U.USERNAME_, A.CITYID , A.ADDRESSTEXT
FROM USERS U
INNER JOIN ADDRESS A ON A.USERID = U.ID 

--ýnner joýn joýn ile ayný þekilde çalýþýr . fark eden bir þey yok

SELECT 
U.USERNAME_, A.CITYID , A.ADDRESSTEXT
FROM USERS U
LEFT JOIN ADDRESS A ON A.USERID = U.ID 

--LEFT JOININ solunda kalan tabloda ki tüm verileri karþý tarafta null olsa dahi yazdýrýr. ortaklarý ve tekrar edeneleri de yazýrýr.

SELECT 
U.USERNAME_, A.CITYID , A.ADDRESSTEXT
FROM USERS U
RIGHT JOIN ADDRESS A ON A.USERID = U.ID 

--RIGHT JOININ saðýnda kalan tabloda ki tüm verileri karþý tarafta null olsa dahi yazdýrýr. ortaklarý ve tekrar edeneleri de yazýrýr.


SELECT 
U.USERNAME_, A.CITYID , A.ADDRESSTEXT
FROM USERS U
FULL JOIN ADDRESS A ON A.USERID = U.ID 

--FULL JOIN tekrar edenler dýþýnda iki taraftada karþýlýðý null olsa dahil yazdýrýr.




---örnekler

--þehirlere göre verilen sipariþleri toplam olarak büyükten küçüðe listeleme

SELECT 
C.CITY,SUM(O.TOTALPRICE)
FROM ORDERS O 
JOIN ADDRESS A ON A.ID = O.ADDRESSID
JOIN CITIES C ON C.ID = A.CITYID  
GROUP BY C.CITY
ORDER BY 2 DESC


--ürün kategorilerine göre sipariþ daðýlýmý

SELECT
I.CATEGORY1 ,I.CATEGORY2,SUM(OD.LINETOTAL) TOTALSALE
FROM ITEMS I
LEFT JOIN ORDERDETAILS OD ON OD.ITEMID = I.ID 
GROUP BY I.CATEGORY1 ,I.CATEGORY2
ORDER BY 1,SUM(OD.LINETOTAL)DESC
--hangi kategoriden toplamda ne kadarlýk saytýþ yapýlmýþ onun çýktýsýný verir



--müþterilere göre sipariþ daðýlýmý
SELECT TOP 50
U.ID,U.NAMESURNAME, SUM(O.TOTALPRICE) TOTALSALE, COUNT(O.ID) ORDERCOUNT
FROM USERS U 
JOIN ORDERS O ON O.USERID = U.ID
GROUP BY U.ID,U.NAMESURNAME
ORDER BY 3 DESC
--tutar olarak en çok sipariþ veren ilk 50 kullanýcý


--müþterinin cinsiyetine göre sipariþ daðýlýmý
SELECT 
U.GENDER, SUM(O.TOTALPRICE) TOTALSALE
FROM  ORDERS O
JOIN USERS U ON O.USERID = U.ID
GROUP BY U.GENDER
--Kadýn ve erkeklerin toplam yaptýðý alýþveriþ tutatlarýný gösterir

SELECT 
CASE
	WHEN U.GENDER = 'K' THEN 'KADIN'
	WHEN U.GENDER = 'E' THEN 'ERKEK'
END AS GENDER,
IIF(U.GENDER = 'K', 'KADIN','ERKEK') GENDER2,     --BU TÜM CASE ÝLE AYNI ÝÞLEVDE 
SUM(O.TOTALPRICE) TOTALSALE
FROM  ORDERS O
JOIN USERS U ON O.USERID = U.ID
GROUP BY U.GENDER

-- burada bir deðiþkenin case ile adýný deðiþtip sorgumuza ekledik eðer gender k ise kadýn e ise erkek yazacak




SELECT 
PAYMENTTYPE, SUM(PAYMENTTOTAL) TOTALSALE,
IIF(PAYMENTTYPE = 1, 'KREDÝ KARTI','NAKÝT') PAYTYPE
FROM PAYMENTS
GROUP BY PAYMENTTYPE


SELECT DATENAME(DW,O.DATE_) DAYNAME_,
C.CITY,
SUM(O.TOTALPRICE) TOTALPRICE
FROM ORDERS O
JOIN ADDRESS A ON A.ID= O.ADDRESSID
JOIN CITIES C ON C.ID = A.CITYID
GROUP BY 
C.CITY , DATEPART(DW,O.DATE_), DATENAME(DW,O.DATE_)
ORDER BY DATEPART(DW,O.DATE_),C.CITY


--þehirlerin haftanýn gününe göre sipariþ daðýlýmý


SELECT 
C.CITY, AVG(DATEDIFF(HOUR,O.DATE_,I.DATE_)) DURATION
FROM ORDERS O
JOIN INVOICES I ON O.ID = I.ORDERID
JOIN ADDRESS A ON A.ID = O.ADDRESSID
JOIN CITIES C ON C.ID= A.CITYID
GROUP BY C.CITY
ORDER BY 2 DESC

---Þipariþlerin ortlama kargolama sürelerini getiren select sorgusu


