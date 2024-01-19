package com.yizhi.common.domain;

public enum  OpenType {
    QQ(1),WEIXIN(2),MINIWEIXIN(3),ALIPAY(4);
    private int value;
    private OpenType(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
