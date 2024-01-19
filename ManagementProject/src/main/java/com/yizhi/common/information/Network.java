package com.yizhi.common.information;

import oshi.util.FormatUtil;

public class Network {
	private String BytesRecv;
	
	private String BytesSent;
	
	private String Name;
	
	private String[] ipv4;
	
	private String[] ipv6;
	
	private String DisplayName;
	
	private String Speed;
	

	public String getBytesRecv() {
		return BytesRecv;
	}

	public void setBytesRecv(Long bytesRecv) {
		BytesRecv = FormatUtil.formatBytes(bytesRecv);
	}

	public String getBytesSent() {
		return BytesSent;
	}

	public void setBytesSent(Long bytesSent) {
		BytesSent = FormatUtil.formatBytes(bytesSent);
	}

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	public String[] getIpv4() {
		return ipv4;
	}

	public void setIpv4(String[] ipv4) {
		this.ipv4 = ipv4;
	}

	public String[] getIpv6() {
		return ipv6;
	}

	public void setIpv6(String[] ipv6) {
		this.ipv6 = ipv6;
	}

	public String getDisplayName() {
		return DisplayName;
	}

	public void setDisplayName(String displayName) {
		DisplayName = displayName;
	}

	public String getSpeed() {
		return Speed;
	}

	public void setSpeed(Long speed) {
		Speed =  FormatUtil.formatBytes(speed);
	}
}
