package com.shf.gulimall.order.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shf.common.utils.PageUtils;
import com.shf.gulimall.order.entity.OrderOperateHistoryEntity;

import java.util.Map;

/**
 * 订单操作历史记录
 *
 * @author 夏沫止水
 * @email HeJieLin@gulimall.com
 * @date 2020-05-22 19:49:53
 */
public interface OrderOperateHistoryService extends IService<OrderOperateHistoryEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

