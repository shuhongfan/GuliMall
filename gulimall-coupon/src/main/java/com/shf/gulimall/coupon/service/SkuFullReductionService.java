package com.shf.gulimall.coupon.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shf.common.to.SkuReductionTo;
import com.shf.common.utils.PageUtils;
import com.shf.gulimall.coupon.entity.SkuFullReductionEntity;

import java.util.Map;

/**
 * 商品满减信息
 *
 * @author 夏沫止水
 * @email HeJieLin@gulimall.com
 * @date 2020-05-22 19:35:30
 */
public interface SkuFullReductionService extends IService<SkuFullReductionEntity> {

    PageUtils queryPage(Map<String, Object> params);

    void saveSkuReduction(SkuReductionTo skuReductionTo);
}

