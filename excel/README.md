**Checkpoint 2 – Pivot Tables**
--Məqsəd
Bu checkpoint-də Excel-in Pivot Table alətindən istifadə edərək satış datası təhlil olundu və 5 fərqli biznes sualına cavab verən hesabatlar hazırlandı.

Business Question 1
Sual:Hansı region üzrə ümumi satış məbləği daha yüksəkdir?
Pivot Table:
-Rows:Region
-Values:Sum of Sales
Nəticə:Ən yüksək satış West regionunda qeydə alınıb. Bu, regionlar arasında satış performansını müqayisə etmək üçün faydalı bir göstəricidir.

Business Question 2
Sual:Hansı məhsul kateqoriyası ən yüksək ümumi satış məbləğinə malikdir?
Pivot Table:
-Rows:Category
-Values:Sum of Sales
Nəticə:Technology kateqoriyası digərlərini üstələyir — şirkətin əsas gəlir mənbələrindən biri məhz budur.

Business Question 3
Sual:Müştərilər ən çox hansı göndərmə üsulundan istifadə edirlər?
Pivot Table:
-Rows:Ship Mode
-Values:Count of Order ID
Nəticə:Pivot cədvəl ən çox seçilən göndərmə üsulunu aydın göstərir, bu da logistika proseslərini qiymətləndirərkən işə yarayır.

Business Question 4
Sual:Hansı müştəri seqmenti ən yüksək ümumi satış məbləğinə malikdir?
Pivot Table:
-Rows:Segment
-Values:Sum of Sales
Nəticə:Seqmentlər üzrə müqayisə aparılanda ən çox gəlir gətirən seqment ortaya çıxır — bu da hədəf auditoriyanı müəyyənləşdirmək üçün önəmlidir.

Business Question 5
Sual:Satışların aylar üzrə paylanması necədir?
Pivot Table:
-Rows:Order Date (Months)
-Values:Sum of Sales
Nəticə:Aylıq satış tendensiyasına baxanda ən yüksək göstərici noyabr ayına düşür. Bu, mövsümi satış dalğalanmalarını izləmək baxımından dəyərlidir.

İstifadə olunan Excel funksiyaları
-Pivot Table
-Sum aggregation
-Count aggregation
-Sorting (Largest to Smallest)
-Date Grouping (Months)

Final Result
5 pivot cədvəl vasitəsilə satış datası fərqli bucaqlardan — region, kateqoriya, göndərmə üsulu, seqment və vaxt üzrə — təhlil olundu.
Bu hesabatlar biznes qərarlarını dəstəkləyəcək praktik məlumat təqdim edir.


**Checkpoint 3–Lookup Formulas**
Məqsəd: Orders sheet-inə People sheet-dən Region əsasında Regional Manager məlumatını lookup formulası ilə birləşdirmək.
Sual-Hər sifarişin aid olduğu Region-un Regional Manager-i kimdir?
İstifadə olunan formula:
=INDEX(People!A:A;MATCH(M2;People!B:B;0))

Formulun izahı:
- MATCH(M2;People!B:B;0)—Orders sheet-də M sütunundakı Region dəyərini 
  (məs. "West") People sheet-in B sütununda axtarır və hansı sətirdə 
  yerləşdiyini tapır.
- INDEX(People!A:A;...)—tapılan sətir nömrəsinə uyğun olan A sütunundakı 
  dəyəri (Regional Manager adını) qaytarır.

Qeyd:
İlk olaraq XLOOKUP funksiyası sınanıldı, lakin Excel versiyasında bu funksiya 
mövcud olmadığı üçün (#NAME? xətası alındı) INDEX-MATCH kombinasiyasına 
keçildi. INDEX-MATCH bütün Excel versiyalarında dəstəkləndiyi üçün daha 
etibarlı seçim oldu.

Nəticə:
Orders sheet-inə yeni "Regional Manager" sütunu əlavə olundu və bütün 
sətirlər üçün formula avtomatik tətbiq edildi.


**Checkpoint 4 – Hesablanan Sahələr**
Bu checkpoint-də Orders sheet-inə üç növ hesablanan sütun əlavə edildi:
1. SUMIFS sütunu — hər region üçün Furniture kateqoriyasının ümumi satışını göstərir:
=SUMIFS(R:R;M:M;"West";O:O;"Furniture")
=SUMIFS(R:R; M:M; "Central"; O:O; "Furniture")
=SUMIFS(R:R; M:M; "South"; O:O; "Furniture")
=SUMIFS(R:R; M:M; "East"; O:O; "Furniture")
2. COUNTIFS sütunu — hər region üçün zərərlə (mənfi profit) bağlanan sifarişlərin sayını göstərir:
=COUNTIFS(M:M;"West";U:U;"<0")
=COUNTIFS(M:M;"Central";U:U;"<0")
=COUNTIFS(M:M;"South";U:U;"<0")
=COUNTIFS(M:M;"East";U:U;"<0")
3. Profit_Status sütunu (nested IF) — hər sifarişin profitinə əsasən kateqoriya təyin edir:
=IF(U2<0;"Zərər";IF(U2<100;"Aşağı Qazanc";"Yüksək Qazanc"))
Nəticədə: Profit mənfidirsə "Zərər", 0-100 arasıdırsa "Aşağı Qazanc", 100-dən çoxdursa "Yüksək Qazanc" kimi işarələnir. Hər üç sütun Orders sheet-in içində, ayrı-ayrı sütunlar şəklində, bütün 
sətirlərə ardıcıl tətbiq olundu.


**Checkpoint 5 – Dashboard və Şərti Formatlaşdırma**
Məqsəd:Satış datasını vizual şəkildə təqdim etmək üçün müxtəlif qrafik tiplərini əhatə edən dashboard hazırlamaq, həmçinin Profit göstəricisini şərti formatlaşdırma ilə vurğulamaq.
--Dashboard
Ayrıca "Dashboard" sheet-də aşağıdakı qrafiklər yaradıldı:
Sales by Region -> Column Chart -> Pivot_Region_Sales
Sales by Category -> Pie Chart -> Pivot_Category_Sales
Sales by Segment -> Column Chart -> Pivot_Segment_Sales 
Orders by Ship Mode -> Donut Chart -> Pivot_ShipMode_Orders 
Monthly Sales Trend -> Line Chart -> Pivot_Monthly_Sales
Hər qrafikin öz başlığı var və dashboard bir baxışda bütün əsas satış göstəricilərini əks etdirir.
--Şərti Formatlaşdırma
Orders sheet-də Profit sütununa (U) aşağıdakı qayda tətbiq olundu:
- **Profit < 0** -> qırmızı rəng (Zərər)
- **Profit ≥ 0** -> yaşıl rəng (Qazanc)
Bu, minlərlə sətir arasında zərərli sifarişləri əl ilə axtarmadan, bir baxışda görməyə imkan verir.
Nəticə: Dashboard və şərti formatlaşdırma birlikdə datanın həm ümumi tendensiyalarını (qrafiklər vasitəsilə), həm də konkret problemli sahələri (rəngli formatlaşdırma vasitəsilə) aydın şəkildə göstərir.
