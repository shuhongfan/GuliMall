package com.shf.gulimall.search.thread;

import io.netty.util.concurrent.CompleteFuture;

import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Demo {
    public static ExecutorService executor = Executors.newFixedThreadPool(10);

//    public static void main(String[] args) throws ExecutionException, InterruptedException {
//        CompletableFuture<Integer> future = CompletableFuture.supplyAsync(() -> {
//                    System.out.println("当前线程:" + Thread.currentThread().getId());
//                    int i = 10 / 0;
//                    System.out.println("运行结果:" + i);
//                    return i;
//                }, executor)
//                .whenComplete((res, exception) -> { // 方法完成后的感知
//                    System.out.println("异步任务完成了...结果是:" + res + ",异常是:" + exception);
//                })
//                .exceptionally(throwable -> {
////                    感知异常,同时返回默认值
//                    return 10;
//                })
//                .handle((res,thr)->{
//                    if (res!=null){
//                        return res*2;
//                    }
//                    if (thr!=null){
//                        return 0;
//                    }
//                    return 0;
//                });
//        Integer integer = future.get();
//        System.out.println("main...end...,结果是:"+integer);
//    }

    public static void main(String[] args) throws ExecutionException, InterruptedException {
        CompletableFuture<Integer> future01 = CompletableFuture.supplyAsync(() -> {
            System.out.println("future01线程:" + Thread.currentThread().getId());
            int i = 10 / 4;
            System.out.println("future01运行结果:" + i);
            return i;
        }, executor);

        CompletableFuture<String> future02 = CompletableFuture.supplyAsync(() -> {
            System.out.println("future02线程:" + Thread.currentThread().getId());
            System.out.println("future02运行结果:");
            return "hello";
        }, executor);

//        future01.runAfterBothAsync(future02,()->{
//            System.out.println("任务3开始");
//        },executor);

//        future01.thenAcceptBothAsync(future02,(f1,f2)->{
//            System.out.println("任务3开始,....之前的结果: f1="+f1+" , f2="+f2);
//        },executor);

//        CompletableFuture<String> future = future01.thenCombineAsync(future02, (f1, f2) -> {
//            return f1 + ":" + f2 + "--->haha";
//        }, executor);
//        System.out.println(future.get());

    }
}
