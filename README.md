# Nut-server

Slim Docker image featuring embedded Nut server from [blawar/nut](https://github.com/blawar/nut) latest release that works for most.

## Features

- Thin Docker image.
- Very low memory usage.
- Designed to work on amd64 arch (Linux, Unix).
- Cron task to poll new titles.
- Zero config bundle.
- Seamless integration for [Tinfoil](https://tinfoil.io/).

## Usage

```bash
# Pull image from Docker hub
docker pull eskwisit/nut-server

# Run image
docker run -d --name=nut-server -v /path/to/titles:/titles:rw eskwisit/nut-server
```
