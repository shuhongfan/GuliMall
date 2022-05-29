package com.xunqi.common.exception;

import lombok.Getter;
import lombok.Setter;

/**
 * @Description: 无库存抛出的异常
 * @Created: with IntelliJ IDEA.
 * @author: 夏沫止水
 * @createTime: 2020-07-05 11:39
 **/

public class NoStockException extends RuntimeException {

    @Getter @Setter
    private Long skuId;

    public NoStockException(Long skuId) {
        super("商品id："+ skuId + "库存不足！");
    }

    public NoStockException(String msg) {
        super(msg);
    }


}
