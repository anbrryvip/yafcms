<?php

/**
 *用户模型
 *
 * @author Anbr <anbrsy@gmail.com>
 */
class UserModel extends BaseModel {

/**
 *定义要查询的表名,主键,和自增字段
 * $table,$pri,$maxid必须设置
 */   
        public function __construct() {

        $this->table = 'admin';  //表名
        $this->pri = array('userid');   //主键
        $this->maxid = 'userid';  //自增字段
    }
/**
 * 根据条件查询用户
 */
	// 根据用户名获取用户数据
	public function get_user_by_username($username) {
		$data = $this->find_fetch(array('username'=>$username), array(), 0, 1);
		return $data ? current($data) : array();
	}
/**
 * 检查用户是否合格
 */
		// 检查用户名是否合格
	public function check_username(&$username) {
		$username = trim($username);
		if(empty($username)) {
			return '用户名不能为空哦！';
		}elseif(utf8::strlen($username) > 16) {
			return '用户名不能大于16位哦！';
		}elseif(str_replace(array("\t","\r","\n",' ','　',',','，','-','"',"'",'\\','/','&','#','*'), '', $username) != $username) {
			return '用户名中含有非法字符！';
		}elseif(htmlspecialchars($username) != $username) {
			return '用户名中不能含有<>！';
		}
		return '';
	}
/**
 * 返回安全的用户名
 */
	public function safe_username(&$username) {
		$username = str_replace(array("\t","\r","\n",' ','　',',','，','-','"',"'",'\\','/','&','#','*'), '', $username);
		$username = htmlspecialchars($username);
	}
/**
  * 检查密码是否合格
  */
	public function check_password(&$password) {
		if(empty($password)) {
			return '密码不能为空哦！';
		}elseif(utf8::strlen($password) < 6) {
			return '密码不能小于6位哦！';
		}elseif(utf8::strlen($password) > 32) {
			return '密码不能大于32位哦！';
		}
		return '';
	}
/**
* 检查密码是否相等
*/
	public function verify_password($password, $salt, $password_md5) {
		return md5(md5($password).$salt) == $password_md5;
	}
/**
 * 防止IP暴力破解
 */
	public function anti_ip_brute($ip) {
		$password_error = $this->runtime->get('password_error_'.$ip);
		return ($password_error && $password_error >= 8) ? true : false;
	}
/**
 * 根据IP记录密码错误次数
 */
	public function password_error($ip) {
		$password_error = (int)$this->runtime->get('password_error_'.$ip);
		$password_error++;
		$this->runtime->set('password_error_'.$ip, $password_error, 450);
	}

/**
 *格式化后显示给用户 
 */
	public function format(&$user) {
		if(!$user) return;
		$user['regdate'] = empty($user['regdate']) ? '0000-00-00 00:00' : date('Y-m-d H:i', $user['regdate']);
		$user['logindate'] = empty($user['logindate']) ? '0000-00-00 00:00' : date('Y-m-d H:i', $user['logindate']);
		$user['loginip'] = long2ip($user['loginip']);
	}
}
