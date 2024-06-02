select * from USERS

SELECT
U.USERNAME_, U.NAMESURNAME, U.EMAIL, C.COUNTRY, CT.CITY ,T.TOWN , A.ADDRESSTEXT
FROM USERS U , ADDRESS A , COUNTRIES C , CITIES CT , TOWNS T
WHERE U.ID = A.USERID AND A.COUNTRYID = C.ID AND   A.CITYID = CT.ID AND A.TOWNID = T.ID 
ORDER BY 1,2,5

SELECT * FROM CITIES

--buradakiler geleneksel y�ntem �uanda pek kullan�lm�yor , ili�kili veri tablolar�ndan primary key ve foreign key aras�nda ba�lant� kurarak(where �art�nda)
--ayn� sorguda birden fazla ili�kili tablodan veri alabiliyoruz . alias da tablolarda kulland�k



--JOIN KULLANIMI

SELECT
U.USERNAME_, U.NAMESURNAME, U.EMAIL,  A.ADDRESSTEXT
FROM USERS U JOIN ADDRESS A  ON U.ID = A.USERID 
ORDER BY 1

--iki tablo aras�nda JOIN ili�ikisini tan�mlarken de ON kullan�l�r . birden fazla her kullann�ld���nda jo�n eklenir

SELECT
U.USERNAME_, U.NAMESURNAME, U.EMAIL,  A.*
FROM USERS U JOIN ADDRESS A  ON U.ID = A.USERID 
ORDER BY 1

-- a.* ile a tablosundaki t�m kolonlar� se�mi� olursun

SELECT
U.USERNAME_, U.NAMESURNAME, U.EMAIL, C.COUNTRY, CT.CITY ,T.TOWN , A.ADDRESSTEXT
FROM USERS U 
JOIN ADDRESS A ON U.ID = A.USERID
JOIN COUNTRIES C ON A.COUNTRYID = C.ID
JOIN CITIES CT ON   A.CITYID = CT.ID
JOIN TOWNS T ON A.TOWNID = T.ID 
ORDER BY 1,2,5

-- �sttekiyle ayn� ��kt�y� verir 



select * from ORDERS where ID = 1
select * from USERS where �d = 7678
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

--�nner jo�n jo�n ile ayn� �ekilde �al���r . fark eden bir �ey yok

SELECT 
U.USERNAME_, A.CITYID , A.ADDRESSTEXT
FROM USERS U
LEFT JOIN ADDRESS A ON A.USERID = U.ID 

--LEFT JOININ solunda kalan tabloda ki t�m verileri kar�� tarafta null olsa dahi yazd�r�r. ortaklar� ve tekrar edeneleri de yaz�r�r.

SELECT 
U.USERNAME_, A.CITYID , A.ADDRESSTEXT
FROM USERS U
RIGHT JOIN ADDRESS A ON A.USERID = U.ID 

--RIGHT JOININ sa��nda kalan tabloda ki t�m verileri kar�� tarafta null olsa dahi yazd�r�r. ortaklar� ve tekrar edeneleri de yaz�r�r.


SELECT 
U.USERNAME_, A.CITYID , A.ADDRESSTEXT
FROM USERS U
FULL JOIN ADDRESS A ON A.USERID = U.ID 

--FULL JOIN tekrar edenler d���nda iki taraftada kar��l��� null olsa dahil yazd�r�r.




---�rnekler

--�ehirlere g�re verilen sipari�leri toplam olarak b�y�kten k����e listeleme

SELECT 
C.CITY,SUM(O.TOTALPRICE)
FROM ORDERS O 
JOIN ADDRESS A ON A.ID = O.ADDRESSID
JOIN CITIES C ON C.ID = A.CITYID  
GROUP BY C.CITY
ORDER BY 2 DESC


--�r�n kategorilerine g�re sipari� da��l�m�

SELECT
I.CATEGORY1 ,I.CATEGORY2,SUM(OD.LINETOTAL) TOTALSALE
FROM ITEMS I
LEFT JOIN ORDERDETAILS OD ON OD.ITEMID = I.ID 
GROUP BY I.CATEGORY1 ,I.CATEGORY2
ORDER BY 1,SUM(OD.LINETOTAL)DESC
--hangi kategoriden toplamda ne kadarl�k sayt�� yap�lm�� onun ��kt�s�n� verir



--m��terilere g�re sipari� da��l�m�
SELECT TOP 50
U.ID,U.NAMESURNAME, SUM(O.TOTALPRICE) TOTALSALE, COUNT(O.ID) ORDERCOUNT
FROM USERS U 
JOIN ORDERS O ON O.USERID = U.ID
GROUP BY U.ID,U.NAMESURNAME
ORDER BY 3 DESC
--tutar olarak en �ok sipari� veren ilk 50 kullan�c�


--m��terinin cinsiyetine g�re sipari� da��l�m�
SELECT 
U.GENDER, SUM(O.TOTALPRICE) TOTALSALE
FROM  ORDERS O
JOIN USERS U ON O.USERID = U.ID
GROUP BY U.GENDER
--Kad�n ve erkeklerin toplam yapt��� al��veri� tutatlar�n� g�sterir

SELECT 
CASE
	WHEN U.GENDER = 'K' THEN 'KADIN'
	WHEN U.GENDER = 'E' THEN 'ERKEK'
END AS GENDER,
IIF(U.GENDER = 'K', 'KADIN','ERKEK') GENDER2,     --BU T�M CASE �LE AYNI ��LEVDE 
SUM(O.TOTALPRICE) TOTALSALE
FROM  ORDERS O
JOIN USERS U ON O.USERID = U.ID
GROUP BY U.GENDER

-- burada bir de�i�kenin case ile ad�n� de�i�tip sorgumuza ekledik e�er gender k ise kad�n e ise erkek yazacak




SELECT 
PAYMENTTYPE, SUM(PAYMENTTOTAL) TOTALSALE,
IIF(PAYMENTTYPE = 1, 'KRED� KARTI','NAK�T') PAYTYPE
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


--�ehirlerin haftan�n g�n�ne g�re sipari� da��l�m�


SELECT 
C.CITY, AVG(DATEDIFF(HOUR,O.DATE_,I.DATE_)) DURATION
FROM ORDERS O
JOIN INVOICES I ON O.ID = I.ORDERID
JOIN ADDRESS A ON A.ID = O.ADDRESSID
JOIN CITIES C ON C.ID= A.CITYID
GROUP BY C.CITY
ORDER BY 2 DESC

---�ipari�lerin ortlama kargolama s�relerini getiren select sorgusu


