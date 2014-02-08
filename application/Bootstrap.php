<?php
/**
 * @name Bootstrap
 * @author root
 * @desc 所有在Bootstrap类中, 以_init开头的方法, 都会被Yaf调用,
 * @see http://www.php.net/manual/en/class.yaf-bootstrap-abstract.php
 * 这些方法, 都接受一个参数:Yaf_Dispatcher $dispatcher
 * 调用的次序, 和申明的次序相同
 */
class Bootstrap extends Yaf_Bootstrap_Abstract{
	
    protected $config;

    public function _initConfig() {
    	
		$this->config = Yaf_Application::app()->getConfig();
		Yaf_Registry::set('config', $this->config);
                 //引入扩展函数
                 Yaf_Loader::import(APPLICATION_PATH.'/Com/Fuc.php');
                 Yaf_Loader::import(APPLICATION_PATH . '/conf/defines.inc.php');

	}

	public function _initPlugin(Yaf_Dispatcher $dispatcher) {
               if (isset($this->config->application->benchmark) && $this->config->application->benchmark == true)
		{
                    $benchmark = new BenchmarkPlugin();
                    $dispatcher->registerPlugin($benchmark);
		}
		
	}
		
	//在这里注册自己的路由协议,默认使用简单路由
	public function _initRoute(Yaf_Dispatcher $dispatcher) {
            
		  	$router = $dispatcher->getRouter();

		  	$route = new Yaf_Route_Simple("m", "c", "a");

                  		$router->addRoute("name", $route);

	}

         //在这里注册自己的view控制器，例如smarty,firekylin
	public function _initView(Yaf_Dispatcher $dispatcher){
	
			$smarty = new Smarty_Adapter(null, $this->config->smarty);
	
			$dispatcher->setView($smarty);
    
    }

	public function _initNamespaces(){
		    
        }

//设置完毕     
}    
