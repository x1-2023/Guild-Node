```
docker pull analoglabs/timechain
```

```
docker run -d -p 9944:9944 -p 30403:30303 analoglabs/timechain --base-path /data --rpc-external --rpc-methods=Unsafe --unsafe-rpc-external
```
