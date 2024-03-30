***cc3Node***
* Đổi mật khẩu người dùng Root
```
sudo passwd root
```
Nhập pass của người dùng hiện tại, sau đo nhập pass mới và xác nhận lại pass

* Chuyển đổi sang người dùng root
```
sudo -i
```

* Tắt Firewall
```
sudo ufw disable
```

*** Setup Proxy ***
```
sudo nano /etc/environment
```

Thêm các dòng sau vào cuối tệp cấu hình (thay bằng địa chỉ proxy)

```
http_proxy="http://mobi4:Mobi1234@proxy.nodegenius.xyz:5104/"
https_proxy="http://mobi4:Mobi1234@proxy.nodegenius.xyz:5104/"
ftp_proxy="http://mobi4:Mobi1234@proxy.nodegenius.xyz:5104/"
```
Nhấn Ctrl + X, sau đó nhấn Y và enter để lưu và đóng tệp

```
source /etc/environment
```

Tiếp theo reset lại server bằng lệnh:

```
sudo reboot
```

Check xem proxy đã hoạt động chưa
```
env | grep -i proxy
```

Kiểm tra địa chỉ Ip hiện tại bằng 1 trong 2 cách dưới đây
```
curl icanhazip.com
```

```
wget -qO- https://api.ipify.org
```
* Cài đặt docker (Nếu đã có docker thì bỏ qua)
```
sudo apt update -y && apt upgrade -y
```
```
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```
```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
```
sudo apt update
sudo apt-cache policy docker-ce
```
```
sudo apt install docker-ce -y
```
```
sudo systemctl status docker
```
```
docker info
```
* Tải Docker image
```
sudo docker pull gluwa/creditcoin3:3.23.0-testnet
```
* Tạo thư mục và phân quyền
```
mkdir ~/chain_data
chmod -R 777 ~/chain_data
```
*Chạy Node (nhớ sửa tên, ip...)
```
docker run \
 --name creditcoin-validator \
 -p 30333:30333 \
 -v ~/chain_data:/data \
 gluwa/creditcoin3:3.23.0-testnet `# Enter latest testnet image` \
 --name "NodeGenius" `# Thay Tên` \
 --public-addr "/dns4/4gdata.vinaddns.com/tcp/30333" `#thay IP`\
 --chain testnet `# we want to connect to the testnet` \
 --bootnodes "/dns4/cc3-test-bootnode.creditcoin.network/tcp/30333/p2p/12D3KooWAxmsWr6iEjFyLqQBzfLvbCRTAhYBeszyr8UWgQx6Zu7K" \
 --validator `# we want to run a validator node` \
 --base-path /creditcoin-node/data `# the base path to store the node's data` \
 --port 30333 # the port to use for node-to-node communications
```

*Chờ nó sync khoảng 30'

*Chạy lệnh check xem node có hoạt động không:
```
docker exec -it creditcoin-validator creditcoin --help
```

*Tạo một tài khoản mới: 
```
docker exec creditcoin-validator creditcoin new
```
*Nhớ Backup seedphare

*Sử dụng lệnh này để kiểm tra địa chỉ ví: 
```
docker exec -it creditcoin-validator creditcoin show-address
```

*Sau đó hãy faucet hoặc chuyển ctc sang 

*Kiểm tra  balance ví : 
```
docker exec -it creditcoin-validator creditcoin balance --substrate-address <địa chỉ ví>
```

*Tạo Validator
```
docker exec -it creditcoin-validator creditcoin wizard --amount 20100
```

*Kiểm tra trạng thái validator:
```
docker exec -it creditcoin-validator creditcoin status --substrate-address <địa chỉ ví>
```

*Hỏi mấy thằng trên discord chúng nó bảo chờ 1-2 ngày thì mới Active




