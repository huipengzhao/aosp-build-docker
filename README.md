# AOSP-Build Docker

Based on Ubuntu 22.04

## AOSP Codebase

Until 2024-06-07, The latest AOSP version is android-14.

Assume we have downloaded the `AOSP` codebase to the `/aosp_src` directory with `repo` on the host machine.

Refer to [Download the Android source](https://source.android.com/docs/setup/download) or [AOSP Mirror Help](https://mirrors.tuna.tsinghua.edu.cn/help/AOSP/) for further help.

## Build Docker Image

The official AOSP build env is maintained on `X86_64` platform only, so we specify the `--platform` option regardless of the host platform.

Now we build the docker image named `aosp-build`.

```bash
docker build --platform linux/amd64 -t aosp-build:latest -f Dockerfile .
```

NOTE, until 2024.6, there may be a [rosetta bug](https://github.com/docker/for-mac/issues/7255) on MacOS with Apple Chip M2 and M3, so we may have to disable rosetta in `Docker Desktop` → `Settings` → `General`.

## Run A Build Docker Container

Run a container named `aosp` of the `aosp-build` image with `-h`, `-v` and `-w` options.

```bash
docker run --platform linux/amd64 --rm -d --name -m 16g aosp -h aosp -v /aosp_src:/aosp -w /aosp aosp-build
```

Note, the default memory limit of Docker Desktop is 8GB, but more than 16GB is required to build the AOSP, enlarge the limit before run the container:

`Docker Desktop` → `Settings` → `Resources` → `Memory limit`

## Open A Bash To The Build Docker Container

```bash
docker exec -it aosp /bin/bash
```

## Helper

```bash
./helper build
```

```bash
./helper run ../android-14.0.0_r1
```

```bash
./helper bash
```

```bash
./helper stop
```

```bash
./helper clean
```
