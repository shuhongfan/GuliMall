

# 1. Nacos概述

官方地址：https://nacos.io

github地址：https://github.com/alibaba/nacos



面试题：微服务间远程交互的过程？

1. 先去注册中心查询服务的服务器地址
2. 调用方给对方发送http请求



## 1.1.   什么是 Nacos

Nacos 是阿里巴巴推出来的一个新开源项目，这是一个更易于构建云原生应用的动态服务发现、配置管理和服务管理平台。

Nacos 致力于帮助您发现、配置和管理微服务。Nacos 提供了一组简单易用的特性集，帮助您快速实现动态服务发现、服务配置、服务元数据及流量管理。

Nacos 帮助您更敏捷和容易地构建、交付和管理微服务平台。 Nacos 是构建以“服务”为中心的现代应用架构 (例如微服务范式、云原生范式) 的服务基础设施。



## 1.2.   为什么是Nacos

常见的注册中心：

1. Eureka（原生，2.0遇到性能瓶颈，停止维护）
2. Zookeeper（支持，专业的独立产品。例如：dubbo）
3. Consul（原生，GO语言开发）
4. Nacos

相对于 Spring Cloud Eureka 来说，Nacos 更强大。

**Nacos = Spring Cloud Eureka + Spring Cloud Config**

Nacos 可以与 Spring, Spring Boot, Spring Cloud 集成，并能代替 Spring Cloud Eureka, Spring Cloud Config。

- 通过 Nacos Server 和 spring-cloud-starter-alibaba-nacos-config 实现配置的动态变更。

- 通过 Nacos Server 和 spring-cloud-starter-alibaba-nacos-discovery 实现服务的注册与发现。



## 1.3.   可以干什么

Nacos是以服务为主要服务对象的中间件，Nacos支持所有主流的服务发现、配置和管理。

Nacos主要提供以下四大功能：

1. 服务发现和服务健康监测
2. 动态配置服务
3. 动态DNS服务
4. 服务及其元数据管理



# 2.  Nacos快速开始

结构图：

![echo service](assets/1542119181336-b6dc0fc1-ed46-43a7-9e5f-68c9ca344d60.png)

Nacos 依赖 Java 环境来运行。如果您是从代码开始构建并运行Nacos，还需要为此配置 Maven环境，请确保是在以下版本环境中安装使用:

1. 64 bit OS，支持 Linux/Unix/Mac/Windows，推荐选用 Linux/Unix/Mac。
2. 64 bit JDK 1.8+
3. Maven 3.2.x+



## 2.1.   下载及安装

你可以通过源码和发行包两种方式来获取 Nacos。

您可以从 [最新稳定版本](https://github.com/alibaba/nacos/releases) 下载 `nacos-server-$version.zip` 包。

```bash
  unzip nacos-server-$version.zip 或者 tar -xvf nacos-server-$version.tar.gz
  cd nacos/bin
```



## 2.2.   启动nacos服务

**Linux/Unix/Mac**

启动命令(standalone代表着单机模式运行，非集群模式):

```
sh startup.sh -m standalone
```



**Windows**

启动命令：

```
cmd startup.cmd
```

或者双击startup.cmd运行文件。



访问：http://localhost:8848/nacos

用户名密码：nacos/nacos

![1565850935295](assets/1565850935295.png)



## 2.3.   注册中心

首先创建两个工程：nacos-provider、nacos-consumer

![1565852100033](assets/1565852100033.png)

![1584353808117](assets/1584353808117.png)

创建生产者：

![1565852279616](assets/1565852279616.png)

![1565852355522](assets/1565852355522.png)

![1565852477523](assets/1565852477523.png)

创建消费者：

![1565852617198](assets/1565852617198.png)

![1567250727696](assets/1567250727696.png)

![1565852777390](assets/1565852777390.png)

然后，一路下一步或者ok。效果如下：

![1565852929136](assets/1565852929136.png)



### 2.3.1.   生产者基本代码

 ![1565854507349](assets/1565854507349.png)

ProviderController代码如下：

```java
@RestController
public class ProviderController {

    @Value("${myName}")
    private String name;

    @GetMapping("hello")
    public String hello(){
        return "hello " + name;
    }
}
```

application.properties配置如下：

```properties
server.port=18070
# 自定义参数
myName=nacos
```



### 2.3.2.   生产者注册到nacos

生产者注册到nacos注册中心，步骤：

1. 添加依赖：spring-cloud-starter-alibaba-nacos-discovery及springCloud

   ```xml
   <dependencies>
       <dependency>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-starter-web</artifactId>
       </dependency>
   
       <dependency>
           <groupId>com.alibaba.cloud</groupId>
           <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
       </dependency>
   
       <dependency>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-starter-test</artifactId>
           <scope>test</scope>
           <exclusions>
               <exclusion>
                   <groupId>org.junit.vintage</groupId>
                   <artifactId>junit-vintage-engine</artifactId>
               </exclusion>
           </exclusions>
       </dependency>
   </dependencies>
   
   <!-- SpringCloud的依赖 -->
   <dependencyManagement>
       <dependencies>
           <dependency>
               <groupId>org.springframework.cloud</groupId>
               <artifactId>spring-cloud-dependencies</artifactId>
               <version>Hoxton.SR2</version>
               <type>pom</type>
               <scope>import</scope>
           </dependency>
           <dependency>
               <groupId>com.alibaba.cloud</groupId>
               <artifactId>spring-cloud-alibaba-dependencies</artifactId>
               <version>2.1.0.RELEASE</version>
               <type>pom</type>
               <scope>import</scope>
           </dependency>
       </dependencies>
   </dependencyManagement>
   ```

   

2. 在 `application.properties` 中配置nacos服务地址和应用名

   ```properties
   server.port=8070
   spring.application.name=nacos-provider
   # nacos服务地址
   spring.cloud.nacos.discovery.server-addr=127.0.0.1:8848
   # 自定义参数
   myName=nacos
   ```

3. 通过Spring Cloud原生注解 `@EnableDiscoveryClient` 开启服务注册发现功能

   ```java
   @SpringBootApplication
   @EnableDiscoveryClient
   public class NacosProviderApplication {
   
       public static void main(String[] args) {
           SpringApplication.run(NacosProviderApplication.class, args);
       }
   
   }
   ```



效果：

![1567251987453](assets/1567251987453.png)



### 2.3.3.   消费端基本代码

 ![1567253090953](assets/1567253090953.png)

ConsumerController代码：

```java
@RestController
public class ConsumerController {

    @GetMapping("hi")
    public String hi() {
        return "hi provider!";
    }
}
```

application.properties:

```properties
server.port=18080
```



### 2.3.4.   消费者注册到nacos

消费者注册到nacos跟生产者差不多，也分3步：

1. 添加依赖：同生产者

2. 在application.properties中配置nacos的服务名及服务地址：同生产者

3. 在引导类（NacosConsumerApplication.java）中添加@EnableDiscoveryClient注解：同生产者

   

效果：

![1567254178699](assets/1567254178699.png)



### 2.3.5.   使用feign调用服务

 ![1567254545445](assets/1567254545445.png)

以前我们使用feign来远程调用，这里也一样。引入feign的依赖：

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>

    <dependency>
        <groupId>com.alibaba.cloud</groupId>
        <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
    </dependency>

    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-starter-openfeign</artifactId>
    </dependency>

    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
        <exclusions>
            <exclusion>
                <groupId>org.junit.vintage</groupId>
                <artifactId>junit-vintage-engine</artifactId>
            </exclusion>
        </exclusions>
    </dependency>
</dependencies>

<!-- SpringCloud的依赖 -->
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-dependencies</artifactId>
            <version>Hoxton.SR2</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-alibaba-dependencies</artifactId>
            <version>2.1.0.RELEASE</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

在NacosConsumerApplication类上添加@EnableFeignClients注解：

```java
@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
public class NacosConsumerApplication {

    public static void main(String[] args) {
        SpringApplication.run(NacosConsumerApplication.class, args);
    }

}
```

编写feignClient：

 ![1584357563919](assets/1584357563919.png)

内容：

```java
@FeignClient("nacos-provider")
public interface ProviderFeign {

    @RequestMapping("hello")
    public String hello();
}
```

在Controller中使用feignClient：

```java
@RestController
public class ConsumerController {

    @Autowired
    private ProviderFeign providerFeign;

    @GetMapping("hi")
    public String hi() {
        return this.providerFeign.hello();
    }
}
```



测试访问：

![1584413185337](assets/1584413185337.png)



## 2.4.   配置中心

​		在系统开发过程中，开发者通常会将一些需要变更的参数、变量等从代码中分离出来独立管理，以独立的配置文件的形式存在。目的是让静态的系统工件或者交付物（如 WAR，JAR 包等）更好地和实际的物理运行环境进行适配。配置管理一般包含在系统部署的过程中，由系统管理员或者运维人员完成。配置变更是调整系统运行时的行为的有效手段。



如果微服务架构中没有使用统一配置中心时，所存在的问题：

- 配置文件分散在各个项目里，不方便维护
- 配置内容安全与权限
- 更新配置后，项目需要重启



nacos配置中心：**系统配置的集中管理**（编辑、存储、分发）、**动态更新不重启**、**回滚配置**（变更管理、历史版本管理、变更审计）等所有与配置相关的活动。



案例：改造生产者中的动态配置项，由配置中心统一管理。

![1567261900469](assets/1567261900469.png)



### 2.4.1.   nacos中创建统一配置

![1567262976093](assets/1567262976093.png)

![1567263334245](assets/1567263334245.png)

1. `dataId` 的完整格式如下：

   ```
   ${prefix}-${spring.profile.active}.${file-extension}
   ```

   - `prefix` 默认为所属工程配置`spring.application.name` 的值（即：nacos-provider），也可以通过配置项 `spring.cloud.nacos.config.prefix`来配置。
   - `spring.profile.active` 即为当前环境对应的 profile，详情可以参考 [Spring Boot文档](https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-profiles.html#boot-features-profiles)。 **注意：当 spring.profile.active 为空时，对应的连接符 - 也将不存在，dataId 的拼接格式变成 `${prefix}.${file-extension}`**
   - `file-exetension` 为配置内容的数据格式，可以通过配置项 `spring.cloud.nacos.config.file-extension` 来配置。**目前只支持 `properties` 和 `yaml` 类型。**

   总结：配置所属工程的spring.application.name的值 + "." + properties/yml

2. 配置内容：

   项目中易变的内容。例如：myName

**当前案例中，nacos-provider工程的spring.application.name=nacos-provider，没有配置spring.profiles.active。所以这里的dataId填写的是nacos-provider.properties**



### 2.4.2.   从配置中心读取配置

从配置中心读取配置，分以下3步：

1. 引入依赖

   在生产者中引入依赖：

   ```xml
   <dependency>
       <groupId>com.alibaba.cloud</groupId>
       <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>
   </dependency>
   ```
   
2. 在 **`bootstrap.properties`** 中配置 Nacos server 的地址和应用名

   ```properties
   spring.cloud.nacos.config.server-addr=127.0.0.1:8848
   # 该配置影响统一配置中心中的dataId，之前已经配置过
   spring.application.name=nacos-provider
   ```

   说明：之所以需要配置 `spring.application.name` ，是因为它是构成 Nacos 配置管理 `dataId`字段的一部分。

   在springboot工程中，bootstrap.properties的加载优先级更高。

3. 通过 Spring Cloud 原生注解 `@RefreshScope` 实现配置自动更新：

   ```java
   @RestController
   @RefreshScope
   public class ProviderController {
   
       @Value("${myName}")
       private String name;
   
       @RequestMapping("hello")
       public String hello(){
           return "hello " + name;
       }
   }
   ```

   

### 2.4.3.   名称空间切换环境

在实际开发中，通常有多套不同的环境（默认只有public），那么这个时候可以根据指定的环境来创建不同的 namespce，例如，开发、测试和生产三个不同的环境，那么使用一套 nacos 集群可以分别建以下三个不同的 namespace。以此来实现多环境的隔离。

![1567300201637](assets/1567300201637.png)

切换到配置列表：

![1567300201637](assets/nacos-namespace.gif)

可以发现有四个名称空间：public（默认）以及我们自己添加的3个名称空间（prod、dev、test），可以点击查看每个名称空间下的配置文件，当然现在只有public下有一个配置。

默认情况下，项目会到public下找 `服务名.properties`文件。

接下来，在dev名称空间中也添加一个nacos-provider.properties配置。这时有两种方式：

1. 切换到dev名称空间，添加一个新的配置文件。缺点：每个环境都要重复配置类似的项目
2. **直接通过clone方式添加配置，并修改即可。推荐**

![1567301645987](assets/1567301645987.png)

![1567301689032](assets/1567301689032.png)

![1567301731019](assets/1567301731019.png)

点击编辑：修改配置内容，以作区分

![1567301779793](assets/1567301779793.png)



在服务提供方nacos-provider中切换命名空间，修改bootstrap.properties添加如下配置

```properties
spring.cloud.nacos.config.namespace=7fd7e137-21c4-4723-a042-d527149e63e0
```

namespace的值为：

![1567302053790](assets/1567302053790.png)



重启服务提供方服务，在浏览器中访问测试：

![1584413339812](assets/1584413339812.png)



### 2.4.4.   回滚配置（了解）

**目前版本该功能有bug，回滚之后配置消失。**

回滚配置只需要两步：

1. 查看历史版本
2. 回滚到某个历史版本

![1567303117328](assets/1567303117328.png)

![1567303168315](assets/1567303168315.png)



### 2.4.5.   加载多配置文件

偶尔情况下需要加载多个配置文件。假如现在dev名称空间下有三个配置文件：nacos-provider.properties、redis.properties、jdbc.properties。

![1567305611637](assets/1567305611637.png)

jdbc.properties:

```properties
jdbc.url=xxxxxx
```

redis.properties:

```properties
redis.url=yyyy
```

nacos-provider.properties默认加载，怎么加载另外两个配置文件？

在bootstrap.properties文件中添加如下配置：

```properties
spring.cloud.nacos.config.ext-config[0].data-id=redis.properties
# 开启动态刷新配置，否则配置文件修改，工程无法感知
spring.cloud.nacos.config.ext-config[0].refresh=true
spring.cloud.nacos.config.ext-config[1].data-id=jdbc.properties
spring.cloud.nacos.config.ext-config[1].refresh=true
```



修改ProviderController使用redis.properties和jdbc.properties配置文件中的参数：

```java
@RestController
@RefreshScope
public class ProviderController {

    @Value("${myName}")
    private String name;

    @Value("${jdbc.url}")
    private String jdbcUrl;

    @Value("${redis.url}")
    private String redisUrl;

    @RequestMapping("hello")
    public String hello(){
        return "hello " + name + ", redis-url=" + redisUrl + ", jdbc-url=" + jdbcUrl;
    }
}
```

测试效果：

![1584414166841](assets/1584414166841.png)



问题：

​	修改一下配置中心中redis.properties中的配置，不重启服务。能否动态加载配置信息

​	删掉`spring.cloud.nacos.config.ext-config[0].refresh=true`，再修改redis.properties中的配置试试



### 2.4.6.   配置的分组

在实际开发中，除了不同的环境外。不同的微服务或者业务功能，可能有不同的redis及mysql数据库。

区分不同的环境我们使用名称空间（namespace），区分不同的微服务或功能，使用分组（group）。

当然，你也可以反过来使用，名称空间和分组只是为了更好的区分配置，提供的两个维度而已。

新增一个redis.properties，所属分组为provider：

![1567307163038](assets/1567307163038.png)

现在开发环境中有两个redis.propertis配置文件，一个是默认分组（DEFAULT_GROUP），一个是provider组

默认情况下从DEFAULT_GROUP分组中读取redis.properties，如果要切换到provider分组下的redis.properties，需要添加如下配置：

```properties
# 指定分组
spring.cloud.nacos.config.ext-config[0].group=provider
```



缺点：

​		将来每个分组下会有太多的配置文件，不利于维护。

最佳实践：

​		**命名空间区分业务功能，分组区分环境。**



# 3. 服务网关Gateway

API 网关出现的原因是微服务架构的出现，不同的微服务一般会有不同的网络地址，而外部客户端可能需要调用多个服务的接口才能完成一个业务需求，如果让客户端直接与各个微服务通信，会有以下的问题：

1. 破坏了服务无状态特点。

   为了保证对外服务的安全性，我们需要实现对服务访问的权限控制，而开放服务的权限控制机制将会贯穿并污染整个开放服务的业务逻辑，这会带来的最直接问题是，破坏了服务集群中REST API无状态的特点。

     	从具体开发和测试的角度来说，在工作中除了要考虑实际的业务逻辑之外，还需要额外考虑对接口访问的控制处理。

2. 无法直接复用既有接口。

   当我们需要对一个即有的集群内访问接口，实现外部服务访问时，我们不得不通过在原有接口上增加校验逻辑，或增加一个代理调用来实现权限控制，无法直接复用原有的接口。

以上这些问题可以借助 API 网关解决。API 网关是介于客户端和服务器端之间的中间层，所有的外部请求都会先经过 API 网关这一层。也就是说，API 的实现方面更多的考虑业务逻辑，而安全、性能、监控可以交由 API 网关来做，这样既提高业务灵活性又不缺安全性，典型的架构图如图所示：

 ![1567310156296](assets/1567310156296.png)

## 3.1. 快速开始

创建网关module：

![1567310403942](assets/1567310403942.png)

![1567310497409](assets/1567310497409.png)

完成后：

 ![1567310618844](assets/1567310618844.png)



### 3.1.1. 引入依赖

已引入，如下。pom.xml中的依赖：

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-starter-gateway</artifactId>
    </dependency>

    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>

<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-dependencies</artifactId>
            <version>${spring-cloud.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```



### 3.1.2. 编写路由规则

为了演示路由到不同服务，这里把消费者和生产者都配置在网关中

application.yml

```yml
server:
  port: 18090
spring:
  cloud:
    gateway:
      routes:
        - id: nacos-consumer
          uri: http://127.0.0.1:18080
          predicates:
            - Path=/hi
        - id: nacos-provider
          uri: http://127.0.0.1:18070
          predicates:
            - Path=/hello
```



### 3.1.3. 启动测试

通过网关路径访问消费者或者生产者。

![1584414868812](assets/1584414868812.png)



## 3.2. 路由规则详解

![1568906267000](assets/1568906267000.png)

基本概念：

- **Route**：路由网关的基本构建块。它由ID，目的URI，断言（Predicate）集合和过滤器（filter）集合组成。如果断言聚合为真，则匹配该路由。
- **Predicate**：这是一个 Java 8函数式断言。允许开发人员匹配来自HTTP请求的任何内容，例如请求头或参数。
- **过滤器**：可以在发送下游请求之前或之后修改请求和响应。

**路由根据断言进行匹配，匹配成功就会转发请求给URI，在转发请求之前或者之后可以添加过滤器。**



### 3.2.1. 断言工厂

Spring Cloud Gateway包含许多内置的Route Predicate工厂。所有这些断言都匹配HTTP请求的不同属性。多路由断言工厂通过`and`组合。

官方提供的路由工厂：

 ![1567318676724](assets/1567318676724.png)

这些断言工厂的配置方式，参照官方文档：https://cloud.spring.io/spring-cloud-static/spring-cloud-gateway/2.1.0.RELEASE/single/spring-cloud-gateway.html

![1567318580097](assets/1567318580097.png)

![img](assets/20190502120932678.png)

这里重点掌握请求路径路由断言的配置方式：

![1567318968400](assets/1567318968400.png)

```yml
spring:
  cloud:
    gateway:
      routes:
      - id: host_route
        uri: http://example.org
        predicates:
        - Path=/foo/{segment},/bar/{segment}
```

这个路由匹配以/foo或者/bar开头的路径，转发到http:example.org。例如 `/foo/1` or `/foo/bar` or `/bar/baz`.



### 3.2.2. 过滤器工厂

路由过滤器允许以某种方式修改传入的HTTP请求或传出的HTTP响应。路径过滤器的范围限定为特定路由。Spring Cloud Gateway包含许多内置的GatewayFilter工厂。

 ![1567323105648](assets/1567323105648.png)

这些过滤器工厂的配置方式，同样参照官方文档：https://cloud.spring.io/spring-cloud-static/spring-cloud-gateway/2.1.0.RELEASE/single/spring-cloud-gateway.html

 ![1567323164745](assets/1567323164745.png)

过滤器 有 20 多个 实现类,根据过滤器工厂的用途来划分，可以分为以下几种：Header、Parameter、Path、Body、Status、Session、Redirect、Retry、RateLimiter和Hystrix

![img](assets/20181202154250869.png)

这里重点掌握PrefixPath GatewayFilter Factory

![1567325859435](assets/1567325859435.png)

上面的配置中，所有的`/foo/**`开始的路径都会命中配置的router，并执行过滤器的逻辑，在本案例中配置了RewritePath过滤器工厂，此工厂将/foo/(?.*)重写为{segment}，然后转发到http://example.org。比如在网页上请求localhost:8090/foo/forezp，此时会将请求转发到http://example.org/forezp的页面



​		在开发中由于所有微服务的访问都要经过网关，为了区分不同的微服务，通常会在路径前加上一个标识，例如：访问服务提供方：`http://localhost:18090/provider/hello` ；访问服务消费方：`http://localhost:18090/consumer/hi`  如果不重写地址，直接转发的话，转发后的路径为：`http://localhost:18070/provider/hello`和`http://localhost:18080/consumer/hi`明显多了一个provider或者consumer，导致转发失败。

这时，我们就用上了路径重写，配置如下：

```yaml
server:
  port: 18090
spring:
  cloud:
    gateway:
      routes:
        - id: nacos-consumer
          uri: http://127.0.0.1:18080
          predicates:
            - Path=/consumer/**
          filters:
            - RewritePath=/consumer/(?<segment>.*),/$\{segment}
        - id: nacos-provider
          uri: http://127.0.0.1:18070
          predicates:
            - Path=/provider/**
          filters:
            - RewritePath=/provider/(?<segment>.*),/$\{segment}
```

**注意**：`Path=/consumer/**`及`Path=/provider/**`的变化

测试：

![1584415091512](assets/1584415091512.png)



## 3.3. 面向服务的路由

![1584415215284](assets/1584415215284.png)

如果要做到负载均衡，则必须把网关工程注册到nacos注册中心，然后通过服务名访问。

### 3.3.1. 把网关服务注册到nacos

1. 引入nacos的相关依赖：

   ```xml
   <dependency>
       <groupId>com.alibaba.cloud</groupId>
       <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
   </dependency>
   
   <dependency>
       <groupId>com.alibaba.cloud</groupId>
       <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>
   </dependency>
   
   <!-- SpringCloud的依赖 -->
   <dependencyManagement>
       <dependencies>
           <dependency>
               <groupId>org.springframework.cloud</groupId>
               <artifactId>spring-cloud-dependencies</artifactId>
               <version>Hoxton.SR2</version>
               <type>pom</type>
               <scope>import</scope>
           </dependency>
           <!-- 在依赖管理中加入springCloud-alibaba组件的依赖 -->
           <dependency>
               <groupId>com.alibaba.cloud</groupId>
               <artifactId>spring-cloud-alibaba-dependencies</artifactId>
               <version>2.1.0.RELEASE</version>
               <type>pom</type>
               <scope>import</scope>
           </dependency>
       </dependencies>
   </dependencyManagement>
   ```

2. 配置nacos服务地址及服务名：

      ![1567316026329](assets/1567316026329.png)

   bootstrap.yml中的配置：

   ```yaml
   spring:
     application:
       name: gateway-demo
     cloud:
       nacos:
         config:
           server-addr: 127.0.0.1:8848
   ```

   application.yml中的配置：

   ```yaml
   server:
     port: 18090
   spring:
     cloud:
       nacos:
         discovery:
           server-addr: 127.0.0.1:8848
       gateway:
         routes:
           - id: nacos-consumer
             uri: http://127.0.0.1:18080
             predicates:
               - Path=/consumer/**
             filters:
               - RewritePath=/consumer/(?<segment>.*),/$\{segment}
           - id: nacos-provider
             uri: http://127.0.0.1:18070
             predicates:
               - Path=/provider/**
             filters:
               - RewritePath=/provider/(?<segment>.*),/$\{segment}
   ```

3. 把网关注入到nacos

   ```java
   @SpringBootApplication
   @EnableDiscoveryClient
   public class GatewayDemoApplication {
   
       public static void main(String[] args) {
           SpringApplication.run(GatewayDemoApplication.class, args);
       }
   
   }
   ```



### 3.3.2. 修改配置，通过服务名路由

```yaml
server:
  port: 18090
spring:
  cloud:
    nacos:
      discovery:
        server-addr: 127.0.0.1:8848
    gateway:
      routes:
        - id: nacos-consumer
          uri: lb://nacos-consumer
          predicates:
            - Path=/consumer/**
          filters:
            - RewritePath=/consumer/(?<segment>.*),/$\{segment}
        - id: nacos-provider
          uri: lb://nacos-provider
          predicates:
            - Path=/provider/**
          filters:
            - RewritePath=/provider/(?<segment>.*),/$\{segment}
```

语法：lb://服务名

lb：LoadBalance，代表负载均衡的方式

服务名取决于nacos的服务列表中的服务名

![1567322529258](assets/1567322529258.png)





## 3.4. 路由的java代码配置方式（了解）

参见官方文档：

![1567328302375](assets/1567328302375.png)

代码如下：

```
@Bean
public RouteLocator customRouteLocator(RouteLocatorBuilder builder, ThrottleGatewayFilterFactory throttle) {
    return builder.routes()
            .route(r -> r.host("**.abc.org").and().path("/image/png")
                .filters(f ->
                        f.addResponseHeader("X-TestHeader", "foobar"))
                .uri("http://httpbin.org:80")
            )
            .route(r -> r.path("/image/webp")
                .filters(f ->
                        f.addResponseHeader("X-AnotherHeader", "baz"))
                .uri("http://httpbin.org:80")
            )
            .route(r -> r.order(-1)
                .host("**.throttle.org").and().path("/get")
                .filters(f -> f.filter(throttle.apply(1,
                        1,
                        10,
                        TimeUnit.SECONDS)))
                .uri("http://httpbin.org:80")
            )
            .build();
}
```



# 4. Sentinel

分布式系统的流量防卫兵

## 4.1. Sentinel 是什么？

随着微服务的流行，服务和服务之间的稳定性变得越来越重要。Sentinel 以流量为切入点，从流量控制、熔断降级、系统负载保护等多个维度保护服务的稳定性。



Sentinel 的历史：

- 2012 年，Sentinel 诞生，主要功能为入口流量控制。
- 2013-2017 年，Sentinel 在阿里巴巴集团内部迅速发展，成为基础技术模块，覆盖了所有的核心场景。Sentinel 也因此积累了大量的流量归整场景以及生产实践。
- 2018 年，Sentinel 开源，并持续演进。
- 2019 年，Sentinel 朝着多语言扩展的方向不断探索，推出 C++ 原生版本，同时针对 Service Mesh 场景也推出了 Envoy 集群流量控制支持，以解决 Service Mesh 架构下多语言限流的问题。
- 2020 年，推出 Sentinel Go 版本，继续朝着云原生方向演进。



Sentinel 分为两个部分:

- 核心库（Java 客户端）不依赖任何框架/库，能够运行于所有 Java 运行时环境，同时对 Dubbo / Spring Cloud 等框架也有较好的支持。
- 控制台（Dashboard）基于 Spring Boot 开发，打包后可以直接运行，不需要额外的 Tomcat 等应用容器。

Sentinel 可以简单的分为 Sentinel 核心库和 Dashboard。核心库不依赖 Dashboard，但是结合 Dashboard 可以取得最好的效果。



## 4.2. 基本概念及作用

基本概念：

 **资源**：是 Sentinel 的关键概念。它可以是 Java 应用程序中的任何内容，例如，由应用程序提供的服务，或由应用程序调用的其它应用提供的服务，甚至可以是一段代码。在接下来的文档中，我们都会用资源来描述代码块。

只要通过 Sentinel API 定义的代码，就是资源，能够被 Sentinel 保护起来。大部分情况下，可以使用方法签名，URL，甚至服务名称作为资源名来标示资源。

**规则**：围绕资源的实时状态设定的规则，可以包括流量控制规则、熔断降级规则以及系统保护规则。所有规则可以动态实时调整。



主要作用：

1. 流量控制
2. 熔断降级
3. 系统负载保护



我们说的资源，可以是任何东西，服务，服务里的方法，甚至是一段代码。使用 Sentinel 来进行资源保护，主要分为几个步骤:

1. 定义资源
2. 定义规则
3. 检验规则是否生效

先把可能需要保护的资源定义好，之后再配置规则。也可以理解为，只要有了资源，我们就可以在任何时候灵活地定义各种流量控制规则。在编码的时候，只需要考虑这个代码是否需要保护，如果需要保护，就将之定义为一个资源。



## 4.3. 快速开始

官方文档：https://github.com/alibaba/spring-cloud-alibaba/wiki/Sentinel

### 4.3.1. 搭建Dashboard控制台

您可以从 release 页面 下载最新版本的控制台 jar 包。

https://github.com/alibaba/Sentinel/releases

下载的jar包（课前资料已下发），copy到一个没有空格或者中文的路径下，打开dos窗口切换到jar包所在目录。

执行：java -jar sentinel-dashboard-xxx.jar

![1584373334543](assets/1584373334543.png)

在浏览器中访问sentinel控制台，默认端口号是8080。进入登录页面，管理页面用户名和密码：sentinel/sentinel

![1584373427975](assets/1584373427975.png)

此时页面为空，这是因为还没有监控任何服务。另外，sentinel是懒加载的，如果服务没有被访问，也看不到该服务信息。



### 4.3.2. 改造nacos-consumer

1. 引入 sentinel 依赖

使用 group ID 为 `com.alibaba.cloud` 和 artifact ID 为 `spring-cloud-starter-alibaba-sentinel` 的 starter。

```xml
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-sentinel</artifactId>
</dependency>
```

2. 在application.properties中添加配置

```properties
# 指定dashboard地址
spring.cloud.sentinel.transport.dashboard=localhost:8080
# 启动该服务，会在应用程序的相应服务器上启动HTTP Server，并且该服务器将与Sentinel dashboard进行交互
spring.cloud.sentinel.transport.port=8719
```



重启nacos-consumer工程，在浏览器中反复访问：http://localhost:18080/hi

再次查看sentinel控制台页面：

![1584415844792](assets/1584415844792.png)



## 4.4. 整合Feign组件

Sentinel 适配了 Feign 组件。使用分三步：

1. 引入依赖：

引入feign及sentinel的依赖

```xml
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-sentinel</artifactId>
</dependency>

<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-openfeign</artifactId>
</dependency>
```

2. 开启sentinel监控功能

```
feign.sentinel.enabled=true
```

3. 代码实现

 ![1584418786881](assets/1584418786881.png)

添加feign接口的熔断类ProviderFallback：

```java
@Component
public class ProviderFallback implements ProviderClient {

    @Override
    public String hello() {
        return "现在服务器忙，请稍后再试！";
    }
}
```

在feign接口ProviderClient中指定熔断类：

![1584418934250](assets/1584418934250.png)



测试之前，先在服务提供方的controller方法中添加异常：

![1584419152242](assets/1584419152242.png)

再重启nacos-provider和nacos-consumer服务。在浏览器中地址栏访问消费方测试：

![1584419290413](assets/1584419290413.png)



## 4.5. 流量控制

### 4.5.1. 什么是流量控制

流量控制在网络传输中是一个常用的概念，它用于调整网络包的发送数据。然而，从系统稳定性角度考虑，在处理请求的速度上，也有非常多的讲究。任意时间到来的请求往往是随机不可控的，而系统的处理能力是有限的。我们需要根据系统的处理能力对流量进行控制。Sentinel 作为一个调配器，可以根据需要把随机的请求调整成合适的形状，如下图所示：

![img](assets/limitflow.gif)

流量控制有以下几个角度:

- 资源的调用关系，例如资源的调用链路，资源和资源之间的关系；
- 运行指标，例如 QPS、线程数等；
- 控制的效果，例如直接限流（快速失败）、冷启动（Warm Up）、匀速排队（排队等待）等。

Sentinel 的设计理念是让您自由选择控制的角度，并进行灵活组合，从而达到想要的效果。

配置如下：

 ![1584939746841](assets/1584939746841.png)



### 4.5.2. QPS流量控制

当 QPS 超过某个阈值的时候，则采取措施进行流量控制。流量控制的效果包括以下几种：**直接拒绝**、**Warm Up**、**匀速排队**。

#### 4.5.2.1. 直接拒绝

**直接拒绝**（`RuleConstant.CONTROL_BEHAVIOR_DEFAULT`）方式是默认的流量控制方式，当QPS超过任意规则的阈值后，新的请求就会被立即拒绝，拒绝方式为抛出`FlowException`。这种方式适用于对系统处理能力确切已知的情况下，比如通过压测确定了系统的准确水位时。

![1584942654297](assets/1584942654297.png)

 ![1584942598766](assets/1584942598766.png)

这里做一个最简单的配置：

​    阈值类型选择：QPS

​    单机阈值：2

综合起来的配置效果就是，该接口的限流策略是每秒最多允许2个请求进入。

点击新增按钮之后，可以看到如下界面：

![1584942744036](assets/1584942744036.png)

在浏览器访问：http://localhost:18080/hi，并疯狂刷新，出现如下信息：

![1584942920888](assets/1584942920888.png)





#### 4.5.2.2. Warm Up（预热）

Warm Up（`RuleConstant.CONTROL_BEHAVIOR_WARM_UP`）方式，即预热/冷启动方式。当系统长期处于低水位的情况下，当流量突然增加时，直接把系统拉升到高水位可能瞬间把系统压垮。通过"冷启动"，让通过的流量缓慢增加，在一定时间内逐渐增加到阈值上限，给冷系统一个预热的时间，避免冷系统被压垮。

 ![1584943355070](assets/1584943355070.png)

疯狂访问：http://localhost:18080/hi

 ![warm_up](assets/warm_up.gif)

可以发现前几秒会发生熔断，几秒钟之后就完全没有问题了

 ![1584943741860](assets/1584943741860.png)



#### 4.5.2.3. 匀速排队

匀速排队（`RuleConstant.CONTROL_BEHAVIOR_RATE_LIMITER`）方式会严格控制请求通过的间隔时间，也即是让请求以均匀的速度通过，对应的是漏桶算法。

测试配置如下：1s处理一个请求，排队等待，等待时间20s。

 ![1584946319183](assets/1584946319183.png)

在postman中，新建一个collection（这里collection名称是sentinel），并把一个请求添加到该collection

![1584944730390](assets/1584944730390.png)

 ![1584944773288](assets/1584944773288.png)

请求添加成功后，点击run按钮：

![1584944876592](assets/1584944876592.png)

配置每隔100ms发送一次请求，一共发送20个请求：

![1584945067742](assets/1584945067742.png)

点击“run sentinel”按钮

![1584946216871](assets/1584946216871.png)



查看控制台，效果如下：可以看到基本每隔1s打印一次

![1584946253148](assets/1584946253148.png)



### 4.5.3. 关联限流

关联限流：当关联的资源请求达到阈值时，就限流自己。

配置如下：/hi2的关联资源/hi，并发数超过2时，/hi2就限流自己

 ![1584947187419](assets/1584947187419.png)

给消费者添加一个controller方法：

![1584946721313](assets/1584946721313.png)



测试：

postman配置如下：每个400ms发送一次请求，一共发送50个。每秒钟超过了2次

 ![1584947322504](assets/1584947322504.png)

在浏览器中访问/hi2  已经被限流。

![1584947118491](assets/1584947118491.png)



### 4.5.4. 链路限流

一棵典型的调用树如下图所示：

```
     	          machine-root
                    /       \
                   /         \
             Entrance1     Entrance2
                /             \
               /               \
      DefaultNode(nodeA)   DefaultNode(nodeA)
```

上图中来自入口 `Entrance1` 和 `Entrance2` 的请求都调用到了资源 `NodeA`，Sentinel 允许只根据某个入口的统计信息对资源限流。

配置如下：表示只针对Entrance1进来的请求做限流限制

 ![1584947796466](assets/1584947796466.png)



### 4.5.5. 线程数限流

**并发线程数限流用于保护业务线程数不被耗尽。**例如，当应用所依赖的下游应用由于某种原因导致服务不稳定、响应延迟增加，对于调用者来说，意味着吞吐量下降和更多的线程数占用，极端情况下甚至导致线程池耗尽。为应对太多线程占用的情况，业内有使用隔离的方案，比如通过不同业务逻辑使用不同线程池来隔离业务自身之间的资源争抢（线程池隔离）。这种隔离方案虽然隔离性比较好，但是代价就是线程数目太多，线程上下文切换的 overhead 比较大，特别是对低延时的调用有比较大的影响。Sentinel 并发线程数限流不负责创建和管理线程池，而是简单统计当前请求上下文的线程数目，如果超出阈值，新的请求会被立即拒绝，效果类似于信号量隔离。

配置如下：如果请求的并发数超过一个就限流

 ![1584948590358](assets/1584948590358.png)



改造controller中的hi方法：

![1584952668510](assets/1584952668510.png)



**测试**

postmain配置如下：

 ![1584948699173](assets/1584948699173.png)

同时在浏览器访问：

![1584948743438](assets/1584948743438.png)



## 4.6. 熔断降级

Sentinel除了流量控制以外，对调用链路中不稳定的资源进行熔断降级也是保障高可用的重要措施之一。

Sentinel **熔断降级**会在调用链路中某个资源出现不稳定状态时（例如调用超时或异常比例升高），对这个资源的调用进行限制，让请求快速失败，避免影响到其它的资源而导致级联错误。当资源被降级后，在接下来的降级时间窗口之内，对该资源的调用都自动熔断（默认行为是抛出 `DegradeException`）。

Sentinel 和 Hystrix 的原则是一致的: 当调用链路中某个资源出现不稳定，例如，表现为 timeout，异常比例升高的时候，则对这个资源的调用进行限制，并让请求快速失败，避免影响到其它的资源，最终产生雪崩的效果。



限流降级指标有三个，如下图：

1. 平均响应时间（RT）

2. 异常比例 

3. 异常数

![1584950908909](assets/1584950908909.png)



### 4.6.1. 平均响应时间（RT）

**平均响应时间** (`DEGRADE_GRADE_RT`)：**当资源的平均响应时间超过阈值**（`DegradeRule` 中的 `count`，以 **ms** 为单位，默认上限是4900ms）之后，资源进入准降级状态。如果**1s之内持续进入 5 个请求**，它们的 RT 都持续超过这个阈值，那么在**接下来的时间窗口**（`DegradeRule` 中的 `timeWindow`，以 s 为单位）之内，对这个方法的调用都会自动地返回（抛出 `DegradeException`）。在下一个时间窗口到来时, 会接着再放入5个请求, 再重复上面的判断。

配置如下：超时时间100ms，熔断时间10s

 ![1584952992492](assets/1584952992492.png)

代码中依然睡了1s

![1584952668510](assets/1584952668510.png)

也就是说请求肯定都会超时。



先执行postmain，配置如下：

 ![1584948699173](assets/1584948699173.png)

再次见到了熟悉的界面：

![1584948743438](assets/1584948743438.png)

10s之内，都是熔断界面



### 4.6.2. 异常比例

**异常比例** (`DEGRADE_GRADE_EXCEPTION_RATIO`)：**当资源的每秒请求量 >= 5，且每秒异常总数占通过量的比值超过阈值**（`DegradeRule` 中的 `count`）之后，资源进入降级状态，即在接下的时间窗口（`DegradeRule`中的 `timeWindow`，以 s 为单位）之内，对这个方法的调用都会自动地返回。异常比率的阈值范围是 `[0.0, 1.0]`，代表 0% - 100%。



### 4.6.3. 异常数

**异常数** (`DEGRADE_GRADE_EXCEPTION_COUNT`)：当资源近 1 分钟的异常数目超过阈值之后会进行熔断。



## 4.7. 规则持久化

无论是通过硬编码的方式来更新规则，还是通过接入 Sentinel Dashboard 后，在页面上操作更新规则，都无法避免一个问题，那就是服务重启后，规则就丢失了，因为默认情况下规则是保存在内存中的。

我们在 Dashboard 上为客户端配置好了规则，并推送给了客户端。这时由于一些因素客户端出现异常，服务不可用了，当客户端恢复正常再次连接上 Dashboard 后，这时所有的规则都丢失了，我们还需要重新配置一遍规则，这肯定不是我们想要的。



持久化配置分以下3步：

1. 引入依赖

```xml
<dependency>
    <groupId>com.alibaba.csp</groupId>
    <artifactId>sentinel-datasource-nacos</artifactId>
</dependency>
```

2. 添加配置：

```properties
# 这里datasource后的consumer是数据源名称，可以随便写，推荐使用服务名
spring.cloud.sentinel.datasource.consumer.nacos.server-addr=localhost:8848
spring.cloud.sentinel.datasource.consumer.nacos.dataId=${spring.application.name}-sentinel-rules
spring.cloud.sentinel.datasource.consumer.nacos.groupId=SENTINEL_GROUP
spring.cloud.sentinel.datasource.consumer.nacos.data-type=json
# 规则类型，取值见：org.springframework.cloud.alibaba.sentinel.datasource.RuleType
spring.cloud.sentinel.datasource.consumer.nacos.rule_type=flow
```

3. nacos中创建流控规则

![1584963158392](assets/1584963158392.png)

配置内容如下：

```json
[
    {
        "resource": "/hello",
        "limitApp": "default",
        "grade": 1,
        "count": 2,
        "strategy": 0,
        "controlBehavior": 0,
        "clusterMode": false
    }
]
```

resource：资源名称

limitApp：限流应用，就是用默认就可以

grade：阈值类型，0表示线程数，1表示qps

count：单机阈值

strategy：流控模式，0-直接，1-关联， 2-链路

controlBehavior：流控效果。0-快速失败，1-warm up 2-排队等待

clusterMode：是否集群



重启consumser，并多次访问：http://localhost:18080/hi。

查看sentinel客户端：就有了限流配置了

![1584963291870](assets/1584963291870.png)

现在你可以尝试测试一下限流配置了



# 5. Sleuth

​		Spring Cloud Sleuth为springCloud实现了一个分布式链路追踪解决方案，大量借鉴了Dapper，Zipkin和HTrace等链路追踪技术。对于大多数用户而言，Sleuth应该是不可见的，并且您与外部系统的所有交互都应自动进行检测。您可以简单地在日志中捕获数据，也可以将其发送到远程收集器服务。



​		随着分布式系统越来越复杂，你的一个请求发过发过去，各个微服务之间的跳转，有可能某个请求某一天压力太大了，一个请求过去没响应，一个请求下去依赖了三四个服务，但是你去不知道哪一个服务出来问题，这时候我是不是需要对微服务进行追踪呀？监控一个请求的发起，从服务之间传递之间的过程，我最好记录一下，记录每一个的耗时多久，一旦出了问题，我们就可以针对性的进行优化，是要增加节点，减轻压力，还是服务继续拆分，让逻辑更加简单点呢？这时候**springcloud-sleuth集成zipkin**能帮我们解决这些服务追踪问题。



## 5.1. zipkin分布式监控客户端

Zipkin是一种分布式跟踪系统。它有助于收集解决微服务架构中的延迟问题所需的时序数据。它管理这些数据的收集和查找。Zipkin的设计基于Google Dapper论文。应用程序用于向Zipkin报告时序数据。Zipkin UI还提供了一个依赖关系图，显示了每个应用程序通过的跟踪请求数。如果要解决延迟问题或错误，可以根据应用程序，跟踪长度，注释或时间戳对所有跟踪进行筛选或排序。选择跟踪后，您可以看到每个跨度所需的总跟踪时间百分比，从而可以识别有问题的应用程序。

通过docker安装：docker run -d -p 9411:9411 openzipkin/zipkin

通过jar包安装：java -jar zipkin-server-*exec.jar

jar包下载地址：https://search.maven.org/remote_content?g=io.zipkin&a=zipkin-server&v=LATEST&c=exec

课前资料有已下载的jar包

在浏览器端访问：http://localhost:9411





## 5.2. 改造consumer/provider工程

对consumer和provider工程分别做如下操作：

1. 引入sleuth的依赖

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-zipkin</artifactId>
</dependency>
```

zipkin的启动器包含了sleuth的依赖。

2. 配置zipkin的相关信息

```properties
# zipkin服务器的地址
spring.zipkin.base-url=http://localhost:9411
# 关闭服务发现，否则springCloud会把zipkin的url当作服务名称
spring.zipkin.discovery-client-enabled=false
# 数据发送的方式：ACTIVEMQ RABBIT KAFKA WEB
spring.zipkin.sender.type=web
# 设置抽样采集率，默认0.1（即10%），这里设置为100%
spring.sleuth.sampler.probability=1
```

3. 重启consumer/provider服务后，访问消费者：http://localhost:18080/hi。查看zipkin客户端如下

![img](assets/zipkin_client.gif)

这时候我们可以在zipkin的ui控制界面看看效果，可以发现，服务之间的调用关系，服务名称已经清晰展现出来了，同时包括服务之间的调用时常等详细信息以及更细的信息都可以通过控制台看到。

![1584499122975](assets/1584499122975.png)

还可以查看调用关系图：

![1584502893425](assets/1584502893425.png)



## 5.3. 基本概念

Span：基本工作单元。发送一个远程请求就会产生一个span，span通过一个64位ID唯一标识，trace以另一个64位ID表示，span还有其他数据信息，比如摘要、时间戳事件、关键值注释(tags)、span的ID、以及进度ID(通常是IP地址)。span在不断的启动和停止，同时记录了时间信息，当你创建了一个span，你必须在未来的某个时刻停止它。

Trace：一系列spans组成的一个树状结构。例如：发送一个请求，需要调用多个微服务，每调用一个微服务都会产生一个span，这些span组成一个trace

Annotation：用来及时记录一个事件的存在，一些核心annotations用来定义一个请求的开始和结束 

- cs - Client Sent -客户端发起一个请求，这个annotion描述了这个span的开始
- sr - Server Received -服务端获得请求并准备开始处理它，如果将其sr减去cs时间戳便可得到网络延迟
- ss - Server Sent -注解表明请求处理的完成(当请求返回客户端)，如果ss减去sr时间戳便可得到服务端需要的处理请求时间
- cr - Client Received -表明span的结束，客户端成功接收到服务端的回复，如果cr减去cs时间戳便可得到客户端从服务端获取回复的所有所需时间

例如一个请求如下：

![dependency](assets/dependencies.png)

使用zipkin跟踪整个请求过程如下：

![img](assets/12889335-49075b7a31bf4b4a.webp)

上图表示一请求链路，一条链路通过`Trace Id`唯一标识，`Span`标识发起的请求信息，各`span`通过`parent id` 关联起来，如图 
![tree-like](assets/parents.png)








