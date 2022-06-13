package com.shf.gulimall.order.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.rabbitmq.client.Channel;
import com.shf.common.utils.PageUtils;
import com.shf.common.utils.Query;
import com.shf.gulimall.order.dao.OrderItemDao;
import com.shf.gulimall.order.entity.OrderEntity;
import com.shf.gulimall.order.entity.OrderItemEntity;
import com.shf.gulimall.order.entity.OrderReturnReasonEntity;
import com.shf.gulimall.order.service.OrderItemService;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.core.MessageProperties;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Map;

//@RabbitListener(queues = {"hello-java-queue"})
@Service("orderItemService")
public class OrderItemServiceImpl extends ServiceImpl<OrderItemDao, OrderItemEntity> implements OrderItemService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<OrderItemEntity> page = this.page(
                new Query<OrderItemEntity>().getPage(params),
                new QueryWrapper<OrderItemEntity>()
        );

        return new PageUtils(page);
    }


    /**
     * queues：声明需要监听的队列
     * channel：当前传输数据的通道
     *
     * 参数类型：
     * 1.Message message：原生消息详细信息：头+体
     * 2.发送消息的类型
     * 3.Channel channel：当前传输数据的通道
     *
     * Queue：可以很多人都来监听。只要收到消息，队列删除消息，而且只能有一个收到消息
     *  1. 同一个消息，只能有一个客户端收到
     *  2.只有一个消息完全处理完，方法运行结束，我们就可以收到下一个消息
     *
     */

//    @RabbitListener(queues = {"hello-java-queue"})
//    @RabbitHandler
    public void revieveMessage(Message message,
                               OrderReturnReasonEntity content,
                               Channel channel) {
        //拿到主体内容
        byte[] body = message.getBody();
        //拿到的消息头属性信息
        MessageProperties messageProperties = message.getMessageProperties();
        System.out.println("接受到的消息...内容" + message + "===内容：" + content);

//        channel 按照顺序自增
        long deliveryTag = message.getMessageProperties().getDeliveryTag();
        System.out.println("deliveryTag="+deliveryTag);

        try {
            if (deliveryTag%2==0){
                channel.basicAck(deliveryTag,false);
                System.out.println("签收了货物："+deliveryTag);
            } else {
                System.out.println("没有签收货物："+deliveryTag);
            }
        } catch (IOException e) {

        }
    }

//    @RabbitHandler
    public void revieveMessage2(Message message,
                               OrderEntity content) {
        //拿到主体内容
        byte[] body = message.getBody();
        //拿到的消息头属性信息
        MessageProperties messageProperties = message.getMessageProperties();
        System.out.println("接受到的消息...内容" + message + "===内容：" + content);

    }

}