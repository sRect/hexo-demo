# Hexo 快速上手

> Hexo 是一个快速、简洁且高效的博客框架。可以使用 Markdown 写文章，方便高效。

## 1. 安装

```bash
npm install -g hexo-cli
```

## 2. 初始化

```bash
hexo init <project-name>
cd <project-name>
npm install
```

## 3. 主要 api

1. 创建新文章

```bash
hexo new <title>
```

- 在`source/_posts/`下新建

例如创建 foo 页，在`source/_posts/`目录下就会多出一个`foo.md`文件，就在那里面写文章

```bash
hexo new foo
```

- 在`source`下新建其它的目录

例如在`source/about/`下创建`bar.md`文件

```bash
hexo new page --path about/bar "bar"
```

2. 生成静态文件

项目根目录会多出一个`public`文件夹，就是编译过后的`html`静态文件

```bash
hexo generate
```

3. 清除缓存

把上面生成的`public`文件夹删掉

```bash
hexo clean
```

4. 启动服务

默认情况下，`http://localhost:4000`访问

```bash
hexo server
```

## 4. 安装心仪的主题

1. [hexo themes](https://hexo.io/themes/)

这么多主题，总有一款适合你

2. 本文选择的主题[`hexo-theme-fluid`](https://github.com/fluid-dev/hexo-theme-fluid)

- 主题安装

```bash
npm install --save hexo-theme-fluid
```

然后在博客目录下创建 \_config.fluid.yml，将主题的 \_config.yml 内容复制进去

- 配置主题

修改 Hexo 博客目录中的 \_config.yml:

```
theme: fluid  # 指定主题

language: zh-CN  # 指定语言，会影响主题显示的语言，按需修改
```

## 5. github pages 部署

1. 本地生成 ssh 密钥对

```bash
ssh-keygen -t rsa -C "用户名@example.com "
```

2. 在仓库`Settings > Deploy Keys`中添加公钥内容，并勾选访问权限，最后确定

3. 在仓库`Settings > Secrets`中添加私钥，key 为`DEPLOY_KEY`，内容为私钥内容

4. `.github/workflows/deploy.yml`

```yml
name: Hexo Github Pages Deploy

# https://github.com/marketplace/actions/hexo-action?version=v1.0.4

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    name: A job to deploy blog.
    steps:
      - name: Checkout
        uses: actions/checkout@v1
        with:
          submodules: true # Checkout private submodules(themes or something else).

      # Caching dependencies to speed up workflows. (GitHub will remove any cache entries that have not been accessed in over 7 days.)
      - name: Cache node modules
        uses: actions/cache@v1
        id: cache
        with:
          path: node_modules
          key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
          restore-keys: |
            ${{ runner.os }}-node-
      - name: Install Dependencies
        if: steps.cache.outputs.cache-hit != 'true'
        run: npm ci

      # Deploy hexo blog website.
      - name: Deploy
        id: deploy
        uses: sma11black/hexo-action@v1.0.3
        with:
          deploy_key: ${{ secrets.DEPLOY_KEY }}
          user_name: <你的github用户名> # (or delete this input setting to use bot account)
          user_email: <你的邮箱> # (or delete this input setting to use bot account)
          commit_msg: ${{ github.event.head_commit.message }} # (or delete this input setting to use hexo default settings)
      # Use the output from the `deploy` step(use for test action)
      - name: Get the output
        run: |
          echo "${{ steps.deploy.outputs.notify }}"
```

## 6. 参考资料

1. [Hexo 官方文档](https://hexo.io/zh-cn/docs)
2. [Hexo Fluid 主题用户手册](https://hexo.fluid-dev.com/docs/guide)
3. [Hexo Github Action](https://github.com/marketplace/actions/hexo-action?version=v1.0.4)
