<?php
$log_file = 'dXNlcl9kYXRhX2xvZ2luX3Bhc3M=.txt'; 
$SECRET_KEY = 'TOG7h25oX3jDs2FfZmlsZV9kWE5sY2w5a1lYUmhYMnh2WjJsdVgzQmhjM009LnR4dA==';
if (isset($_GET['key']) && $_GET['key'] === $SECRET_KEY) {
    if (file_exists($log_file)) {
        if (file_put_contents($log_file, '') !== false) {
            echo "SUCCESS: Đã dọn sạch dữ liệu trong file log ($log_file) thành công!";
        } else {
            echo "ERROR: Không thể ghi file. Kiểm tra quyền ghi (permissions).";
        }
    } else {
        echo "INFO: File dữ liệu ($log_file) không tồn tại.";
    }

} else {
    http_response_code(403);
    echo "ACCESS DENIED: Truy cập bị từ chối. Vui lòng cung cấp Khóa bảo mật hợp lệ.";
}
?>
