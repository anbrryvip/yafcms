<?php
/**
 *常量配置文件
 *例:smarty输出自定义常量,
 *{#$samary.const.常量名称#}
 *
 */
/*log文件*/
define('logdir', APPLICATION_PATH . '/log/');
/*文件上传文件夹*/
define('upload','/resource/upload');
/**
 *静态地址常量设置
 *$resource 可直接要访问的url/目录 访问可自定义
 *为了模板的img,JS,CSS,分开,可以自己自定义设置目录
 */
define('resource','/resource');
//默认defaule路可根据实际情况更改
define('resource_img','/resource/defaule/img');
define('resource_js','/resource/defaule/js');
define('resource_css','/resource/defaule/css');
//admin后台地址
define('resource_admin','/resource/admin');
