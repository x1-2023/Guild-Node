#!/bin/bash

# Di chuyển đến thư mục nơi bạn muốn lưu trữ tệp script .sh
cd /root

# Sao chép mã nguồn từ GitHub
wget https://raw.githubusercontent.com/x1-2023/Guild-Node/main/cloudflare.sh

# Di chuyển đến thư mục chứa tệp script .sh
cd

# Cấp quyền thực thi cho tệp script .sh
chmod +x cloudflare.sh

# Kiểm tra xem tệp script .sh có chạy đúng không
./cloudflare.sh

# Thêm tệp script .sh vào Crontab
(crontab -l ; echo "* * * * * /root/cloudflare.sh") | crontab -
