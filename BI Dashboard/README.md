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

**Checkpoint 2: Dataya uyğun seçilmiş 4+ fərqli qrafik tipi**
İşçi Masasının (Dashboard) strukturu biznes analitikası standartlarına uyğun olaraq "Tək Səhifəlik İcraçı Paneli" (Single-Page Executive Dashboard) formasında tərtib olunmuşdur. Bütün vizual seçimləri məqsədlidir və müəyyən analitik suallara cavab verir:
1. Card Visuals(Əsas İcraçı Metrikaları — KPI)
• Seçim Məntiqi: Rəhbərliyin ilk baxışda biznesin ümumi sağlamlığını dəyərləndirməsi üçün ən kritik rəqəmlər yuxarı hissəyə yerləşdirilmişdir.
• İzah etdiyi məsələ: 
  - Sum of SalesAmount(70.64M): Ümumi gəlir həcmi.
  - Sum of Profit(25.12M): Şirkətin xalis mənfəəti.
  - Sum of Quantity(300K): Satılmış ümumi məhsul sayı.
2. Line Chart—"Sum of SalesAmount by Month"(Zaman Analizi)
• Seçim Məntiqi: Datanın zaman oxu (time-series) üzrə dəyişimini və mövsümiliyi(seasonality) göstərmək üçün ən effektiv vizual xətti qrafikdir.
• İzah etdiyi məsələ: Satışların aylar üzrə qalxıb-enmə dinamikasını və pik dövrlərini izləməyə imkan verir.
3. Clustered Column Chart—"Sum of SalesAmount by Category"(Müqayisəli Performans)
• Seçim Məntiqi: Diskret kateqoriyaların gəlir baxımından sıralanması və bir-biri ilə müqayisəsi üçün sütunlu qrafik seçilmişdir.
• İzah etdiyi məsələ: Məhsul portfelində top-satılan (Clothing, Accessories) və nisbətən zəif satılan kateqoriyaları aşkar etməyə xidmət edir.
4. Clustered Column Chart—"Sum of TotalCost by Year"(Maliyyə Yükü Analizi)
• Seçim Məntiqi: İllər üzrə əməliyyat xərclərinin artım/azalma sürətini tək-tək müqayisə etmək üçün tətbiq olunmuşdur.
• İzah etdiyi məsələ: 2018–2024-cü illər ərzində xərclərin sabitləşdiyini və ya dəyişdiyini illik kəsikdə göstərir.
5. Map Visual—"Sum of SalesAmount by Country"(Coğrafi Paylanma)
• Seçim Məntiqi: Regional göstəriciləri xəritə üzərində dairələrin ölçüsü ilə göstərmək məkan analizini (spatial analysis) asanlaşdırır.
• İzah etdiyi məsələ: Qlobal bazarda satışın hansı ölkələrdə (məs. Misir, Almaniya, Hindistan) daha sıx cəmləndiyini vizuallaşdırır.
6. Donut Chart—"Count of Channel by PaymentMethod"(Struktur Payı)
• Seçim Məntiqi: Bütövün hissələrə bölünməsini(Proportion / Part-to-whole) faizlə göstərmək üçün daxili boşluqlu dairəvi qrafik seçilmişdir.
• İzah etdiyi məsələ: Müştərilərin ödəniş kanallarına(Bank Transfer, Cash, PayPal, Credit Card) olan üstünlük nisbətlərini göstərir.
7. Matrix Table—"Country vs SalesAmount & Profit"(Dəqiq Və İyerarxik Təhlil)
• Seçim Məntiqi: Vizual qrafiklərdən fərqli olaraq, dəqiq rəqəmləri və çarpaz göstəriciləri (Gəlir vs Mənfəət) sətir-sətir analiz etmək üçün Matrix tətbiq edilmişdir.
• İzah etdiyi məsələ: Ölkə (və onun altındakı Region) kəsiyində hansı bazarın nə kadar mənfəətlilik (Profit Margin) verdiyini dəqiqliklə təqdim edir.

NƏTİCƏ: Bütün vizuallar bir-biri ilə interaktiv əlaqədədir(Cross-filtering) və istifadəçiyə vahid ekrandan istənilən parametri filtrləyərək dərin analiz aparmaq imkanı verir.
