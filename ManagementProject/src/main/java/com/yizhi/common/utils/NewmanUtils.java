package com.yizhi.common.utils;


import org.springframework.boot.SpringApplication;
import org.springframework.context.ConfigurableApplicationContext;

import java.io.File;

public class NewmanUtils {

    public static final String NEWMAN_RUN_JSON = "testone.postman_collection.json";
    public static final String NEWMAN_ENVIRONMENT_JSON = "MyWorkspace.postman_globals.json";

    public static void run(String[] argArr, ConfigurableApplicationContext context) {

        if (argArr != null && argArr.length > 0) {
//                String[] argArr = params.split(",");//{生成的json文件路径,postman文件目录}
            String reportPath = argArr[0];
            String jsonpath = argArr[1];
            System.out.println(reportPath);
            System.out.println(jsonpath);
            String cmd = "newman run " + jsonpath + File.separator + NEWMAN_RUN_JSON + " -g " + jsonpath + File.separator + NEWMAN_ENVIRONMENT_JSON + " -r json --reporter-json-export " + reportPath;
            CmdUtil.executeCmd(cmd);

            try {
                System.exit(SpringApplication.exit(context));
            } catch (Exception e) {
                System.exit(-1);
            }

        }
    }
}
