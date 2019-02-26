---
layout: '[layout]'
title: HEXO Github
date: 2019-02-18 11:28:16
tags: linux hexo github
categories: Blog
---

# Linux 下HEXO + Github 搭建博客

## HEXO 环境搭建流程

- [HEXO 环境搭建流程](https://www.jianshu.com/p/a0a27d840992)

1. 安装Nodejs 和 npm
2. 正式安装Hexo
3. 初始化文件夹 hexo init

## Github 的部署

1. github 上建立repository ；
2. 命名为 username.github.io; 
3. 修改hexo 目录下的_config.yml

```
修改hexo 目录下的_config.yml
  deploy:
  type: git
  repository: https://github.com/quronghui/quronghui.github.io.git
  branch: master
```

4. 配置github

   ```
   $ git config --global user.name "yourName"
   $ git config --global user.eamil "email@example.com"
   ```

## HEXO 主题的修改 

- 使用 [NEXT](https://blog.csdn.net/qq_32454537/article/details/79482896)主题
  1. 更改主题配置文件(NEXT)中的，站点配置文件`_config.yml`
  2. 动态效果还未实现
- [官方NEXT的配置文档](http://theme-next.iissnan.com/getting-started.html#avatar-setting)
  1. avatar 下添加头像
- [Hexo的Next主题详细配置](https://www.jianshu.com/p/3a05351a37dc)

## HEXO 博客分支备份

- [参考教程](https://www.jianshu.com/p/57b5a384f234)

1. 在 hexo 博客文件夹下，创建两个分支（[Github 的部署](Github 的部署), 修改_config.yml时，只是添加git的源在里面，没有进行add 或者clone，因此没有master主分支）

   ```
   $ git branch dev(master)		// 创建分支,dev只是分支名字
   $ git checkout dev(master)		// 分支切换（也就是设置默认分支）
   ```

2. `clone` 博客文件到本地，git clone https://github.com/quronghui/quronghui.github.io.git

3. 将之前的hexo文件夹中的文件 ，复制至username.github.io文件夹，为了进行一次分支提交；

   ```
   _config.yml
   themes/
   source/
   scaffolds/
   package.json
   .gitignore
   ```

4. 将themes/next/ 下的.git/删除，否则无法将主题文件夹push；

   ```
   delete :
   	themes/next/ 下的.git/删除
   	两个地方都删除
   ```

5. 在username.github.io 下创建分支dev , 并且切换分支dev

   + 这样以后就在username.github.io 下工作

   ```
   分支：
   	git branch dev
   	git checkout dev
   install
   	sudo npm install
   	sudo npm install hexo-deployer-git --save
   ```

6. 提交文件到分支dev上。

   ```
   git add -A ;
   git commit -m "" ;
   git push origin dev ;
   ```

7. 部署至Github上

   ```
   hexo g
   hexo d
   ```

## HEXO 博客迁移

- 主要是需要重装一遍环境

1. 安装git；

2. 安装Nodejs和npmwin；

3. 使用`git clone -b hexo https://github.com/quronghui/quronghui.github.io.git 将仓库拷贝至本地；

4. 在文件夹内执行以下命令 

   ```
   npm install hexo-cli -g
   npm install
   npm install hexo-deployer-git
   ```

## HEXO 博客分支问题

1. 在quronghui.github.io 文件夹下进行提交的时候，产生了很多冲突。因此，我直接删除hexo文件夹。

2. 使用clone将仓库拷贝至本地；

   ```
   git clone -b hexo https://github.com/quronghui/quronghui.github.io.git 
   ```

3. 在文件夹内执行以下命令

   ```
   sudo npm install
   sudo npm install hexo-deployer-git
   ```

4. 这样相当于在本地重建环境

## HEXO关于Tags 点击无反应

+ [参考链接](https://blog.csdn.net/qq_42247008/article/details/85003789)

1. 添加标签 ：  hexo new page tags

2. 确定配置文件中，大小写一致

   + 确认**站点**配置文件里有tag_dir: tags
   + 确认主题配置文件里有tags: /tags

3. 编辑站点的source/tags/index.md，添加

   ```
   title: tags
   date: 2015-10-20 06:49:50
   type: "tags"
   comments: false
   ```

## HEXO 添加搜索

1. npm install hexo-generator-searchdb --save

2. 修改站点配置文件

   ```
   search:
       path: search.xml
       field: post
       format: html
       limit: 10000
   ```

3. 修改主题配置文件

   ```
   hemes/next下的_config.yml文件
   local_search:
       enable: true## HEXO 添加搜索
   ```


## HEXO 修改默认生成的文档界面

1. 站点配置文件_config.yml查看

   ```
   default_layout ：post
   ```

2. 修改

   ```
   /scaffolds/post : 修改默认页面
   	layout: post
   	title: {{ title }}
   	date: {{ date }}
   	categories: 
   	tags: 
   ```

3. 新建页面

   + 使用 hexo new post < name >

## HEXO 文章引用pdf  -- 可查看 

1. 安装pdf插件

   ```
   npm install --save hexo-pdf
   ```

2. 本地存在的pdf 

   ```
   1. 将pdf文件放在 /source/_post/name 下
   2. 文档中使用 {% pdf ./pdf名字.pdf %}
   ```

3. 网上链接

   ```
   {% pdf http://7xov2f.com1.z0.glb.clouddn.com/bash_freshman.pdf %}
   ```

## HEXO 添加本地文件下载

1. 调整程序配置文件_config.yml 里的post_asset_folder:这个选项设置为True

2. 在source下创建/document文件夹

   ```
   mkdir document
   把文件复制到这个文件夹
   ```

3. 在 .md 中引入

    [ name ]（/ document /name.ppt）

## HEXO markdown文档添加多个分类

1. 添加子分类

   ```
   categories:
     - Java
     - Servlet
   ```

2. 添加多个分类

   ```
   categories:
     -[Java]
     -[Servlet]
   ```

   