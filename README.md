# Linux 下HEXO + Github 搭建博客
## HEXO 环境搭建流程

- [HEXO 环境搭建流程](https://www.jianshu.com/p/a0a27d840992)

1. 安装Nodejs 和 npm
2. 正式安装Hexo
3. 初始化文件夹 hexo init

## Github 的部署

1. 修改打开hexo 目录下的_config.yml：deploy -- 下的repository

## HEXO 主题的修改 

- 使用 [NEXT](https://blog.csdn.net/qq_32454537/article/details/79482896)主题
  1. 更改主题配置文件(NEXT)中的，站点配置文件`_config.yml`
  2. 动态效果还未实现
- [官方NEXT的配置文档](http://theme-next.iissnan.com/getting-started.html#avatar-setting)
- [Hexo的Next主题详细配置](https://www.jianshu.com/p/3a05351a37dc)

## HEXO 博客备份

- [参考教程](https://www.jianshu.com/p/57b5a384f234)

1. 在 hexo 博客文件夹下，创建两个分支（[Github 的部署](Github 的部署), 修改_config.yml时，只是添加git的源在里面，没有进行add 或者clone，因此没有master主分支）

   ```
   $ git branch dev(master)		// 创建分支,dev只是分支名字
   $ git checkout dev(master)		// 分支切换（也就是设置默认分支）
   ```

2. `clone` 博客文件到本地，git clone https://github.com/quronghui/quronghui.github.io.git

3. 将之前的hexo文件夹中的`_config.yml`，`themes/`，`source/`，`scaffolds/`，`package.json`，`.gitignore`复制至username.github.io文件夹，为了进行一次分支提交；

4. 将themes/next/ 下的.git/删除（两个地方的都删除一下），否则无法将主题文件夹push；

5. 在username.github.io 下创建分支dev , 并且切换分支dev

   - 源文档上是在username.github.io 安装了npm和git提交源，这样以后就在username.github.io 下工作

6. 执行`git add .`、`git commit -m ""`、`git push origin hexo`来提交hexo网站源文件，提交到分支dev上。

7. 将在username.github.io 提交后得到的 .git 文件， 复制到hexo 博客文件夹下，删除username.github.io文件夹。

8. 此时，在hexo 博客下便能切换master和dev，在不同的分支下进行工作；

## HEXO 博客迁移

- 主要是需要重装一遍环境

1. 安装git；
2. 安装Nodejs和npm；
3. 使用`git clone git@github.com:WincerChan/WincerChan.github.io.git`将仓库拷贝至本地；
   + 存在一个问题：通过Clone就会很慢；
4. 在文件夹内执行以下命令`npm install hexo-cli -g`、`npm install`、`npm install hexo-deployer-git`。

## 直接通过原来备份的文件进行迁移

1. 先安装git；然后安装Nodejs和npm；

2. 执行命令安装hexo-cli：`npm install hexo-cli -g`

3. 使用Hexo初始化一个blog

   ```
   $ hexo init HexoBlog	// 初始化一个新项目；
   ```

4. 在文件夹中切换到分支内容（push到git上的内容），然后将内容全部复制到HexoBlog里面；

5. 然后安装`npm install`、`npm install hexo-deployer-git`

6. 最后就可以正常使用 hexo g 和 hexo d

## 阿里云域名的绑定

- [参考链接](https://juejin.im/post/5a71a4f9518825733a3105ac)

1. 阿里云域名的购买
2. 域名的解析
3. github 修改
4. 博客目录下进行修改
   - 在 `hexo` 生成的博客的 `source` 目录下新建一个 `CNAME` 文件，然后在这个文件中填入你的域名，这样就不会每次发布之后，`gitpage` 里的 `custom domain` 都被重置掉啦。

## hexo 博客menu 单词错误

1. 跟着网上的教程，弄得hexo deploy 时候，静态界面出现404错误；
2. 通过以前备份的文件，宠新提交才能用