---
layout: title
title: MongoDB vs PostgreSQL in GIS
date: 2017-09-11 09:11:06
tags: database
categories: GIS
---

开源的空间数据库比较少见，最近一个小项目需要用到，所以特地还对比了一番。

PostgreSQL 能够使用PostGIS的全套功能，当然这并不是一个优势。但是可以做一些有用的东西，比如你可以查找在地图上的某一个半径内的兴趣点。就可以用earth distance的模块和gist索引。

Mongodb的话就可以使用geoNear的方法，同时搭配的就是2d空间索引。其实大同小异。

PostgreSQL的查询很快速而且很灵活，可以很好的扩展。在MongoDB上会麻烦一些。

在考虑这两者的时候，也需要考虑很多如：

在SQL方面支持更好的是

数据是否是结构化的，是否会有一些半结构化的存在。

是否需要ACID的保证。

是否需要查询多表

在MongoDB支持更好的是

是否需要高强度的扩容。

js 或者 JSON的编程方式
