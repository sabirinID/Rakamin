-- Soal 1
-- Tim Risk sedang menginvestigasi untuk pelanggan yang menggunakan
-- email Yahoo ataupun Roketmail khususnya yang meregistrasi di
-- kuartal 1 (Januari–Maret) tahun 2012 dan juga berulang tahun
-- antara bulan Januari–Maret.
-- Menampilkan informasi nama, email, bulan lahir, dan tanggal
-- registrasi dari pelanggan yang memenuhi kriteria tersebut!
SELECT nama,
       email,
       bulan_lahir,
       tanggal_registrasi
  FROM rakamin_customer
 WHERE (email LIKE '%yahoo%' OR email LIKE '%roketmail%')
       AND tanggal_registrasi BETWEEN '2012-01-01' AND '2012-03-31'
       AND bulan_lahir IN ('Januari', 'Februari', 'Maret');

-- Soal 2
-- Tim Business ingin menganalisis perilaku spending dari para
-- pelanggan dengan cara mengklasifikasikan setiap transaksi menjadi
-- beberapa bucket menurut jumlah uang yang dikeluarkan atau jumlah
-- transaksi (setelah PPN). Dengan kriteria spending bucket, yaitu:
-- LOW: jumlah transaksi tidak melebihi 20000;
-- MEDIUM: jumlah transaksi lebih dari 20000 dan tidak melebihi 50000;
-- HIGH: jumlah transaksi lebih dari 50000.
-- Menampilkan informasi id_order, id_pelanggan, harga, harga
-- setelah PPN, dan spending_bucket sesuai kriteria di atas!
-- Mengurutkan berdasarkan harga setelah PPN dari yang terbesar!
SELECT id_order,
       id_pelanggan,
       harga,
       harga * (1 + ppn) AS harga_setelah_ppn,
       CASE WHEN harga * (1 + ppn) > 50000 THEN 'HIGH'
            WHEN harga * (1 + ppn) > 20000 THEN 'MEDIUM'
            ELSE 'LOW'
       END AS spending_bucket
  FROM rakamin_order
 ORDER BY harga_setelah_ppn DESC;

-- Soal 3
-- Tim Merchant Acquisition ingin menganalisis performa dari para
-- merchant yang sudah ada dengan melihat beberapa metrik, yaitu
-- jumlah order serta jumlah pendapatan (sebelum PPN) yang telah
-- diterima oleh masing-masing merchant.
-- Menampilkan id_merchant, jumlah order, dan jumlah pendapatan
-- sebelum PPN!
-- Mengurutkan berdasarkan jumlah pendapatan dari yang tertinggi!
SELECT id_merchant,
       COUNT(id_order) AS jumlah_order,
       SUM(harga) AS jumlah_pendapatan_sebelum_ppn
  FROM rakamin_order
 GROUP BY id_merchant
 ORDER BY jumlah_pendapatan_sebelum_ppn DESC;

-- Soal 4
-- Tim Payment ingin menganalisis terhadap metode pembayaran yang
-- paling populer selama ini.
-- Menampilkan metode pembayaran serta frekuensi penggunaan dengan
-- frekuensi di atas 10!
-- Mengurutkan berdasarkan frekuensi dari yang terbanyak!
SELECT metode_bayar,
       COUNT(id_order) AS frekuensi_penggunaan
  FROM rakamin_order
 GROUP BY metode_bayar
HAVING COUNT(id_order) > 10
 ORDER BY frekuensi_penggunaan DESC;

-- Soal 5
-- Tim Business Development ingin memikirkan strategi ekspansi ke
-- kota-kota lainnya, sehingga mereka ingin mengetahui ketimpangan
-- populasi pelanggan di kota-kota yang ada sekarang dan meminta
-- informasi tentang jumlah terkecil dan terbesar dari populasi
-- pelanggan di suatu kota.
-- Menampilkan dua angka tersebut!
SELECT MIN(jumlah_pelanggan) AS populasi_pelanggan_terkecil,
       MAX(jumlah_pelanggan) AS populasi_pelanggan_terbesar
  FROM
       (SELECT kota, COUNT(id_pelanggan) AS jumlah_pelanggan
       FROM rakamin_customer_address
       GROUP BY kota) AS populasi_pelanggan;

-- Soal 6
-- Tim Payment ingin memperdalam analisis terhadap metode pembayaran,
-- sehingga mereka ingin melihat detail frekuensi penggunaan untuk
-- masing-masing metode pembayaran dan merchant yang ada.
-- Menampilkan nama merchant, metode pembayaran, dan frekuensi
-- penggunaan!
SELECT rm.nama_merchant,
       ro.metode_bayar,
       COUNT(id_order) AS frekuensi_penggunaan
  FROM rakamin_order AS ro
  JOIN rakamin_merchant AS rm
       ON ro.id_merchant = rm.id_merchant
 GROUP BY rm.nama_merchant, ro.metode_bayar
 ORDER BY rm.nama_merchant, frekuensi_penggunaan DESC;
	
-- Soal 7
-- Tim Marketing ingin memberikan reward kepada para pelanggan yang
-- telah melakukan transaksi dengan total kuantitas di atas 5.
-- Menampilkan informasi id_pelanggan, total kuantitas, nama, dan
-- email dari pelanggan yang memenuhi kriteria tersebut!
WITH cte_order AS (
	SELECT id_pelanggan,
               SUM(kuantitas) AS total_kuantitas
	  FROM rakamin_order
	 GROUP BY 1
	HAVING SUM(kuantitas) > 5
)
SELECT co.id_pelanggan,
       co.total_kuantitas,
       rc.nama,
       rc.email
  FROM cte_order AS co
  JOIN rakamin_customer AS rc
    ON co.id_pelanggan = rc.id_pelanggan
 ORDER BY 2 DESC;
