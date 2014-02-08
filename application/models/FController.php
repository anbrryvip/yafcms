<?php

/**
 * 管理前台Controller
 * Created by IntelliJ IDEA.
 * User: chenzhidong
 * Date: 13-12-5
 * Time: 下午12:16
 */
class FControllerModel extends Yaf_Controller_Abstract {
    
	public function init() {
            
            $config = Yaf_Registry::get('config');
            $view = $this->initView();
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