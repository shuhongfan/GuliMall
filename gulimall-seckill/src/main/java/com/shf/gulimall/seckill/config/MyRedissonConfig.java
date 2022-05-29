package com.shf.gulimall.seckill.config;

import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;

/**
 * @Description:
 * @Created: with IntelliJ IDEA.
 * @author: 夏沫止水
 * @createTime: 2020-06-11 09:39
 **/

@Configuration
public class MyRedissonConfig {

    /**
     * 所有对Redisson的使用都是通过RedissonClient
     * @return
     * @throws IOException
     */
    @Bean(destroyMethod="shutdown")
    public RedissonClient redissonClient() throws IOException {
        //1、创建配置
        Config config = new Config();
        config.useSingleServer().setAddress("redis://192.168.120.20:6379");

        //2、根据Config创建出RedissonClient实例
        //Redis url should start with redis:// or rediss://
        RedissonClient redissonClient = Redisson.create(config);
        return redissonClient;
    }

}
