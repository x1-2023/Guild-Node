# cc3Node
Guidl Node
Cài đặt docker


```
sudo docker pull gluwa/creditcoin3:3.23.0-testnet
```
```
mkdir ~/chain_data
chmod -R 777 ~/chain_data
```
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

Chờ nó sync khoảng 30'

Chạy lệnh check xem node có hoạt động không:
```
docker exec -it creditcoin-validator creditcoin --help
```

Tạo một tài khoản mới: 
```
docker exec creditcoin-validator creditcoin new
```
Backup seedphare

Sử dụng lệnh này để kiểm tra địa chỉ ví: 
```
docker exec -it creditcoin-validator creditcoin show-address
```

Sau đó hãy faucet hoặc chuyển ctc sang 

Kiểm tra  balance ví : 
```
docker exec -it creditcoin-validator creditcoin balance --substrate-address <địa chỉ ví>
```

tạo Validator
```
docker exec -it creditcoin-validator creditcoin wizard --amount 20100
```

Kiểm tra trạng thái validator:
```
docker exec -it creditcoin-validator creditcoin status --substrate-address <địa chỉ ví>
```

Chờ nó thôi




