

create login yenilog with password = ''
go

use sales
go

create user yeniuser for login yenilog

create role kategori_okunmasin
go

deny select on categories to kategori_okunmasin

alter role db_datareader add member yeniuser
go

select * from tblkategori 
go

alter role kategori_okunmasin drop member yeniuser
go

drop role kategori_okunmasin
go

drop user yeniuser
go

drop login yenilog
go


declare @adsoyad varchar(50)
set @adsoyad = 'aleyna erkul'
print @adsoyad


--bir değişken tanımladıktan sonra go kullanılırsa ondan sonra o değişken terkar tanımlanmalı kullanılacaksa çünkü kullanım alanından çıkıyor 
declare @a int 
set @a = 42
go
select @a  -- bu kısım hata verir 


