package com.yizhi.common.domain;

import com.fasterxml.jackson.annotation.JsonRootName;


@JsonRootName(Const.ERROR_RESPONSE)
public class Response {
	private String code;
	private String msg;
	private Object data;
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMsg() {
		return this.msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}



	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
}

