



# 1. RabbitMQ

## 1.1.   现实问题



目前我们已经完成了商品和搜索系统的开发。我们思考一下，是否存在问题？

- 商品的原始数据保存在数据库中，增删改查都在数据库中完成。
- 搜索服务数据来源是索引库，如果数据库商品发生变化，索引库数据不能及时更新。

如果我们在后台修改了商品的价格，搜索页面依然是旧的价格，这样显然不对。该如何解决？



这里有两种解决方案：

- 方案1：每当后台对商品做增删改操作，同时要修改索引库数据
- 方案2：搜索服务对外提供操作接口，后台在商品增删改后，调用接口



以上两种方式都有同一个严重问题：就是代码耦合，后台服务中需要嵌入搜索和商品页面服务，违背了微服务的`独立`原则。

所以，我们会通过另外一种方式来解决这个问题：消息队列



## 1.2.   消息队列（MQ）

### 1.2.1.   什么是消息队列

消息队列，即MQ，Message Queue。

![1527063872737](assets/1527063872737.png)



消息队列是典型的：生产者、消费者模型。生产者不断向消息队列中生产消息，消费者不断的从队列中获取消息。因为消息的生产和消费都是异步的，而且只关心消息的发送和接收，没有业务逻辑的侵入，这样就实现了生产者和消费者的解耦。

结合前面所说的问题：

- 商品服务对商品增删改以后，无需去操作索引库，只是发送一条消息，也不关心消息被谁接收。
- 搜索服务服务接收消息，去处理索引库。

如果以后有其它系统也依赖商品服务的数据，同样监听消息即可，商品服务无需任何代码修改。



### 1.2.2.   AMQP和JMS

MQ是消息通信的模型，并不是具体实现。现在实现MQ的有两种主流方式：AMQP、JMS。

![1527064480681](assets/1527064480681.png)

![1527064487042](assets/1527064487042.png)



两者间的区别和联系：

- JMS是定义了统一的接口，来对消息操作进行统一；AMQP是通过规定协议来统一数据交互的格式
- JMS限定了必须使用Java语言；AMQP只是协议，不规定实现方式，因此是跨语言的。
- JMS规定了两种消息模型；而AMQP的消息模型更加丰富



### 1.2.3.   常见MQ产品

![1527064606029](assets/1527064606029.png)

- ActiveMQ：基于JMS
- RabbitMQ：基于AMQP协议，erlang语言开发，稳定性好
- RocketMQ：基于JMS，阿里巴巴产品，目前交由Apache基金会
- Kafka：分布式消息系统，高吞吐量



### 1.2.4.   RabbitMQ

RabbitMQ是基于AMQP的一款消息管理系统

官网： http://www.rabbitmq.com/

官方教程：http://www.rabbitmq.com/getstarted.html

![1532758972119](assets/1532758972119.png)



 ![1527064762982](assets/1527064762982.png)



## 1.3.   下载和安装

### 1.3.1.   下载

官网下载地址：http://www.rabbitmq.com/download.html

![1532759070767](assets/1532759070767.png)





### 1.3.2.   安装

下载镜像：`docker pull rabbitmq:management`

创建实例并启动：

```
docker run -d --name rabbitmq --publish 5671:5671 \
--publish 5672:5672 --publish 4369:4369 --publish 25672:25672 --publish 15671:15671 --publish 15672:15672 \
rabbitmq:management
```

注：
4369 -- erlang发现口
5672 --client端通信口

15672 -- 管理界面ui端口
25672 -- server间内部通信口



### 1.3.3.   测试

在web浏览器中输入地址：http://虚拟机ip:15672/

输入默认账号: guest   : guest

![1570340475739](assets/1570340475739.png)

overview：概览

connections：无论生产者还是消费者，都需要与RabbitMQ建立连接后才可以完成消息的生产和消费，在这里可以查看连接情况

channels：通道，建立连接后，会形成通道，消息的投递获取依赖通道。

Exchanges：交换机，用来实现消息的路由

Queues：队列，即消息队列，消息存放在队列中，等待消费，消费后被移除队列。

 

端口：

5672: rabbitMq的编程语言客户端连接端口

15672：rabbitMq管理界面端口

25672：rabbitMq集群的端口



## 1.4.   管理界面

### 1.4.1.   添加用户

如果不使用guest，我们也可以自己创建一个用户：

![1570341128229](assets/1570341128229.png)

1、 超级管理员(administrator)

可登陆管理控制台，可查看所有的信息，并且可以对用户，策略(policy)进行操作。

2、 监控者(monitoring)

可登陆管理控制台，同时可以查看rabbitmq节点的相关信息(进程数，内存使用情况，磁盘使用情况等)

3、 策略制定者(policymaker)

可登陆管理控制台, 同时可以对policy进行管理。但无法查看节点的相关信息(上图红框标识的部分)。

4、 普通管理者(management)

仅可登陆管理控制台，无法看到节点信息，也无法对策略进行管理。

5、 其他

无法登陆管理控制台，通常就是普通的生产者和消费者。

 

### 1.4.2.   创建Virtual Hosts

虚拟主机：类似于mysql中的database。他们都是以“/”开头

![1570341361306](assets/1570341361306.png)



### 1.4.3.   设置权限

![1570341470699](assets/1570341470699.png)

![1570341567294](assets/1570341567294.png)

![1570341637530](assets/1570341637530.png)



# 2. 五种消息模型

RabbitMQ提供了6种消息模型，但是第6种其实是RPC，并不是MQ，因此不予学习。那么也就剩下5种。

但是其实3、4、5这三种都属于订阅模型，只不过进行路由的方式不同。

![1527068544487](assets/1527068544487.png)



我们通过一个demo工程来了解下RabbitMQ的工作方式，导入工程：

 ![1570342715181](assets/1570342715181.png)

依赖：

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>cn.itcast.rabbitmq</groupId>
	<artifactId>itcast-rabbitmq</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>2.0.2.RELEASE</version>
	</parent>
	<properties>
		<java.version>1.8</java.version>
	</properties>
	<dependencies>
		<dependency>
			<groupId>org.apache.commons</groupId>
			<artifactId>commons-lang3</artifactId>
			<version>3.3.2</version>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-amqp</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
		</dependency>
	</dependencies>
</project>
```

我们抽取一个建立RabbitMQ连接的工具类，方便其他程序获取连接：

```java
public class ConnectionUtil {
    /**
     * 建立与RabbitMQ的连接
     * @return
     * @throws Exception
     */
    public static Connection getConnection() throws Exception {
        //定义连接工厂
        ConnectionFactory factory = new ConnectionFactory();
        //设置服务地址
        factory.setHost("172.16.116.100");
        //端口
        factory.setPort(5672);
        //设置账号信息，用户名、密码、vhost
        factory.setVirtualHost("/fengge");
        factory.setUsername("fengge");
        factory.setPassword("fengge");
        // 通过工程获取连接
        Connection connection = factory.newConnection();
        return connection;
    }
}
```



## 2.1.   基本消息模型

官方介绍：

 ![1532762961149](assets/1532762961149.png)

RabbitMQ是一个消息代理：它接受和转发消息。 你可以把它想象成一个邮局：当你把邮件放在邮箱里时，你可以确定邮差先生最终会把邮件发送给你的收件人。 在这个比喻中，RabbitMQ是邮政信箱，邮局和邮递员。

RabbitMQ与邮局的主要区别是它不处理纸张，而是接受，存储和转发数据消息的二进制数据块。

 ![1532762975546](assets/1532762975546.png)

P（producer/ publisher）：生产者，一个发送消息的用户应用程序。

C（consumer）：消费者，消费和接收有类似的意思，消费者是一个主要用来等待接收消息的用户应用程序

队列（红色区域）：rabbitmq内部类似于邮箱的一个概念。虽然消息流经rabbitmq和你的应用程序，但是它们只能存储在队列中。队列只受主机的内存和磁盘限制，实质上是一个大的消息缓冲区。许多生产者可以发送消息到一个队列，许多消费者可以尝试从一个队列接收数据。

总之：

生产者将消息发送到队列，消费者从队列中获取消息，队列是存储消息的缓冲区。



我们将用Java编写两个程序;发送单个消息的生产者，以及接收消息并将其打印出来的消费者。我们将详细介绍Java API中的一些细节，这是一个消息传递的“Hello World”。

我们将调用我们的消息发布者（发送者）Send和我们的消息消费者（接收者）Recv。发布者将连接到RabbitMQ，发送一条消息，然后退出。

### 2.1.1.   生产者发送消息

```java
public class Send {

    private final static String QUEUE_NAME = "simple_queue";

    public static void main(String[] argv) throws Exception {
        // 获取到连接以及mq通道
        Connection connection = ConnectionUtil.getConnection();
        // 从连接中创建通道，这是完成大部分API的地方。
        Channel channel = connection.createChannel();

        // 声明（创建）队列，必须声明队列才能够发送消息，我们可以把消息发送到队列中。
        // 声明一个队列是幂等的 - 只有当它不存在时才会被创建
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);

        // 消息内容
        String message = "Hello World!";
        channel.basicPublish("", QUEUE_NAME, null, message.getBytes());
        System.out.println(" [x] Sent '" + message + "'");

        //关闭通道和连接
        channel.close();
        connection.close();
    }
}
```

控制台：

![1532763328424](assets/1532763328424.png)

### 2.1.2.   管理工具中查看消息

进入队列页面，可以看到新建了一个队列：simple_queue

![1532763817830](assets/1532763817830.png)

点击队列名称，进入详情页，可以查看消息：

![1532763489858](assets/1532763489858.png)

在控制台查看消息并不会将消息消费，所以消息还在。



### 2.1.3.   消费者获取消息

```java
public class Recv {
    private final static String QUEUE_NAME = "simple_queue";

    public static void main(String[] argv) throws Exception {
        // 获取到连接
        Connection connection = ConnectionUtil.getConnection();
        // 创建通道
        Channel channel = connection.createChannel();
        // 声明队列
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);
        // 定义队列的消费者
        DefaultConsumer consumer = new DefaultConsumer(channel) {
            // 获取消息，并且处理，这个方法类似事件监听，如果有消息的时候，会被自动调用
            @Override
            public void handleDelivery(String consumerTag, Envelope envelope, BasicProperties properties,
                    byte[] body) throws IOException {
                // body 即消息体
                String msg = new String(body);
                System.out.println(" [x] received : " + msg + "!");
            }
        };
        // 监听队列，第二个参数：是否自动进行消息确认。
        channel.basicConsume(QUEUE_NAME, true, consumer);
    }
}
```

控制台：

![1532763733443](assets/1532763733443.png)

这个时候，队列中的消息就没了：

![1532763773208](assets/1532763773208.png)

我们发现，消费者已经获取了消息，但是程序没有停止，一直在监听队列中是否有新的消息。一旦有新的消息进入队列，就会立即打印.



### 2.1.4. 生产者消息确认机制

面试题：如何避免消息丢失？

消息的丢失，在MQ角度考虑，一般有三种途径：

1. 生产者确认发送到MQ服务器（生产者确认机制）
2. MQ服务器不丢数据（消息持久化）
3. 消费者确认消费掉消息（消费者确认机制）

生产者/消费者保证消息不丢失有两种实现方式：

1. 开启事务模式
2. 消息确认模式

开启事务会大幅降低消息发送及接收效率，使用的相对较少，因此我们生产环境一般都采取消息确认模式，我们只是讲解消息确认模式及消息持久化

1. 生产者的ACK机制。有时，业务处理成功，消息也发了，但是我们并不知道消息是否成功到达了rabbitmq，例如：由于网络等原因导致业务成功而消息发送失败，此时可以使用rabbitmq的发送确认功能，要求rabbitmq显式告知我们消息是否已成功发送。
2. 消费者的ACK机制。可以防止消费者丢失消息。

![1585466011140](assets/1585466011140.png)

生产者确认机制有很严重的性能问题，如果每秒钟只有几百的消息量，可以使用。所以，我们主要讲了消费者的消息确认机制。



生产者确认

```java

// 开启消息确认机制
channel.confirmSelect();
// 消息是否正常发送到交换机
channel.addConfirmListener((long deliveryTag, boolean multiple) -> {
    System.out.println("消息发送成功！");
}, (long deliveryTag, boolean multiple) -> {
    // 此种情况无法演示
    System.out.println("消息发送失败！");
});
```



### 2.1.5. 消费者消息确认机制（ACK）

通过刚才的案例可以看出，消息一旦被消费者接收，队列中的消息就会被删除。

那么问题来了：RabbitMQ怎么知道消息被接收了呢？

如果消费者领取消息后，还没执行操作就挂掉了呢？或者抛出了异常？消息消费失败，但是RabbitMQ无从得知，这样消息就丢失了！

因此，RabbitMQ有一个ACK机制。当消费者获取消息后，会向RabbitMQ发送回执ACK，告知消息已经被接收。不过这种回执ACK分两种情况：

- 自动ACK：消息一旦被接收，消费者自动发送ACK
- 手动ACK：消息接收后，不会发送ACK，需要手动调用

大家觉得哪种更好呢？

这需要看消息的重要性：

- 如果消息不太重要，丢失也没有影响，那么自动ACK会比较方便
- 如果消息非常重要，不容丢失。那么最好在消费完成后手动ACK，否则接收消息后就自动ACK，RabbitMQ就会把消息从队列中删除。如果此时消费者宕机，那么消息就丢失了。

我们之前的测试都是自动ACK的，如果要手动ACK，需要改动我们的代码：

```java
public class Recv2 {
    private final static String QUEUE_NAME = "simple_queue";

    public static void main(String[] argv) throws Exception {
        // 获取到连接
        Connection connection = ConnectionUtil.getConnection();
        // 创建通道
        final Channel channel = connection.createChannel();
        // 声明队列
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);
        // 定义队列的消费者
        DefaultConsumer consumer = new DefaultConsumer(channel) {
            // 获取消息，并且处理，这个方法类似事件监听，如果有消息的时候，会被自动调用
            @Override
            public void handleDelivery(String consumerTag, Envelope envelope, BasicProperties properties,
                    byte[] body) throws IOException {
                // body 即消息体
                String msg = new String(body);
                System.out.println(" [x] received : " + msg + "!");
                // 手动进行ACK
                channel.basicAck(envelope.getDeliveryTag(), false);
            }
        };
        // 监听队列，第二个参数false，手动进行ACK
        channel.basicConsume(QUEUE_NAME, false, consumer);
    }
}
```

注意到最后一行代码：

```java
channel.basicConsume(QUEUE_NAME, false, consumer);
```

如果第二个参数为true，则会自动进行ACK；如果为false，则需要手动ACK。方法的声明：

![1532764253019](assets/1532764253019.png)



#### 2.1.5.1.   自动ACK存在的问题

修改消费者，添加异常，如下：

![1532764600849](assets/1532764600849.png)

生产者不做任何修改，直接运行，消息发送成功：

![1532764694290](assets/1532764694290.png)

运行消费者，程序抛出异常。但是消息依然被消费：

![1532764717995](assets/1532764717995.png)

管理界面：

![1532764734232](assets/1532764734232.png)

 

#### 2.1.5.2.   演示手动ACK

修改消费者，把自动改成手动（去掉之前制造的异常）

![1532764831241](assets/1532764831241.png)

生产者不变，再次运行：

![1532764895239](assets/1532764895239.png)

运行消费者

![1532764957092](assets/1532764957092.png)

但是，查看管理界面，发现：

![1532765013834](assets/1532765013834.png)

停掉消费者的程序，发现：

![1532765038088](assets/1532765038088.png)

这是因为虽然我们设置了手动ACK，但是代码中并没有进行消息确认！所以消息并未被真正消费掉。

当我们关掉这个消费者，消息的状态再次称为Ready

 

修改代码手动ACK：

![1532765123282](assets/1532765123282.png)

执行：

![1532765151039](assets/1532765151039.png)

消息消费成功！



## 2.2.   work消息模型

工作队列或者竞争消费者模式

 ![1532765197277](assets/1532765197277.png)

在第一篇教程中，我们编写了一个程序，从一个命名队列中发送并接受消息。在这里，我们将创建一个工作队列，在多个工作者之间分配耗时任务。

工作队列，又称任务队列。主要思想就是避免执行资源密集型任务时，必须等待它执行完成。相反我们稍后完成任务，我们将任务封装为消息并将其发送到队列。 在后台运行的工作进程将获取任务并最终执行作业。当你运行许多消费者时，任务将在他们之间共享，但是**一个消息只能被一个消费者获取**。

这个概念在Web应用程序中特别有用，因为在短的HTTP请求窗口中无法处理复杂的任务。

接下来我们来模拟这个流程：

```
P：生产者：任务的发布者

C1：消费者，领取任务并且完成任务，假设完成速度较快

C2：消费者2：领取任务并完成任务，假设完成速度慢
```

 











面试题：避免消息堆积？

1）采用workqueue，多个消费者监听同一队列。

2）接收到消息以后，而是通过线程池，异步消费。

 

### 2.2.1.   生产者

生产者与案例1中的几乎一样：

```java
public class Send {
    private final static String QUEUE_NAME = "test_work_queue";

    public static void main(String[] argv) throws Exception {
        // 获取到连接
        Connection connection = ConnectionUtil.getConnection();
        // 获取通道
        Channel channel = connection.createChannel();
        // 声明队列
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);
        // 循环发布任务
        for (int i = 0; i < 50; i++) {
            // 消息内容
            String message = "task .. " + i;
            channel.basicPublish("", QUEUE_NAME, null, message.getBytes());
            System.out.println(" [x] Sent '" + message + "'");

            Thread.sleep(i * 2);
        }
        // 关闭通道和连接
        channel.close();
        connection.close();
    }
}
```

不过这里我们是循环发送50条消息。

### 2.2.2.   消费者1

![1527085386747](assets/1527085386747.png)

### 2.2.3.   消费者2

![1527085448377](assets/1527085448377.png)

与消费者1基本类似，就是没有设置消费耗时时间。

这里是模拟有些消费者快，有些比较慢。



接下来，两个消费者一同启动，然后发送50条消息：

![1527085826462](assets/1527085826462.png)

可以发现，两个消费者各自消费了25条消息，而且各不相同，这就实现了任务的分发。



### 2.2.4.   能者多劳

刚才的实现有问题吗？

- 消费者1比消费者2的效率要低，一次任务的耗时较长
- 然而两人最终消费的消息数量是一样的
- 消费者2大量时间处于空闲状态，消费者1一直忙碌

现在的状态属于是把任务平均分配，正确的做法应该是消费越快的人，消费的越多。

怎么实现呢？

我们可以使用basicQos方法和prefetchCount = 1设置。 这告诉RabbitMQ一次不要向工作人员发送多于一条消息。 或者换句话说，不要向工作人员发送新消息，直到它处理并确认了前一个消息。 相反，它会将其分派给不是仍然忙碌的下一个工作人员。

![1532765689904](assets/1532765689904.png)

再次测试：

![1527086159534](assets/1527086159534.png)



## 2.3.   订阅模型分类

在之前的模式中，我们创建了一个工作队列。 工作队列背后的假设是：每个任务只被传递给一个工作人员。 在这一部分，我们将做一些完全不同的事情 - 我们将会传递一个信息给多个消费者。 这种模式被称为“发布/订阅”。 

订阅模型示意图：

 ![1527086284940](assets/1527086284940.png)

解读：

1、1个生产者，多个消费者

2、每一个消费者都有自己的一个队列

3、生产者没有将消息直接发送到队列，而是发送到了交换机

4、每个队列都要绑定到交换机

5、生产者发送的消息，经过交换机到达队列，实现一个消息被多个消费者获取的目的

X（Exchanges）：交换机一方面：接收生产者发送的消息。另一方面：知道如何处理消息，例如递交给某个特别队列、递交给所有队列、或是将消息丢弃。到底如何操作，取决于Exchange的类型。

Exchange类型有以下几种：

```
Fanout：广播，将消息交给所有绑定到交换机的队列

Direct：定向，把消息交给符合指定routing key 的队列 

Topic：通配符，把消息交给符合routing pattern（路由模式） 的队列

```

我们这里先学习

```
Fanout：即广播模式

```

**Exchange（交换机）只负责转发消息，不具备存储消息的能力**，因此如果没有任何队列与Exchange绑定，或者没有符合路由规则的队列，那么消息会丢失！



## 2.4.   订阅模型-Fanout

Fanout，也称为广播。

流程图：

 ![1527086564505](assets/1527086564505.png)

在广播模式下，消息发送流程是这样的：

- 1）  可以有多个消费者
- 2）  每个**消费者有自己的queue**（队列）
- 3）  每个**队列都要绑定到Exchange**（交换机）
- 4）  **生产者发送的消息，只能发送到交换机**，交换机来决定要发给哪个队列，生产者无法决定。
- 5）  交换机把消息发送给绑定过的所有队列
- 6）  队列的消费者都能拿到消息。实现一条消息被多个消费者消费



### 2.4.1.   生产者

两个变化：

- 1）  声明Exchange，不再声明Queue
- 2）  发送消息到Exchange，不再发送到Queue

```java
public class Send {

    private final static String EXCHANGE_NAME = "fanout_exchange_test";

    public static void main(String[] argv) throws Exception {
        // 获取到连接
        Connection connection = ConnectionUtil.getConnection();
        // 获取通道
        Channel channel = connection.createChannel();
        
        // 声明exchange，指定类型为fanout
        channel.exchangeDeclare(EXCHANGE_NAME, "fanout");
        
        // 消息内容
        String message = "Hello everyone";
        // 发布消息到Exchange
        channel.basicPublish(EXCHANGE_NAME, "", null, message.getBytes());
        System.out.println(" [生产者] Sent '" + message + "'");

        channel.close();
        connection.close();
    }
}

```

### 2.4.2.   消费者1

```java
public class Recv {
    private final static String QUEUE_NAME = "fanout_exchange_queue_1";

    private final static String EXCHANGE_NAME = "fanout_exchange_test";

    public static void main(String[] argv) throws Exception {
        // 获取到连接
        Connection connection = ConnectionUtil.getConnection();
        // 获取通道
        Channel channel = connection.createChannel();
        // 声明队列
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);

        // 绑定队列到交换机
        channel.queueBind(QUEUE_NAME, EXCHANGE_NAME, "");

        // 定义队列的消费者
        DefaultConsumer consumer = new DefaultConsumer(channel) {
            // 获取消息，并且处理，这个方法类似事件监听，如果有消息的时候，会被自动调用
            @Override
            public void handleDelivery(String consumerTag, Envelope envelope, BasicProperties properties,
                    byte[] body) throws IOException {
                // body 即消息体
                String msg = new String(body);
                System.out.println(" [消费者1] received : " + msg + "!");
            }
        };
        // 监听队列，自动返回完成
        channel.basicConsume(QUEUE_NAME, true, consumer);
    }
}

```

要注意代码中：**队列需要和交换机绑定**

### 2.4.3.   消费者2

```java
public class Recv2 {
    private final static String QUEUE_NAME = "fanout_exchange_queue_2";

    private final static String EXCHANGE_NAME = "fanout_exchange_test";

    public static void main(String[] argv) throws Exception {
        // 获取到连接
        Connection connection = ConnectionUtil.getConnection();
        // 获取通道
        Channel channel = connection.createChannel();
        // 声明队列
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);

        // 绑定队列到交换机
        channel.queueBind(QUEUE_NAME, EXCHANGE_NAME, "");
        
        // 定义队列的消费者
        DefaultConsumer consumer = new DefaultConsumer(channel) {
            // 获取消息，并且处理，这个方法类似事件监听，如果有消息的时候，会被自动调用
            @Override
            public void handleDelivery(String consumerTag, Envelope envelope, BasicProperties properties,
                    byte[] body) throws IOException {
                // body 即消息体
                String msg = new String(body);
                System.out.println(" [消费者2] received : " + msg + "!");
            }
        };
        // 监听队列，手动返回完成
        channel.basicConsume(QUEUE_NAME, true, consumer);
    }
}

```



### 2.4.4.   测试

我们运行两个消费者，然后发送1条消息：

![1532766264386](assets/1532766264386.png)

![1532766291204](assets/1532766291204.png)



## 2.5.   订阅模型-Direct

有选择性的接收消息

在订阅模式中，生产者发布消息，所有消费者都可以获取所有消息。

在路由模式中，我们将添加一个功能 - 我们将只能订阅一部分消息。 例如，我们只能将重要的错误消息引导到日志文件（以节省磁盘空间），同时仍然能够在控制台上打印所有日志消息。

但是，在某些场景下，我们希望不同的消息被不同的队列消费。这时就要用到Direct类型的Exchange。

在Direct模型下，队列与交换机的绑定，不能是任意绑定了，而是要指定一个RoutingKey（路由key）

消息的发送方在向Exchange发送消息时，也必须指定消息的routing key。

 ![1532766437787](assets/1532766437787.png)

P：生产者，向Exchange发送消息，发送消息时，会指定一个routing key。

X：Exchange（交换机），接收生产者的消息，然后把消息递交给 与routing key完全匹配的队列

C1：消费者，其所在队列指定了需要routing key 为 error 的消息

C2：消费者，其所在队列指定了需要routing key 为 info、error、warning 的消息



### 2.5.1.   生产者

此处我们模拟商品的增删改，发送消息的RoutingKey分别是：insert、update、delete

```java
public class Send {
    private final static String EXCHANGE_NAME = "direct_exchange_test";

    public static void main(String[] argv) throws Exception {
        // 获取到连接
        Connection connection = ConnectionUtil.getConnection();
        // 获取通道
        Channel channel = connection.createChannel();
        // 声明exchange，指定类型为direct
        channel.exchangeDeclare(EXCHANGE_NAME, "direct");
        // 消息内容
        String message = "商品新增了， id = 1001";
        // 发送消息，并且指定routing key 为：insert ,代表新增商品
        channel.basicPublish(EXCHANGE_NAME, "insert", null, message.getBytes());
        System.out.println(" [商品服务：] Sent '" + message + "'");

        channel.close();
        connection.close();
    }
}
```



### 2.5.2.   消费者1

我们此处假设消费者1只接收两种类型的消息：更新商品和删除商品。

```java
public class Recv {
    private final static String QUEUE_NAME = "direct_exchange_queue_1";
    private final static String EXCHANGE_NAME = "direct_exchange_test";

    public static void main(String[] argv) throws Exception {
        // 获取到连接
        Connection connection = ConnectionUtil.getConnection();
        // 获取通道
        Channel channel = connection.createChannel();
        // 声明队列
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);
        
        // 绑定队列到交换机，同时指定需要订阅的routing key。假设此处需要update和delete消息
        channel.queueBind(QUEUE_NAME, EXCHANGE_NAME, "update");
        channel.queueBind(QUEUE_NAME, EXCHANGE_NAME, "delete");

        // 定义队列的消费者
        DefaultConsumer consumer = new DefaultConsumer(channel) {
            // 获取消息，并且处理，这个方法类似事件监听，如果有消息的时候，会被自动调用
            @Override
            public void handleDelivery(String consumerTag, Envelope envelope, BasicProperties properties,
                    byte[] body) throws IOException {
                // body 即消息体
                String msg = new String(body);
                System.out.println(" [消费者1] received : " + msg + "!");
            }
        };
        // 监听队列，自动ACK
        channel.basicConsume(QUEUE_NAME, true, consumer);
    }
}

```



### 2.5.3.   消费者2

我们此处假设消费者2接收所有类型的消息：新增商品，更新商品和删除商品。

```java
public class Recv2 {
    private final static String QUEUE_NAME = "direct_exchange_queue_2";
    private final static String EXCHANGE_NAME = "direct_exchange_test";

    public static void main(String[] argv) throws Exception {
        // 获取到连接
        Connection connection = ConnectionUtil.getConnection();
        // 获取通道
        Channel channel = connection.createChannel();
        // 声明队列
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);
        
        // 绑定队列到交换机，同时指定需要订阅的routing key。订阅 insert、update、delete
        channel.queueBind(QUEUE_NAME, EXCHANGE_NAME, "insert");
        channel.queueBind(QUEUE_NAME, EXCHANGE_NAME, "update");
        channel.queueBind(QUEUE_NAME, EXCHANGE_NAME, "delete");

        // 定义队列的消费者
        DefaultConsumer consumer = new DefaultConsumer(channel) {
            // 获取消息，并且处理，这个方法类似事件监听，如果有消息的时候，会被自动调用
            @Override
            public void handleDelivery(String consumerTag, Envelope envelope, BasicProperties properties,
                    byte[] body) throws IOException {
                // body 即消息体
                String msg = new String(body);
                System.out.println(" [消费者2] received : " + msg + "!");
            }
        };
        // 监听队列，自动ACK
        channel.basicConsume(QUEUE_NAME, true, consumer);
    }
}

```



### 2.5.4.   测试

我们分别发送增、删、改的RoutingKey，发现结果：

 ![1527088296131](assets/1527088296131.png)



## 2.6.   订阅模型-Topic

`Topic`类型的`Exchange`与`Direct`相比，都是可以根据`RoutingKey`把消息路由到不同的队列。只不过`Topic`类型`Exchange`可以让队列在绑定`Routing key` 的时候使用通配符！

`Routingkey` 一般都是有一个或多个单词组成，多个单词之间以”.”分割，例如： `item.insert`

 通配符规则：

```
`#`：匹配一个或多个词

`*`：匹配不多不少恰好1个词
```

举例：

```
`audit.#`：能够匹配`audit.irs.corporate` 或者 `audit.irs`

`audit.*`：只能匹配`audit.irs`
```



 ![1532766712166](assets/1532766712166.png)

在这个例子中，我们将发送所有描述动物的消息。消息将使用由三个字（两个点）组成的routing key发送。路由关键字中的第一个单词将描述速度，第二个颜色和第三个种类：“<speed>.<color>.<species>”。

我们创建了三个绑定：Q1绑定了绑定键“* .orange.*”，Q2绑定了“*.*.rabbit”和“lazy.＃”。

Q1匹配所有的橙色动物。

Q2匹配关于兔子以及懒惰动物的消息。



练习，生产者发送如下消息，会进入那个队列：

quick.orange.rabbit     Q1 Q2

lazy.orange.elephant	 

quick.orange.fox	  

lazy.pink.rabbit 	 

quick.brown.fox 	

quick.orange.male.rabbit 

orange 



### 2.6.1.   生产者

使用topic类型的Exchange，发送消息的routing key有3种： `item.isnert`、`item.update`、`item.delete`：

```java
public class Send {
    private final static String EXCHANGE_NAME = "topic_exchange_test";

    public static void main(String[] argv) throws Exception {
        // 获取到连接
        Connection connection = ConnectionUtil.getConnection();
        // 获取通道
        Channel channel = connection.createChannel();
        // 声明exchange，指定类型为topic
        channel.exchangeDeclare(EXCHANGE_NAME, "topic");
        // 消息内容
        String message = "新增商品 : id = 1001";
        // 发送消息，并且指定routing key 为：insert ,代表新增商品
        channel.basicPublish(EXCHANGE_NAME, "item.insert", null, message.getBytes());
        System.out.println(" [商品服务：] Sent '" + message + "'");

        channel.close();
        connection.close();
    }
}
```



### 2.6.2.   消费者1

我们此处假设消费者1只接收两种类型的消息：更新商品和删除商品

```java
public class Recv {
    private final static String QUEUE_NAME = "topic_exchange_queue_1";
    private final static String EXCHANGE_NAME = "topic_exchange_test";

    public static void main(String[] argv) throws Exception {
        // 获取到连接
        Connection connection = ConnectionUtil.getConnection();
        // 获取通道
        Channel channel = connection.createChannel();
        // 声明队列
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);
        
        // 绑定队列到交换机，同时指定需要订阅的routing key。需要 update、delete
        channel.queueBind(QUEUE_NAME, EXCHANGE_NAME, "item.update");
        channel.queueBind(QUEUE_NAME, EXCHANGE_NAME, "item.delete");

        // 定义队列的消费者
        DefaultConsumer consumer = new DefaultConsumer(channel) {
            // 获取消息，并且处理，这个方法类似事件监听，如果有消息的时候，会被自动调用
            @Override
            public void handleDelivery(String consumerTag, Envelope envelope, BasicProperties properties,
                    byte[] body) throws IOException {
                // body 即消息体
                String msg = new String(body);
                System.out.println(" [消费者1] received : " + msg + "!");
            }
        };
        // 监听队列，自动ACK
        channel.basicConsume(QUEUE_NAME, true, consumer);
    }
}

```



### 2.6.3.   消费者2

我们此处假设消费者2接收所有类型的消息：新增商品，更新商品和删除商品。

```java
/**
 * 消费者2
 */
public class Recv2 {
    private final static String QUEUE_NAME = "topic_exchange_queue_2";
    private final static String EXCHANGE_NAME = "topic_exchange_test";

    public static void main(String[] argv) throws Exception {
        // 获取到连接
        Connection connection = ConnectionUtil.getConnection();
        // 获取通道
        Channel channel = connection.createChannel();
        // 声明队列
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);
        
        // 绑定队列到交换机，同时指定需要订阅的routing key。订阅 insert、update、delete
        channel.queueBind(QUEUE_NAME, EXCHANGE_NAME, "item.*");

        // 定义队列的消费者
        DefaultConsumer consumer = new DefaultConsumer(channel) {
            // 获取消息，并且处理，这个方法类似事件监听，如果有消息的时候，会被自动调用
            @Override
            public void handleDelivery(String consumerTag, Envelope envelope, BasicProperties properties,
                    byte[] body) throws IOException {
                // body 即消息体
                String msg = new String(body);
                System.out.println(" [消费者2] received : " + msg + "!");
            }
        };
        // 监听队列，自动ACK
        channel.basicConsume(QUEUE_NAME, true, consumer);
    }
}

```



## 2.7.   持久化

要将消息持久化，前提是：队列、Exchange都持久化



### 2.7.1.   交换机持久化

![1532766951432](assets/1532766951432.png)

### 2.7.2.   队列持久化

![1532766981230](assets/1532766981230.png)

### 2.7.3.   消息持久化

![1532767057491](assets/1532767057491.png)



# 3. Spring AMQP

## 3.1.   简介

Sprin有很多不同的项目，其中就有对AMQP的支持：

![1532767136007](assets/1532767136007.png)

Spring AMQP的页面：http://spring.io/projects/spring-amqp

![1532767171063](assets/1532767171063.png)



注意这里一段描述：

![1532767227821](assets/1532767227821.png)                                             

```
     Spring-amqp是对AMQP协议的抽象实现，而spring-rabbit 是对协议的具体实现，也是目前的唯一实现。底层使用的就是RabbitMQ。

```



## 3.2. 入门程序

### 3.2.1. 依赖和配置

添加AMQP的启动器：

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-amqp</artifactId>
</dependency>

```

在`application.yml`中添加RabbitMQ地址：

```yaml
spring:
  rabbitmq:
    host: 192.168.56.101
    username: fengge
    password: fengge
    virtual-host: /fengge
```



### 3.2.2. 监听者（消费者）

在SpringAmqp中，对消息的消费者进行了封装和抽象，一个普通的JavaBean中的普通方法，只要通过简单的注解，就可以成为一个消费者。

```java
@Component
public class Listener {

    @RabbitListener(bindings = @QueueBinding(
            value = @Queue(value = "spring.test.queue", durable = "true"),
            exchange = @Exchange(
                    value = "spring.test.exchange",
                    ignoreDeclarationExceptions = "true",
                    type = ExchangeTypes.TOPIC
            ),
            key = {"a.#"}))
    public void listen(String msg){
        System.out.println("接收到消息：" + msg);
    }
}

```

- `@Componet`：类上的注解，注册到Spring容器
- `@RabbitListener`：方法上的注解，声明这个方法是一个消费者方法，需要指定下面的属性：
  - `bindings`：指定绑定关系，可以有多个。值是`@QueueBinding`的数组。`@QueueBinding`包含下面属性：
    - `value`：这个消费者关联的队列。值是`@Queue`，代表一个队列
    - `exchange`：队列所绑定的交换机，值是`@Exchange`类型
    - `key`：队列和交换机绑定的`RoutingKey`

类似listen这样的方法在一个类中可以写多个，就代表多个消费者。



### 3.2.3. AmqpTemplate（生产者）

Spring最擅长的事情就是封装，把他人的框架进行封装和整合。

Spring为AMQP提供了统一的消息处理模板：AmqpTemplate，非常方便的发送消息，其发送方法：

![1527090258083](assets/1527090258083.png)

红框圈起来的是比较常用的3个方法，分别是：

- 指定交换机、RoutingKey和消息体
- 指定消息
- 指定RoutingKey和消息，会向默认的交换机发送消息



### 3.2.4. 测试代码

```java
@RunWith(SpringRunner.class)
@SpringBootTest(classes = Application.class)
public class MqDemo {

    @Autowired
    private AmqpTemplate amqpTemplate;

    @Test
    public void testSend() throws InterruptedException {
        String msg = "hello, Spring boot amqp";
        this.amqpTemplate.convertAndSend("spring.test.exchange","a.b", msg);
        // 等待10秒后再结束
        Thread.sleep(10000);
    }
}

```

运行后查看日志：

![1532767726274](assets/1532767726274.png)



## 3.3. 生产者确认

 ![1585467767083](assets/1585467767083.png)

内容如下：

```java
/**
 * @Description 消息发送确认
 * <p>
 * ConfirmCallback  只确认消息是否正确到达 Exchange 中
 * ReturnCallback   消息没有正确到达队列时触发回调，如果正确到达队列不执行
 * <p>
 * 1. 如果消息没有到exchange,则confirm回调,ack=false
 * 2. 如果消息到达exchange,则confirm回调,ack=true
 * 3. exchange到queue成功,则不回调return
 * 4. exchange到queue失败,则回调return
 * @Author qy
 */
@Configuration
@Slf4j
public class ProducerAckConfig implements RabbitTemplate.ConfirmCallback, RabbitTemplate.ReturnCallback {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    @PostConstruct
    public void init() {
        rabbitTemplate.setConfirmCallback(this);            //指定 ConfirmCallback
        rabbitTemplate.setReturnCallback(this);             //指定 ReturnCallback
    }

    /**
     * 确认消息是否正确到达 Exchange 中
     * @param correlationData
     * @param ack
     * @param cause
     */
    @Override
    public void confirm(CorrelationData correlationData, boolean ack, String cause) {
        if (ack) {
            log.info("消息发送成功：" + JSON.toJSONString(correlationData));
        } else {
            log.info("消息发送失败：{} 数据：{}", cause, JSON.toJSONString(correlationData));
        }
    }

    /**
     * 消息没有正确到达队列时触发回调，如果正确到达队列不执行
     * @param message
     * @param replyCode
     * @param replyText
     * @param exchange
     * @param routingKey
     */
    @Override
    public void returnedMessage(Message message, int replyCode, String replyText, String exchange, String routingKey) {
        // 反序列化对象输出
        System.out.println("消息主体: " + new String(message.getBody()));
        System.out.println("应答码: " + replyCode);
        System.out.println("描述：" + replyText);
        System.out.println("消息使用的交换器 exchange : " + exchange);
        System.out.println("消息使用的路由键 routing : " + routingKey);
    }
}
```



测试1：消息正常发送，正常消费

![1585467927161](assets/1585467927161.png)



测试2：消息到达交换机，没有达到队列

![1585468585707](assets/1585468585707.png)

![1585468467934](assets/1585468467934.png)



测试3：消息不能到达交换机

![1585468780482](assets/1585468780482.png)

![1585468657812](assets/1585468657812.png)



## 3.4. 消费者确认

springboot-rabbit提供了三种消息确认模式：

- **AcknowledgeMode.NONE**：不确认模式（不管程序是否异常只要执行了监听方法，消息即被消费。相当于rabbitmq中的自动确认，这种方式不推荐使用）
- **AcknowledgeMode.AUTO**：自动确认模式（默认，消费者没有异常会自动确认，有异常则不确认，无限重试，导致**程序死循环**。不要和rabbit中的自动确认混淆）
- **AcknowledgeMode.MANUAL**：手动确认模式（需要手动调用channel.basicAck确认，可以捕获异常控制重试次数，甚至可以控制失败消息的处理方式）

配置方法：

```properties
spring.rabbitmq.listener.simple.acknowledge-mode=manual/none/auto
```



### 3.4.1. 自动确认模式

在消费者中制造一个异常：

![1585469259345](assets/1585469259345.png)

可以看到mq将无限重试，消费消息：

![1585468657812](assets/autoack.gif)

消息将无法消费：

![1585469409514](assets/1585469409514.png)

停掉应用消息回到Ready状态，消息不会丢失！



### 3.4.2. 不确认模式

在application.yml修改确认模式为none：

![1585470769598](assets/1585470769598.png)

保留消费者中的int i = 1/0异常，再次运行，程序报错：

![1585470901358](assets/1585470901358.png)

消息已经被消费：

![1585470927937](assets/1585470927937.png)



### 3.4.3. 手动确认模式

确认消息：

```java
// 参数二：是否批量确认
channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
```

拒绝消息：

```java
// 参数二：是否重新入队，false时消息不再重发，如果配置了死信队列则进入死信队列，没有死信就会被丢弃
channel.basicReject(message.getMessageProperties().getDeliveryTag(), false);
```

不确认消息：

```java
// 参数二：是否批量； 参数三：是否重新回到队列，true重新入队
channel.basicNack(message.getMessageProperties().getDeliveryTag(), false, true);
```



改造消费者监听器代码如下：

```java
@Component
public class Listener {

    @RabbitListener(bindings = @QueueBinding(
            value = @Queue(value = "spring.test.queue", durable = "true"),
            exchange = @Exchange(
                    value = "spring.test.exchange",
                    ignoreDeclarationExceptions = "true",
                    type = ExchangeTypes.TOPIC
            ),
            key = {"a.*"}))
    public void listen(String msg, Channel channel, Message message) throws IOException {
        try {
            System.out.println("接收到消息：" + msg);

            int i = 1 / 0;
            // 确认收到消息，false只确认当前consumer一个消息收到，true确认所有consumer获得的消息
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
        } catch (Exception e) {
            if (message.getMessageProperties().getRedelivered()) {
                System.out.println("消息重试后依然失败，拒绝再次接收");
                // 拒绝消息，不再重新入队（如果绑定了死信队列消息会进入死信队列，没有绑定死信队列则消息被丢弃，也可以把失败消息记录到redis或者mysql中），也可以设置为true再重试。
                channel.basicReject(message.getMessageProperties().getDeliveryTag(), false);
            } else {
                System.out.println("消息消费时出现异常，即将再次返回队列处理");
                // Nack消息，重新入队（重试一次）
                channel.basicNack(message.getMessageProperties().getDeliveryTag(), false, true);
            }
            e.printStackTrace();
        }
    }
}
```



输出日志如下：

```
接收到消息：hello, Spring boot amqp
消息消费时出现异常，即将再次返回队列处理
java.lang.ArithmeticException: / by zero
	at com.atuigu.rabbitmq.spring.Listener.listen(Listener.java:31)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	........................
2020-03-29 16:56:20.432  INFO 23432 --- [16.116.100:5672] c.a.rabbitmq.spring.ProducerAckConfig    : 消息发送成功：null


接收到消息：hello, Spring boot amqp
消息重试后依然失败，拒绝再次接收
java.lang.ArithmeticException: / by zero
	at com.atuigu.rabbitmq.spring.Listener.listen(Listener.java:31)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	.........................
```





## 3.5. 死信队列

死信，在官网中对应的单词为“Dead Letter”，可以看出翻译确实非常的简单粗暴。那么死信是个什么东西呢？

“死信”是RabbitMQ中的一种消息机制，当你在消费消息时，如果队列里的消息出现以下情况：

1. 消息被否定确认，使用 `channel.basicNack` 或 `channel.basicReject` ，并且此时`requeue` 属性被设置为`false`。
2. 消息在队列的存活时间超过设置的TTL时间。
3. 消息队列的消息数量已经超过最大队列长度。

那么该消息将成为“死信”。

“死信”消息会被RabbitMQ进行特殊处理，如果配置了死信队列信息，那么该消息将会被丢进死信队列中，如果没有配置，则该消息将会被丢弃。



死信的队列的使用，大概可以分为以下步骤：

1. 配置业务队列，绑定到业务交换机上
2. 为业务队列配置死信交换机（DLX）和路由key
3. 为死信交换机配置死信队列（DLQ）



在配置类中增加配置：

 ![1585474690360](assets/1585474690360.png)

内容如下：

```java
/**
     * 声明业务交换机
     *
     * @return
     */
@Bean
public TopicExchange topicExchange() {
    return new TopicExchange("spring.test.exchange", true, false);
}

/**
     * 声明业务队列
     * 并把死信交换机绑定到业务队列
     * @return
     */
@Bean
public Queue queue() {
    Map<String, Object> arguments = new HashMap<>();
    //         x-dead-letter-exchange    这里声明当前队列绑定的死信交换机
    arguments.put("x-dead-letter-exchange", "dead-exchange");
    //         x-dead-letter-routing-key  这里声明当前队列的死信路由key
    arguments.put("x-dead-letter-routing-key", "msg.dead");
    return new Queue("spring.test.queue", true, false, false, arguments);
}

/**
     * 业务队列绑定到业务交换机
     *
     * @return
     */
@Bean
public Binding binding() {
    return new Binding("spring.test.queue", Binding.DestinationType.QUEUE, "spring.test.exchange", "a.b", null);
}

/**
     * 声明死信交换机
     * @return
     */
@Bean
public TopicExchange deadExchange(){
    return new TopicExchange("dead-exchange", true, false);
}

/**
     * 声明死信队列
     * @return
     */
@Bean
public Queue deadQueue(){
    return new Queue("dead-queue", true, false, false);
}

/**
     * 把死信队列绑定到死信交换机
     * @return
     */
@Bean
public Binding deadBinding() {
    return new Binding("dead-queue", Binding.DestinationType.QUEUE, "dead-exchange", "msg.dead", null);
}
```



改造消费者监听器：

![1585474754089](assets/1585474754089.png)



**注意：测试前，需要把项目停掉，并在rabbitmq浏览器控制台删除之前声明好的交换机及队列**



运行测试后：

![1585474792447](assets/1585474792447.png)

可以看到spring.test.queue有了绑定死信交换机，死信消息已经进入死信队列。



## 3.6. 延时队列

`延时队列`，最重要的特性就体现在它的`延时`属性上，跟普通的队列不一样的是，`普通队列中的元素总是等着希望被早点取出处理，而延时队列中的元素则是希望被在指定时间得到取出和处理`，所以延时队列中的元素是都是带时间属性的，通常来说是需要被处理的消息或者任务。

简单来说，延时队列就是用来存放需要在指定时间被处理的元素的队列。

### 3.6.1. 使用场景

那么什么时候需要用延时队列呢？考虑一下以下场景：

1. 订单在十分钟之内未支付则自动取消。
2. 新创建的店铺，如果在十天内都没有上传过商品，则自动发送消息提醒。
3. 账单在一周内未支付，则自动结算。
4. 用户注册成功后，如果三天内没有登陆则进行短信提醒。
5. 用户发起退款，如果三天内没有得到处理则通知相关运营人员。
6. 预定会议后，需要在预定的时间点前十分钟通知各个与会人员参加会议。

这些任务看起来似乎可以使用定时任务，一直轮询数据，每秒查一次，取出需要被处理的数据，然后处理不就完事了吗？如果数据量比较少，确实可以这样做，比如：对于“如果账单一周内未支付则进行自动结算”这样的需求，如果对于时间不是严格限制，而是宽松意义上的一周，那么每天晚上跑个定时任务检查一下所有未支付的账单，确实也是一个可行的方案。但对于数据量比较大，并且时效性较强的场景，如：“订单十分钟内未支付则关闭“，短期内未支付的订单数据可能会有很多，活动期间甚至会达到百万甚至千万级别，对这么庞大的数据量仍旧使用轮询的方式显然是不可取的，很可能在一秒内无法完成所有订单的检查，同时会给数据库带来很大压力，无法满足业务要求而且性能低下。

更重要的一点是，不！优！雅！



### 3.6.2. 怎么声明

延时队列需要配置TTL，那么什么时TTL呢？

消息的TTL（Time To Live）就是消息的存活时间，单位是毫秒。我们可以对队列或者消息设置TTL，消息如果在TTL设置的时间内没有被消费，则会成为“死信”。如果同时配置了队列的TTL和消息的TTL，那么较小的那个值将会被使用。

队列设置TTL：

```java
Map<String, Object> args = new HashMap<String, Object>();
args.put("x-message-ttl", 6000);
channel.queueDeclare(queueName, durable, exclusive, autoDelete, args);
```

消息设置TTL：

```java
AMQP.BasicProperties.Builder builder = new AMQP.BasicProperties.Builder();
builder.expiration("6000");
AMQP.BasicProperties properties = builder.build();
channel.basicPublish(exchangeName, routingKey, mandatory, properties, "msg body".getBytes());
```

这样这条消息的过期时间也被设置成了6s。

但这两种方式是有区别的，**如果设置了队列的TTL属性，那么一旦消息过期，就会被队列丢弃，而第二种方式，消息即使过期，也不一定会被马上丢弃，因为消息是否过期是在即将投递到消费者之前判定的，如果当前队列有严重的消息积压情况，则已过期的消息也许还能存活较长时间。**

另外，还需要注意的一点是，如果不设置TTL，表示消息永远不会过期，如果将TTL设置为0，则表示除非此时可以直接投递该消息到消费者，否则该消息将会被丢弃。



### 3.6.3. 如何使用

![img](assets/20190527083121768.png)

实现如下：

 ![1585477749188](assets/1585477749188.png)

配置延时队列及死信队列：

```java
@Configuration
public class TTLQueueConfig {

    /**
     * 交换机
     * @return
     */
    @Bean
    public Exchange exchange(){

        return new TopicExchange("ORDER-EXCHANGE", true, false, null);
    }

    /**
     * 延时队列
     * @return
     */
    @Bean("ORDER-TTL-QUEUE")
    public Queue ttlQueue(){

        Map<String, Object> arguments = new HashMap<>();
        arguments.put("x-dead-letter-exchange", "ORDER-EXCHANGE");
        arguments.put("x-dead-letter-routing-key", "order.close");
        arguments.put("x-message-ttl", 120000); // 仅仅用于测试，实际根据需求，通常30分钟或者15分钟
        return new Queue("ORDER-TTL-QUEUE", true, false, false, arguments);
    }

    /**
     * 延时队列绑定到交换机
     * rountingKey：order.create
     * @return
     */
    @Bean("ORDER-TTL-BINDING")
    public Binding ttlBinding(){

        return new Binding("ORDER-TTL-QUEUE", Binding.DestinationType.QUEUE, "ORDER-EXCHANGE", "order.create", null);
    }

    /**
     * 死信队列
     * @return
     */
    @Bean("ORDER-CLOSE-QUEUE")
    public Queue queue(){

        return new Queue("ORDER-CLOSE-QUEUE", true, false, false, null);
    }

    /**
     * 死信队列绑定到交换机
     * routingKey：order.close
     * @return
     */
    @Bean("ORDER-CLOSE-BINDING")
    public Binding closeBinding(){

        return new Binding("ORDER-CLOSE-QUEUE", Binding.DestinationType.QUEUE, "ORDER-EXCHANGE", "order.close", null);
    }
}
```

在MqDemo测试类中添加发送消息的测试用例：

```java
@Test
public void testTTL() throws IOException {

    this.rabbitTemplate.convertAndSend("ORDER-EXCHANGE", "order.create", "hello world!");
    System.in.read();
}
```

添加消费者，消费死信消息：

```java
@Component
public class DeadListener {

    @RabbitListener(queues = "ORDER-CLOSE-QUEUE")
    public void testDead(String msg){
        System.out.println(msg);
    }
}
```



# 4. 项目改造

接下来，我们就改造项目，实现搜索服务的数据同步。

## 4.1.   思路分析

> 发送方：商品微服务

- 什么时候发？

  当商品服务对商品进行写操作：增、删、改的时候，需要发送一条消息，通知其它服务。

- 发送什么内容？

  对商品的增删改时其它服务可能需要新的商品数据，但是如果消息内容中包含全部商品信息，数据量太大，而且并不是每个服务都需要全部的信息。因此我们**只发送商品id**，其它服务可以根据id查询自己需要的信息。

> 接收方：搜索微服务

接收消息后如何处理？

- 搜索微服务：
  - 增/改：添加新的数据到索引库 
  - 删：删除索引库数据



## 4.2.   商品服务发送消息

我们先在商品微服务`gmall-pms`中实现发送消息。

### 4.2.1.   引入依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-amqp</artifactId>
</dependency>

```

### 4.2.2.   配置文件

我们在application.yml中添加一些有关RabbitMQ的配置：

```yaml
spring:
  rabbitmq:
    host: 172.16.116.100
    username: fengge
    password: fengge
    virtual-host: /fengge
    template:
      exchange: gmall.item.exchange
    publisher-confirms: true

```

- template：有关`AmqpTemplate`的配置
  - exchange：缺省的交换机名称，此处配置后，发送消息如果不指定交换机就会使用这个
- publisher-confirms：生产者确认机制，确保消息会正确发送，如果发送失败会有错误回执，从而触发重试



### 4.2.3.   改造SpuInfoServiceImpl

在SpuInfoServiceImpl中封装一个发送消息到mq的方法：**（需要注入AmqpTemplate模板）**

```java
@Autowired
private AmqpTemplate amqpTemplate;

private void sendMessage(Long id, String type){
    // 发送消息
    try {
        this.amqpTemplate.convertAndSend("item." + type, id);
    } catch (Exception e) {
        logger.error("{}商品消息发送异常，商品id：{}", type, id, e);
    }
}

```

这里没有指定交换机，因此默认发送到了配置中的：`gmall.item.exchange`

**注意：这里要把所有异常都try起来，不能让消息的发送影响到正常的业务逻辑**



然后在新增的时候调用：

![1570343973179](assets/1570343973179.png)



## 4.3.   搜索服务接收消息

搜索服务接收到消息后要做的事情：

- 增：添加新的数据到索引库
- 删：删除索引库数据
- 改：修改索引库数据

### 4.3.1.   引入依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-amqp</artifactId>
</dependency>
```

### 4.3.2.   添加配置

```yaml
spring:
  rabbitmq:
    host: 192.168.56.101
    username: fengge
    password: fengge
    virtual-host: /fengge
```

这里只是接收消息而不发送，所以不用配置template相关内容。

### 4.3.3.   编写监听器

 ![1570344827798](assets/1570344827798.png)

代码：

```java
@Component
public class SpuInfoListener {

    @Autowired
    private SearchService searchService;

    /**
     * 处理insert的消息
     *
     * @param id
     * @throws Exception
     */
    @RabbitListener(bindings = @QueueBinding(
            value = @Queue(value = "gmall.item.create.queue", durable = "true"),
            exchange = @Exchange(
                    value = "gmall.item.exchange",
                    ignoreDeclarationExceptions = "true",
                    type = ExchangeTypes.TOPIC),
            key = {"item.insert"}))
    public void listenCreate(Long id) throws Exception {
        if (id == null) {
            return;
        }
        // 创建索引
        this.searchService.createIndex(id);
    }
}
```



### 4.3.4.   编写创建索引方法

这里因为要创建和删除索引，我们需要在SearchService中拓展创建索引：

```java
@Override
public void createIndex(Long id) {

    Resp<List<SkuInfoEntity>> skuInfoResp = this.gmallPmsFeign.querySkuBySpuId(id);
    List<SkuInfoEntity> skuInfoEntities = skuInfoResp.getData();
    if (!CollectionUtils.isEmpty(skuInfoEntities)) {
        skuInfoEntities.forEach(skuInfoEntity -> {
            GoodsVO goodsVO = new GoodsVO();
            goodsVO.setId(skuInfoEntity.getSkuId());
            goodsVO.setName(skuInfoEntity.getSkuName());
            goodsVO.setPic(skuInfoEntity.getSkuDefaultImg());
            goodsVO.setPrice(skuInfoEntity.getPrice());
            goodsVO.setSale(0); // 销量，数据库暂没设计
            goodsVO.setSort(0);
            // 设置库存
            Resp<List<WareSkuEntity>> wareSkuResp = this.gmallWmsFeign.queryWareSkuBySkuId(skuInfoEntity.getSkuId());
            List<WareSkuEntity> wareSkuEntities = wareSkuResp.getData();
            if (!CollectionUtils.isEmpty(wareSkuEntities)) {
                long sum = wareSkuEntities.stream().mapToLong(WareSkuEntity::getSkuId).sum();
                goodsVO.setStock(sum);
            }
            // 设置品牌
            goodsVO.setBrandId(skuInfoEntity.getBrandId());
            if (skuInfoEntity.getBrandId() != null) {
                Resp<BrandEntity> brandEntityResp = this.gmallPmsFeign.info(skuInfoEntity.getBrandId());
                if (brandEntityResp.getData() != null) {
                    goodsVO.setBrandName(brandEntityResp.getData().getName());
                }
            }
            // 设置分类
            goodsVO.setProductCategoryId(skuInfoEntity.getCatalogId());
            if (skuInfoEntity.getCatalogId() != null) {
                Resp<CategoryEntity> categoryEntityResp = this.gmallPmsFeign.catInfo(skuInfoEntity.getCatalogId());
                if (categoryEntityResp.getData() != null) {
                    goodsVO.setProductCategoryName(categoryEntityResp.getData().getName());
                }
            }
            // 设置搜索的规格属性
            Resp<List<ProductAttrValueEntity>> listResp = this.gmallPmsFeign.querySearchAttrValue(id);
            if (!CollectionUtils.isEmpty(listResp.getData())) {
                List<SpuAttributeValueVO> spuAttributeValueVOS = listResp.getData().stream().map(productAttrValueEntity -> {
                    SpuAttributeValueVO spuAttributeValueVO = new SpuAttributeValueVO();
                    spuAttributeValueVO.setId(productAttrValueEntity.getId());
                    spuAttributeValueVO.setName(productAttrValueEntity.getAttrName());
                    spuAttributeValueVO.setValue(productAttrValueEntity.getAttrValue());
                    spuAttributeValueVO.setProductAttributeId(productAttrValueEntity.getAttrId());
                    spuAttributeValueVO.setSpuId(productAttrValueEntity.getSpuId());
                    return spuAttributeValueVO;
                }).collect(Collectors.toList());
                goodsVO.setAttrValueList(spuAttributeValueVOS);
            }
            Index action = new Index.Builder(goodsVO).index("goods").type("info").id(skuInfoEntity.getSkuId().toString()).build();
            try {
                jestClient.execute(action);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }
}
```

创建索引的方法可以从之前导入数据的测试类中拷贝和改造。



## 4.4.   修改数据试一试

在后台修改商品数据的价格，分别在搜索及商品详情页查看是否统一。



