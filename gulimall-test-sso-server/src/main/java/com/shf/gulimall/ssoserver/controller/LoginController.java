package com.shf.gulimall.ssoserver.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.util.UUID;

/**
 * @Description:
 * @Created: with IntelliJ IDEA.
 * @author: 夏沫止水
 * @createTime: 2020-06-29 19:56
 **/

/**
 *  单点登录
 *
 * 1. 给登录服务器留下登录痕迹
 * 2.登录服务器要将token信息重定向的时候，带到url地址上
 * 3.其他系统要处理url地址上的关键token，只要有，将token对应的用户保存到自己的session中
 * 4.自己系统将用户保存在自己会话中。
 */
@Controller
public class LoginController {

    @Autowired
    StringRedisTemplate redisTemplate;

    @ResponseBody
    @GetMapping("/userinfo")
    public String userinfo(@RequestParam(value = "token") String token) {
        String s = redisTemplate.opsForValue().get(token);

        return s;

    }


    @GetMapping("/login.html")
    public String loginPage(@RequestParam("redirect_url") String url,
                            Model model,
                            @CookieValue(value = "sso_token", required = false) String sso_token) {
        if (!StringUtils.isEmpty(sso_token)) {
            return "redirect:" + url + "?token=" + sso_token;
        }


        model.addAttribute("url", url);

        return "login";
    }

    @PostMapping(value = "/doLogin")
    public String doLogin(@RequestParam("username") String username,
                          @RequestParam("password") String password,
                          @RequestParam("redirect_url") String url,
                          HttpServletResponse response) {

        //登录成功跳转，跳回到登录页
        if (!StringUtils.isEmpty(username) && !StringUtils.isEmpty(password)) {

            String uuid = UUID.randomUUID().toString().replace("_", "");
            redisTemplate.opsForValue().set(uuid, username);
            Cookie sso_token = new Cookie("sso_token", uuid);

            response.addCookie(sso_token);
            return "redirect:" + url + "?token=" + uuid;
        }
        return "login";
    }

}
