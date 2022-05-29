package com.xunqi.gulimall.seckill;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.session.data.redis.config.annotation.web.http.EnableRedisHttpSession;

/**
 * 1、整合Sentinel
 *  1）、导入依赖 spring-cloud-starter-alibaba-sentinel
 *  2）、下载sentinel控制台
 *  3）、配置 sentinel 控制台地址信息
 *  4）、在控制台调整参数、【默认所有的流控规则保存在内存中，重启失效】
 *
 * 2、每一个微服务都导入 actuator ：并配合 management.endpoints.web.exposure.include=*
 * 3、自定义 sentinel 流控返回的数据
 *
 * 4、使用Sentinel来保护feign远程调用，熔断；
 *  1）、调用方的熔断保护：feign.sentinel.enable=true
 *  2）、调用方手动指定远程服务的降级策略。远程服务被降级处理。触发我们的熔断回调方法
 *  3）、超大浏览的时候，必须牺牲一些远程服务。在服务的提供方（远程服务）指定降级策略；
 *      提供方是在运行，但是不允许自己的业务逻辑，返回的是默认的降级数据（限流的数据）
 *
 * 5、自定义受保护的资源
 *  1）、代码
 *          try (Entry entry = SphU.entry("seckillSkus")) {
 *              //业务逻辑
 *          } catch(Exception e) {}
 *
 *  2）、基于注解
 *
 */

@EnableRedisHttpSession     //开启springsession
@EnableFeignClients
@EnableDiscoveryClient
@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)
public class GulimallSeckillApplication {

    public static void main(String[] args) {
        SpringApplication.run(GulimallSeckillApplication.class, args);
    }

}
