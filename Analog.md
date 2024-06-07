```
docker pull analoglabs/timechain
```

```
docker run -d -p 9944:9944 -p 30403:30303 analoglabs/timechain --base-path /data --rpc-external --rpc-methods=Unsafe --unsafe-rpc-external
```

chạy lệnh để lấy ID

```
docker ps -a
```
sau đó thay id vào container name ở dưới
```
docker exec -it <container_name> analog-node status
```
```
docker exec -it <container_name> sh -c "echo $PATH"
```

```
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
```
