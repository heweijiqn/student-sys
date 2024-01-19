package com.yizhi.miniapp.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

/**
 * @author <a href="https://github.com/binarywang">Binary Wang</a>
 */
public class JsonUtils {
    private static final ObjectMapper JSON2 = new ObjectMapper();

    static {
    	JSON2.setSerializationInclusion(Include.NON_NULL);
    	JSON2.configure(SerializationFeature.INDENT_OUTPUT, Boolean.TRUE);
    }

    public static String toJson(Object obj) {
        try {
            return JSON2.writeValueAsString(obj);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return null;
    }
    public static String toJson2(Object obj) {
		return JSON.toJSONString(obj);
	}
    public static String mapToJson(Map map){
		String jsonStr="";
		if(map!=null&&!map.isEmpty()){
			map.put("success", true);
		}else{
			map=new HashMap();
			map.put("success", false);
		}
		jsonStr=JSON.toJSONString(map);
		return jsonStr;
	};
	public static Map jsonToMap(String json){
		Map jsonmap=(Map)JSON.parse(json);
		return jsonmap;
	}
	 
	public static String listToJson(List list){
		String jsonStr="";
		Map map=new HashMap();
		map.put("root", list);
	    if(list!=null&&list.size()>0){
	    	map.put("success", true);
	    }else{
			map.put("success", false);
		}
		jsonStr=JSON.toJSONString(map);
		return jsonStr;
	}
	public static String listToJson(List list,int totalpage){
		String jsonStr="";
		Map map=new HashMap();
		map.put("totalpage", totalpage);
	    map.put("root", list);
	    if(list!=null&&list.size()>0){
	    	map.put("success", true);
	    }else{
			map.put("success", false);
		}
		jsonStr=JSON.toJSONString(map);
		return jsonStr;
	}
	public static String javabean2json(Object object) {
        Map<String, Object> map = new HashMap<String, Object>();
        if(object==null)
        	map.put("success", false);
        else
        	map.put("success", true);
        map.put("data", object);
        return JSON.toJSONString(map);
    }
	
	
	 public static List<Map> jsonToList(String json) {
	        List<Map> listMap = new ArrayList<Map>();
	        String JSON = json.substring(1, json.length() - 1);
	        JSON = JSON.replaceAll("},", "}^");
	        StringTokenizer strTokenizer = new StringTokenizer(JSON, "^");

	        while (strTokenizer.hasMoreTokens()) {
	            String token = strTokenizer.nextToken();
	            Map paraMap = JsonUtils.jsonToMap(token);
	            listMap.add(paraMap);
	        }

	       return listMap;
	    }
    
}
