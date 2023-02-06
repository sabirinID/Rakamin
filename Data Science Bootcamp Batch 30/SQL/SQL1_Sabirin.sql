-- Soal 1
-- Manajerial ingin mengetahui sejauh mana perkembangan atau
-- ekspansi RakaFood.
-- Menampilkan semua kota unik di mana pelanggan berasal!
SELECT DISTINCT kota
  FROM rakamin_customer_address;

-- Soal 2
-- Tim Engineering baru saja melakukan update skema tabel order.
-- Menampilkan 10 baris transaksi terbaru dari tabel rakamin_order!
SELECT *
  FROM rakamin_order
 ORDER BY tanggal_pembelian DESC
 LIMIT 10;

-- Soal 3
-- Tim Risk ingin mengetahui performa dari sistem fraud detection
-- yang telah berjalan selama ini.
-- Menampilkan data customer yang terdeteksi sebagai penipu!
SELECT *
  FROM rakamin_customer
 WHERE penipu = 1;

-- Soal 4
-- Tim Business Development sedang menjalin kerja sama baru dengan
-- pihak ShopeePay.
-- Menampilkan data order yang menggunakan metode bayar ShopeePay
-- yang diurutkan dari jumlah transaksi terbesar!
SELECT *
  FROM rakamin_order
 WHERE metode_bayar = 'shopeepay'
 ORDER BY harga DESC;

-- Soal 5
-- Tim Marketing akan melakukan campaign di Kota Tangerang dalam
-- waktu dua bulan ke depan.
-- Membuat tabel baru bernama rakamin_customer_address_tangerang
-- yang berisi data tabel rakamin_customer_address khusus di
-- kota Tangerang!
CREATE TABLE rakamin_customer_address_tangerang AS
       SELECT *
         FROM rakamin_customer_address
        WHERE kota = 'Tangerang';

-- Soal 6
-- Tim Marketing menemukan beberapa data point yang keliru dari
-- tabel rakamin_customer_address_tangerang.
-- Kolom provinsi untuk kota Tangerang seharusnya:
-- Banten (bukan Jawa Barat) dan
-- kolom alamat untuk customer dengan id_pelanggan 10 seharusnya:
-- Karawaci (bukan Daan Mogot).
-- Mengubah tabel tersebut sesuai seperti ketentuan di atas!
UPDATE rakamin_customer_address_tangerang
   SET provinsi = 'Banten';

UPDATE rakamin_customer_address_tangerang
   SET alamat = 'Karawaci'
 WHERE id_pelanggan = 10;

-- Soal 7
-- Ternyata tabel rakamin_customer_address_tangerang belum
-- memiliki data customer baru.
-- Menambahkan ke dalam tabel tersebut satu baris data berikut:
-- id_alamat: 101, id_pelanggan: 70, alamat: Ciledug,
-- kolom kota dan provinsi mengikuti baris-baris lainnya.
INSERT INTO rakamin_customer_address_tangerang (
       id_alamat,
       id_pelanggan,
       alamat,
       kota,
       provinsi
)
VALUES (
       101,
       70,
       'Ciledug',
       'Tangerang',
       'Banten'
);

-- Soal 8
-- Dalam tabel rakamin_customer_address_tangerang, ternyata
-- id_alamat 54 adalah data yang tidak valid dan salah input.
-- Menghapus baris data tersebut!
DELETE FROM rakamin_customer_address_tangerang
 WHERE id_alamat = 54;
