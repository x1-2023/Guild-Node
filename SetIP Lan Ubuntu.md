*Để cố định IP không bị reset sau mỗi lần khởi động lại máy, làm cách sau

Gõ lệnh sau để mở tệp cấu hình mạng
```
sudo nano /etc/netplan/01-netcfg.yaml
```

Tệp cấu hình mạng sẽ mở trong trình soạn thảo nano. Bạn sẽ thấy một số nội dung tương tự như sau:
```
network:
    version: 2
    renderer: networkd
    ethernets:
        ens33:
            dhcp4: true
```

Sửa đổi tệp cấu hình mạng chuyển từ DHCP sang Ip tĩnh:
```
network:
    version: 2
    renderer: networkd
    ethernets:
        ens33:
            dhcp4: no
            addresses: [192.168.1.100/24]
            gateway4: 192.168.1.1
            nameservers:
                addresses: [8.8.8.8, 8.8.4.4]
```

Sau khi sửa xong nhấn CtrX, nhấn Y, sau đó nhấn Enter

```
sudo netplan apply
```
Chạy lệnh này để áp dụng thay đổi
