<?php
/**
 * 管理后台Controller
 * Created by IntelliJ IDEA.
 * User: chenzhidong
 * Date: 13-12-5
 * Time: 下午12:16
 */
class BControllerModel extends Yaf_Controller_Abstract {
        
    
    
        public function init() {
            
        		//设置Controller的模板位置为模块目录下的views文件夹
        		  $this->setViewpath(APPLICATION_PATH .
                                     APPLICATION_NAME.
                                     '/modules/'.
                                     $this->getModuleName().
                                     '/views');
        	
                     $views = $this->initView();
                }
       
        public function getM(){
  
            return  $this->getRequest()->getModuleName();	

        }

        public function getC(){

             return  $this->getRequest()->getControllerName();
  
        }

        public function getA(){

            return  $this->getRequest()->getActionName();
  

        }
}