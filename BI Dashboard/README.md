**Week 3–BI Dashboard(Power BI)**
**Checkpoint 1–Data Import və Data Modelləşdirmə**
DATA IMPORT: Power BI Desktop-da 7 CSV faylı Get Data → Text/CSV vasitəsilə import olundu:
- FactSales(satış əməliyyatları)
- FactSalesTarget(satış hədəfləri)
- DimCustomer(müştəri məlumatı)
- DimEmployee(işçi məlumatı)
- DimGeography(coğrafi məlumat)
- DimProduct(məhsul məlumatı)
- DimDate2(tarix kalendarı)

DATA MODELLƏŞDİRMƏ(ƏLAQƏLƏR): Data star schema (ulduz sxemi) prinsipi ilə modelləşdirildi. Model view-da aşağıdakı əlaqələr quruldu(hamısı Many-to-One):
1. FactSales.CustomerKey -> DimCustomer.CustomerKey(Active)
2. FactSales.ProductKey -> DimProduct.ProductKey(Active)
3. FactSales.OrderDateKey -> DimDate2.DateKey(Active)
4. FactSales.EmployeeKey -> DimEmployee.EmployeeKey(Inactive)
5. FactSales.GeographyKey -> DimGeography.GeographyKey(Inactive)
6. FactSalesTarget.Category -> DimProduct.Category(Active)
7. DimCustomer.GeographyKey -> DimGeography.GeographyKey(Active)
8. DimEmployee.GeographyKey -> DimGeography.GeographyKey(Active)

NƏTİCƏ: Bütün 7 cədvəl bir-biri ilə əlaqələndirildi və data model dashboard qurmaq üçün tam hazır vəziyyətə gətirildi. Fact cədvəllər (əməliyyat datası) müvafiq Dim cədvəllərə (təsviri məlumat) açar sütunlar vasitəsilə bağlandı.

İSTİFADƏ OLUNAN ALƏT VƏ TEXNOLOGİYA:
-Alət: Power BI Desktop
-Data Source: CSV faylları(Local file import)
