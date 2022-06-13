package com.shf.gulimall.order.controller;

import com.shf.gulimall.order.entity.OrderEntity;
import com.shf.gulimall.order.entity.OrderReturnReasonEntity;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.UUID;

@RestController
public class RabbitController {
    @Autowired
    private RabbitTemplate rabbitTemplate;

    @GetMapping("/sendMq")
    public String sendMq(@RequestParam("num") Integer num){
        for (int i = 0; i < num; i++) {
            if (i%2==0){
                OrderReturnReasonEntity reasonEntity = new OrderReturnReasonEntity();
                reasonEntity.setId(1L);
                reasonEntity.setCreateTime(new Date());
                reasonEntity.setName("哈哈--"+i);
                rabbitTemplate.convertAndSend(
                        "hello-java-exchange",
                        "hello.java",
                        reasonEntity);
            } else {
                OrderEntity orderEntity = new OrderEntity();
                orderEntity.setOrderSn(UUID.randomUUID().toString());
                rabbitTemplate.convertAndSend(
                        "hello-java-exchange",
                        "hello22.java",
                        orderEntity);
            }
        }
        return "success";
    }
}
