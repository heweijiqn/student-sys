package com.yizhi.common.domain;

public class SysException extends Exception {
    private String key;
    private Object values;
    //带key和参数
    public SysException(String message,String key,Object value){
        super(message);
        this.key=key;
        this.values=new Object[]{value};
    }
    //带key和参数数组
    public SysException(String message,String key,Object values[]){
        super(message);
        this.key=key;
        this.values=values;
    }
    public SysException(String message){
        super(message);
    }
    public SysException(String message,String key) {
        super(message);
    }
    public String getKey() {
        return key;
    }
    public void setKey(String key) {
        this.key = key;
    }
    public Object getValues() {
        return values;
    }
    public void setValues(Object values) {
        this.values = values;
    }

}

