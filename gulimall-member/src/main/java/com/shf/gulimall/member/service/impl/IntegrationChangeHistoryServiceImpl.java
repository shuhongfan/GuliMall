package com.shf.gulimall.member.service.impl;

import com.shf.gulimall.member.entity.IntegrationChangeHistoryEntity;
import com.shf.gulimall.member.service.IntegrationChangeHistoryService;
import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shf.common.utils.PageUtils;
import com.shf.common.utils.Query;

import com.shf.gulimall.member.dao.IntegrationChangeHistoryDao;


@Service("integrationChangeHistoryService")
public class IntegrationChangeHistoryServiceImpl extends ServiceImpl<IntegrationChangeHistoryDao, IntegrationChangeHistoryEntity> implements IntegrationChangeHistoryService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<IntegrationChangeHistoryEntity> page = this.page(
                new Query<IntegrationChangeHistoryEntity>().getPage(params),
                new QueryWrapper<IntegrationChangeHistoryEntity>()
        );

        return new PageUtils(page);
    }

}