---
layout: post
title: Windows and GitHub Pages and Jeklly Building owns Bolg
date: 2018-11-14
categories: Blog
tags:  
 - GitHub Pages  
 - jeklly Blog
---

# Windows By GitHub Pages and Jekyll building Blog
## Install Tools
+ 整个流程参考链接如下，包括博客的模板
+ [Visit Link](https://blog.csdn.net/xudailong_blog/article/details/78762262)

## github
1. Building yourself github account number.
2. Build a New respository.
    + Name : “github_name”.github.io (ep: quronghui.github.io)
3. git clone 选好的模板
4. 上传到你的GitHub

## Github Page
+ GitHub Page 相当于一个服务器
+ Jekyll 运行在 GitHub Page 上

## Jekyll 环境的搭建
### Jekyll Knowledge
1. Jekyll 是一个简单的博客形态的静态站点生产机器
2. Jeklly 的一个最好的特点是“关注 blog 本身”，一个文件夹_posts下进行管理，减少繁琐

### Jekyll 搭建
1. GitHub Pages + jekyll 的方式
    + 直接参考这个Link 
    + [Jekyll环境的搭建](https://643435675.github.io/2015/02/15/create-my-blog-with-jekyll/)

### Jekyll 搭建中安装包的说明
1. 安装[Ruby](http://www.runoob.com/ruby/ruby-tutorial.html)
    + Ruby 是一种开源的面向对象程序设计的服务器端脚本语言
    + 没找到在Blog中担当的角色
2. 安装RubyGems
    + 用于对 Ruby 组件进行打包的 Ruby 打包系统
    + 也就是 Ruby 的管理系统
    + 用Rubygem 安装Jekyll,所有的依赖包都会被安装
3. 用RubyGems安装Jekyll
4. cd到博客文件夹，开启服务器
5. 访问 http://localhost:4000/
6. 提交代码到远程GitHub上
+ [jekyll 中文说明文档](https://www.jekyll.com.cn/docs/posts/)

### Jekyll 变量语法
1. jekyll serve 
    + => 一个开发服务器将会运行在 http://localhost:4000/
    + 始终需要重新更新
2. jekyll serve --watch
    + 本地调试的时候，会自动更新 
3. categories 和 tags
    + categories 属性归类
    + tags 类似于搜索标签
4. date 变量
    + 这个日期会覆盖文件命名的日期，并作为发布的时间。

### Jekyll 文件夹   
1. _posts Blog文件夹
    + 年-月-日-标题.MARKUP
    + MARKUP : 是一种标记，是用什么格式写。 
    + example .md 和 .textile
2. _assets 图片和文档目录
    + 图片和文档的引用，前提是图片和文档放在assets 目录下
    + ![图片]({{ site.url }}/assets/name.jpg)
    + [PDF文档]({{ site.url }}/assets/name.pdf)
3. _drafts 草稿文件夹
    + 保存一些占时没有写好的文档，不会进行发表。
    + jekyll serve --drafts : 查看未发表的草稿博客
    
### github.io 文件夹目录
1. index.html -- 创建主页面
    + 任何网站的配置一样，需要按约定在站点的要目录下找到index.html
    + 这个文件就将是你的 Jekyll 生成站点的**主页**。
2. 为其他文件创建页面
    + 命名 HTML 文件
    ![html]({{ site.url }}/assets/img/html.png)
    + 没有真正理解这个每个页面的展示，没有成功实现
3. _config.yml -- 文件
    + 修改文件，好像本地博客不会发生改变
### 代码亮亮
1. 代码亮亮   
    ![code]({{ site.url }}/assets/img/code.png)
2. 给代码加入行号  
    ![line]({{ site.url }}/assets/img/line.png)
