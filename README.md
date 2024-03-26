# cc3Node
Guidl Node
Cài đặt docker


sudo docker pull gluwa/creditcoin3:3.23.0-testnet
Step 1
sudo mkdir -p $HOME/c3cnode && cd $HOME/c3cnode


docker run \
 --name creditcoin-validator \
 -p 30333:30333 \
 -v ~/chain_data:/data \
 gluwa/creditcoin3:3.23.0-testnet `# Enter latest testnet image` \
 --name "NodeGenius" `# name the validator` \
 --public-addr "/dns4/4gdata.vinaddns.com/tcp/30333" \
 --chain testnet `# we want to connect to the testnet` \
 --bootnodes "/dns4/cc3-test-bootnode.creditcoin.network/tcp/30333/p2p/12D3KooWAxmsWr6iEjFyLqQBzfLvbCRTAhYBeszyr8UWgQx6Zu7K" \
 --validator `# we want to run a validator node` \
 --base-path /data \
 --port 30333 # the port to use for node-to-node communications
