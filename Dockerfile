# 1. 基础镜像安装
FROM alpine:3.15 AS base

ENV NODE_ENV=production \
  APP_PATH=/usr/share/nginx/hexo

WORKDIR $APP_PATH

# 使用国内镜像，加速下面 apk add下载安装alpine不稳定情况
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache --update nodejs=16.14.0-r0 yarn=1.22.17-r0

# 2. 基于基础镜像安装项目依赖
FROM base AS install

COPY . ./

RUN yarn install

RUN yarn run build

FROM base AS result

# 将public目录下的文件全部复制到/usr/share/nginx/hexo下面
COPY --from=install $APP_PATH/public .

# 3. 最终基于nginx进行构建
FROM nginx:latest

# 删除nginx 默认配置
# RUN rm /etc/nginx/conf.d/default.conf

# 添加自己的配置 default.conf 在下面
ADD nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=result . /usr/share/nginx/hexo

EXPOSE 80