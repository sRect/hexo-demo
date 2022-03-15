FROM nginx:latest

WORKDIR /usr/share/nginx/hexo

# 删除nginx 默认配置
RUN rm /etc/nginx/conf.d/default.conf

# 添加自己的配置 default.conf 在下面
ADD nginx.conf /etc/nginx/conf.d/default.conf
# 将public目录下的文件全部复制到/usr/share/nginx/hexo下面
COPY public /usr/share/nginx/hexo

EXPOSE 8002