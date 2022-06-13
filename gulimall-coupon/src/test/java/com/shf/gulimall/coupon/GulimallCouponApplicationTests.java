package com.shf.gulimall.coupon;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

//@RunWith(SpringRunner.class)
//@SpringBootTest
public class GulimallCouponApplicationTests {

    @Test
    public void contextLoads() {
        LocalDate now = LocalDate.now();
        LocalDate plus = now.plusDays(1);
        LocalDate plus2 = now.plusDays(2);

        System.out.println(now);
        System.out.println(plus);
        System.out.println(plus2);

        LocalTime min = LocalTime.MIN;
        LocalTime max = LocalTime.MAX;
        System.out.println(min);
        System.out.println(max);

        LocalDateTime start = LocalDateTime.of(now, min);
        LocalDateTime end = LocalDateTime.of(plus, max);

        System.out.println(start.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        System.out.println(end.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
    }

}
