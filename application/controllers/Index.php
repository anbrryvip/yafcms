<?php

//use BaseControllers;

/**
 * @name  GTM API
 * @author LuJunJian<CmsSuper@163.com>
 * @desc GTM默认控制器
 */

class IndexController extends FControllerModel {

        function indexAction() {
                $msg = array(
                 'title'     => '开发计划',
                 'pro_start' => '项目起始时间:2014年1月17日',
                 'run'=>"占用内存:".runmem(),
                  'runtime'=>"运行时间:".  runtime(),
                 'pro_now'   => "现在时间:".date('Y年m月d日',time()),
                 'desc'      => '项目进入底层结构设计初级阶段',
                 'copyright' => '© 2014 All rights reserved | Powered'
        );

       $this->_view->assign('msg',$msg);
        }
}
