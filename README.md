# Build an image to be able to watch streams on Kick.com via streamlink

After users encounter [a problem](https://github.com/nonvegan/streamlink-plugin-kick/issues/1) I decided to write this Dockerfile

It runs within Docker container. So you have to install Docker first

The receipts below tested and work on Linux

## Deployment

### Build an image

```bash
wget https://raw.githubusercontent.com/br4instormer/streamlink-kick/main/Dockerfile
docker build -t streamlink-kick:latest --build-arg={uid=$(id -u),gid=$(id -g)} .
```

## Using

### Get stream information

```bash
docker run --rm -it streamlink-kick https://kick.com/<user>
```

### Record VOD/stream in current local directory. Detached mode

```bash
docker run --rm -d --name "streamlink-kick" -v "$PWD:/recordings" streamlink-kick -o "<output_file_name>" https://kick.com/<user> <quality>
```

### Record VOD/stream in current local directory. Interactive mode

You can stop recording with `CTRL+C`

```bash
docker run --rm --it --name "streamlink-kick" -v "$PWD:/recordings" streamlink-kick -o "<output_file_name>" https://kick.com/<user> <quality>
```

### Watch stream from remote streamlink

`9000` - is your local port on host machine

`8080` - is port within docker container

```bash
docker run --rm -d -p 9000:8080 --name "streamlink-kick" streamlink-kick --player-external-http --player-external-http-port 8080 https://kick.com/<user> <quality>
# give some time to streamlink connect streaming service
# sleep 3
vlc http://localhost:9000
```

### View logs of detached container

```bash
docker logs -f streamlink-kick
```

## Credits

[Streamlink](https://github.com/streamlink/streamlink)

[Documentation](https://streamlink.github.io/index.html)

[Kick.com plugin](https://github.com/nonvegan/streamlink-plugin-kick)
