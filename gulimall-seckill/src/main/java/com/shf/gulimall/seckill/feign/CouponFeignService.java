package com.shf.gulimall.seckill.feign;

import com.shf.common.utils.R;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 远程调用coupon优惠服务
 */
@FeignClient("gulimall-coupon")
public interface CouponFeignService {

    /**
     * 查询最近三天需要参加秒杀商品的信息
     * @return
     */
    @GetMapping(value = "/coupon/seckillsession/Lates3DaySession")
    R getLates3DaySession();

}
