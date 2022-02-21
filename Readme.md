# Theia IDE

A [Docker](http://docker.com) file to build images for AMD & ARM devices with a installation of [Eclipse Theia IDE](https://theia-ide.org/) an extensible platform to develop multi-language Cloud & Desktop IDEs with state-of-the-art web technologies.

> Be aware! You should read carefully the usage documentation of every tool!

## Thanks to

- [Eclipse Theia IDE](https://theia-ide.org/)

## Details

| Website | GitHub | Docker Hub |
| --- | --- | --- |
| [Deft.Work my personal blog](https://deft.work) | [theia](https://github.com/elswork/theia) | [theia](https://hub.docker.com/r/elswork/theia) |

| Docker Pulls | Docker Stars | Size | Sponsors |
| --- | --- | --- | --- |
| [![Docker pulls](https://img.shields.io/docker/pulls/elswork/theia.svg)](https://hub.docker.com/r/elswork/theia "theia on Docker Hub") | [![Docker stars](https://img.shields.io/docker/stars/elswork/theia.svg)](https://hub.docker.com/r/elswork/theia "theia on Docker Hub") | [![Docker Image size](https://img.shields.io/docker/image-size/elswork/theia)](https://hub.docker.com/r/elswork/theia "theia on Docker Hub") | [![GitHub Sponsors](https://img.shields.io/github/sponsors/elswork)](https://github.com/sponsors/elswork "Sponsor me!") |

## Build Instructions

Build for amd64 arm64 or armv7l architecture (thanks to its [Multi-Arch](https://blog.docker.com/2017/11/multi-arch-all-the-things/) base image)

``` sh
docker build -t elswork/theia .
```

## Start Theia IDE

``` sh
make start
``` 
Or
``` sh
docker run -d -p 3000:3000 -v "$(pwd):/home/project:cached" elswork/theia
```

---
**NOTE**

The node user has the same user and group ID as the typical user's system group ID (that is my case).

---
**[Sponsor me!](https://github.com/sponsors/elswork) Together we will be unstoppable.**

Other ways to fund me:

[![GitHub Sponsors](https://img.shields.io/github/sponsors/elswork)](https://github.com/sponsors/elswork) [![Donate PayPal](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/donate/?business=LFKA5YRJAFYR6&no_recurring=0&item_name=Open+Source+Donation&currency_code=EUR) [![Donate with Bitcoin](https://en.cryptobadges.io/badge/micro/18yfsHW2ma4SiY685wh4h7a1aTCqkq2AEc)](https://en.cryptobadges.io/donate/18yfsHW2ma4SiY685wh4h7a1aTCqkq2AEc) [![Donate with Ethereum](https://en.cryptobadges.io/badge/micro/0x186b91982CbB6450Af5Ab6F32edf074dFCE8771c)](https://en.cryptobadges.io/donate/0x186b91982CbB6450Af5Ab6F32edf074dFCE8771c)
