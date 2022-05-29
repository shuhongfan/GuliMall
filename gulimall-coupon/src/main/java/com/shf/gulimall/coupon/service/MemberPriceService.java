package com.shf.gulimall.coupon.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shf.common.utils.PageUtils;
import com.shf.gulimall.coupon.entity.MemberPriceEntity;

import java.util.Map;

/**
 * 商品会员价格
 *
 * @author 夏沫止水
 * @email HeJieLin@gulimall.com
 * @date 2020-05-22 19:35:30
 */
public interface MemberPriceService extends IService<MemberPriceEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

