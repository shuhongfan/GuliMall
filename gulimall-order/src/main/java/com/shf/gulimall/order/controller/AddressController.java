package com.shf.gulimall.order.controller;

import com.shf.common.utils.R;
import com.shf.gulimall.order.feign.MemberFeignService;
import com.shf.gulimall.order.vo.MemberAddressVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AddressController {
    @Autowired
    private MemberFeignService memberFeignService;

    @PostMapping("/addLocation")
    public R addLocation(@RequestBody MemberAddressVo memberAddressVo){
        return memberFeignService.addLocation(memberAddressVo);
    }
}
