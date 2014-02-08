<?php
/**
 * 管理后台控制器
 * 
 * @author Lujunjian <YafCms@163.com>
 * @copyright 2013-2013 www.yafcms.com
 */
class IndexController extends BControllerModel{
	
	public $db = NULL;
/**
 * 后台主菜单
 */
	public function indexAction(){

		unset($this->_navs[1]['my-newtab']);
		foreach ($this->_navs[1] as $k => $v) {
			$this->_navs[2][$v['p']][$k] = $v;
		}
		unset($this->_navs[1]);

		$this->_view->display();
		exit;	
		                 		
	}	
/**
 * 后台登录
 */
	public function loginAction() {
		if(empty($_POST)) {
			$this->_view->display();
		}elseif(form_submit()) {
			$user = &$this->user;
			$username = R('username', 'P');
			$password = R('password', 'P');

			if($message = $user->check_username($username)) {
				exit('{"name":"username", "message":"啊哦，'.$message.'"}');
			}elseif($message = $user->check_password($password)){
				exit('{"name":"password", "message":"啊哦，'.$message.'"}');
			}

			// 防IP暴力破解
			$ip = &$_ENV['_ip'];
			if($user->anti_ip_brute($ip)) {
				exit('{"name":"password", "message":"啊哦，请15分钟之后再试！"}');
			}

//2014年2月9日 01:24:32			$data = $user->get_user_by_username($username);
			if($data && $user->verify_password($password, $data['salt'], $data['password'])) {
				// 写入 cookie
				$admauth = str_auth("$data[uid]\t$data[username]\t$data[password]\t$data[groupid]\t$ip", 'ENCODE');
				_setcookie('admauth', $admauth, 0, '', '', false, true);

				// 更新登陆信息
				$data['lastip'] = $data['loginip'];
				$data['lastdate'] = $data['logindate'];
				$data['loginip'] = ip2long($ip);
				$data['logindate'] = $_ENV['_time'];
				$data['logins']++;
				$user->update($data);

				// 删除密码错误记录
				$this->runtime->delete('password_error_'.$ip);

				exit('{"name":"", "message":"登录成功！"}');
			}else{
				// 记录密码错误日志
				$log_password = '******'.substr($password, 6);
				log::write("密码错误：$username - $log_password", 'login_log.php');

				// 记录密码错误次数
				$user->password_error($ip);

				exit('{"name":"password", "message":"啊哦，帐号或密码不正确！"}');
			}
		}else{
			exit('{"name":"username", "message":"啊哦，表单失效！请刷新后再试！"}');
		}
	}

/**
* 后台登出
*/
	public function logoutAction(){
		_setcookie('admauth', '', 1);
		exit('<html><body><script>window.location="index.php?c=login"</script></body></html>');
            
	}
}