<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');
include 'konekdb.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['id'])) {
    echo json_encode(['pesan' => 'ID kosong']);
    exit;
}

$stmt = $konekdb->prepare("DELETE FROM produk WHERE id = :id");
$stmt->bindParam(':id', $data['id']);

if ($stmt->execute()) {
    echo json_encode(['pesan' => 'Sukses hapus']);
} else {
    echo json_encode(['pesan' => 'Gagal hapus']);
}
?>