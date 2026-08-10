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
