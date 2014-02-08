<?php

/**
 *   
 *    YAFCMS 主入口文件
 *
 */



define('APPLICATION_PATH', dirname(__FILE__));
define("APPLICATION_NAME", 'application');

$application = new Yaf_Application( APPLICATION_PATH . "/conf/application.ini");

$application
        ->bootstrap()
        ->run();
?>
