package com.yizhi.common.utils;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.KeyStore;
import java.util.ArrayList;  
import java.util.Iterator;  
import java.util.List;  
import java.util.Map;  
import java.util.Map.Entry;
 
import javax.imageio.stream.FileImageOutputStream;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
 
 
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;  
import org.apache.http.NameValuePair;  
import org.apache.http.client.HttpClient;  
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;  
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.LinkedMultiValueMap;
 
import com.alibaba.fastjson.JSON;
public class HttpUtils {
    private final static Logger logger = LoggerFactory.getLogger(HttpUtils.class);
    public static String doPostSSL(String url,Map<String,String> map,String charset){  
        HttpClient httpClient = null;  
        HttpPost httpPost = null;  
        String result = null;  
        try{  
            httpClient = new SSLClient();  
            httpPost = new HttpPost(url);  
            //设置参数  
            List<NameValuePair> list = new ArrayList<NameValuePair>();  
            Iterator iterator = map.entrySet().iterator();  
            while(iterator.hasNext()){  
                Entry<String,String> elem = (Entry<String, String>) iterator.next();  
                list.add(new BasicNameValuePair(elem.getKey(),elem.getValue()));  
            }  
            if(list.size() > 0){  
                UrlEncodedFormEntity entity = new UrlEncodedFormEntity(list,charset);  
                httpPost.setEntity(entity);  
            }  
            HttpResponse response = httpClient.execute(httpPost);  
            if(response != null){  
                HttpEntity resEntity = response.getEntity();  
                if(resEntity != null){  
                    result = EntityUtils.toString(resEntity,charset);  
                }  
            }  
        }catch(Exception ex){  
            ex.printStackTrace();  
        }  
        return result;  
    }  
     public static String doPostBybody(String reqUrl, Map parameters)
      {
        HttpsURLConnection urlConn = null;
        try {
          urlConn = sendPostBybody(reqUrl, parameters);
          String responseContent = getContent(urlConn);
          String str1 = responseContent.trim();
 
          return str1;
        }
        finally
        {
          if (urlConn != null) {
            urlConn.disconnect();
            urlConn = null;
          }
        }
      }
     
     public static String generatorParamJsonString(Map parameters)
      {
        return  JSON.toJSONString(parameters);
      }
     private static HttpsURLConnection sendPostBybody(String reqUrl, Map parameters) {
          HttpsURLConnection urlConn = null;
            try {
              String params = generatorParamJsonString(parameters);
              URL url = new URL(reqUrl);
              urlConn = (HttpsURLConnection)url.openConnection();
              urlConn.setRequestMethod("POST");
 
              urlConn.setConnectTimeout(60000);//60s
              urlConn.setReadTimeout(20000);
              urlConn.setDoOutput(true);
              byte[] b = params.getBytes("UTF-8");
              urlConn.getOutputStream().write(b, 0, b.length);
              urlConn.getOutputStream().flush();
              urlConn.getOutputStream().close();
            } catch (Exception e) {
              throw new RuntimeException(e.getMessage(), e);
            }
            return urlConn;
          }
    public static String doPost(String reqUrl, Map<String, String> parameters)
      {
        HttpURLConnection urlConn = null;
        try {
          urlConn = sendPost(reqUrl, parameters);
          String responseContent = getContent(urlConn);
          String str1 = responseContent.trim();
 
          return str1;
        }catch(Exception e){
             return e.getMessage();
        }
        finally
        {
          if (urlConn != null) {
            urlConn.disconnect();
            urlConn = null;
          }
        }
      }
      public static String doPost(String reqUrl, String parameters)
      {
        HttpURLConnection urlConn = null;
        try {
          urlConn = sendPost(reqUrl, parameters);
          String responseContent = getContent(urlConn);
          String str1 = responseContent.trim();
 
          return str1;
        }
        finally
        {
          if (urlConn != null) {
            urlConn.disconnect();
            urlConn = null;
          }
        }
      }
      private static HttpURLConnection sendPost(String reqUrl, String params) {
            HttpURLConnection urlConn = null;
            try {
              URL url = new URL(reqUrl);
              urlConn = (HttpURLConnection)url.openConnection();
              urlConn.setRequestMethod("POST");
 
              urlConn.setConnectTimeout(60000);//60s
              urlConn.setReadTimeout(20000);
              urlConn.setDoOutput(true);
              byte[] b = params.getBytes("UTF-8");
              urlConn.getOutputStream().write(b, 0, b.length);
              urlConn.getOutputStream().flush();
              urlConn.getOutputStream().close();
            } catch (Exception e) {
              throw new RuntimeException(e.getMessage(), e);
            }
            return urlConn;
          }
      private static String getContent(HttpURLConnection urlConn) {
        String responseContent;
        try {
          responseContent = null;
          InputStream in = urlConn.getInputStream();
          BufferedReader rd = new BufferedReader(new InputStreamReader(in, "UTF-8"));
          String tempLine = rd.readLine();
          StringBuffer tempStr = new StringBuffer();
          String crlf = System.getProperty("line.separator");
          while (tempLine != null) {
            tempStr.append(tempLine);
            tempStr.append(crlf);
            tempLine = rd.readLine();
          }
          responseContent = tempStr.toString();
          rd.close();
          in.close();
          return responseContent;
        } catch (Exception ex) {
            StringBuffer sb=new StringBuffer();
            sb.append(ex.toString());
            for(StackTraceElement s:ex.getStackTrace()){
                sb.append(s.toString());
            }
          throw new RuntimeException("访问超时", ex);
        }
      }
 
      public static byte[] getBytes(String reqUrl) {
        return getBytes(reqUrl, null);
      }
 
      public static byte[] getBytes(String reqUrl, Map<String, String> parameters) {
        HttpURLConnection conn = sendGet(reqUrl, parameters);
        return getBytes(conn); }
 
      private static byte[] getBytes(HttpURLConnection urlConn) {
        InputStream in;
        try {
          in = urlConn.getInputStream();
          ByteArrayOutputStream os = new ByteArrayOutputStream();
          byte[] buf = new byte[1024];
          for (int i = 0; (i = in.read(buf)) > 0; )
            os.write(buf, 0, i);
          in.close();
          return os.toByteArray();
        } catch (Exception e) {
            StringBuffer sb=new StringBuffer();
        sb.append(e.toString());
        for(StackTraceElement s:e.getStackTrace()){
            sb.append(s.toString());
        }
          throw new RuntimeException(e.getMessage(), e);
        }
      }
 
      private static HttpURLConnection sendPost(String reqUrl, Map<String, String> parameters) {
        HttpURLConnection urlConn = null;
        try {
          String params = generatorParamString(parameters);
          URL url = new URL(reqUrl);
          urlConn = (HttpURLConnection)url.openConnection();
          urlConn.setRequestMethod("POST");
 
          urlConn.setConnectTimeout(60000);//60s
          urlConn.setReadTimeout(20000);
          urlConn.setDoOutput(true);
          byte[] b = params.getBytes("UTF-8");
          urlConn.getOutputStream().write(b, 0, b.length);
          urlConn.getOutputStream().flush();
          urlConn.getOutputStream().close();
        } catch (Exception e) {
          throw new RuntimeException(e.getMessage(), e);
        }
        return urlConn;
      }
      private static HttpURLConnection sendGet(String reqUrl, Map<String, String> parameters) {
        HttpURLConnection urlConn = null;
        try {
          String params = generatorParamString(parameters);
          URL url = new URL(reqUrl);
          urlConn = (HttpURLConnection)url.openConnection();
          urlConn.setRequestMethod("GET");
 
          urlConn.setConnectTimeout(5000);
          urlConn.setReadTimeout(5000);
          urlConn.setDoOutput(true);
          if ((params != null) && (!("".equals(params)))) {
            byte[] b = params.getBytes();
            urlConn.getOutputStream().write(b, 0, b.length);
            urlConn.getOutputStream().flush();
            urlConn.getOutputStream().close();
          }
        } catch (Exception e) {
          throw new RuntimeException(e.getMessage(), e);
        }
        return urlConn;
      }
 
      public static String generatorParamString(Map<String, String> parameters)
      {
        StringBuffer params = new StringBuffer();
        if (parameters != null)
          for (Iterator iter = parameters.keySet().iterator(); iter.hasNext(); ) {
            String name = (String)iter.next();
            String value = (String)parameters.get(name);
            params.append(name + "=");
            try {
              params.append(URLEncoder.encode(value, "UTF-8"));
            } catch (UnsupportedEncodingException e) {
              throw new RuntimeException(e.getMessage(), e);
            } catch (Exception e) {
              String message = String.format("'%s'='%s'", new Object[] { name, value });
              throw new RuntimeException(message, e);
            }
            if (iter.hasNext()) params.append("&");
          }
 
        return params.toString();
      }
 
      public static String doGet(String link, String charset)
      {
        URL url;
        try
        {
          url = new URL(link);
          HttpURLConnection conn = (HttpURLConnection)url.openConnection();
          conn.setConnectTimeout(60000);//60s
          conn.setReadTimeout(20000);
          conn.setRequestMethod("GET");
         // conn.setRequestProperty("User-Agent", "Mozilla/5.0");
          BufferedInputStream in = new BufferedInputStream(conn.getInputStream());
          ByteArrayOutputStream out = new ByteArrayOutputStream();
          byte[] buf = new byte[1024];
          for (int i = 0; (i = in.read(buf)) > 0; )
            out.write(buf, 0, i);
 
          out.flush();
          String s = new String(out.toByteArray(), charset);
          return s;
        } catch (Exception e) {
          throw new RuntimeException(e.getMessage(), e);
        }
      }
 
      public static String doGet(String link)
      {
        return doGet(link, "UTF-8");
      }
 
      public static int getIntResponse(String link) {
        String str = doGet(link);
        return Integer.parseInt(str.trim());
      }
      public static String doPostWithImg(String reqUrl, String parameters,String savepath) throws Exception
      {
        HttpURLConnection urlConn = null;
        try {
          urlConn = sendImgPost(reqUrl, parameters);
          InputStream inStream = urlConn.getInputStream();//通过输入流获取图片数据  
          byte[] btImg = readInputStream(inStream);//得到图片的二进制数据  
          byte2image(btImg, savepath);
          return savepath;
        }
        finally
        {
          if (urlConn != null) {
            urlConn.disconnect();
            urlConn = null;
          }
        }
       
      }
      private static HttpURLConnection sendImgPost(String reqUrl, String params) {
            HttpURLConnection urlConn = null;
            try {
              URL url = new URL(reqUrl);
              urlConn = (HttpURLConnection)url.openConnection();
              urlConn.setRequestMethod("POST");
 
              urlConn.setConnectTimeout(60000);//60s
              urlConn.setReadTimeout(20000);
              urlConn.setDoOutput(true);
              urlConn.setDoInput(true);
              byte[] b = params.getBytes("UTF-8");
              urlConn.getOutputStream().write(b, 0, b.length);
              urlConn.getOutputStream().flush();
              urlConn.getOutputStream().close();
            } catch (Exception e) {
              throw new RuntimeException(e.getMessage(), e);
            }
            return urlConn;
          }
      /** 
       * 从输入流中获取数据 
       * @param inStream 输入流 
       * @return 
       * @throws Exception 
       */  
      public static byte[] readInputStream(InputStream inStream) throws Exception{  
          ByteArrayOutputStream outStream = new ByteArrayOutputStream();  
          byte[] buffer = new byte[1024];  
          int len = 0;  
          while( (len=inStream.read(buffer)) != -1 ){  
              outStream.write(buffer, 0, len);  
          }  
          inStream.close();  
          return outStream.toByteArray();  
      } 
      public static String byte2image(byte[] data,String path){
            if(data.length<3||path.equals("")) return null;
            try{
            FileImageOutputStream imageOutput = new FileImageOutputStream(new File(path));
            imageOutput.write(data, 0, data.length);
            imageOutput.close();
            System.out.println("Make Picture success,Please find image in " + path);
            } catch(Exception ex) {
              System.out.println("Exception: " + ex);
              ex.printStackTrace();
            }
            return path;
          }
      /**
       * 发送请求
        * */
  public static String ssl(String url,String data,String mchId){
           StringBuffer message = new StringBuffer();
           try {
               KeyStore keyStore  = KeyStore.getInstance("PKCS12");
               HttpUtils htt=new HttpUtils();
               String certFilePath = htt.getClass().getResource("/META-INF/")+"apiclient_cert.p12";//"D:/cert/apiclient_cert.p12";//D:\cert (1)D:/cert/apiclient_cert.p12
               logger.error("certFilePath"+certFilePath);
               // linux下
              if ("/".equals(File.separator)) {
                  certFilePath = "//myspace//webroot//DdService///WEB-INF//classes//META-INF//apiclient_cert.p12";///myspace/webroot/DdService/WEB-INF/classes/META-INF/apiclient_cert.p12
              }else{
                  certFilePath = "D:/cert/apiclient_cert.p12";
              }
               logger.error("certFilePath"+certFilePath);
              FileInputStream instream = new FileInputStream(new File(certFilePath));
              keyStore.load(instream, mchId.toCharArray());
              SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, mchId.toCharArray()).build();
              SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslcontext, new String[] { "TLSv1" }, null, SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
              CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
              HttpPost httpost = new HttpPost(url);
              httpost.addHeader("Connection", "keep-alive");
              httpost.addHeader("Accept", "*/*");
              httpost.addHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
              httpost.addHeader("Host", "api.mch.weixin.qq.com");
              httpost.addHeader("X-Requested-With", "XMLHttpRequest");
              httpost.addHeader("Cache-Control", "max-age=0");
              httpost.addHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0) ");
              httpost.setEntity(new StringEntity(data, "UTF-8"));
              System.out.println("executing request" + httpost.getRequestLine());
              CloseableHttpResponse response = httpclient.execute(httpost);
              try {
                  HttpEntity entity = response.getEntity();
                  System.out.println("----------------------------------------");
                  System.out.println(response.getStatusLine());
                  if (entity != null) {
                      System.out.println("Response content length: " + entity.getContentLength());
                      BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(entity.getContent(),"UTF-8"));
                      String text;
                     while ((text = bufferedReader.readLine()) != null) {
                          message.append(text);
                      }
                  }
                  EntityUtils.consume(entity);
              } catch (IOException e) {
                  logger.error("file:"+StringUtils.msgfmt(e));
              } finally {
                  response.close();
              }
          } catch (Exception e1) {
               logger.error("file:"+StringUtils.msgfmt(e1));
          } 
          return message.toString();
      }
 
}