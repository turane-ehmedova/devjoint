-- DevJoint Internship
-- Checkpoint 6
-- Topic:Query Optimization (Index və Correlated Subquery)
-- Database: Northwind

--Bu checkpointdə sorğuların performansını artırmaq üçün
--index istifadəsi və correlated subquery-nin JOIN ilə
--optimallaşdırılması göstərilir.

--Query 1: Orders cədvəlində CustomerID sütunu üçün index yaradaq.
--Index WHERE və JOIN əməliyyatlarının daha sürətli işləməsinə kömək edir.
--Index:
--CustomerID sütununda index yaratmaq WHERE və JOIN əməliyyatlarında
--axtarışın daha səmərəli aparılmasına kömək etmək üçün istifadə olunur.
--Index olmadıqda database uyğun məlumatı tapmaq üçün bütün cədvəli
--yoxlaya bilər(Full Table Scan).
--Index olduqda isə database index strukturundan istifadə edərək uyğun
--sətrləri daha tez tapır və bütün cədvəlin yoxlanmasına ehtiyac azalır.
--Bu üstünlük xüsusilə böyük cədvəllərdə daha aydın nəzərə çarpır.
--Bundan əlavə, index hər sorğuda mütləq istifadə olunmur.
--Query optimizer sorğunun və məlumatın vəziyyətindən asılı olaraq
--index-dən istifadə edib-etməməyə qərar verir.
CREATE INDEX IF NOT EXISTS idx_orders_customerid ON Orders(CustomerID);

--Query 2:Orders cədvəlindən CustomerID = 'ALFKI' olan sifarişləri göstərək.
--Bu sorğu CustomerID sütununda yaradılmış index-dən istifadə edərək
--məlumatı daha sürətli tapa bilər.
SELECT * FROM Orders
WHERE CustomerID = 'ALFKI';

--Query 3:Bu yoxlama sorğusudur. Yaratdığımız index-lərin bazada olub-olmadığını göstərir.
SELECT name FROM sqlite_master
WHERE type = 'index';

--Query 4:Products cədvəlindən məhsulun adını və aid olduğu
--kateqoriyanın adını Correlated Subquery istifadə edərək göstərək.
SELECT ProductName,
(SELECT CategoryName FROM Categories
WHERE Categories.CategoryID = Products.CategoryID) AS CategoryName
FROM Products;

--Query 5:Query 4-dəki sorğunu INNER JOIN istifadə edərək
--daha səmərəli şəkildə yazaq.
SELECT Products.ProductName, Categories.CategoryName
FROM Products INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID;

--Query 6:Customers cədvəlindən şirkət adını və sifariş sayını
--Correlated Subquery istifadə edərək göstərək.
SELECT CompanyName,
(SELECT COUNT(*) FROM Orders
WHERE Orders.CustomerID = Customers.CustomerID) AS TotalOrders
FROM Customers;

--Query 7:Query 6-dakı sorğunu INNER JOIN istifadə edərək optimallaşdıraq.
--Qeyd: Əvvəl INNER JOIN istifadə etmişdim lakin bu sifarişi olanları və onların sayını göstərirdi. 
--Bunu aradan qaldırmaq üçün biz LEFT JOİN-dən istifadə etməliyik ki,sifariş etməyənləridə görmək mümkün olsun.
SELECT Customers.CompanyName,
COUNT(Orders.OrderID) AS TotalOrders
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CompanyName;
--Qeyd:Yenilənmiş versiyası aşağıdakıdır:
--Query 7:
SELECT Customers.CompanyName, COUNT(Orders.OrderID) AS TotalOrders
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CompanyName;


--Query 8:Products cədvəlindən məhsulun adını və qiymətini göstərək.
--Orta qiymətdən yüksək olan məhsulları Subquery istifadə edərək seçək.
SELECT ProductName, UnitPrice FROM Products
WHERE UnitPrice >
(SELECT AVG(UnitPrice) FROM Products);

--Query 9:Əvvəl yaratdığımız index-i silək.
DROP INDEX idx_orders_customerid;
