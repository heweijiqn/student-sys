package com.yizhi.common.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class CmdUtil {

    public static String executeCmd(String cmd) {
        String os = System.getProperty("os.name");
        //Windows操作系统
        if (os != null && os.toLowerCase().startsWith("windows")) {
            return CmdUtil.executeWindowsCmd(cmd);
        } else {
            return CmdUtil.executeLinuxCmd(cmd);
        }
    }

    public static String executeWindowsCmd(String cmd) {
        return executeCmd("cmd /C "+cmd, "GBK");
    }

    public static String executeLinuxCmd(String cmd) {
        return executeCmd(cmd, "utf-8");
    }

    public static String executeCmd(String cmd, String charsetName) {
        System.out.println("执行命令[ " + cmd + "]");
        Runtime run = Runtime.getRuntime();
        try {
            Process process = run.exec(cmd);
            String line;
            InputStream stderr = process.getInputStream();//原始执行结果 得到进程的标准输出信息流
            InputStreamReader isr = new InputStreamReader(stderr, charsetName);//转换为字符流 此时设置字符编码 默认为utf-8
            BufferedReader stdoutReader = new BufferedReader(isr);
            StringBuffer out = new StringBuffer();
            while ((line = stdoutReader.readLine()) != null) {
                System.out.println(line);
                out.append(line);
                out.append("\n");
            }
            try {
                process.waitFor();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            process.destroy();
            return out.toString();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}