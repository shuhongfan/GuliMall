package com.shf.gulimall.coupon.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shf.common.to.MemberPrice;
import com.shf.common.to.SkuReductionTo;
import com.shf.common.utils.PageUtils;
import com.shf.common.utils.Query;
import com.shf.gulimall.coupon.dao.SkuFullReductionDao;
import com.shf.gulimall.coupon.entity.MemberPriceEntity;
import com.shf.gulimall.coupon.entity.SkuFullReductionEntity;
import com.shf.gulimall.coupon.entity.SkuLadderEntity;
import com.shf.gulimall.coupon.service.MemberPriceService;
import com.shf.gulimall.coupon.service.SkuFullReductionService;
import com.shf.gulimall.coupon.service.SkuLadderService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


@Service("skuFullReductionService")
public class SkuFullReductionServiceImpl extends ServiceImpl<SkuFullReductionDao, SkuFullReductionEntity> implements SkuFullReductionService {

    @Autowired
    private SkuLadderService skuLadderService;

    @Autowired
    private MemberPriceService memberPriceService;


    @Override
    public PageUtils queryPage(Map<String, Object> params) {

        QueryWrapper<SkuFullReductionEntity> queryWrapper = new QueryWrapper<SkuFullReductionEntity>();

        String key = (String) params.get("key");

        if (!StringUtils.isEmpty(key)) {
            queryWrapper.eq("id",key).or().eq("sku_id",key);
        }

        IPage<SkuFullReductionEntity> page = this.page(
                new Query<SkuFullReductionEntity>().getPage(params),
                queryWrapper
        );

        return new PageUtils(page);
    }

    @Override
    public void saveSkuReduction(SkuReductionTo skuReductionTo) {

        //1、保存满减打折、会员价
        //1、1）、sku的优惠、满减等信息：gulimall_sms--->sms_sku_ladder、sms_sku_full_reduction、sms_member_price
        SkuLadderEntity skuLadderEntity = new SkuLadderEntity();
        BeanUtils.copyProperties(skuReductionTo,skuLadderEntity);
        skuLadderEntity.setAddOther(skuReductionTo.getCountStatus());

        if (skuReductionTo.getFullCount() > 0) {
            skuLadderService.save(skuLadderEntity);
        }

        //2、sms_sku_full_reduction
        SkuFullReductionEntity skuFullReductionEntity = new SkuFullReductionEntity();
        BeanUtils.copyProperties(skuReductionTo,skuFullReductionEntity);
        if (skuFullReductionEntity.getFullPrice().compareTo(BigDecimal.ZERO) == 1) {
            this.save(skuFullReductionEntity);
        }


        //3、sms_member_price
        List<MemberPrice> memberPrice = skuReductionTo.getMemberPrice();

        List<MemberPriceEntity> collect = memberPrice.stream().map(mem -> {
            MemberPriceEntity memberPriceEntity = new MemberPriceEntity();
            memberPriceEntity.setSkuId(skuReductionTo.getSkuId());
            memberPriceEntity.setMemberLevelId(mem.getId());
            memberPriceEntity.setMemberLevelName(mem.getName());
            memberPriceEntity.setMemberPrice(mem.getPrice());
            memberPriceEntity.setAddOther(1);
            return memberPriceEntity;
        }).filter(item -> {
            return item.getMemberPrice().compareTo(BigDecimal.ZERO) == 1;
        }).collect(Collectors.toList());

        memberPriceService.saveBatch(collect);
    }

}