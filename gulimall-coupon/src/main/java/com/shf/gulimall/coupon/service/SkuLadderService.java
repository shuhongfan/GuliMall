package com.shf.gulimall.coupon.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shf.common.utils.PageUtils;
import com.shf.gulimall.coupon.entity.SkuLadderEntity;

import java.util.Map;

/**
 * 商品阶梯价格
 *
 * @author 夏沫止水
 * @email HeJieLin@gulimall.com
 * @date 2020-05-22 19:35:30
 */
public interface SkuLadderService extends IService<SkuLadderEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

