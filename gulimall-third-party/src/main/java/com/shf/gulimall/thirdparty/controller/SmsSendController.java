package com.shf.gulimall.thirdparty.controller;

import com.cloopen.rest.sdk.BodyType;
import com.cloopen.rest.sdk.CCPRestSmsSDK;
import com.shf.common.utils.R;
import com.shf.gulimall.thirdparty.component.SmsComponent;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Set;

/**
 * @Description:
 * @Created: with IntelliJ IDEA.
 * @author: 夏沫止水
 * @createTime: 2020-06-27 10:04
 **/

@RestController
@RequestMapping(value = "/sms")
public class SmsSendController {

    @Resource
    private SmsComponent smsComponent;

    /**
     * 提供给别的服务进行调用
     * @param phone
     * @param code
     * @return
     */
//    @GetMapping(value = "/sendCode")
//    public R sendCode(@RequestParam("phone") String phone, @RequestParam("code") String code) {
//
//        //发送验证码
//        smsComponent.sendCode(phone,code);
//
//        return R.ok();
//    }

    @GetMapping(value = "/sendCode")
    public R sendCode(@RequestParam("phone") String phone, @RequestParam("code") String code) {
        //生产环境请求地址：app.cloopen.com
        String serverIp = "app.cloopen.com";
        //请求端口
        String serverPort = "8883";
        //主账号,登陆云通讯网站后,可在控制台首页看到开发者主账号ACCOUNT SID和主账号令牌AUTH TOKEN
        String accountSId = "8aaf07087249953401725f8762410e19";
        String accountToken = "a280f40bbffb41e9a41f1a4678794730";
        //请使用管理控制台中已创建应用的APPID
        String appId = "8aaf07087249953401725f8763490e20";
        CCPRestSmsSDK sdk = new CCPRestSmsSDK();
        sdk.init(serverIp, serverPort);
        sdk.setAccount(accountSId, accountToken);
        sdk.setAppId(appId);
        sdk.setBodyType(BodyType.Type_JSON);
        String to = "13437191068";
        String templateId= "1";
        String[] datas = {code,"10"};
//        String subAppend="1234";  //可选	扩展码，四位数字 0~9999
//        String reqId="fadfafas";  //可选 第三方自定义消息id，最大支持32位英文数字，同账号下同一自然天内不允许重复

        HashMap<String, Object> result = sdk.sendTemplateSMS(to,templateId,datas);
        result.put("phone", phone);
        result.put("code", code);
        if("000000".equals(result.get("statusCode"))){
            return R.ok().setData(result.get("data"));
        }else{
            //异常返回输出错误码和错误信息
            return R.error(Integer.parseInt((String) result.get("statusCode")),result.get("statusMsg").toString());
        }
    }
}
