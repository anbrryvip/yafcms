<?php
/**
 * Description of Interface
 *
 * @author 彪
 */

interface Cache_Interface {
	public function get($key);
	public function multi_get($keys);
	public function set($key, $data, $life = 0);
	public function update($key, $data, $life = 0);
	public function delete($key);
	public function maxid($table, $val = FALSE);
	public function count($table, $val = FALSE);
	public function truncate($pre = '');

	public function l2_cache_get($l2_key);
	public function l2_cache_set($l2_key, $keys, $life = 0);
}

/*
	用法：
	$conf = array (
		'enable'=>TRUE,
		'type'=>'memcache',
		'memcache'=>array (
			'host'=>'127.0.0.1',
			'port'=>'11211',
		)
	);
	$cache = new cache_memcache($conf);
	
	// 取一条记录
	$user = $cache->get("user-uid-$uid");
	
	// 增加一条记录:
	$uid = $cache->maxid('user');
	$cache->set("user-uid-$uid", array('username'=>'admin', 'email'=>'xxx@xxx.com'));
	$cache->maxid('user', '+1');
	
	// 存一条记录，覆盖写入
	$cache->set("user-uid-$uid", array('username'=>'admin', 'email'=>'xxx@xxx.com'));
	
	// 删除一条记录
	$cache->delete("user-uid-$uid");
	
	// 遍历
	$uid = $cache->maxid('user');  // 取最大的UID
	$uids = array();
	for($i=0; $i<$uid; $i++) $uids[] = $i;
	$userlist = $cache->get($uids);
	
	// 取记录总数
	$cache->count('user');

	// 清除所有记录
	$cache->truncate();
*/