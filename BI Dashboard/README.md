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

**Checkpoint 3: Bir neçə vizual arasında bağlı interaktiv filtr/slicer**
Slicer—Power BI hesabat səhifəsində istifadəçiyə məlumatları dinamik şəkildə filtrləmək imkanı verən interaktiv vizual alətdir.İstifadəçi təcrübəsini(UX) rahatlaşdırmaq və istənilən biznes sualına(məs:2023-cü ildə Onlayn kanalda xərclər nə qədər olub?) bir neçə kliklə cavab tapmaq üçün istifadə olunur.
Dashboard-a 4 slicer əlavə olundu, hər biri fərqli təhlil kəsimi üçün:
1. Country slicer (DimGeography.Country)—ölkə üzrə filtrasiya
2. Category slicer (DimProduct.Category)—məhsul kateqoriyası üzrə filtrasiya
3. Year slicer (DimDate2.Year)—il üzrə filtrasiya
4. Channel slicer (FactSales.Channel)—satış kanalı(Online/Retail/Partner/Phone) üzrə filtrasiya
NECƏ İŞLƏYİR: Bütün slicer-lər eyni səhifədə, dashboard-un digər vizualları ilə(3 KPI kart, Line Chart, Column Chart, Map, Table, Donut Chart) yanaşı yerləşdirilib. Checkpoint 1-də qurulan data model əlaqələri sayəsində (Fact cədvəllərin Dim cədvəllərə key sütunları vasitəsilə bağlanması) bütün bu vizuallar avtomatik olaraq bir-birinə bağlıdır.
İstifadəçi istənilən slicer-də bir dəyər seçdikdə (məsələn Country="Egypt", Channel="Online", Category="Electronics" və ya Year=2023), 
Power BI həmin filtri bütün səhifədəki digər vizuallara avtomatik tətbiq edir:
- KPI kartlar(Total Sales, Total Profit, Total Quantity) yalnız seçilmiş filtrə uyğun məbləğləri göstərir.
- Line Chart yalnız seçilmiş şərtlərə uyğun aylıq trendi göstərir.
- Map yalnız seçilmiş ölkə(ləri) vurğulayır.
- Table sətirləri filtrə uyğun daralır.
Bir neçə slicer eyni anda istifadə edildikdə (məsələn Country="UAE" VƏ Channel="Retail"), filtrlər birlikdə(AND məntiqi ilə) tətbiq olunur—yəni yalnız hər iki şərtə uyğun data göstərilir.
NƏTİCƏ: Bu, istifadəçiyə tək bir dashboard üzərində müxtəlif kəsimlərdə(ölkə,kateqoriya, il, kanal) sərbəst analiz aparmaq imkanı verir, ayrıca statik hesabatlar hazırlamağa ehtiyac qalmır.

**Checkpoint 4: Hədəf/əvvəlki dövrlə müqayisəli KPI xülasə kartları**
Layihənin Məqsədi:İcraçı rəhbərlik(Executive Level) üçün biznesin yalnız statik gəlirini deyil,illik müəyyən edilmiş hədəflərə(Targets) çatma dərəcəsini və keçən ilin eyni dövrü(Year-over-Year) ilə müqayisəli inkişaf dinamikasını dərhal izləməyə imkan verən dinamik KPI göstəricilərinin qurulmasıdır.
Dashboard-da biznes metrikalarının dinamikasını, hədəfə çatma faizini və əvvəlki dövrlə müqayisəsini əks etdirmək üçün geniş DAX arxitekturası qurulmuş və 4 ədəd xülasə kartı yaradılmışdır.
1. DATA MODELLƏŞDİRMƏ VƏ DAX ÖLÇÜLƏRİ (MEASURES):
Model Optimallaşdırılması: DimDate2 cədvəli 'Mark as Date Table' olaraq təyin edilmişdir. FactSalesTarget cədvəlində TargetSalesAmount sütununun tipi Decimal Number-ə dəyişdirilmişdir.
1)Actual Sales = SUM(FactSales[SalesAmount])
2)Target Sales = SUM(FactSalesTarget[TargetSalesAmount])
3)Sales vs Target = [Actual Sales] - [Target Sales]
4)Sales vs Target % = DIVIDE([Actual Sales] - [Target Sales], [Target Sales])
5)Sales Previous Year = CALCULATE([Actual Sales], SAMEPERIODLASTYEAR(DimDate2[Date]))
6)Sales YoY % = DIVIDE([Actual Sales] - [Sales Previous Year], [Sales Previous Year])
Burada adi bölmə (/) əvəzinə DIVIDE() funksiyasından istifadə olunmuşdur ki, məxrəc 0 və ya boş olduqda hesabat xəta verməsin.

2. VİZUAL TƏTBİQİ:
-KPI Visual 1(Sales vs Target): Actual Sales göstəricisi Target Sales hədəfi ilə müqayisə edilmiş, trend oxu üzrə kəsir və dinamika vizuallaşdırılmışdır.
-KPI Visual 2(Sales vs Previous Year): Actual Sales göstəricisi SAMEPERIODLASTYEAR vasitəsilə əvvəlki ilin eyni dövrü ilə müqayisə edilmişdir.
-Card 1(Sales vs Target-Fərq Məbləği): Mütləq pul fərqini (-54M) göstərən standart kart vizualı.
-Card 2(Sales vs Target %-Faiz Dəyişimi): Nisbi fərq göstəricisini (-72.80%) faiz formatında əks etdirən kart vizualı.

**Checkpoint 5: Dashboard dizaynı (aydın vizual iyerarxiya, ardıcıl rəng sxemi, izdihamsız)**
Hesabatın icraçı rəhbərlik (Executive Level) tərəfindən rahat oxunması, vizual cluttering-in(sıxlığın) aradan qaldırılması və peşəkar görünüş üçün UI/UX prinsipləri əsasında optimallaşdırma aparılmışdır.
1. STRUKTUR VƏ VİZUAL İYERARXİYA(GRID LAYOUT):
-Filter Panel(Sol Zolaq): Bütün dinamik süzgəclər(Channel, Year, Category, Country) sol tərəfdə vertikal qaydada qruplaşdırılaraq əsas analiz sahəsindən ayrılmışdır.
-Executive Summary Panel(Yuxarı Zolaq): 4 ədəd hədəf və zaman müqayisəli KPI kartı(Actual vs Target, Actual vs PY, Sales vs Target, Sales vs Target %) yuxarı hissədə yan-yana yerləşdirilmişdir.
-Analytical Grid(Orta və Aşağı Zolaq): Əsas satış və xərc dinamikası(Sales vs Total Cost Trend) və kateqoriya bölgüsü mərkəzdə, regional və ödəniş təfərrüatları (Map, Country Table, Payment Donut Chart) isə aşağı hissədə hizalanmışdır.

2. VİZUAL TƏMİZLİK VƏ OPTİMALLAŞDIRMA(DE-CLUTTERING):
-Təkrar və lazımsız sadə kartlar təmizlənmiş, xətti qrafiklər tək bir müqayisəli vizualda(Sales vs Total Cost) birləşdirilmişdir.
-Standart avto-başlıqlar daha qısa və aydın biznes anlayışları ilə(məs: Sales Trend, Sales Distribution) əvəz olunmuşdur.
