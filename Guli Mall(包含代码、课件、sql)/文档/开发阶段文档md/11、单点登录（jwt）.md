

# 1. 用户管理提供数据接口

搭建gmall-ums略。。。。

参照课前资料中的《前端商城接口文档.md》编写数据接口


## 1.1. 数据验证功能

根据接口文档知：

- 请求方式：GET
- 请求路径：check/{param}/{type}
- 请求参数：param,type
- 返回结果：true或false



### 1.1.2. UserController

```java
/**
     * 校验数据是否可用
     * @param data
     * @param type
     * @return
     */
@GetMapping("check/{data}/{type}")
public ResponseVo<Boolean> checkData(@PathVariable("data") String data, @PathVariable("type") Integer type) {
    Boolean b = this.userService.checkData(data, type);

    return ResponseVo.ok(b);
}
```



### 1.1.2. UserService

```java
@Autowired
private UserMapper userMapper;

@Override
public Boolean checkData(String data, Integer type) {
    QueryWrapper<UserEntity> wrapper = new QueryWrapper<>();
    switch (type) {
        case 1:
            wrapper.eq("username", data);
            break;
        case 2:
            wrapper.eq("phone", data);
            break;
        case 3:
            wrapper.eq("email", data);
            break;
        default:
            return null;
    }
    return this.userMapper.selectCount(wrapper) == 0;
}
```



### 1.1.3. 测试

我们在数据库插入一条假数据：

![1570084398728](assets/1570084398728.png)

然后在浏览器调用接口，测试：

![1570084470608](assets/1570084470608.png)

![1570084533646](assets/1570084533646.png)



## 1.2. 发送短信功能

参考接口文档，这里的业务逻辑是这样的：

- 1）我们接收页面发送来的手机号码
- 2）生成一个随机验证码
- 3）将验证码保存在服务端
- 4）发送短信，将验证码发送到用户手机

那么问题来了：验证码保存在哪里呢？

验证码有一定有效期，一般是5分钟，我们可以利用Redis的过期机制来保存。



具体实现略。。。。



## 1.3. 注册功能

基本逻辑：

- 1）校验短信验证码
- 2）生成盐
- 3）对密码加密
- 4）写入数据库
- 5）删除Redis中的验证码



### 1.3.1. UserController

```java
/**
     * 注册
     * @param userEntity
     * @param code
     * @return
     */
@PostMapping("register")
public ResponseVo<Object> register(UserEntity userEntity, @RequestParam("code") String code) {
    this.userService.register(userEntity, code);

    return ResponseVo.ok(null);
}
```



### 1.3.2. UserService

```java
public void register(UserEntity userEntity, String code) {
    // 校验短信验证码
    // String cacheCode = this.redisTemplate.opsForValue().get(KEY_PREFIX + userEntity.getPhone());
    // if (!StringUtils.equals(code, cacheCode)) {
    //     return false;
    // }

    // 生成盐
    String salt = StringUtils.replace(UUID.randomUUID().toString(), "-", "");
    userEntity.setSalt(salt);

    // 对密码加密
    userEntity.setPassword(DigestUtils.md5Hex(salt + DigestUtils.md5Hex(userEntity.getPassword())));

    // 设置创建时间等
    userEntity.setCreateTime(new Date());
    userEntity.setLevelId(1l);
    userEntity.setStatus(1);
    userEntity.setIntegration(0);
    userEntity.setGrowth(0);
    userEntity.setNickname(userEntity.getUserName());

    // 添加到数据库
    boolean b = this.save(userEntity);

    // if(b){
    // 注册成功，删除redis中的记录
    // this.redisTemplate.delete(KEY_PREFIX + memberEntity.getPhone());
    // }
}
```



### 1.3.3. 测试

我们通过PostMan测试：

![1570087515131](assets/1570087515131.png)

查看数据库：

![1570088222195](assets/1570088222195.png)

查看redis中的信息也被删除



## 1.4. 查询用户

请求方式：GET

请求路径：/ums/user/query

请求参数：username/phone/email password

响应数据：用户的json格式



### 1.4.1. controller

```java
    @GetMapping("query")
    public ResponseVo<UserEntity> queryUser(
            @RequestParam("loginName")String loginName,
            @RequestParam("password")String password
    ){
        UserEntity userEntity = this.userService.queryUser(loginName, password);
        return ResponseVo.ok(userEntity);
    }
```

### 1.4.2. service

```java
@Override
public UserEntity queryUser(String loginName, String password) {

    // 1.根据登录名查询用户信息（拿到盐）
    UserEntity userEntity = this.getOne(new QueryWrapper<UserEntity>()
                                        .eq("username", loginName)
                                        .or()
                                        .eq("phone", loginName)
                                        .or()
                                        .eq("email", loginName)
                                       );

    // 2.判断用户是否为空
    if (userEntity == null){
        throw new UserException("账户输入不合法！");
    }

    // 3.对密码加盐加密，并和数据库中的密码进行比较
    password = DigestUtils.md5Hex(password + userEntity.getSalt());
    if (!StringUtils.equals(userEntity.getPassword(), password)){
        throw new UserException("密码输入错误！");
    }

    // 4.返回用户信息
    return userEntity;
}
```

要注意，查询时也要对密码进行加密后判断是否一致。



### 1.4.3. 测试

![1570089177601](assets/1570089177601.png)



## 1.5. 搭建接口工程

创建gmall-ums-interface工程：

 ![1586099669013](assets/1586099669013.png)

pom.xml中的依赖，参照其他interface工程。并在gmall-ums和gmall-auth工程中引入该接口工程

GmallUmsApi:

```java
public interface GmallUmsApi {

    /**
     * 根据登录名和密码查询用户
     * @param username
     * @param password
     * @return
     */
    @GetMapping("ums/user/query")
    public ResponseVo<UserEntity> queryUser(
            @RequestParam("loginName") String loginName,
            @RequestParam("password") String password
    );
}
```



# 2. 单点登录（SSO）

SSO英文全称Single Sign On，单点登录。

SSO是在多个应用系统中，用户只需要登录一次就可以访问所有相互信任的应用系统。

![1570089652583](assets/1570089652583.png)



## 2.1. cookie问题

电商平台通常由多个微服务组成，每个微服务都有独立的域名，而cookie是有作用域的。

查看浏览器控制台：

![1570092836836](assets/1570092836836.png)

domain：作用域名

| domain参数        | atguigu.com | sso.atguigu.com | order.atguigu.com |
| ----------------- | ----------- | --------------- | ----------------- |
| atguigu.com       | √           | √               | √                 |
| sso.atguigu.com   | ×           | √               | ×                 |
| order.atguigu.com | ×           | ×               | √                 |

domain有两点要注意：

​	1. **domain参数可以设置父域名以及自身，但不能设置其它域名，包括子域名，否则cookie不起作用。**

​	2. **cookie的作用域是domain本身以及domain下的所有子域名。**



Cookie的路径（Path）：

​	response.addCookie默认放在当前路径下，访问当前路径下的所有请求都会带

​	设置/标识项目根路径，访问项目任何位置都会携带



## 2.2. 演示案例

把课前资料中的sso演示工程 《sso-example》导入idea，并且启动。

![1570103418857](assets/1570103418857.png)

在hosts文件中配置域名的映射：

![1570103160672](assets/1570103160672.png)

追加配置如下：

```
127.0.0.1 client.atguigu.com
127.0.0.1 sso.atguigu.com
```



### 2.2.1. 测试一：不能访问兄弟域名cookie

访问：http://client.atguigu.com:8080/hello

由于没有登录会重定向到登录页面：

![1570103522358](assets/1570103522358.png)

输入用户名密码（任意）点击登录，又回到了上述页面。

查看浏览器cookie，发现：

![1570103772200](assets/1570103772200.png)

sso.atguigu.com下已经有token信息。那么为什么又回到了登录页面呢？

这是由于点击登录时，cookie放入了sso.atguigu.com这个作用域，client域下没有cookie导致，再次访问client时，client认为没有登录，又重定向到登录页面



### 2.2.2. 测试二：可以访问父域名的cookie

修改sso-service工程LoginController类的login方法，把cookie的作用域设置为`atguigu.com`

![1570104693601](assets/1570104693601.png)

重启sso-service。

并清理掉浏览器中的cookie：![1570104808919](assets/1570104808919.png)



访问：http://client.atguigu.com:8080/hello

依然重定向到登录页面：

![1570103522358](assets/1570103522358.png)

输入任意内容，点击登录：

![1570104959025](assets/1570104959025.png)

可以登录成功！！



### 2.2.3. 测试三：cookie的作用路径

修改sso-service工程LoginController类的login方法，把cookie的作用路径设置为`/hello`

![1570105058571](assets/1570105058571.png)

重启sso-service服务，并清理掉cookie信息。



在浏览器中访问：http://client.atguigu.com:8080/hello

依然重定向到登录页面，输入任意内容，点击登录：

![1570105244367](assets/1570105244367.png)

可以登录成功，但是cookie的作用路径是/hello。

此时访问：http://client.atguigu.com:8080/hello1

又会跳转到登录页面。原因：cookie只能在/hello路径及其子路径下可以正常访问。



## 2.3. 有状态登录

为了保证客户端cookie的安全性，服务端需要记录每次会话的客户端信息，从而识别客户端身份，根据用户身份进行请求的处理，典型的设计如tomcat中的session。

例如登录：用户登录后，我们把登录者的信息保存在服务端session中，并且给用户一个cookie值，记录对应的session。然后下次请求，用户携带cookie值来，我们就能识别到对应session，从而找到用户的信息。

缺点是什么？

- 服务端保存大量数据，增加服务端压力
- 服务端保存用户状态，无法进行水平扩展
- 客户端请求依赖服务端，多次请求必须访问同一台服务器

即使使用redis保存用户的信息，也会损耗服务器资源。



## 2.4. 无状态登录

微服务集群中的每个服务，对外提供的都是Rest风格的接口。而Rest风格的一个最重要的规范就是：服务的无状态性，即：

- 服务端不保存任何客户端请求者信息
- 客户端的每次请求必须具备自描述信息，通过这些信息识别客户端身份

带来的好处是什么呢？

- 客户端请求不依赖服务端的信息，任何多次请求不需要必须访问到同一台服务
- 服务端的集群和状态对客户端透明
- 服务端可以任意的迁移和伸缩
- 减小服务端存储压力



## 2.5. 无状态登录流程

无状态登录的流程：

- 当客户端第一次请求服务时，服务端对用户进行信息认证（登录）
- 认证通过，将用户信息进行加密形成token，返回给客户端，作为登录凭证
- 以后每次请求，客户端都携带认证的token
- 服务的对token进行解密，判断是否有效。

流程图：

 ![](assets/1527300483893.png)

整个登录过程中，最关键的点是什么？

**token的安全性**

token是识别客户端身份的唯一标示，如果加密不够严密，被人伪造那就完蛋了。

采用何种方式加密才是安全可靠的呢？

我们将采用`JWT + RSA非对称加密`



# 3. jwt实现无状态登录

JWT，全称是Json Web Token， 是JSON风格轻量级的授权和身份认证规范，可实现无状态、分布式的Web应用授权；官网：https://jwt.io

GitHub上jwt的java客户端：https://github.com/jwtk/jjwt



## 3.1. 数据格式

JWT包含三部分数据：

- Header：头部，通常头部有两部分信息：

  - token类型：JWT
  - 加密方式：base64（HS256）

- Payload：载荷，就是有效数据，一般包含下面信息：

  - 用户身份信息（注意，这里因为采用base64编码，可解码，因此不要存放敏感信息）
  - 注册声明：如token的签发时间，过期时间，签发人等

  这部分也会采用base64编码，得到第二部分数据

- Signature：签名，是整个数据的认证信息。根据前两步的数据，再加上指定的密钥（secret）（不要泄漏，最好周期性更换），通过base64编码生成。用于验证整个数据完整和可靠性

![1570109371216](assets/1570109371216.png)



## 3.2. JWT交互流程

流程图：

 ![1527305891424](assets/1527305891424.png)

步骤翻译：

- 1、用户登录
- 2、服务的认证，通过后根据secret生成token
- 3、将生成的token返回给浏览器
- 4、用户每次请求携带token
- 5、服务端利用公钥解读jwt签名，判断签名有效后，从Payload中获取用户信息
- 6、处理请求，返回响应结果

因为JWT签发的token中已经包含了用户的身份信息，并且每次请求都会携带，这样服务的就无需保存用户信息，甚至无需去数据库查询，完全符合了Rest的无状态规范。



## 3.3. 非对称加密

加密技术是对信息进行编码和解码的技术，编码是把原来可读信息（又称明文）译成代码形式（又称密文），其逆过程就是解码（解密），加密技术的要点是加密算法，加密算法可以分为三类：  

- 对称加密，如AES
  - 基本原理：将明文分成N个组，然后使用密钥对各个组进行加密，形成各自的密文，最后把所有的分组密文进行合并，形成最终的密文。
  - 优势：算法公开、计算量小、加密速度快、加密效率高
  - 缺陷：双方都使用同样密钥，安全性得不到保证 
- 非对称加密，如RSA
  - 基本原理：同时生成两把密钥：私钥和公钥，私钥隐秘保存，公钥可以下发给信任客户端
    - 私钥加密，持有公钥才可以解密
    - 公钥加密，持有私钥才可解密
  - 优点：安全，难以破解
  - 缺点：算法比较耗时
- 不可逆加密，如MD5，SHA 
  - 基本原理：加密过程中不需要使用[密钥](https://baike.baidu.com/item/%E5%AF%86%E9%92%A5)，输入明文后由系统直接经过加密算法处理成密文，这种加密后的数据是无法被解密的，无法根据密文推算出明文。



RSA算法历史：

1977年，三位数学家Rivest、Shamir 和 Adleman 设计了一种算法，可以实现非对称加密。这种算法用他们三个人的名字缩写：RSA



# 4. 搭建授权中心

![1570120069198](assets/1570120069198.png)

用户鉴权：

- 接收用户的登录请求，通过用户中心的接口进行校验，通过后生成JWT
- 使用私钥生成JWT并返回

有一些生成jwt，解析jwt这样行为的工具类，以后在其它微服务中也会用到，因此放在gmall-core中。



## 4.1. 创建工程

![1589984888452](assets/1589984888452.png)

pom.xml中添加gmall-common及gmall-ums-interface的依赖



启动类：

```java
@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
public class GmallAuthApplication {

    public static void main(String[] args) {
        SpringApplication.run(GmallAuthApplication.class, args);
    }

}
```

bootstrap.yml：

```yml
spring:
  application:
    name: auth-service
  cloud:
    nacos:
      config:
        server-addr: 127.0.0.1:8848
```

application.yml：

```yml
server:
  port: 18089
spring:
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848
    sentinel:
      transport:
        dashboard: localhost:8080
        port: 8179
  zipkin:
    base-url: http://localhost:9411/
    sender:
      type: web
    discovery-client-enabled: false
  sleuth:
    sampler:
      probability: 1
  thymeleaf:
    cache: false
feign:
  sentinel:
    enabled: true
```



网关工程gmall-gateway添加用户授权的网关路由：

![1589983706531](assets/1589983706531.png)

在nginx中添加：sso.gmall.com

![1589985096412](assets/1589985096412.png)

在hosts文件中添加sso.gmall.com的域名映射。

注意：不要忘记重启网关，重新加载nginx配置。



## 4.2. JWT工具类

gmall-common工程中已经封装了jwt相关的工具类：

 ![1586091816358](assets/1586091816358.png)

并在gmall-common中的pom.xml中引入了jwt相关的依赖：

```xml
<dependency>
    <groupId>io.jsonwebtoken</groupId>
    <artifactId>jjwt-api</artifactId>
    <version>0.10.6</version>
</dependency>
<dependency>
    <groupId>io.jsonwebtoken</groupId>
    <artifactId>jjwt-impl</artifactId>
    <version>0.10.6</version>
</dependency>
<dependency>
    <groupId>io.jsonwebtoken</groupId>
    <artifactId>jjwt-jackson</artifactId>
    <version>0.10.6</version>
    <scope>runtime</scope>
</dependency>
<dependency>
    <groupId>joda-time</groupId>
    <artifactId>joda-time</artifactId>
    <version>2.10.3</version>
</dependency>
```



## 4.3. 测试工具类

```java
public class JwtTest {

    // 别忘了创建D:\\project\rsa目录
	private static final String pubKeyPath = "D:\\project\\rsa\\rsa.pub";
    private static final String priKeyPath = "D:\\project\\rsa\\rsa.pri";

    private PublicKey publicKey;

    private PrivateKey privateKey;

    @Test
    public void testRsa() throws Exception {
        RsaUtils.generateKey(pubKeyPath, priKeyPath, "234");
    }

//    @BeforeEach
    public void testGetRsa() throws Exception {
        this.publicKey = RsaUtils.getPublicKey(pubKeyPath);
        this.privateKey = RsaUtils.getPrivateKey(priKeyPath);
    }

    @Test
    public void testGenerateToken() throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("id", "11");
        map.put("username", "liuyan");
        // 生成token
        String token = JwtUtils.generateToken(map, privateKey, 5);
        System.out.println("token = " + token);
    }

    @Test
    public void testParseToken() throws Exception {
        String token = "eyJhbGciOiJSUzI1NiJ9.eyJpZCI6IjExIiwidXNlcm5hbWUiOiJsaXV5YW4iLCJleHAiOjE1ODYwOTg0MDd9.Gjt968x1OhFVUSDvnKK_TdNgau6wFCLXF98Teosidf__FewtOW3ytA5I1H9jU3DVzrhDfZl0fFfxNJrPPb75_WNKj06f6lB2yRy8fbazzVDrtzsBcPqEa1HeVoNA3NmUVQNlPC3ckYhZ-yu9BT3km3lY0eGum_jPivBHLsXLMbFnSnpXIjYi3kguJfXXRZYKuanGttCV6t7uCWd10GWhEBbXhIi81houaALr2cDWtqHUBC6FbJ0oVdxAaZixwnZJm_vSUjmYjM062H3CJwX44WCxLZXhSRCWhWo3HGpSU2LuUyfd_IJw8MDdI5w31P3dRczAjMjMykAhGBlOCGwy7Q";

        // 解析token
        Map<String, Object> map = JwtUtils.getInfoFromToken(token, publicKey);
        System.out.println("id: " + map.get("id"));
        System.out.println("userName: " + map.get("username"));
    }
}
```



测试生成公钥和私钥，我们运行testRsa方法：**注意需要把@Before方法注释掉**

![1586098332178](assets/1586098332178.png)

运行之后，查看目标目录：

![1586098456319](assets/1586098456319.png)



测试testGenerateToken生成token：注意把@BeforeEach的注释去掉的

![1586098527275](assets/1586098527275.png)

![1570121524935](assets/1570121524935.png)



测试解析token：

![1570121569190](assets/1570121569190.png)

正常情况：

![1570121735824](assets/1570121735824.png)

任意改动一下：

![1570121792041](assets/1570121792041.png)



## 4.4. 配置公钥和私钥

我们需要在授权中心生成真正的公钥和私钥。可以把相关配置内容配置到gmall-auth工程的`application.yml`中或者配置中心：

```yaml
auth:
  jwt:
    pubKeyPath: D:\\project-1010\\rsa\\rsa.pub
    priKeyPath: D:\\project-1010\\rsa\\rsa.pri
    secret: 30489ouerweljrLROE@#)(@$*343jlsdf
    cookieName: GMALL-TOKEN
    expire: 180
    unick: unick
```

然后编写属性类读取jwt配置，并从秘钥配置文件中读取出响应的公钥及私钥，加载这些数据：

 ![1586099976265](assets/1586099976265.png)

内容如下：

```java
@Data
@Slf4j
@ConfigurationProperties(prefix = "auth.jwt")
public class JwtProperties {

    private String pubKeyPath;
    private String priKeyPath;
    private String secret;
    private String cookieName;
    private Integer expire;
    private String unick;

    private PublicKey publicKey;
    private PrivateKey privateKey;

    /**
     * 该方法在构造方法执行之后执行
     */
    @PostConstruct
    public void init(){
        try {
            File pubFile = new File(pubKeyPath);
            File priFile = new File(priKeyPath);
            // 如果公钥或者私钥不存在，重新生成公钥和私钥
            if (!pubFile.exists() || !priFile.exists()) {
                RsaUtil.generateKey(pubKeyPath, priKeyPath, secret);
            }
            this.publicKey = RsaUtil.getPublicKey(pubKeyPath);
            this.privateKey = RsaUtil.getPrivateKey(priKeyPath);
        } catch (Exception e) {
            log.error("生成公钥和私钥出错");
            e.printStackTrace();
        }
    }
}
```



# 5. 完成登录功能

## 5.1. 跳转到登录页

参照京东，当点击登录跳转到登录页面时，如下：

![1589984482920](assets/1589984482920.png)

会记录跳转到登录页面前的页面地址，登录成功后要回到原来的页面。



把课前资料动态页面中的common目录及login.html拷贝到templates目录下

 ![1589985622839](assets/1589985622839.png)

添加AuthController，并添加页面跳转方法如下：

```java
@Controller
public class AuthController {

    @GetMapping("toLogin.html")
    public String toLogin(@RequestParam("returnUrl")String returnUrl, Model model){

        // 把登录前的页面地址，记录到登录页面，以备将来登录成功，回到登录前的页面
        model.addAttribute("returnUrl", returnUrl);
        return "login";
    }
}
```

在login.html页面会记录returnUrl地址，将来登录成功后重定向到该地址：

![1589984597255](assets/1589984597255.png)



在浏览器输入：http://sso.gmall.com/toLogin.html?returnUrl=http://www.gmall.com

效果如下：

![1589985849725](assets/1589985849725.png)



## 5.2. 完成登录功能

接下来，我们需要在`gmall-auth`编写登录代码。基本流程如下：

- 客户端携带用户名和密码请求登录 ，并携带登录前页面的路径
- 授权中心调用用户中心接口，根据用户名和密码查询用户信息
- 用户名密码不正确，不能获取用户，登录失败
- 如果校验成功，则生成JWT，jwt要防止别人盗取
- 把jwt放入cookie
- 为了方便页面展示登录用户昵称，向cookie中单独写入昵称（例如京东cookie中的的**unick**）
- 重定向 回到登录前的页面



实现后的项目结构如下：

 ![1589985770901](assets/1589985770901.png)



### 5.2.1. AuthController

编写授权接口，我们接收登录名和密码及登陆前的页面地址，登录成功后重定向到登陆前页面。

- 请求方式：post
- 请求路径：/login
- 请求参数：loginName和password
- 返回结果：无

代码：

```java
@Controller
public class AuthController {

    @Autowired
    private AuthService authService;

    @Autowired
    private JwtProperties jwtProperties;

    @GetMapping("toLogin.html")
    public String toLogin(@RequestParam("returnUrl")String returnUrl, Model model){

        // 把登录前的页面地址，记录到登录页面，以备将来登录成功，回到登录前的页面
        model.addAttribute("returnUrl", returnUrl);
        return "login";
    }

    @PostMapping("login")
    public String login(
            @RequestParam("loginName")String loginName,
            @RequestParam("password")String password,
            @RequestParam("returnUrl")String returnUrl,
            HttpServletRequest request, HttpServletResponse response
    ){
        this.authService.accredit(loginName, password, request, response);

        // 登录成功重定向到登录前页面
        return "redirect:" + returnUrl;
    }
}
```



### 5.2.2. AuthService

在gmall-auth：

```java
@Service
@EnableConfigurationProperties({JwtProperties.class})
public class AuthService {

    @Autowired
    private GmallUmsClient umsClient;

    @Autowired
    private JwtProperties jwtProperties;

    public void accredit(String loginName, String password, HttpServletRequest request, HttpServletResponse response) {

        try {
            // 1. 完成远程请求，获取用户信息
            ResponseVo<UserEntity> userEntityResponseVo = this.umsClient.queryUser(loginName, password);
            UserEntity userEntity = userEntityResponseVo.getData();

            // 2. 判断用户信息是否为空
            if (userEntity == null) {
                throw new UserException("用户名或者密码有误！");
            }

            // 3. 把用户id及用户名放入载荷
            Map<String, Object> map = new HashMap<>();
            map.put("userId", userEntity.getId());
            map.put("username", userEntity.getUsername());

            // 4. 为了防止jwt被别人盗取，载荷中加入用户ip地址
            String ipAddress = IpUtil.getIpAddress(request);
            map.put("ip", ipAddress);

            // 5. 制作jwt类型的token信息
            String token = JwtUtil.generateToken(map, this.jwtProperties.getPrivateKey(), this.jwtProperties.getExpire());

            // 6. 把jwt放入cookie中
            CookieUtil.setCookie(request, response, this.jwtProperties.getCookieName(), token, this.jwtProperties.getExpire() * 60);
            // 7.用户昵称放入cookie中，方便页面展示昵称
            CookieUtil.setCookie(request, response, this.jwtProperties.getUnick(), userEntity.getNickname(), this.jwtProperties.getExpire() * 60);

        } catch (Exception e) {
            e.printStackTrace();
            throw new UserException("用户名或者密码出错！");
        }
    }
}
```



### 5.2.3. GmallUmsClient

接下来我们肯定要对用户密码进行校验，所以我们需要通过FeignClient去访问 ums-service微服务：

在gmall-auth中引入gmall-ums-interface依赖：

```xml
<dependency>
    <groupId>com.atguigu</groupId>
    <artifactId>gmall-ums-interface</artifactId>
    <version>0.0.1-SNAPSHOT</version>
</dependency>
```

编写GmallUmsClient：

```java
@FeignClient("ums-service")
public interface GmallUmsClient extends GmallUmsApi {
}
```



### 5.2.4. 测试

此时，在登录页面输入正确的用户名和密码信息，可以登录成功并跳转到首页：

![1589986690210](assets/1589986690210.png)

但是查看cookie信息发现cookie为空。

再查看Headers中的Set-Cookie信息中的Domain发现是ip地址，不是地址栏的域名。

![1589986786365](assets/1589986786365.png)

由于浏览器地址栏地址：http://www.gmall.com，而设置cookie的domain域是ip地址，相当于兄弟域名。

兄弟之间不能操作cookie。导致cookie没有写入成功！



为什么是Set-Cookie的Domain是IP地址？



## 5.3. 解决cookie写入问题

解决cookie写入问题，要注意两点：

1. cookie中的domain域必须和地址栏（或者是父域名）一致。
2. cors跨域满足携带cookie的生效条件
   - 服务的响应头中需要携带Access-Control-Allow-Credentials并且为true。（网关中已设置）
   - 响应头中的Access-Control-Allow-Origin一定不能为*，必须是指定的域名。（网关中已设置具体域名）
   - 浏览器发起ajax需要指定withCredentials 为true。（前端工程：gmall-admin\src\utils\httpRequest.js文件已经设置）

### 5.3.1. 跟踪CookieUtils

在gmall-auth中AuthController的authentication方法打一个断点：

![1586423963010](assets/1586423963010.png)

F7进入setCookie方法：

![1586424034071](assets/1586424034071.png)

发现它调用了重载的setCookie方法，再次F7：

![1586424122034](assets/1586424122034.png)

142行可以发现获取domian域并设置domain域。F7进入getDomainName方法，查看最终获取的domain是什么

![1586424340106](assets/1586424340106.png)

160行获取的serverName是ip地址。也就是说这时候只能获取ip地址了，获取不到域名信息。



### 5.3.2. domain地址变化原因

那么问题来了：为什么我们这里的请求serverName变成了pi地址了呢？

这是因为在地址栏输入域名时，经过了两次转发：

- 我们使用了nginx反向代理，当监听到sso.gmall.com的时候，会自动将请求转发至代理ip地址，即gateway服务器地址。
- 而后请求到达我们的gateway网关，gateway网关就会根据路径匹配，我们的请求是/api/auth，根据规则被转发到了auth服务地址 ，即我们的授权中心。

每次转发都会丢失域名信息。



### 5.3.3. nginx转发时要携带域名

首先nginx转发请求给网关时，要携带域名信息。需要在nginx配置文件中配置代理头信息：

```
proxy_set_header Host $host;
```

![1586424821163](assets/1586424821163.png)

修改完成之后，重新加载nginx配置：nginx -s reload

这样就解决了nginx转发时的域名问题。



### 5.3.4. 网关转发时要携带域名

在网关转发请求给服务时，要携带地址信息：

```properties
spring.cloud.gateway.x-forwarded.host-enabled=true
```

![1586425049752](assets/1586425049752.png)

修改之后再次重启，测试

![1586424340106](assets/1586424340106.png)

发现serverName依然时ip地址。

这是因为网关转发后，会把域名通过X-Forwarded-Host头信息转发给服务。所以，需要修改160行的代码，如下：

```java
String serverName = request.getHeader("X-Forwarded-Host");
```

![1586429090255](assets/1586429090255.png)



### 5.3.5. 再次登录测试

![1589987566694](assets/1589987566694.png)

完美！！！！！



## 5.4. 公共页头显示用户名

![1589995729874](assets/1589995729874.png)

js实现：

```javascript
<script th:inline="javascript">
    var item = new Vue({
        el: '#header',

        data: {
            keyword: [[${searchParam?.keyword}]],
            nickName: ''
        },

        created() {
            this.showInfo()
        },
        methods: {
            showInfo() {
                // debugger
                if(auth.getUserInfo()) {
                    this.nickName = auth.getUserInfo();
                }
            },

            search() {
                if(this.keyword == null) this.keyword = ''
                window.location.href = 'http://search.gmall.com/search?keyword=' + this.keyword
            },

            login() {
                window.location.href = 'http://sso.gmall.com/toLogin.html?returnUrl='+window.location.href
            },

            logout() {
                //debugger
                auth.removeToken()
                auth.removeUserInfo()

                //跳转页面
                window.location.href = "/"
            }
        }
    })
</script>
```



# 6. 网关过滤器验证登录状态

gateway网关过滤器包含两种：**全局过滤器**和**局部过滤器**。

## 6.1. 自定义全局过滤器

自定义全局过滤器非常简单：实现GlobalFilter接口即可，无差别拦截所有微服务的请求

 ![1590056832978](assets/1590056832978.png)

内容如下：

```java
@Component
public class TestGatewayFilter implements GlobalFilter, Ordered {

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        System.out.println("无需配置，拦截所有经过网关的请求！！");
        // 放行
        return chain.filter(exchange);
    }

    /**
     * 通过实现Orderer接口的getOrder方法控制全局过滤器的执行顺序
     * @return
     */
    @Override
    public int getOrder() {
        return 0;
    }
}
```



## 6.2. 自定义局部过滤器

自定义局部过滤器稍微麻烦一点：

1. 需要编写过滤器工厂类继承AbstractGatewayFilterFactory抽象类
2. 在需要过滤的微服务路由中配置该过滤器

可以做到定点拦截。



 ![1590051151965](assets/1590051151965.png)



### 6.2.1. 过滤器工厂AuthGatewayFilterFactory

```java
@Component
public class AuthGatewayFilterFactory extends AbstractGatewayFilterFactory<Object> {

    @Override
    public GatewayFilter apply(Object config) {
        // 实现GatewaFilter接口
        return new GatewayFilter() {
            @Override
            public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {

                System.out.println("自定义过滤器！");
                // 放行
                return chain.filter(exchange);
            }
        };
    }
}
```



### 6.2.2. 在配置文件中使用

现在拿gmall-auth工程尝试使用吧

![1590051099606](assets/1590051099606.png)

过滤器名称就是`Auth`，即自定义过滤器工厂`类名称` 去掉 `GatewayFilterFactory`



### 6.2.3. 读取过滤器配置内容

此时，虽然可以使用这个拦截器了，但是我们的拦截器还是光秃秃的，不能指定内容。

如果像下面一样指定`拦截路径`，并在过滤器中获取`拦截路径`，再去判断当前路径是否需要拦截

假设如下：

![1590051731953](assets/1590051731953.png)



改造AuthGatewayFilterFactory过滤器工厂类如下：

```java
@Component
public class AuthGatewayFilterFactory extends AbstractGatewayFilterFactory<AuthGatewayFilterFactory.PathConfig> {

    /**
     * 一定要重写构造方法
     * 告诉父类，这里使用PathConfig对象接收配置内容
     */
    public AuthGatewayFilterFactory() {
        super(PathConfig.class);
    }

    @Override
    public GatewayFilter apply(PathConfig config) {
        // 实现GatewaFilter接口
        return new GatewayFilter() {
            @Override
            public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {

                System.out.println("自定义过滤器！" + config);
                // 放行
                return chain.filter(exchange);
            }
        };
    }

    /**
     * 指定字段顺序
     * 可以通过不同的字段分别读取：/toLogin.html,/login
     * 在这里希望通过一个集合字段读取所有的路径
     * @return
     */
    @Override
    public List<String> shortcutFieldOrder() {
        return Arrays.asList("authPaths");
    }

    /**
     * 指定读取字段的结果集类型
     * 默认通过map的方式，把配置读取到不同字段
     *  例如：/toLogin.html,/login
     *      由于只指定了一个字段，只能接收/toLogin.html
     * @return
     */
    @Override
    public ShortcutType shortcutType() {
        return ShortcutType.GATHER_LIST;
    }

    /**
     * 读取配置的内部类
     */
    @Data
    public static class PathConfig{
        private List<String> authPaths;
    }
}
```



测试效果如下：已经可以拿到配置内容

![1590052897996](assets/1590052897996.png)



## 6.3. 通过自定义局部过滤器完成登录验证

接下来，我们在gmall-gateway编写过滤器，对用户的token进行校验，如果发现未登录，则进行拦截。

思路：

1. 判断请求路径在不在拦截名单中，不在直接放行
2. 获取请求中的token。同步请求从cookie中获取，异步请求从header中获取（走cookie太重，一个网站往往有很多cookie，如果通过携带cookie的方式传递token，网络传输压力太大）
3. 判断token是否为空。为空直接拦截
4. 如果不为空，解析jwt获取登录信息
5. 判断是否被盗用。通过登录信息中的ip和当前请求的ip比较
6. 传递登录信息给后续服务。后续各服务就不用再去解析了
7. 放行



### 6.3.1. 引入jwt相关配置

既然是登录拦截，一定需要公钥解析jwt，我们在`gmall-gateway`中配置。

首先在pom.xml中，引入所需要的依赖：

```xml
<dependency>
    <groupId>com.atguigu</groupId>
    <artifactId>gmall-common</artifactId>
    <version>0.0.1-SNAPSHOT</version>
</dependency>
```

然后编写application.yml属性文件，添加如下内容：

```yaml
auth:
  jwt:
    pubKeyPath: D:\\project\\rsa\\rsa.pub # 公钥地址
    cookieName: GMALL-TOKEN
```

编写属性类，读取公钥：

 ![1590056138535](assets/1590056138535.png)

jwtProperties内容如下：

```java
@Data
@Slf4j
@ConfigurationProperties(prefix = "auth.jwt")
public class JwtProperties {

    private String pubKeyPath;// 公钥

    private PublicKey publicKey; // 公钥

    private String cookieName;

    @PostConstruct
    public void init(){
        try {
            // 获取公钥和私钥
            this.publicKey = RsaUtils.getPublicKey(pubKeyPath);
        } catch (Exception e) {
            log.error("初始化公钥失败！", e);
            throw new RuntimeException();
        }
    }

}
```



### 6.3.2. 编写代码实现登录拦截

改造AuthGatewayFilterFactory

```java
@Component
@EnableConfigurationProperties({JwtProperties.class})
public class AuthGatewayFilterFactory extends AbstractGatewayFilterFactory<AuthGatewayFilterFactory.PathConfig> {

    @Autowired
    private JwtProperties properties;

    /**
     * 一定要重写构造方法
     * 告诉父类，这里使用PathConfig对象接收配置内容
     */
    public AuthGatewayFilterFactory() {
        super(PathConfig.class);
    }

    @Override
    public GatewayFilter apply(PathConfig config) {
        // 实现GatewaFilter接口
        return new GatewayFilter() {
            @Override
            public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {

                // 获取request和response，注意：不是HttpServletRequest及HttpServletResponse
                ServerHttpRequest request = exchange.getRequest();
                ServerHttpResponse response = exchange.getResponse();
                // 获取当前请求的path路径
                String path = request.getURI().getPath();

                // 1.判断请求路径在不在拦截名单中，不在直接放行
                Boolean flag = false;
                for (String authPath : config.getAuthPaths()) {
                    // 如果白名单中有一个包含当前路径
                    if (path.indexOf(authPath) != -1){
                        flag = true;
                        break;
                    }
                }
                // 不在拦截名单中，放行
                if (!flag){
                    return chain.filter(exchange);
                }

                // 2.获取请求中的token
                String token = "";
                // 异步请求，通过头信息获取token
                List<String> tokenList = request.getHeaders().get("token");
                if(!CollectionUtils.isEmpty(tokenList)) {
                    token = tokenList.get(0);
                } else {
                    // 同步请求通过cookie
                    MultiValueMap<String, HttpCookie> cookies = request.getCookies();
                    if (CollectionUtils.isEmpty(cookies) || !cookies.containsKey(properties.getCookieName())) {
                        // 拦截
                        // 重定向到登录
                        // 303状态码表示由于请求对应的资源存在着另一个URI，应使用重定向获取请求的资源
                        response.setStatusCode(HttpStatus.SEE_OTHER);
                        response.getHeaders().set(HttpHeaders.LOCATION, "http://sso.gmall.com/toLogin.html?returnUrl="+request.getURI());
                        // 设置响应状态码为未认证
//                        response.setStatusCode(HttpStatus.UNAUTHORIZED);
                        return response.setComplete();
                    }

                    // 获取cookie中的jwt
                    HttpCookie cookie = cookies.getFirst(properties.getCookieName());
                    token = cookie.getValue();
                }

                // 3.判断token是否为空
                if (StringUtils.isEmpty(token)) {
                    // 去登录
                    response.setStatusCode(HttpStatus.SEE_OTHER);
                    response.getHeaders().set(HttpHeaders.LOCATION, "http://sso.gmall.com/toLogin.html?returnUrl="+request.getURI());
                    return response.setComplete();
                }

                try {
                    // 4.解析jwt，获取登录信息
                    Map<String, Object> map = JwtUtil.getInfoFromToken(token, properties.getPublicKey());

                    // 5.判断token是否被盗用
                    String ip = map.get("ip").toString();
                    // 当前请求的ip
                    String curIp = IpUtil.getIpAddressAtGateway(request);
                    if (!StringUtils.equals(ip, curIp)){
                        // 去登陆
                        response.setStatusCode(HttpStatus.SEE_OTHER);
                        response.getHeaders().set(HttpHeaders.LOCATION, "http://sso.gmall.com/toLogin.html?returnUrl="+request.getURI());
                        return response.setComplete();
                    }

                    // 6.传递登录信息给后续服务
                    String userId = map.get("userId").toString();
                    // 将userId转变成request对象。mutate：转变的意思
                    request.mutate().header("userId", userId).build();
                    exchange.mutate().request(request).build();

                    // 放行
                    return chain.filter(exchange);
                } catch (Exception e) {
                    e.printStackTrace();
                    // 7.异常，去登录
                    response.setStatusCode(HttpStatus.SEE_OTHER);
                    response.getHeaders().set(HttpHeaders.LOCATION, "http://sso.gmall.com/toLogin.html?returnUrl="+request.getURI());
                    return response.setComplete();
                }
            }
        };
    }

    /**
     * 指定字段顺序
     * 可以通过不同的字段分别读取：/toLogin.html,/login
     * 在这里希望通过一个集合字段读取所有的路径
     * @return
     */
    @Override
    public List<String> shortcutFieldOrder() {
        return Arrays.asList("authPaths");
    }

    /**
     * 指定读取字段的结果集类型
     * 默认通过map的方式，把配置读取到不同字段
     *  例如：/toLogin.html,/login
     *      由于只指定了一个字段，只能接收/toLogin.html
     * @return
     */
    @Override
    public ShortcutType shortcutType() {
        return ShortcutType.GATHER_LIST;
    }

    /**
     * 读取配置的内部类
     */
    @Data
    public static class PathConfig{
        private List<String> authPaths;
    }
}
```



### 6.3.3. 配置过滤器并测试

在网关配置文件中的配置如下：

![1590056483612](assets/1590056483612.png)

在浏览器上访问：http://sso.gmall.com/xxx

重定向到了登录页面

![1590056551282](assets/1590056551282.png)

输入用户名及密码登录后

![1590056697775](assets/1590056697775.png)

出现404，说明登录情况下网关放行了，由于没有该路径对应的接口，所有出现了404



## 6.4. 常见异常解决

如果网关报如下错误：

![1570158724129](assets/1570158724129.png)

原因：springCloud-gateway内部集成的是webflux而不是servlet，所以需要排除servlet相关的依赖。

tomcat是servlet容器

![1586431296556](assets/1586431296556.png)