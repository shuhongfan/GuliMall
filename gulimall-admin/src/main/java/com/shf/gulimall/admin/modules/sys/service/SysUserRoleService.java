/**
 * Copyright (c) 2016-2019 人人开源 All rights reserved.
 *
 * https://www.renren.io
 *
 * 版权所有，侵权必究！
 */

package com.shf.gulimall.admin.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shf.gulimall.admin.modules.sys.entity.SysUserRoleEntity;

import java.util.List;



/**
 * 用户与角色对应关系
 *
 * @author Mark sunlightcs@gmail.com
 */
public interface SysUserRoleService extends IService<SysUserRoleEntity> {
	
	void saveOrUpdate(Long userId, List<Long> roleIdList);
	
	/**
	 * 根据用户ID，获取角色ID列表
	 */
	List<Long> queryRoleIdList(Long userId);

	/**
	 * 根据角色ID数组，批量删除
	 */
	int deleteBatch(Long[] roleIds);
}
