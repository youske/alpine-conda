dockerfile Alpine Linux with miniconda
======================================

# 概要
alpinelinux ベースanacondaを導入したイメージ

youske/alpine-conda;latest <- miniconda2
youske/alpine-conda;miniconda2 <-2 miniconda
youske/alpine-conda:miniconda3

# 導入

base image
docker pull youske/alpine-conda:miniconda


miniconda
https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh

# setting
user: admin
pass: admin
homedir: /home/admin


# etc
