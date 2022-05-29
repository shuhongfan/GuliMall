/**
 * Copyright (c) 2016-2019 人人开源 All rights reserved.
 *
 * https://www.renren.io
 *
 * 版权所有，侵权必究！
 */

package com.shf.gulimall.admin.modules.oss.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shf.gulimall.admin.modules.oss.dao.SysOssDao;
import com.shf.gulimall.admin.modules.oss.entity.SysOssEntity;
import com.shf.gulimall.admin.modules.oss.service.SysOssService;
import com.shf.gulimall.admin.common.utils.PageUtils;
import com.shf.gulimall.admin.common.utils.Query;
import org.springframework.stereotype.Service;

import java.util.Map;


@Service("sysOssService")
public class SysOssServiceImpl extends ServiceImpl<SysOssDao, SysOssEntity> implements SysOssService {

	@Override
	public PageUtils queryPage(Map<String, Object> params) {
		IPage<SysOssEntity> page = this.page(
			new Query<SysOssEntity>().getPage(params)
		);

		return new PageUtils(page);
	}
	
}
