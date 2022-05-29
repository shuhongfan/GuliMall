package com.xunqi.gulimall.seckill.scheduled;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * @Description:
 * @Created: with IntelliJ IDEA.
 * @author: 夏沫止水
 * @createTime: 2020-07-09 18:49
 **/

/**
 * 定时任务
 *      1、@EnableScheduling 开启定时任务
 *      2、@Scheduled开启一个定时任务
 *
 * 异步任务
 *      1、@EnableAsync:开启异步任务
 *      2、@Async：给希望异步执行的方法标注
 */

@Slf4j
@Component
// @EnableAsync
// @EnableScheduling
public class HelloScheduled {

    /**
     * 1、在Spring中表达式是6位组成，不允许第七位的年份
     * 2、在周几的的位置,1-7代表周一到周日
     * 3、定时任务不该阻塞。默认是阻塞的
     *      1）、可以让业务以异步的方式，自己提交到线程池
     *              CompletableFuture.runAsync(() -> {
     *         },execute);
     *
     *      2）、支持定时任务线程池；设置 TaskSchedulingProperties
     *        spring.task.scheduling.pool.size: 5
     *
     *      3）、让定时任务异步执行
     *          异步任务
     *
     *      解决：使用异步任务 + 定时任务来完成定时任务不阻塞的功能
     *
     */
    // @Async
    // @Scheduled(cron = "*/5 * * ? * 4")
    // public void hello() {
    //     log.info("hello...");
    //     try { TimeUnit.SECONDS.sleep(3); } catch (InterruptedException e) { e.printStackTrace(); }
    //
    // }

}
