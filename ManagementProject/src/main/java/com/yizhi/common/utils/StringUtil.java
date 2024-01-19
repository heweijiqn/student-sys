package com.yizhi.common.utils;

import java.util.Date;
import java.util.Random;
import java.util.regex.Pattern;

public class StringUtil {
	public static String msgfmt(Exception e) {
		StringBuffer sb = new StringBuffer();
		sb.append(e.getMessage());
		for (StackTraceElement el : e.getStackTrace()) {
			sb.append(el);
		}
		return sb.toString();
	}

	/**
	 * 样式过滤
	 * 
	 * @param inputString
	 * @return
	 */
	public static String Html2Text(String inputString) {
		String htmlStr = inputString; // 含html标签的字符串
		String textStr = "";
		java.util.regex.Pattern p_script;
		java.util.regex.Matcher m_script;
		java.util.regex.Pattern p_style;
		java.util.regex.Matcher m_style;
		java.util.regex.Pattern p_html;
		java.util.regex.Matcher m_html;
		try {
			String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>"; // 定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script>
			String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>"; // 定义style的正则表达式{或<style[^>]*?>[\\s\\S]*?<\\/style>
			String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式
			p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
			m_script = p_script.matcher(htmlStr);
			htmlStr = m_script.replaceAll(""); // 过滤script标签
			p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
			m_style = p_style.matcher(htmlStr);
			htmlStr = m_style.replaceAll(""); // 过滤style标签
			p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
			m_html = p_html.matcher(htmlStr);
			htmlStr = m_html.replaceAll(""); // 过滤html标签
			textStr = htmlStr;
		} catch (Exception e) {
			System.err.println("Html2Text: " + e.getMessage());
		}
		return textStr;// 返回文本字符串
	}
	 /** 
     * 使用java正则表达式去掉多余的.与0 
     * @param s 
     * @return  
     */  
    public static String subZeroAndDot(String s){  
        if(s.indexOf(".") > 0){  
            s = s.replaceAll("0+?$", "");//去掉多余的0  
            s = s.replaceAll("[.]$", "");//如最后一位是.则去掉  
        }  
        return s;  
    } 
    public static String timeFmt(String secs){
    	String str="";
    	if(secs!=null&&!"".equals(secs)){
    		int $day=0;
        	int $hour=0;
        	int $minute=0;
    		int $second=(int)Float.parseFloat(secs);
    		$day = $second/(3600*24);
    		$second = $second%(3600*24);//除去整天之后剩余的时间
    		$hour = $second/3600;
    		$second = $second%3600;//除去整小时之后剩余的时间 
    		$minute =$second/60;
    		if($day>0){
    			str+=$day+"天";
    		}
    		if($hour>0){
    			str+=$hour+"小时";
    		}
    		if($minute>0){
    			str+=$minute+"分";
    		}
    	    if("".equals(str)){
    	    	str="已结束";
    	    }
    		//返回字符串
    		return str;
    	}
    	return str;
    }
}
