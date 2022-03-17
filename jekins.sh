# npm install -g yarn
# yarn config set registry https://registry.npm.taobao.org
# yarn install

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
  sudo docker image rm registry.cn-hangzhou.aliyuncs.com/<你的阿里云镜像容器服务-命名空间>/<你的阿里云镜像容器服务-仓库名称>:latest
} || { # catch
  echo "旧的镜像不存在==>"
}

sudo docker image build -t hexo-blog .

sudo docker tag hexo-blog registry.cn-hangzhou.aliyuncs.com/<你的阿里云镜像容器服务-命名空间>/<你的阿里云镜像容器服务-仓库名称>:latest

sudo docker container run -d -p 8002:80 --name hexo-blog registry.cn-hangzhou.aliyuncs.com/<你的阿里云镜像容器服务-命名空间>/<你的阿里云镜像容器服务-仓库名称>:latest

sudo docker login --username=<你的阿里云容器镜像用户名> registry.cn-hangzhou.aliyuncs.com --password=<你的阿里云容器镜像密码>

sudo docker push registry.cn-hangzhou.aliyuncs.com/<你的阿里云镜像容器服务-命名空间>/<你的阿里云镜像容器服务-仓库名称>:latest

sudo docker logout

echo "部署成功==>"
