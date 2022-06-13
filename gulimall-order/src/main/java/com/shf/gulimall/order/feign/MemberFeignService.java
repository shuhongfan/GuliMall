package com.shf.gulimall.order.feign;

import com.shf.common.utils.R;
import com.shf.gulimall.order.vo.MemberAddressVo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

/**
 * @Description:
 * @Created: with IntelliJ IDEA.
 * @author: 夏沫止水
 * @createTime: 2020-07-02 19:39
 **/

@FeignClient("gulimall-member")
public interface MemberFeignService {

    /**
     * 查询当前用户的全部收货地址
     * @param memberId
     * @return
     */
    @GetMapping(value = "/member/memberreceiveaddress/{memberId}/address")
    List<MemberAddressVo> getAddress(@PathVariable("memberId") Long memberId);

    @PostMapping("/member/memberreceiveaddress/addLocation")
    public R addLocation(@RequestBody MemberAddressVo memberAddressVo);

}
