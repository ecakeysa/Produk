<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header('Content-Type: application/json');
include 'konekdb.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['kode']) || !isset($data['nama']) || !isset($data['harga'])) {
    echo json_encode(['error' => 'Data tidak lengkap']);
    exit;
}

try {
    // TAMBAHKAN kategori dan deskripsi ke dalam SQL
    $sql = "INSERT INTO produk (kode, nama, harga, url_gambar, kategori, deskripsi) 
            VALUES (:kode, :nama, :harga, :url_gambar, :kategori, :deskripsi)";
    
    $stmt = $konekdb->prepare($sql);
    $stmt->bindParam(':kode', $data['kode']);
    $stmt->bindParam(':nama', $data['nama']);
    $stmt->bindParam(':harga', $data['harga']);
    $stmt->bindParam(':url_gambar', $data['url_gambar']);
    $stmt->bindParam(':kategori', $data['kategori']); // BARU
    $stmt->bindParam(':deskripsi', $data['deskripsi']); // BARU
    
    $stmt->execute();

    echo json_encode(['Sukses' => 'Produk Berhasil ditambah', 'id' => $konekdb->lastInsertId()]);
} catch (PDOException $e) {
    echo json_encode(['Error' => $e->getMessage()]);
}
?>