#!/bin/sh

## 此Shell脚本用于安装Nginx

## Version      20190519.00

#### 版本 设置 
VERSION_OPENSSL="1.1.1c"
VERSION_PCRE="8.43"
VERSION_ZLIB="1.2.11"
VERSION_NGINX="1.16.1"

#### 没有特殊需求，请不要修改
WEB_PATH_OPENSSL="https://www.openssl.org/source/openssl-$VERSION_OPENSSL.tar.gz"
WEB_PATH_PCRE="https://ftp.pcre.org/pub/pcre/pcre-$VERSION_PCRE.tar.gz"
WEB_PATH_ZLIB="https://www.zlib.net/zlib-$VERSION_ZLIB.tar.gz"
WEB_PATH_NGXIN="http://nginx.org/download/nginx-$VERSION_NGINX.tar.gz"

#### 路径 设置
TEMP_DIR="/tmp/nginx-install-temp-file"
PATH_NGINX_BIN="/usr/local/bin/nginx-$VERSION_NGINX"


#### 判断临时文件夹是否存在
if [ ! -d $TEMP_DIR ];then
    mkdir $TEMP_DIR
else
    OLD_TEMP_DIR=$TEMP_DIR.$RANDOM

    mv $TEMP_DIR $OLD_TEMP_DIR
    mkdir $TEMP_DIR
    echo -e "\033[36m[INFO]\033[0m 发现旧文件，文件已经移动到 $OLD_TEMP_DIR"
fi



#### Wget检查
if [ ! -x /bin/wget ];then
    echo -e "\033[31m[ERROR]\033[0m 缺少wget 脚本结束"
    exit 127
fi


cd $TEMP_DIR



# #### OpenSSL 下载
echo -e "\033[36m[INFO]\033[0m 正在获取 OpenSSL-$VERSION_OPENSSL"

wget -P $TEMP_DIR $WEB_PATH_OPENSSL
tar -zxf $TEMP_DIR/openssl-$VERSION_OPENSSL.tar.gz

if [ $? -ne 0 ];then
    echo -e "\033[31m[ERROR]\033[0m OpenSSL-$VERSION_OPENSSL 获取失败"
    exit 10
fi
echo -e "\033[36m[INFO]\033[0m OpenSSL-$VERSION_OPENSSL 获取成功"
LOCAL_PATH_OPENSSL="$TEMP_DIR/openssl-$VERSION_OPENSSL"



# #### PCRE 下载
echo -e "\033[36m[INFO]\033[0m 正在获取 PCRE-$VERSION_PCRE"

wget -P $TEMP_DIR $WEB_PATH_PCRE
tar -zxf $TEMP_DIR/pcre-$VERSION_PCRE.tar.gz

if [ $? -ne 0 ];then
    echo -e "\033[31m[ERROR]\033[0m PCRE-$VERSION_PCRE 获取失败"
    exit 10
fi
echo -e "\033[36m[INFO]\033[0m PCRE-$VERSION_PCRE 获取成功"
LOCAL_PATH_PCRE="$TEMP_DIR/pcre-$VERSION_PCRE"



# #### ZLib 下载
echo -e "\033[36m[INFO]\033[0m 正在获取 ZLib-$VERSION_ZLIB"

wget -P $TEMP_DIR $WEB_PATH_ZLIB
tar -zxf $TEMP_DIR/zlib-$VERSION_ZLIB.tar.gz

if [ $? -ne 0 ];then
    echo -e "\033[31m[ERROR]\033[0m ZLib-$VERSION_ZLIB 获取失败"
    exit 10
fi
echo -e "\033[36m[INFO]\033[0m ZLib-$VERSION_ZLIB 获取成功"
LOCAL_PATH_ZLIB="$TEMP_DIR/zlib-$VERSION_ZLIB"



# #### Nginx 下载
echo -e "\033[36m[INFO]\033[0m 正在获取 Nginx-$VERSION_NGINX"

wget -P $TEMP_DIR $WEB_PATH_NGXIN
tar -zxf $TEMP_DIR/nginx-$VERSION_NGINX.tar.gz

if [ $? -ne 0 ];then
    echo -e "\033[31m[ERROR]\033[0m Nginx-$VERSION_NGINX 获取失败"
    exit 10
fi
echo -e "\033[36m[INFO]\033[0m Nginx-$VERSION_NGINX 获取成功"
LOCAL_PATH_NGINX="$TEMP_DIR/nginx-$VERSION_NGINX"



#### brotli
echo -e "\033[36m[INFO]\033[0m 正在获取 ngx_brotli"
git clone https://github.com/google/ngx_brotli
cd ngx_brotli
git submodule update --init
if [ $? -ne 0 ];then
    echo -e "\033[31m[ERROR]\033[0m ngx_brotli 获取失败"
    exit 10
fi
echo -e "\033[36m[INFO]\033[0m ngx_brotli 获取成功"
cd ..
LOCAL_PATH_BROTLI="$TEMP_DIR/ngx_brotli"



#### 构建 Nginx
cd $LOCAL_PATH_NGINX

echo -e "\033[36m[INFO]\033[0m 开始构建 nginx"

./configure \
--prefix=$PATH_NGINX_BIN \
--with-openssl=$LOCAL_PATH_OPENSSL \
--with-pcre=$LOCAL_PATH_PCRE \
--with-zlib=$LOCAL_PATH_ZLIB \
--add-module=$LOCAL_PATH_BROTLI \
--with-http_realip_module \
--with-http_ssl_module \
--with-http_v2_module

make && make install

if [ $? -ne 0 ];then
    echo -e "\033[31m[ERROR]\033[0m nginx 构建失败"
    exit 10
fi
echo -e "\033[36m[INFO]\033[0m nginx 构建成功"