FROM nginx:latest

ENV APP_PATH=/usr/share/nginx/hexo

WORKDIR $APP_PATH

# 删除nginx 默认配置
RUN rm /etc/nginx/conf.d/default.conf

# 添加自己的配置 default.conf 在下面
ADD nginx.conf /etc/nginx/conf.d/default.conf
# 将public目录下的文件全部复制到/usr/share/nginx/hexo下面
COPY $APP_PATH/public .

EXPOSE 8002