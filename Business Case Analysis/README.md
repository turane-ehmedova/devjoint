**Week 4–Business Case Analysis+Report**
**Checkpoint 1–Biznes sualına uyğun 3-5 KPI/metrikanın müəyyən edilməsi**
BİZNES SUALI: 2025-in son rübündə (Oktyabr-Dekabr) marketinq performansı 2024-ün eyni dövrü ilə (Oktyabr-Dekabr 2024) müqayisədə necə dəyişib, və zəifləmə varsa səbəbi nədir?
Eyni dövr (Oct-Dec) müqayisə edilib ki, mövsümilik təhrifi olmasın(məsələn dekabrı iyulla müqayisə etmək yanlış nəticə verərdi).
SEÇİLMİŞ 5 KPI/METRİKA:
1. Total Revenue
   Düstur:SUM(revenue)
   Biznes məqsədi:Ümumi gəlirin miqyasını göstərmək üçün baza göstəricidir.
2. Conversion Rate(CR %)
   Düstur:(Total Conversions/Total Sessions)×100
   Biznes məqsədi:Trafikin nə qədər real alıcıya/sifarişçiyə çevrildiyini ölçür—kanalın gətirdiyi trafikin keyfiyyətini göstərir.
3. ROAS(Return on Ad Spend)
   Düstur:Total Revenue/Total Spend
   Biznes məqsədi:Xərclənən hər 1 vahid marketinq büdcəsinin nə qədər gəlir gətirdiyini göstərir—kanalların maliyyə baxımından nə qədər mənfəətli olduğunu qiymətləndirir.
4. CPA(Cost Per Acquisition)
   Düstur:Total Spend/Total Conversions
   Biznes məqsədi:Tək bir uğurlu conversion əldə etmək üçün orta hesabla nə qədər marketinq büdcəsi xərcləndiyini göstərir—xərclərin optimallaşdırılması üçün kritikdir.
5. AOV(Average Order Value)
   Düstur:Total Revenue/Total Conversions
   Biznes məqsədi:Qazanılan hər bir uğurlu conversion/sifariş başına düşən orta gəliri göstərir—alıcı davranışının(nə qədər xərclədiyinin) dəyişib-dəyişmədiyini ayırd etməyə kömək edir.

SEÇİMIN ƏSASLANDIRMASI:Burada göstərdiyimiz 5 KPI aşağıdakı qruplara bölünür:
-Miqyas göstəricisi(Total Revenue)—ümumi böyüklüyü əks etdirir.
-Keyfiyyət göstəricisi(Conversion Rate)—trafikin nə qədər yaxşı nəticəyə çevrildiyini göstərir.
-Səmərəlilik göstəriciləri(ROAS, CPA)—xərclənən pulun nə qədər səmərəli işlədiyini göstərir.
-Alıcı davranışı göstəricisi(AOV)—CR-dən müstəqil olaraq, alıcıların nə qədər xərclədiyini göstərir.

CR və AOV bir-birindən müstəqil məlumat verir(biri "neçə nəfər alış etdi", digəri "alış edənlər nə qədər xərclədi")—bu, performans zəifləməsinin əsl səbəbini(az alıcı, yoxsa az xərcləyən alıcı) ayırd etməyə kömək edəcək.
Bu KPI-lar həm ümumi səviyyədə, həm də kanal/region/müştəri seqmenti üzrə seqmentləşdirilə bilər—bu, Simpson paradoksu tələsinə düşməmək üçün vacibdir(ümumi rəqəmə deyil, alt-seqmentlərə də ayrıca baxılacaq).

**Checkpoint 2–Lazımi datanın çıxarılması/aqreqasiyası üçün SQL sorğuları**
-- 1.Datanın strukturuna ilkin baxış:
SELECT * FROM marketing_events LIMIT 5;
-- 2.2025 Q4 dövrü üzrə ümumi gəlir, xərc, seans və konversiyaların cəmi
SELECT 
sum(revenue) as total_revenue,
sum(spend) as total_spend,
sum(sessions) as total_sessions,
sum(conversions) as total_conversions
FROM marketing_events WHERE date BETWEEN '2025-10-01' AND '2025-12-31';
-- 3.2025 Q4 üzrə əsas KPI-ların hesablanması(ROAS, CR%, CPA, AOV)
Burada round istifadə etmə səbəbimiz odur ki, alacağımız qiymətlər yüksək olur və round vasitəsilə biz onu yuvarlaq şəkildə göstəririk. 
SELECT 
  sum(revenue) as total_revenue,
  sum(spend) as total_spend,
  sum(sessions) as total_sessions,
  sum(conversions) as total_conversions,
  round(sum(revenue)*1.0/sum(spend),2) as roas,
  round(sum(conversions)*100.0/sum(sessions),2) as conversion_rate,
  round(sum(spend)*1.0/sum(conversions),2) as cpa,
  round(sum(revenue)*1.0/sum(conversions),2) as aov
FROM marketing_events WHERE date BETWEEN '2025-10-01' AND '2025-12-31';
-- 4.2024 Q4 və 2025 Q4 Müqayisəli(YoY) Performans Analizi, ümumi analiz. UNİON ALL vasitəsilə iki cədvəli birləşşdirib bir-birinin üzərində yazırıq.
SELECT 
  '2024 Q4' as period,
  sum(revenue) as total_revenue,
  sum(spend) as total_spend,
  sum(sessions) as total_sessions,
  sum(conversions) as total_conversions,
  round(sum(revenue)*1.0/sum(spend), 2) as roas,
  round(sum(conversions)*100.0/sum(sessions), 2) as conversion_rate,
  round(sum(spend)*1.0/sum(conversions), 2) as cpa,
  round(sum(revenue)*1.0/sum(conversions), 2) as aov
FROM marketing_events WHERE date BETWEEN '2024-10-01' AND '2024-12-31'
UNION ALL
SELECT 
  '2025 Q4' AS period,
  sum(revenue),
  sum(spend),
  sum(sessions),
  sum(conversions),
  round(sum(revenue)*1.0/sum(spend), 2),
  round(sum(conversions)*100.0/sum(sessions), 2),
  round(sum(spend)*1.0/sum(conversions), 2),
  round(sum(revenue)*1.0/sum(conversions), 2)
FROM marketing_events WHERE date BETWEEN '2025-10-01' AND '2025-12-31';
-- 5.Kanallar üzrə gəlir, ROAS və Konversiya müqayisəsi
SELECT channel, '2024 Q4' as period,
sum(revenue) as total_revenue,
round(sum(revenue)*1.0/sum(spend), 2) as roas,
round(sum(conversions)*100.0/sum(sessions), 2) as conversion_rate
FROM marketing_events WHERE date BETWEEN '2024-10-01' AND '2024-12-31'
GROUP by channel
UNION ALL
SELECT channel, '2025 Q4' as period,
sum(revenue),
round(sum(revenue)*1.0/sum(spend), 2),
round(sum(conversions)*100.0/sum(sessions), 2)
FROM marketing_events WHERE date BETWEEN '2025-10-01' AND '2025-12-31'
GROUP by channel
ORDER by channel, period;
-- 6.Kanallar üzrə Seans Sayının (Trafikin) Müqayisəsi
SELECT channel,'2024 Q4' AS period,SUM(sessions) AS total_sessions
FROM marketing_events WHERE date BETWEEN '2024-10-01' AND '2024-12-31'
GROUP BY channel
UNION ALL
SELECT channel,'2025 Q4' AS period,SUM(sessions)
FROM marketing_events WHERE date BETWEEN '2025-10-01' AND '2025-12-31'
GROUP BY channel
ORDER BY channel, period;
--7.Regionlar uzre 2025 Q4 analizi
SELECT 
    region,
    sum(revenue) as total_revenue,
    sum(spend) as total_spend,
    round(sum(revenue)*1.0/sum(spend), 2) as roas,
    round(sum(conversions)*100.0/sum(sessions), 2) as conversion_rate
FROM marketing_events WHERE date BETWEEN '2025-10-01' AND '2025-12-31'
GROUP BY region;
--8.Customer Segment uzre 2025 Q4 JOIN analizi
SELECT 
    c.customer_segment,
    sum(e.revenue) as total_revenue,
    sum(e.spend) as total_spend,
    round(sum(e.revenue)*1.0/sum(e.spend), 2) as roas,
    round(sum(e.conversions)*100.0/sum(e.sessions), 2) as conversion_rate
FROM marketing_events e JOIN customers c ON e.customer_id = c.customer_id
WHERE e.date BETWEEN '2025-10-01' AND '2025-12-31'
GROUP BY c.customer_segment;

**Checkpoint 3–Kök-səbəb tərzli analiz (metrikanın region/kanal/zaman üzrə seqmentlərə bölünərək araşdırılması)**
METODOLOGIYA: Analiz 4 səviyyədə seqmentləşdirdik ki, ümumi rəqəmin arxasında gizlənən fərqləri aşkarlayaq:
1. Zaman(Q4 2024 vs Q4 2025, eyni təqvim dövrü)
2. Kanal(Email, Organic Search, Paid Search, Paid Social)
3. Region(North, South, East, West)
4. Müştəri seqmenti(New, Returning, Loyal) və kampaniya məqsədi(Acquisition, Retention)
TAPINTILAR:
1. ÜMUMI SƏVİYYƏ (Q4 2024->Q4 2025)
Revenue:3,173,087.12 -> 3,528,235.61
Hesablama:(3,528,235.61 - 3,173,087.12) / 3,173,087.12 × 100 = 11.19% ≈ +11.2%

Conversion Rate: 5.8% -> 6.03%
Hesablama: (6.03 - 5.8) / 5.8 × 100 = 3.97%

AOV: 52.7 -> 56.24
Hesablama: (56.24 - 52.7) / 52.7 × 100 = 6.72% 

ROAS: 12.4 -> 12.85
Hesablama: (12.85 - 12.4) / 12.4 × 100 = 3.63%

Sessions: 1,038,924 -> 1,039,875
Hesablama: (1,039,875 - 1,038,924) / 1,038,924 × 100 = 0.09%
Nəticə: Performans yaxşılaşıb, amma Sessions (trafik) demək olar ki, dəyişməyib. Deməli, artım yeni trafik cəlb etməkdən deyil, mövcud trafikin daha yaxşı çevrilməsindən qaynaqlanır.

2. KANAL SƏVİYYƏSİ
Bütün 4 kanal (Email, Organic Search, Paid Search, Paid Social) təxminən bərabər dərəcədə yaxşılaşıb. Heç bir kanal geriləməyib—kanal səviyyəsində 
problem yoxdur.

3. REGION SƏVİYYƏSİ
North: ROAS 12.70, CR 6.03%
South: ROAS 12.90, CR 6.05%
East: ROAS 12.89, CR 6.01%
West: ROAS 12.96, CR 6.04%
Nəticə: Regionlar arasında əhəmiyyətli fərq yoxdur—region səviyyəsində problem yoxdur.

4. MÜŞTƏRİ SEQMENTİ SƏVİYYƏSİ
New: ROAS 11.84, CR 5.74%
Loyal: ROAS 13.67, CR 6.31%
Returning: ROAS 13.07, CR 6.06%

Hesablama (New vs Loyal ROAS fərqi):
(13.67 - 11.84) / 13.67 × 100 = 13.39% (Təqribən New seqmenti Loyal-dan 13.4% aşağıdır)
Nəticə: New müştərilər digər seqmentlərdən aydın şəkildə zəif performans göstərir.

5. ƏSAS KÖK-SƏBƏB — KAMPANİYA MƏQSƏDİ SƏVİYYƏSİ
Retention: ROAS 140.13, CR 7.28%, Revenue 922,037.49
Acquisition: ROAS 9.72, CR 5.70%, Revenue 2,606,198.12

Hesablama (ROAS fərqi, dəfə ilə):
140.13 / 9.72 = 14.42 (təqribən Retention, Acquisition-dan 14 dəfə daha yüksək ROAS göstərir)

Nəticə: Retention kampaniyaları Acquisition-dan qat-qat daha səmərəlidir.Amma Acquisition kampaniyalarına ayrılan büdcə/gəlir həcmi daha böyükdür (Revenue 2.6M və 922K) — yəni marketinq büdcəsinin böyük hissəsi nisbətən az səmərəli kanala yönəlib.
ÜMUMİ NƏTİCƏ:Ümumi göstəricilər müsbət olsa da, bunun altında struktur bir qeyri-səmərəlilik var:Acquisition kampaniyaları(yeni müştəri cəlbi) Retention kampaniyalarından(mövcud müştəri saxlanması) qat-qat az səmərəlidir, lakin büdcənin böyük hissəsini alır.Bu, həm New müştəri seqmentinin zəif göstəricisini, həm də ümumi ROAS-ın Retention-a nisbətən aşağı qalmasını izah edir.

**Checkpoint 4–Narrativi Dəstəkləyən Vizuallaşdırma**
Bu checkpointdə 3 qrafik hazırlandı, hər biri kök-səbəb analizindəki konkret bir iddianı vizual olaraq dəstəkləyir:
1. ROAS by Campaign Objective
Retention kampaniyalarının (ROAS 140.13) Acquisition kampaniyalarından(ROAS 9.72) 14 dəfə daha səmərəli olduğunu göstərir — əsas kök-səbəb tapıntısı.
2. Total Revenue by Period
Q4 2024(təqribən 3.17M) vs Q4 2025(təqribən 3.53M) — ümumi gəlir artımını vizuallaşdırır.
3. Total Sessions by Period
Q4 2024(təqribən 1.04M) vs Q4 2025 (təqribən 1.04M) — trafikin demək olar ki, dəyişmədiyini göstərir, bu da gəlir artımının yeni trafik deyil, daha yaxşı konversiya sayəsində baş verdiyini sübut edir.

İstifadə edilən alət: Power BI Desktop. DAX measure-lar(Total Revenue, Total Sessions, ROAS) və hesablanmış "Period" sütunu istifadə olunub.

**Checkpoint 5–YAZILI XÜLASƏ**
*VƏZİYYƏT*
2025-in son rübündə(Oktyabr-Dekabr) marketinq performansı, 2024-ün eyni dövrü(Oktyabr-Dekabr 2024) ilə müqayisə edildi. Analiz zamanı mövsümilik təhrifindən qaçmaq üçün yalnız eyni təqvim dövrü müqayisə edilib.
İlkin baxışda ümumi göstəricilər müsbətdir: Revenue +11.2%, Conversion Rate +4%, AOV +6.7% artıb. Lakin bu müsbət ümumi mənzərənin altında diqqət tələb edən strukturlar mövcuddur.
*TAPINTILAR*
1. Trafik artımı dayanıb:Sessions demək olar ki, dəyişməyib. Deməli, gəlir artımı yeni müştəri cəlbindən deyil, mövcud trafikin daha yaxşı çevrilməsindən qaynaqlanır.
2. Kanal və region səviyyəsində problem yoxdur:Bütün 4 kanal(Email, Organic Search, Paid Search, Paid Social) və bütün 4 region(North, South, East, West) bərabər dərəcədə sabit/müsbət performans göstərir.
3. Yeni müştərilər zəif performans göstərir:New seqmenti(ROAS 11.84, CR 5.74%) Loyal(ROAS 13.67, CR 6.31%) və Returning(ROAS 13.07, CR 6.06%) seqmentlərindən aşağıdır.
4. ƏSAS TAPINTI—Kampaniya məqsədi arasında kəskin fərq:Retention kampaniyaları ROAS 140.13 göstərdiyi halda, Acquisition kampaniyaları cəmi ROAS 9.72 göstərir — 14 dəfəlik fərq. Buna baxmayaraq, Acquisition kampaniyalarına ayrılan büdcə/gəlir həcmi(2.6M) Retention-dan(922K) xeyli böyükdür.
Bu tapıntılar bir-birini tamamlayır:Acquisition-a yönəlmiş böyük büdcə nisbətən aşağı səmərəlilik göstərir, bu da həm New müştəri seqmentinin zəif nəticəsini, həm də trafik artımının niyə gəlir artımı qədər sürətli olmadığını izah edir.
*TÖVSİYƏ*
Marketinq büdcəsinin bir hissəsi Acquisition kampaniyalarından Retention kampaniyalarına köçürülməlidir. Konkret addım: 
növbəti rübdə Acquisition büdcəsinin 15-20%-ini Retention/Email kampaniyalarına yönəltmək və nəticədə ROAS-ın ümumi səviyyədə necə dəyişdiyini izləmək tövsiyə olunur. Bu, ROAS-dakı 14 dəfəlik fərqə əsaslanaraq, ümumi marketinq gəlirliliyini əhəmiyyətli dərəcədə artıra bilər.
