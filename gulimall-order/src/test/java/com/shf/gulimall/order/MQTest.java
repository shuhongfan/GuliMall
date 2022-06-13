package com.shf.gulimall.order;

import com.shf.gulimall.order.entity.OrderReturnReasonEntity;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.amqp.core.AmqpAdmin;
import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Date;


@Slf4j
@RunWith(SpringRunner.class)
@SpringBootTest
public class MQTest {
    @Autowired
    private AmqpAdmin amqpAdmin;

    @Autowired
    private RabbitTemplate rabbitTemplate;

    @Test
    public void createExchange(){
        DirectExchange directExchange = new DirectExchange(
                "hello-java-exchange",
                true,
                false);
        amqpAdmin.declareExchange(directExchange);
        log.info("exchange{}创建成功",directExchange.getName());
    }

    @Test
    public void createQueue(){
        Queue queue = new Queue(
                "hello-java-queue",
                true,
                false,
                false
        );
        amqpAdmin.declareQueue(queue);
        log.info("queue{}创建成功",queue.getName());
    }

    @Test
    public void createBinding(){
        Binding binding = new Binding(
                "hello-java-queue",
                Binding.DestinationType.QUEUE,
                "hello-java-exchange",
                "hello.java",
                null
          );
        amqpAdmin.declareBinding(binding);
        log.info("binding{}创建成功",binding.getRoutingKey());
    }

    @Test
    public void sendMessage(){
        String msg = "hello world";
        rabbitTemplate.convertAndSend(
                "hello-java-exchange",
                "hello.java",
                msg
        );
        log.info("消息发送完成：{}",msg);
    }

    @Test
    public void sendEntity(){
        OrderReturnReasonEntity entity = new OrderReturnReasonEntity();
        entity.setId(1L);
        entity.setCreateTime(new Date());
        entity.setName("哈哈");

        rabbitTemplate.convertAndSend(
                "hello-java-exchange",
                "hello.java",
                entity
        );
        log.info("消息发送完成：{}",entity);
    }
}
