package com.shf.gulimall.auth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.session.data.redis.config.annotation.web.http.EnableRedisHttpSession;


/**
 * 核心原理
 * 1）、@EnableRedisHttpSession导入RedisHttpSessionConfiguration配置
 *      1、给容器中添加了一个组件
 *          RedisOperationsSessionRepository：Redis操作session，session的增删改查封装类
 *      2.SessionRepositoryFilter  ==> Filter: session过滤器，每个请求都必须经过filter
 *          2.1、创建的时候，就自动从容器中获取到了sessionRepository
 *          2.2、原始的request、response都被包装到sessionRespository
 *          2.3、以后获取session。request.getSession（）
 *          2.4、wrappedRequest.getSession() ===》  SessionRepository 中获取到的
 *      3. 原理：简单的装饰者模式
 */

@EnableRedisHttpSession     //整合Redis作为session存储
@EnableFeignClients
@EnableDiscoveryClient
@SpringBootApplication
public class GulimallAuthServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(GulimallAuthServerApplication.class, args);
    }

}
