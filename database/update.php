<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');
include 'konekdb.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['id'])) {
    echo json_encode(['pesan' => 'ID tidak ditemukan']);
    exit;
}

try {
    // TAMBAHKAN kategori dan deskripsi ke dalam SET
    $sql = "UPDATE produk SET 
            kode = :kode, 
            nama = :nama, 
            harga = :harga, 
            url_gambar = :url_gambar,
            kategori = :kategori,
            deskripsi = :deskripsi 
            WHERE id = :id";

    $stmt = $konekdb->prepare($sql);
    $stmt->bindParam(':id', $data['id']);
    $stmt->bindParam(':kode', $data['kode']);
    $stmt->bindParam(':nama', $data['nama']);
    $stmt->bindParam(':harga', $data['harga']);
    $stmt->bindParam(':url_gambar', $data['url_gambar']); 
    $stmt->bindParam(':kategori', $data['kategori']); // BARU
    $stmt->bindParam(':deskripsi', $data['deskripsi']); // BARU
    
    $stmt->execute();
    echo json_encode(['pesan' => 'Sukses update']);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['pesan' => 'Gagal: ' . $e->getMessage()]);
} 
?>