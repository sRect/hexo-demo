npm install -g yarn

yarn install

{ # try
  echo "暂停旧的容器==>"
  sudo docker container stop hexo-blog
} || { # catch
  echo "旧的容器不存在==>"
  # save log for exception
}

{ # try
  echo "删除旧的容器==>"
  sudo docker container rm hexo-blog
} || { # catch
  echo "旧的容器不存在==>"
}

{ # try
  echo "删除旧的镜像==>"
  sudo docker image rm registry.cn-hangzhou.aliyuncs.com/test-blog/hexo-blog:latest
} || { # catch
  echo "旧的镜像不存在==>"
}

sudo docker login --username=srect2018 registry.cn-hangzhou.aliyuncs.com --password=xxx

sudo docker image build -t hexo-blog .

sudo docker tag hexo-blog registry.cn-hangzhou.aliyuncs.com/test-blog/hexo-blog:latest

sudo docker container run -d -p 8002:8002 --name hexo-blog registry.cn-hangzhou.aliyuncs.com/test-blog/hexo-blog:latest

sudo docker push registry.cn-hangzhou.aliyuncs.com/test-blog/hexo-blog:latest

sudo docker logout

echo "部署成功==>"
