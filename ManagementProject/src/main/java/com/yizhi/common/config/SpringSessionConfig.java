package com.yizhi.common.config;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;

@ConditionalOnProperty(prefix = "yizhi", name = "spring-session-open", havingValue = "true")
public class SpringSessionConfig {

}
