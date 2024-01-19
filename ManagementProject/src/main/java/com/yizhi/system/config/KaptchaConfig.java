package com.yizhi.system.config;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
 
import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;
 
@Component
public class KaptchaConfig {
	@Bean
	public DefaultKaptcha getDefaultKaptcha(){
		com.google.code.kaptcha.impl.DefaultKaptcha defaultKaptcha = new com.google.code.kaptcha.impl.DefaultKaptcha();
		Properties properties = new Properties();
		properties.setProperty("kaptcha.border", "yes");
		properties.setProperty("kaptcha.border.color", "105,179,90");
		properties.setProperty("kaptcha.textproducer.font.color", "red");
		properties.setProperty("kaptcha.image.width", "110");
		properties.setProperty("kaptcha.image.height", "40");
		properties.setProperty("kaptcha.textproducer.font.size", "30");
		properties.setProperty("kaptcha.textproducer.char.space", "4");
		properties.setProperty("kaptcha.session.key", "code");
		properties.setProperty("kaptcha.textproducer.char.length", "4");
		properties.setProperty("kaptcha.textproducer.font.names", "宋体,楷体,微软雅黑");
		Config config = new Config(properties);
		defaultKaptcha.setConfig(config);
		
		return defaultKaptcha;
	}
}

