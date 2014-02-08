-- phpMyAdmin SQL Dump
-- version 4.1.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2014-02-08 23:39:42
-- 服务器版本： 5.6.15
-- PHP Version: 5.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `yaf_cms`
--

-- --------------------------------------------------------

--
-- 表的结构 `yaf_admin`
--

CREATE TABLE IF NOT EXISTS `yaf_admin` (
  `userid` char(18) NOT NULL DEFAULT '' COMMENT '主键 用户id',
  `password` int(11) NOT NULL COMMENT '密码',
  `name` varchar(50) DEFAULT '' COMMENT '账号唯一索引',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态 1正常,0为封号',
  `admin` int(11) DEFAULT '0' COMMENT '是否管理员：1 是，0 否',
  `regdate` datetime DEFAULT NULL COMMENT '创建时间',
  `logindate` datetime DEFAULT NULL COMMENT '最后登录时间',
  `loginip` char(24) DEFAULT '' COMMENT '登录ip',
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户数据表:admin 用途：用户登录的身份认证';

-- --------------------------------------------------------

--
-- 表的结构 `yaf_admingroup`
--

CREATE TABLE IF NOT EXISTS `yaf_admingroup` (
  `userid` char(18) NOT NULL DEFAULT '' COMMENT '组合主键(userid + channalid) 用户id',
  `adminid` int(18) NOT NULL COMMENT '添加者',
  `channelid` varchar(20) NOT NULL DEFAULT '' COMMENT '频道id（索引）',
  `power` char(32) DEFAULT NULL COMMENT '权限(共32位，每位代表一种权限，0代表没有权限，1代表有权限，第一位代表身份a系统管理员h主编o编辑d美术b实习/兼职)',
  `logdate` datetime DEFAULT NULL COMMENT '最后登录时间',
  `regdate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`userid`,`channelid`),
  KEY `channelid` (`channelid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组权限备注：权限的第一位很重要，可以用来定义角色。不拆表 用途：检查用户是否有对某频道某功能的权限';

-- --------------------------------------------------------

--
-- 表的结构 `yaf_article`
--

CREATE TABLE IF NOT EXISTS `yaf_article` (
  `articleid` bigint(13) unsigned NOT NULL COMMENT '主键文章id(减去基数的时间戳)',
  `title` varchar(100) NOT NULL COMMENT '标题(索引)',
  `title_color` varchar(18) DEFAULT NULL COMMENT '标题颜色',
  `subtitle` varchar(100) DEFAULT NULL COMMENT '副标题',
  `digest` varchar(250) DEFAULT NULL COMMENT '摘要',
  `picurl` varchar(100) DEFAULT NULL COMMENT '图片地址',
  `source` varchar(100) DEFAULT NULL COMMENT '来源(索引)',
  `author` varchar(30) DEFAULT NULL COMMENT '作者(索引)',
  `odertime` datetime DEFAULT NULL COMMENT '预定发布时间',
  `posttime` datetime DEFAULT NULL COMMENT '发布时间(索引)',
  `updatetime` datetime DEFAULT NULL COMMENT '最后修改时间',
  `tags` varchar(100) DEFAULT NULL COMMENT '标签列表(图片是个特殊的tag)',
  `userid` int(11) DEFAULT NULL COMMENT '发布者',
  `updateuid` int(11) DEFAULT NULL COMMENT '更新人',
  `uip` char(24) DEFAULT NULL COMMENT 'ip',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态(0普通，1预定 2未加tag,3抓取 99删除)',
  `logs` varchar(1000) DEFAULT NULL COMMENT '修改日志',
  `content` text COMMENT '内容上限65536字节',
  `daynum` int(11) DEFAULT NULL COMMENT '天数(用于排序)',
  `power` tinyint(4) DEFAULT '1' COMMENT '权重',
  `threadid` bigint(13) unsigned DEFAULT NULL COMMENT '主贴ID',
  `templateid` bigint(13) DEFAULT NULL COMMENT '模板ID(索引)',
  `realtags` varchar(100) DEFAULT NULL COMMENT 'TAG列表',
  `catchurl` varchar(200) DEFAULT NULL,
  `ispic` char(3) DEFAULT 'no' COMMENT '是否头图',
  `showAllPage` tinyint(1) DEFAULT '0',
  `syscWap` tinyint(1) DEFAULT '0',
  `diy1` varchar(2000) DEFAULT NULL COMMENT '自定义字段1',
  `diy2` varchar(2000) DEFAULT NULL COMMENT '自定义字段2',
  `diy3` varchar(2000) DEFAULT NULL COMMENT '自定义字段3',
  `diy4` varchar(2000) DEFAULT NULL COMMENT '自定义字段4',
  `diy5` varchar(2000) DEFAULT NULL COMMENT '自定义字段5',
  KEY `title` (`title`,`source`,`posttime`,`userid`,`templateid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章数据表备注：拆表，每个频道一张表，article_频道id。联合索引：(`status`,`updatetime`)';

-- --------------------------------------------------------

--
-- 表的结构 `yaf_articlecount`
--

CREATE TABLE IF NOT EXISTS `yaf_articlecount` (
  `date` date NOT NULL DEFAULT '0000-00-00' COMMENT '日期，组合主键(`date`,`channelid`,`userid`)',
  `channelid` char(18) NOT NULL DEFAULT '' COMMENT '频道ID ',
  `userid` char(18) NOT NULL DEFAULT '' COMMENT '用户ID',
  `article` smallint(5) unsigned DEFAULT '0' COMMENT '发表文章数量',
  PRIMARY KEY (`date`,`channelid`,`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章统计表：articlecount 联合索引：`userid` (`userid`,`date`)';

-- --------------------------------------------------------

--
-- 表的结构 `yaf_channel`
--

CREATE TABLE IF NOT EXISTS `yaf_channel` (
  `id` char(18) NOT NULL COMMENT '频道ID',
  `channel_name` char(32) NOT NULL COMMENT '频道名(索引)',
  `channel_domain` varchar(64) DEFAULT NULL COMMENT '频道域名',
  `article_file_path` varchar(128) DEFAULT NULL COMMENT '频道文章生成的基路径',
  `pic_domain` varchar(64) DEFAULT NULL COMMENT '频道图片域名',
  `pic_file_path` varchar(128) DEFAULT NULL COMMENT '频道图片存放的基路径',
  `isimportant` tinyint(1) DEFAULT NULL COMMENT '是否重点',
  `upline` tinyint(1) DEFAULT NULL COMMENT '是否上线',
  `category` varchar(16) DEFAULT NULL COMMENT '频道类别',
  PRIMARY KEY (`id`),
  KEY `name` (`channel_name`),
  KEY `name_2` (`channel_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='频道信息表：channel';

-- --------------------------------------------------------

--
-- 表的结构 `yaf_hotword`
--

CREATE TABLE IF NOT EXISTS `yaf_hotword` (
  `hotword` varchar(20) NOT NULL COMMENT '热词',
  `channelid` varchar(18) NOT NULL COMMENT '频道id，联合主键（`channelid`,`hotword`）',
  `url` varchar(120) NOT NULL COMMENT '热词连接',
  PRIMARY KEY (`hotword`,`channelid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='热词表: hotword';

-- --------------------------------------------------------

--
-- 表的结构 `yaf_list`
--

CREATE TABLE IF NOT EXISTS `yaf_list` (
  `tag` varchar(20) NOT NULL DEFAULT '' COMMENT '组合主键(tag + articleid)',
  `articleid` bigint(13) NOT NULL COMMENT '文章id(索引)',
  `title` varchar(100) NOT NULL COMMENT '标题',
  `subtitle` varchar(100) DEFAULT '' COMMENT '副标题',
  `digest` varchar(250) DEFAULT NULL COMMENT '摘要',
  `url` varchar(100) DEFAULT NULL COMMENT '空文章地址',
  `picurl` varchar(100) DEFAULT NULL COMMENT '图片地址',
  `source` varchar(100) DEFAULT NULL COMMENT '来源',
  `author` varchar(30) DEFAULT NULL COMMENT '作者',
  `uid` char(18) DEFAULT NULL COMMENT '发布者',
  `daynum` int(11) DEFAULT NULL COMMENT '天数用于排序',
  `power` tinyint(4) DEFAULT NULL COMMENT '权重',
  `posttime` datetime DEFAULT NULL COMMENT '提交时间',
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间索引()',
  `ispic` char(3) DEFAULT 'no' COMMENT '是否图片',
  `sontag` varchar(20) DEFAULT NULL COMMENT '子tag',
  `sontagid` bigint(13) unsigned DEFAULT NULL COMMENT '子tagid',
  `isdelete` tinyint(4) DEFAULT '0' COMMENT '是否已经删除 ',
  `title_color` varchar(255) DEFAULT NULL COMMENT '标题颜色',
  `diy1` varchar(2000) DEFAULT NULL COMMENT '自定义字段1',
  `diy2` varchar(2000) DEFAULT NULL COMMENT '自定义字段2',
  `diy3` varchar(2000) DEFAULT NULL COMMENT '自定义字段3',
  `diy4` varchar(2000) DEFAULT NULL COMMENT '自定义字段4',
  `diy5` varchar(2000) DEFAULT NULL COMMENT '自定义字段5',
  PRIMARY KEY (`tag`,`articleid`),
  KEY `articleid` (`articleid`,`posttime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='lsit_频道id 备注：拆表，每个频道一张表，list_频1道id 用途：保存各标签下的文章信息。联合索引：`tag`';

-- --------------------------------------------------------

--
-- 表的结构 `yaf_tagtree`
--

CREATE TABLE IF NOT EXISTS `yaf_tagtree` (
  `channelid` char(18) NOT NULL COMMENT '组合主键(channelid + tag) 频道id',
  `tag` varchar(10) NOT NULL COMMENT 'tag',
  `parenttag` varchar(20) NOT NULL COMMENT '父tag',
  `tagtree` varchar(200) NOT NULL COMMENT 'tag祖宗树',
  `updatetime` datetime DEFAULT NULL COMMENT '最后修改时间（索引）',
  `status` char(1) DEFAULT '0' COMMENT '状态(0普通1特殊)',
  `tagid` bigint(13) DEFAULT NULL COMMENT 'tagid(减去基数的时间戳，用于文件名)',
  `templateid` bigint(13) DEFAULT NULL COMMENT '模板id(如果不为0说明是别名)',
  `templatename` varchar(20) DEFAULT NULL COMMENT '模板名(如果模板id为0，则为模板类型)',
  KEY `updatetime` (`updatetime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='标签信息表：tagtree 备注：联合索引：UNIQUE KEY `channelid_3` (`channelid`,';

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
