/* 1. Study Case: rata-rata user/pengguna.
Narasi: Dalam marketing segmentasi pasar sangat diperlukan karena berpengaruh
dengan strategi pemasaran, Identifikasi preferensi produk, perilaku pembelian, dan
kebutuhan yang unik bagi segmen tersebut. Karena setiap brand harus mempunyai
positioning yang tepat berdasarkan segmen market terbesar mereka. dan salah satu
contoh melakukan segmentasi pasar adalah dengan menggunakan rentang usia
pengguna web/aplikasi kita.

Berikut insight yang didapatkan:
Berdasarkan query yang sudah dilakukan maka data rata rata usia pengguna
web/aplikasi kita adalah 41.063419. 

Syntax SQL: */
SELECT AVG(age) AS rata_rata_umur
FROM bigquery-public-data.thelook_ecommerce.users;

/* 2. Study Case: jenis kelamin user/pengguna terbanyak
Narasi: Seperti case pada nomor 1 salah satu segmentasi pasar yang biasa
dilakukan brand adalah dengan segmentasi berdasarkan gender. Karena
berbedanya Identifikasi preferensi produk, perilaku pembelian di antara laki-laki atau
perempuan.

Berikut insight yang didapatkan:
Setelah melakukan query didapatkan data jenis kelamin pengguna terbanyak adalah
wanita dengan jumlah 50312 pengguna. Dengan ini brand harus melakukan
kebijakan bisnis yang lebih condong kepada wanita karena dengan alasan market
terbanyak.

Syntax SQL: */
SELECT gender, COUNT(*) AS total_users
FROM bigquery-public-data.thelook_ecommerce.users
GROUP BY gender
ORDER BY total_users DESC
LIMIT 1;

/* 3. Study Case: Total sales berdasarkan traffic source.
Narasi: Total sales tidak bisa dipisahkan dengan ads/iklan. sehingga setiap brand
harus bisa mengetahui customer mereka kebanyakan datang dari mana. sehingga
mereka bisa melakukan ads dengan tepat.

Berikut insight yang didapatkan:
setelah melakukan query dihasilkan bahwa traffic source terbanyak di dapatkan data
dari email dengan total sales/transaksi sebanyak 2211737. sehingga brand bisa
memaksimalkan ads di email dengan hasil data tersebut.

Syntax SQL: */
SELECT traffic_source, COUNT(oi.id) AS total_sales
FROM bigquery-public-data.thelook_ecommerce.order_items oi
JOIN bigquery-public-data.thelook_ecommerce.events e ON
oi.user_id = e.user_id
GROUP BY traffic_source
ORDER BY total_sales DESC;

/* 
4. Study Case: Segmentasi pengguna berdasarkan negara
Narasi: Sebuah brand harus mengetahui persebaran geografis penggunanya.
Berikut insight yang didapatkan: Setelah melakukan query didapatkan bahwa
pengguna terbanyak berasal dari China dengan total jumlah pengguna ada 33881.

Syntax SQL:
*/

SELECT country, COUNT(id) AS total_users
FROM bigquery-public-data.thelook_ecommerce.users
GROUP BY country
ORDER BY total_users DESC
LIMIT 5;

/*   
5. Study Case: Segmentasi berdasarkan kategori terlaku.
Narasi: Kita harus bisa mengetahui kategori barang apa yang paling banyak terjual di
ecommerce kita supaya bisa membuat pertimbangan untuk menambah jumlah
produk di kategori tersebut.

Berikut insight yang didapatkan: Kita bisa mengetahui 5 kategori barang yang paling
banyak terjual di ecommerce kita
Syntax SQL:
*/    

SELECT p.category, COUNT(oi.id) AS total_sales
FROM bigquery-public-data.thelook_ecommerce.order_items oi
JOIN bigquery-public-data.thelook_ecommerce.products p ON
oi.product_id = p.id
GROUP BY p.category
ORDER BY total_sales DESC
LIMIT 5;

/*
6. Study Case: Pengguna dengan order terbanyak
Narasi: Kita harus mengetahui Customer yang loyal berbelanja di ecommerce kita,
supaya bisa mempertahankan customer itu untuk tetap terus berbelanja di
ecommerce kita.

Berikut insight yang didapatkan: Kita bisa mengetahui data 5 pelanggan dengan
order terbanyak.

Syntax SQL:
*/

SELECT
u.id,
u.first_name,
u.last_name,
COUNT(o.order_id) AS total_pesanan
FROM
bigquery-public-data.thelook_ecommerce.users u
LEFT JOIN
bigquery-public-data.thelook_ecommerce.orders o ON u.id =
o.user_id
GROUP BY
u.id, u.first_name, u.last_name
ORDER BY
total_pesanan DESC
LIMIT 5;

/*
7. Study Case: Mencari produk yang paling banyak di retur
Narasi: Kita harus bisa mengetahui produk apa yang paling banyak di retur oleh
pelanggan untuk menjadikannya bahan evaluasi apakah produk tersebut tidak layak
untuk dipasarkan dll.

Berikut insight yang didapatkan: Kita bisa mengetahui 10 produk yang paling banyak
di retur.

Syntax SQL:
*/
SELECT
p.name AS product_name,
p.category,
p.brand,
COUNT(*) AS num_returns
FROM
bigquery-public-data.thelook_ecommerce.order_items oi
JOIN
bigquery-public-data.thelook_ecommerce.products p ON
oi.product_id = p.id
JOIN
bigquery-public-data.thelook_ecommerce.orders o ON
oi.order_id = o.order_id
WHERE
o.status = 'Returned'
GROUP BY
product_name, category, brand
ORDER BY
num_returns DESC
LIMIT 10;

/*
8. Study Case: Mengetahui waktu yang dibutuhkan untuk packing dan pengiriman
Narasi: Kita harus bisa mengetahui kinerja warehouse dari ecommerce kita untuk
melihat apakah packing dan pengantaran barang sudah sesuai standar atau belum.

Berikut insight yang didapatkan: Kita bisa mendapatkan data rata rata packing
barang dan rata rata pengantaran barang

Syntax SQL:
*/
SELECT
status,
AVG(TIMESTAMP_DIFF(shipped_at, created_at, DAY)) AS
rata_rata_lama_packing,
AVG(TIMESTAMP_DIFF(delivered_at, shipped_at, DAY)) AS
rata_rata_lama_pengiriman
FROM
bigquery-public-data.thelook_ecommerce.order_items
WHERE
status = 'Complete'
GROUP BY
status;

/*
9. Study Case: Trend penjualan produk pada 1 bulan terakhir.
.
Narasi: Brand harus bisa catch up dengan trend barang yang sedang dia jual, produk
mana saja yang sedang diminati oleh pelanggan supaya brand bisa mempersiapkan
stok barang yang sedang naik trendnya dan tidak kehilangan kesempatan untuk
menjual lebih banyak produk.

Berikut insight yang didapatkan: setelah mendapatkan data dari query 10 produk
teratas yang trendnya sedang naik berdasarkan hasil penjualan 1 bulan terakhir
adalah Wrangler Men's Premium Performance Cowboy Cut Jean, True Religion
Men's Ricky Straight Jean, Lee Men's Relaxed Fit Slightly Tapered Leg Jean,
RVCA Men's Way Holmer Sweat Shirt,Pearl iZUMi Attack Sock 3-Pack

Syntax SQL:
*/
SELECT
p.name AS product_name,
COUNT(oi.id) AS total_sales
FROM
bigquery-public-data.thelook_ecommerce.order_items oi
JOIN
bigquery-public-data.thelook_ecommerce.products p ON oi.product_id = p.id
JOIN

bigquery-public-data.thelook_ecommerce.orders o ON oi.order_id = o.order_id
WHERE
o.created_at >= TIMESTAMP '2024-01-25 00:00:00' AND
o.created_at <= TIMESTAMP '2024-02-25 23:59:59'
GROUP BY
p.name
ORDER BY
total_sales DESC
LIMIT 5

/*
10. Study Case: Ketersediaan distribution center di kota dengan jumlah order terbesar di
Amerika.
Narasi: Selain memikirkan tentang produk setiap brand juga harus memikirkan
tentang warehousing. Karena posisi warehouse bisa berpengaruh ke setiap cost
yang dikeluarkan di setiap transaksinya. dengan itu kita bisa melakukan query untuk
mencari tahu apakah di kota dengan order/transaksi terbanyak di United State
apakah tersedia distribution center atau tidak.

Berikut insight yang didapatkan:
Setelah melakukan query kita bisa mendapatkan hasil kota dengan order/transaksi
terbanyak di United State adalah kota New York, tetapi di kota tersebut tidak
tersedia distribution center. Dengan itu brand bisa melakukan analisis apakah
dibutuhkan atau tidak untuk membuka distribution center di kota New York sebagai
kota dengan transaksi terbanyak di United State.

Syntax SQL:
*/
SELECT
u.city AS most_popular_city,
u.total_users,
CASE
WHEN dc.id IS NOT NULL THEN 'There is a distribution

center'

ELSE 'There is no distribution center'
END AS city_in_distribution_centers,
m.total_orders
FROM (
SELECT

city,
COUNT(id) AS total_users
FROM
bigquery-public-data.thelook_ecommerce.users
WHERE
country = 'United States'
GROUP BY
city
ORDER BY
total_users DESC
LIMIT 1
) u
LEFT JOIN

bigquery-public-data.thelook_ecommerce.distribution_centers dc
ON u.city = dc.name
LEFT JOIN (
SELECT
u.city,
COUNT(oi.order_id) AS total_orders
FROM
bigquery-public-data.thelook_ecommerce.users u
JOIN
bigquery-public-data.thelook_ecommerce.order_items oi

ON u.id = oi.user_id
WHERE
u.city IN (
SELECT city
FROM (
SELECT
city,
COUNT(id) AS total_users
FROM

bigquery-public-data.thelook_ecommerce.users

WHERE

country = 'United States'
GROUP BY
city
ORDER BY
total_users DESC
LIMIT 1
)
)
AND oi.status = 'Complete'
GROUP BY
u.city
ORDER BY
total_orders DESC
LIMIT 1
) m ON u.city = m.city;