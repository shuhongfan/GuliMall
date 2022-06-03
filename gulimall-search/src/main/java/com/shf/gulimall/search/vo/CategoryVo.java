package com.shf.gulimall.search.vo;

import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class CategoryVo {

    private Long catId;
    /**
     * 分类名称
     */
    private String name;
}
