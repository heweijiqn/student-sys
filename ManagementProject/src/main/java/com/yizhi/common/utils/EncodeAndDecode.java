package com.yizhi.common.utils;

import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.security.Security;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;

import com.sun.crypto.provider.SunJCE;

public class EncodeAndDecode {
	/*private static void ednCode(String plainText) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(plainText.getBytes());
			byte b[] = md.digest();

			int i;

			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
			System.out.println("result: " + buf.toString());// 32λ�ļ���
			System.out.println("result: " + buf.toString().substring(8, 24));// 16λ�ļ���
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}*/

	private static String strDefaultKey = "whd123huixuewnag";
	private Cipher encryptCipher;
	private Cipher decryptCipher;

	public static String byteArr2HexStr(byte[] arrB) {
		int iLen = arrB.length;

		StringBuffer sb = new StringBuffer(iLen * 2);
		for (int i = 0; i < iLen; ++i) {
			int intTmp = arrB[i];

			while (intTmp < 0) {
				intTmp += 256;
			}

			if (intTmp < 16)
				sb.append("0");

			sb.append(Integer.toString(intTmp, 16));
		}
		return sb.toString();
	}

	public static byte[] hexStr2ByteArr(String strIn) {
		byte[] arrB = strIn.getBytes();
		int iLen = arrB.length;

		byte[] arrOut = new byte[iLen / 2];
		for (int i = 0; i < iLen; i += 2) {
			String strTmp = new String(arrB, i, 2);
			arrOut[(i / 2)] = (byte) Integer.parseInt(strTmp, 16);
		}
		return arrOut;
	}

	public EncodeAndDecode() {
		this(strDefaultKey);
	}

	public EncodeAndDecode(String strKey) {
		this.encryptCipher = null;

		this.decryptCipher = null;

		Security.addProvider(new SunJCE());
		Key key = getKey(strKey.getBytes());
		try {
			this.encryptCipher = Cipher.getInstance("DES");
			this.encryptCipher.init(1, key);

			this.decryptCipher = Cipher.getInstance("DES");
			this.decryptCipher.init(2, key);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		}
	}

	public byte[] encrypt(byte[] arrB) {
		try {
			return this.encryptCipher.doFinal(arrB);
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}

	public String encrypt(String strIn) {
		try {
			return byteArr2HexStr(encrypt(strIn.getBytes()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public byte[] decrypt(byte[] arrB) {
		try {
			return this.decryptCipher.doFinal(arrB);
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}

	public String decrypt(String strIn) {
		return new String(decrypt(hexStr2ByteArr(strIn)));
	}

	private Key getKey(byte[] arrBTmp) {
		byte[] arrB = new byte[8];

		for (int i = 0; (i < arrBTmp.length) && (i < arrB.length); ++i) {
			arrB[i] = arrBTmp[i];
		}

		Key key = new SecretKeySpec(arrB, "DES");

		return key;
	}

	public static void main(String[] args) {
	
		//ednCode("houwenhua");
		EncodeAndDecode Encode=new EncodeAndDecode();
		/*String pwd =Encode.decrypt("3c0486ff1442fb37");*/
		String pwd = Encode.encrypt("111111");
		System.out.println(pwd);
		System.out.println(Encode.decrypt(pwd));
		// 328099418@qq.com  su13860718166

	}
}
