package com.yizhi.common.config;

import java.util.HashMap;
import java.util.Map;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.CustomExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


//@Configuration
public class XdelayConfig {
	
	public static final String IMMEDIATE_QUEUE_XDELAY=Constant.SYSTEM_NAME+".order.delay.queue";
	public static final String DELAYED_EXCHANGE_XDELAY=Constant.SYSTEM_NAME+".order.delay.exchange";
	public static final String DELAY_ROUTING_KEY_XDELAY=Constant.SYSTEM_NAME+".order_delay";
	
	public  static final String ORDER_ASSIGN_QUEUE  = Constant.SYSTEM_NAME+".order.assign.queue";

    // 创建一个立即消费队列
    @Bean
    public Queue immediateQueue() {
        // 第一个参数是创建的queue的名字，第二个参数是是否支持持久化
        return new Queue(IMMEDIATE_QUEUE_XDELAY, true);
    }

    @Bean
    public CustomExchange delayExchange() {
        Map<String, Object> args = new HashMap<String, Object>();
        args.put("x-delayed-type", "direct");
        return new CustomExchange(DELAYED_EXCHANGE_XDELAY, "x-delayed-message", true, false, args);
    }

    @Bean
    public Binding bindingNotify() {
        return BindingBuilder.bind(immediateQueue()).to(delayExchange()).with(DELAY_ROUTING_KEY_XDELAY).noargs();
    }
    
    /*
     * 指定处理部门队列
     * @return
     
    @Bean
    public Queue assignOrderQueue() {
       
        return new Queue(ORDER_ASSIGN_QUEUE);
    }
   */
}
