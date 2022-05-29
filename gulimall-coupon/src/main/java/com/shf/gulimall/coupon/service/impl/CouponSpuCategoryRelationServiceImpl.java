package com.shf.gulimall.coupon.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shf.common.utils.PageUtils;
import com.shf.common.utils.Query;
import com.shf.gulimall.coupon.dao.CouponSpuCategoryRelationDao;
import com.shf.gulimall.coupon.entity.CouponSpuCategoryRelationEntity;
import com.shf.gulimall.coupon.service.CouponSpuCategoryRelationService;
import org.springframework.stereotype.Service;

import java.util.Map;


@Service("couponSpuCategoryRelationService")
public class CouponSpuCategoryRelationServiceImpl extends ServiceImpl<CouponSpuCategoryRelationDao, CouponSpuCategoryRelationEntity> implements CouponSpuCategoryRelationService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<CouponSpuCategoryRelationEntity> page = this.page(
                new Query<CouponSpuCategoryRelationEntity>().getPage(params),
                new QueryWrapper<CouponSpuCategoryRelationEntity>()
        );

        return new PageUtils(page);
    }

}